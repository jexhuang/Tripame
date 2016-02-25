package com.rec.controller;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Date;
import java.sql.Timestamp;
import java.util.Calendar;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.rec.model.*;
import com.spot.model.SpotService;
import com.ad.model.AdService;
import com.ad.model.AdVO;
import com.mem.model.*;

@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 5 * 1024 * 1024, maxRequestSize = 5 * 5 * 1024 * 1024)
public class RecServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(req, res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8"); // 處理中文檔名
		res.setContentType("text/html; charset=UTF-8");
		PrintWriter out = res.getWriter();
		String action = req.getParameter("action");
		HttpSession session = req.getSession();
		if ("address".equals(action)) {
			String con = req.getParameter("con");
			String con1 = new String(con.getBytes("ISO-8859-1"), "UTF-8");
			String dis = req.getParameter("dis");
			String dis1 = new String(dis.getBytes("ISO-8859-1"), "UTF-8");
			out.println(con1 + dis1);
		}
		if ("UpdateOneRec".equals(action)) {
			Integer recno = Integer.parseInt(req.getParameter("recno"));
			RecService recsvc = new RecService();
			RecVO recvo = recsvc.getOneRec(recno);
			MemService memsvc = new MemService();
			MemVO memvo = memsvc.getOneMem(recvo.getMemno());
			req.setAttribute("memname", memvo.getMemname());
			req.setAttribute("recvo", recvo);
			RequestDispatcher success = req
					.getRequestDispatcher("/Back/Rec/UpdateOneRec.jsp");
			success.forward(req, res);
			return;
		}
		if ("UpdateStatus".equals(action)) {
			Integer recno = Integer.parseInt(req.getParameter("recno"));
			RecService recsvc = new RecService();
			RecVO recvo = recsvc.getOneRec(recno);
			String status = req.getParameter("status");
			if(status==null){
				status=recvo.getRecstatus();
			}
			String message = req.getParameter("recmessage");
			SpotService spotSvc = new SpotService();
			recsvc.updateRec(recno, recvo.getMemno(),
					recvo.getRecclass(), recvo.getRecsort(), recvo.getReccon(),
					recvo.getRectown(), recvo.getRecname(),
					recvo.getRecphone(), recvo.getRecaddress(),
					recvo.getReccontent(), recvo.getRecpic(),
					recvo.getRecsite(), recvo.getReclat(), recvo.getReclong(),
					status, message);
			if(status.equals("審核成功")){
				spotSvc.insertSpot(recvo.getMemno(), recvo.getRecclass(), recvo.getReccon(), recvo.getRectown(),
						recvo.getRecname(), recvo.getRecphone(), recvo.getRecaddress(), recvo.getReccontent(),
						recvo.getRecsite(), recvo.getRecsort(), 0, recvo.getReclat(), recvo.getReclong(),
						"上架", 0, recvo.getRecpic());
			}
			res.sendRedirect(req.getContextPath() + "/Back/Rec/ListAllRec.jsp");
			return;
		}
		if ("Add_New_Rec".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			MemVO memvo = (MemVO) session.getAttribute("memvo");
			String con = req.getParameter("country");
			String dis = req.getParameter("district");
			String address = req.getParameter("recaddress");
			if (address.length() == 0) {
				errorMsgs.add("請輸入地址");
			}
			String content = req.getParameter("reccontent");
			if (content.length() == 0) {
				errorMsgs.add("請輸入內容");
			}
			String recclass = req.getParameter("recclass");
			String name = req.getParameter("recname");
			if (name.length() == 0) {
				errorMsgs.add("請輸入名稱");
			}
			String phone = req.getParameter("recphone");
			if (phone.length() == 0) {
				phone = "無";
			}
			String site = req.getParameter("recsite");
			if (site.length() == 0) {
				site = "無";
			}
			double lat = Double.parseDouble(req.getParameter("recLat"));
			double lng = Double.parseDouble(req.getParameter("recLng"));
			Part part = req.getPart("recpic");
			InputStream fin = part.getInputStream();
			if ((fin.available()) == 0) {
				errorMsgs.add("上傳一張你的照片吧!");
			}
			ByteArrayOutputStream buffer = new ByteArrayOutputStream();
			byte[] temp = new byte[4096];
			int rerec;
			try {
				while ((rerec = fin.read(temp)) >= 0) {
					buffer.write(temp, 0, rerec);
				}
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			byte[] data = buffer.toByteArray();
			RecVO recvo = new RecVO();
			recvo.setRecaddress(address);
			recvo.setRecclass(recclass);
			recvo.setReccon(con);
			recvo.setRectown(dis);
			recvo.setReccontent(content);
			recvo.setReclat(lat);
			recvo.setReclong(lng);
			recvo.setRecphone(phone);
			recvo.setRecpic(data);
			recvo.setRecsite(site);
			recvo.setRecname(name);

			if (!errorMsgs.isEmpty()) {
				req.setAttribute("recvo", recvo);
				RequestDispatcher failureView = req
						.getRequestDispatcher("/Front/Rec/AddNewRec.jsp");
				failureView.forward(req, res);
				return;// 程式中斷
			}
			RecService recsvc = new RecService();
			recsvc.addRec(memvo.getMemno(), recclass, "無", con, dis, name,
					phone, address, content, data, site, lat, lng, "審核中",
					"目前無回覆訊息");
			fin.close();
			String url = req.getContextPath() + "/Front/Rec/ListRecByMemno.jsp";
			res.sendRedirect(url);
			return;
		}
		if ("UpdateOneRecByMemno".equals(action)) {
			Integer recno = Integer.parseInt(req.getParameter("recno"));
			RecService recsvc = new RecService();
			RecVO recvo = recsvc.getOneRec(recno);
			MemService memsvc = new MemService();
			MemVO memvo = memsvc.getOneMem(recvo.getMemno());
			req.setAttribute("memname", memvo.getMemname());
			req.setAttribute("recvo", recvo);
			String url = "/Front/Rec/UpdateOneRecByMemno.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url);
			successView.forward(req, res);
			return;
		}
		if ("deleteOneRecByMemno".equals(action)) {
			Integer recno = Integer.parseInt(req.getParameter("recno"));
			RecService recsvc = new RecService();
			recsvc.deleteRec(recno);
			String url = req.getContextPath() + "/Front/Rec/ListRecByMemno.jsp";
			res.sendRedirect(url);
			return;
		}

		if ("UpdateByMem".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			String status = req.getParameter("recstatus");
			if ("請修改".equals(status)) {
				MemVO memvo = (MemVO) session.getAttribute("memvo");
				Integer recno = Integer.parseInt(req.getParameter("recno"));
				RecService recsvc = new RecService();
				RecVO recvo = recsvc.getOneRec(recno);
				String con = req.getParameter("country");
				String dis = req.getParameter("district");
				String recaddress = req.getParameter("recaddress");
				if (recaddress.length() == 0) {
					errorMsgs.add("請輸入地址");
				}
				String content = req.getParameter("reccontent");
				if (content.length() == 0) {
					errorMsgs.add("請輸入內容");
				}
				String recclass = req.getParameter("recclass");
				String name = req.getParameter("recname");
				if (name.length() == 0) {
					errorMsgs.add("請輸入名稱");
				}
				String phone = req.getParameter("recphone");
				if (phone.length() == 0) {
					phone = "無";
				}
				String site = req.getParameter("recsite");
				if (site.length() == 0) {
					site = "無";
				}
				String message = req.getParameter("recmessage");
				double lat = Double.parseDouble(req.getParameter("recLat"));
				double lng = Double.parseDouble(req.getParameter("recLng"));
				Part part = req.getPart("recpic");
				byte[] data = new byte[0];
				InputStream fin = part.getInputStream();
				if (fin.available() != 0) {
					ByteArrayOutputStream buffer = new ByteArrayOutputStream();
					byte[] temp = new byte[4096];
					int rerec;
					try {
						while ((rerec = fin.read(temp)) >= 0) {
							buffer.write(temp, 0, rerec);
						}
					} catch (IOException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					data = buffer.toByteArray();
				} else {
					data = recvo.getRecpic();
				}
				RecVO recvo1 = new RecVO();
				recvo1.setRecaddress(recaddress);
				recvo1.setRecclass(recclass);
				recvo1.setReccon(con);
				recvo1.setRectown(dis);
				recvo1.setReccontent(content);
				recvo1.setReclat(lat);
				recvo1.setReclong(lng);
				recvo1.setRecphone(phone);
				recvo1.setRecpic(data);
				recvo1.setRecsite(site);
				recvo1.setRecname(name);
				recvo1.setRecstatus(status);
				recvo1.setRecno(recno);
				recvo1.setRecmessage(message);
				

				if (!errorMsgs.isEmpty()) {
					req.setAttribute("recvo", recvo1);
					RequestDispatcher failureView = req
							.getRequestDispatcher("/Front/Rec/UpdateOneRecByMemno.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}
				recsvc.updateRec(recno, memvo.getMemno(), recclass, "無", con, dis,
						name, phone, recaddress, content, data, site, lat, lng,
						status,message);
				String url = req.getContextPath()
						+ "/Front/Rec/ListRecByMemno.jsp";
				res.sendRedirect(url);
				return;
			} else {
				String url = req.getContextPath()
						+ "/Front/Rec/ListRecByMemno.jsp";
				res.sendRedirect(url);
				return;

			}
		}
	}
}
