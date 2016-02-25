package com.ad.controller;

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

import com.ad.model.*;
import com.mem.model.*;
import com.spot.model.SpotService;

@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 5 * 1024 * 1024, maxRequestSize = 5 * 5 * 1024 * 1024)
public class AdsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(req, res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		req.setCharacterEncoding("UTF-8"); // 處理中文檔名
		res.setContentType("text/html; charset=UTF-8");
		PrintWriter out = res.getWriter();
		Calendar calendar = Calendar.getInstance();
		java.util.Date now = calendar.getTime();
		Timestamp currentTimestamp = new Timestamp(now.getTime());
		String action = req.getParameter("action");
		HttpSession session = req.getSession();
		if ("address".equals(action)) {
			String con = req.getParameter("con");
			String con1 = new String(con.getBytes("ISO-8859-1"), "UTF-8");
			String dis = req.getParameter("dis");
			String dis1 = new String(dis.getBytes("ISO-8859-1"), "UTF-8");
			out.println(con1 + dis1);
		}
		if ("Add_New_Ads".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			MemVO memvo = (MemVO) session.getAttribute("memvo");
			String con = req.getParameter("country");
			if (con.length() == 0) {
				errorMsgs.add("請選擇縣市");
			}
			String dis = req.getParameter("district");
			if (dis.length() == 0) {
				errorMsgs.add("請選擇鄉鎮");
			}
			String address = req.getParameter("adaddress");
			if (address.length() == 0) {
				errorMsgs.add("請輸入地址");
			}
			String content = req.getParameter("adcontent");
			if (content.length() == 0) {
				errorMsgs.add("請輸入內容");
			}
			String adclass = req.getParameter("adclass");
			String name = req.getParameter("adname");
			if (name.length() == 0) {
				errorMsgs.add("請輸入名稱");
			}
			String phone = req.getParameter("adphone");
			if (phone.length() == 0) {
				phone = "無";
			}
			String site = req.getParameter("adsite");
			if (site.length() == 0) {
				site = "無";
			}
			double lat = Double.parseDouble(req.getParameter("adLat"));
			double lng = Double.parseDouble(req.getParameter("adLng"));
			Date begin = new Date(currentTimestamp.getTime());
			Date end = new Date(currentTimestamp.getTime());
			Part part = req.getPart("adpic");
			InputStream fin = part.getInputStream();
			if ((fin.available()) == 0) {
				errorMsgs.add("上傳一張你的照片吧!");
			}
			ByteArrayOutputStream buffer = new ByteArrayOutputStream();
			byte[] temp = new byte[4096];
			int read;
			try {
				while ((read = fin.read(temp)) >= 0) {
					buffer.write(temp, 0, read);
				}
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			byte[] data = buffer.toByteArray();
			AdVO advo = new AdVO();
			advo.setAdaddress(address);
			advo.setAdbegin(begin);
			advo.setAdclass(adclass);
			advo.setAdcon(con);
			advo.setAdtown(dis);
			advo.setAdcontent(content);
			advo.setAdend(end);
			advo.setAdlat(lat);
			advo.setAdlong(lng);
			advo.setAdphone(phone);
			advo.setAdpic(data);
			advo.setAdsite(site);
			advo.setAdname(name);

			if (!errorMsgs.isEmpty()) {
				req.setAttribute("advo", advo);
				RequestDispatcher failureView = req
						.getRequestDispatcher("/Front/Ad/AddNewAds.jsp");
				failureView.forward(req, res);
				return;// 程式中斷
			}
			AdService adsvc = new AdService();
			adsvc.addAd(memvo.getMemno(), adclass, "無", con, dis, name, phone,
					address, content, data, site, lat, lng, "審核中", begin, end,
					"目前無回覆訊息");
			fin.close();
			String url = req.getContextPath() + "/Front/Ad/ListAdsByMemno.jsp";
			res.sendRedirect(url);
			return;
		}

		if ("UpdateOneAd".equals(action)) {
			Integer adno = Integer.parseInt(req.getParameter("adno"));
			AdService adsvc = new AdService();
			AdVO advo = adsvc.getOneAd(adno);
			MemService memsvc = new MemService();
			MemVO memvo = memsvc.getOneMem(advo.getMemno());
			req.setAttribute("memname", memvo.getMemname());
			req.setAttribute("advo", advo);
			String url = "/Back/Ad/UpdateOneAd.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url);
			successView.forward(req, res);
			return;
		}
		if ("UpdateStatus".equals(action)) {
			Integer adno = Integer.parseInt(req.getParameter("adno"));
			AdService adsvc = new AdService();
			AdVO advo = adsvc.getOneAd(adno);
			SpotService spotSvc = new SpotService();

			String status = req.getParameter("status");
			if(status==null){
				status=advo.getAdstatus();
			}
			String message = req.getParameter("admessage");
			if ("上架中".equals(status)) {
				if(!(advo.getAdstatus().equals("上架中"))){
				Date date = new Date(currentTimestamp.getTime()
						+ (long) 604800000.0);
				Date date1 = new Date(currentTimestamp.getTime());
				adsvc.updateAd(adno, advo.getMemno(), advo.getAdclass(),
						advo.getAdsort(), advo.getAdcon(), advo.getAdtown(),
						advo.getAdname(), advo.getAdphone(),
						advo.getAdaddress(), advo.getAdcontent(),
						advo.getAdpic(), advo.getAdsite(), advo.getAdlat(),
						advo.getAdlong(), status, date1, date, message);
				spotSvc.insertSpot(advo.getMemno(), advo.getAdclass(), advo.getAdcon(), advo.getAdtown(),
						advo.getAdname(), advo.getAdphone(), advo.getAdaddress(), advo.getAdcontent(),
						advo.getAdsite(), advo.getAdsort(), 0, advo.getAdlat(), advo.getAdlong(),
						"上架", 0, advo.getAdpic());
				}else{
					adsvc.updateAd(adno, advo.getMemno(), advo.getAdclass(),
							advo.getAdsort(), advo.getAdcon(), advo.getAdtown(),
							advo.getAdname(), advo.getAdphone(),
							advo.getAdaddress(), advo.getAdcontent(),
							advo.getAdpic(), advo.getAdsite(), advo.getAdlat(),
							advo.getAdlong(), status, advo.getAdbegin(),
							advo.getAdend(), message);
				}
				
			} else {
				adsvc.updateAd(adno, advo.getMemno(), advo.getAdclass(),
						advo.getAdsort(), advo.getAdcon(), advo.getAdtown(),
						advo.getAdname(), advo.getAdphone(),
						advo.getAdaddress(), advo.getAdcontent(),
						advo.getAdpic(), advo.getAdsite(), advo.getAdlat(),
						advo.getAdlong(), status, advo.getAdbegin(),
						advo.getAdend(), message);
			}
			String url = req.getContextPath() + "/Back/Ad/ListAllAds.jsp";
			res.sendRedirect(url);
			return;
		}
		if ("UpdateOneAdByMemno".equals(action)) {
			Integer adno = Integer.parseInt(req.getParameter("adno"));
			AdService adsvc = new AdService();
			AdVO advo = adsvc.getOneAd(adno);
			MemService memsvc = new MemService();
			MemVO memvo = memsvc.getOneMem(advo.getMemno());
			req.setAttribute("memname", memvo.getMemname());
			req.setAttribute("advo", advo);
			String url = "/Front/Ad/UpdateOneAdByMemno.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url);
			successView.forward(req, res);
			return;
		}
		if ("UpdateByMem".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			String status = req.getParameter("adstatus");
			if ("請修改".equals(status)) {
				MemVO memvo = (MemVO) session.getAttribute("memvo");
				Integer adno = Integer.parseInt(req.getParameter("adno"));
				AdService adsvc = new AdService();
				AdVO advo = adsvc.getOneAd(adno);
				String con = req.getParameter("country");
				String dis = req.getParameter("district");
				String address = req.getParameter("adaddress");
				if (address.length() == 0) {
					errorMsgs.add("請輸入地址");
				}
				String content = req.getParameter("adcontent");
				if (content.length() == 0) {
					errorMsgs.add("請輸入內容");
				}
				String adclass = req.getParameter("adclass");
				String name = req.getParameter("adname");
				if (name.length() == 0) {
					errorMsgs.add("請輸入名稱");
				}
				String phone = req.getParameter("adphone");
				if (phone.length() == 0) {
					phone = "無";
				}
				String site = req.getParameter("adsite");
				if (site.length() == 0) {
					site = "無";
				}
				String message = req.getParameter("admessage");
				double lat = Double.parseDouble(req.getParameter("adLat"));
				double lng = Double.parseDouble(req.getParameter("adLng"));
				Date begin = Date.valueOf(req.getParameter("adbegin"));
				Date end = Date.valueOf(req.getParameter("adend"));
				Part part = req.getPart("adpic");
				byte[] data = new byte[0];
				InputStream fin = part.getInputStream();
				if (fin.available() != 0) {
					ByteArrayOutputStream buffer = new ByteArrayOutputStream();
					byte[] temp = new byte[4096];
					int read;
					try {
						while ((read = fin.read(temp)) >= 0) {
							buffer.write(temp, 0, read);
						}
					} catch (IOException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					data = buffer.toByteArray();
				} else {
					data = advo.getAdpic();
				}
				AdVO advo1 = new AdVO();
				advo1.setAdaddress(address);
				advo1.setAdbegin(begin);
				advo1.setAdclass(adclass);
				advo1.setAdcon(con);
				advo1.setAdtown(dis);
				advo1.setAdcontent(content);
				advo1.setAdend(end);
				advo1.setAdlat(lat);
				advo1.setAdlong(lng);
				advo1.setAdphone(phone);
				advo1.setAdpic(data);
				advo1.setAdsite(site);
				advo1.setAdname(name);
				advo1.setAdno(adno);
				advo1.setAdstatus(status);
				advo1.setAdmessage(message);
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("advo", advo1);
					RequestDispatcher failureView = req
							.getRequestDispatcher("/Front/Ad/UpdateOneAdByMemno.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}
				adsvc.updateAd(adno, memvo.getMemno(), adclass, "無", con, dis,
						name, phone, address, content, data, site, lat, lng,
						status, begin, end, message);
				String url = req.getContextPath()
						+ "/Front/Ad/ListAdsByMemno.jsp";
				res.sendRedirect(url);
				return;
			} else {
				String url = req.getContextPath()
						+ "/Front/Ad/ListAdsByMemno.jsp";
				res.sendRedirect(url);
				return;

			}
		}
		if ("deleteOneAdByMemno".equals(action)) {
			Integer adno = Integer.parseInt(req.getParameter("adno"));
			AdService adsvc = new AdService();
			adsvc.deleteAd(adno);
			String url = req.getContextPath() + "/Front/Ad/ListAdsByMemno.jsp";
			res.sendRedirect(url);
			return;
		}
	}
}
