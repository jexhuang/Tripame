package com.travel.controller;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Date;
import java.util.ArrayList;
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

import com.mem.model.MemService;
import com.mem.model.MemVO;
import com.travel.model.*;
import com.trajoin.model.*;

@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 5 * 1024 * 1024, maxRequestSize = 5 * 5 * 1024 * 1024)
public class TravelServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		doPost(req, res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8"); // 處理中文檔名
		res.setContentType("text/html; charset=UTF-8");
		HttpSession session = req.getSession();
		PrintWriter out = res.getWriter();
		String action = req.getParameter("action");
		if ("Add_New_Travel".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			Part part = req.getPart("pic");
			String name = req.getParameter("name");
			if (name.length() == 0) {
				errorMsgs.add("未輸入行程名稱");
			}
			String begin1 = req.getParameter("begin");
			if (begin1.length() == 0) {
				errorMsgs.add("未選擇開始日期");
			}
			String end1 = req.getParameter("end");
			if (end1.length() == 0) {
				errorMsgs.add("未選擇結束日期");
			}
//			String deadline1 = req.getParameter("deadline");
//			if (deadline1.length() == 0) {
//				errorMsgs.add("未選擇截止日期");
//			}
			String limit1 = req.getParameter("limit");
			if (limit1.length() == 0) {
				errorMsgs.add("請輸入限制人數");
			}
			Integer limit = 0;
			try {
				limit = Integer.parseInt(limit1);
			} catch (NumberFormatException e) {
				errorMsgs.add("請輸入數字");
			}
			String price1 = req.getParameter("price");
			if (price1.length() == 0) {
				errorMsgs.add("請輸入報名費");
			}
			Integer price = 0;
			try {
				price = Integer.parseInt(price1);
			} catch (NumberFormatException e) {
				errorMsgs.add("請輸入數字");
			}
			String content = req.getParameter("editor1");
			if (content.length() == 0) {
				errorMsgs.add("未輸入行程內容");
			}
			String status = req.getParameter("status");
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

			TravelVO tvo = new TravelVO();
			tvo.setTravelcontent(content);
			tvo.setTravelname(name);
			tvo.setTravelstatus(status);
			tvo.setTravellimit(limit);
			tvo.setTravelprice(price);
			if (!errorMsgs.isEmpty()) {
				req.setAttribute("begin", begin1);
				req.setAttribute("end", end1);
				req.setAttribute("travelvo", tvo);
				RequestDispatcher failureView = req
						.getRequestDispatcher("/Back/Travel/AddNewTravel.jsp");
				failureView.forward(req, res);
				return;// 程式中斷
			}

			Date begin = Date.valueOf(begin1);
			Date end = Date.valueOf(end1);
			//Date deadline = Date.valueOf(deadline1);
			long dead1=begin.getTime();
			dead1=dead1-86400;
			Date deadline=new Date(dead1);
			fin.close();
			TravelService tsvc = new TravelService();
			tsvc.addTravel(name, begin, end, content, limit, deadline, data,
					status, price);

			String url = "/Back/Travel/ListAllTravel.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url);
			successView.forward(req, res);
		}
		if ("UpdateOneTravel".equals(action)) {
			Integer travelno = Integer.parseInt(req.getParameter("travelno"));
			TravelService tsvc = new TravelService();
			TravelVO tvo = tsvc.getOneTravel(travelno);
			TrajoinService tjsvc = new TrajoinService();
			List<TrajoinVO> list = tjsvc.getAll();
			List<TrajoinVO> list1 = new ArrayList<TrajoinVO>();
			for (TrajoinVO tjvo : list) {
				if (tjvo.getTravelno().equals(travelno)) {
					list1.add(tjvo);
				}
			}
			req.setAttribute("list", list1);
			req.setAttribute("travelvo", tvo);
			String url = "/Back/Travel/UpdateTravel.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url);
			successView.forward(req, res);
		}
		if ("UpdateTravel".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			Integer travelno = Integer.parseInt(req.getParameter("travelno"));
			TrajoinService tjsvc = new TrajoinService();
			List<TrajoinVO> list = tjsvc.getAll();
			List<TrajoinVO> list1 = new ArrayList<TrajoinVO>();
			for (TrajoinVO tjvo : list) {
				if (tjvo.getTravelno().equals(travelno)) {
					list1.add(tjvo);
				}
			}
			TravelService tsvc = new TravelService();
			TravelVO tvo = tsvc.getOneTravel(travelno);
			Part part = req.getPart("pic");
			String name = req.getParameter("name");
			if (name.length() == 0) {
				errorMsgs.add("未輸入行程名稱");
			}
			String begin1 = req.getParameter("begin");
			if (begin1.length() == 0) {
				errorMsgs.add("未選擇開始日期");
			}
			String end1 = req.getParameter("end");
			if (end1.length() == 0) {
				errorMsgs.add("未選擇結束日期");
			}
//			String deadline1 = req.getParameter("deadline");
//			if (deadline1.length() == 0) {
//				errorMsgs.add("未選擇截止日期");
//			}
			String limit1 = req.getParameter("limit");
			if (limit1.length() == 0) {
				errorMsgs.add("請輸入限制人數");
			}
			Integer limit = 0;
			try {
				limit = Integer.parseInt(limit1);
			} catch (NumberFormatException e) {
				errorMsgs.add("請輸入數字");
			}
			String price1 = req.getParameter("price");
			if (price1.length() == 0) {
				errorMsgs.add("請輸入報名費");
			}
			Integer price = 0;
			try {
				price = Integer.parseInt(price1);
			} catch (NumberFormatException e) {
				errorMsgs.add("請輸入數字");
			}
			String content = req.getParameter("editor1");
			if (content.length() == 0) {
				errorMsgs.add("未輸入行程內容");
			}
			String status = req.getParameter("status");
			if(status==null){
				status=tvo.getTravelstatus();
			}
			InputStream fin = part.getInputStream();
			byte[] data = new byte[0];
			if (fin.available() > 0) {
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
				data = tvo.getTravelpic();
			}

			if (!errorMsgs.isEmpty()) {
				req.setAttribute("list", list1);
				req.setAttribute("travelvo", tvo);
				RequestDispatcher failureView = req
						.getRequestDispatcher("/Back/Travel/UpdateTravel.jsp");
				failureView.forward(req, res);
				return;// 程式中斷
			}

			Date begin = Date.valueOf(begin1);
			Date end = Date.valueOf(end1);
			//Date deadline = Date.valueOf(deadline1);
			long dead1=begin.getTime();
			dead1=dead1-86400;
			Date deadline=new Date(dead1);
			fin.close();
			tsvc.updateTravel(travelno, name, begin, end, content, limit,
					deadline, data, status, price);

			String url = "/Back/Travel/ListAllTravel.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url);
			successView.forward(req, res);

		}
		if ("DeleteOneTravel".equals(action)) {
			Integer travelno = Integer.parseInt(req.getParameter("travelno"));
			TravelService tsvc = new TravelService();
			TrajoinService tjsvc = new TrajoinService();
			tjsvc.deleteTrajoin(travelno);
			tsvc.deleteTravel(travelno);
			String url = "/Back/Travel/ListAllTravel.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url);
			successView.forward(req, res);
		}
		if ("WatchTravel".equals(action)) {
			Integer travelno = Integer.parseInt(req.getParameter("travelno"));
			TravelService tsvc = new TravelService();
			TravelVO tvo = tsvc.getOneTravel(travelno);
			req.setAttribute("travelvo", tvo);
			String url = "/Front/Travel/WatchOneTravel.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url);
			successView.forward(req, res);
		}
		if ("WatchTravelByMem".equals(action)) {
			Integer travelno = Integer.parseInt(req.getParameter("travelno"));
			TravelService tsvc = new TravelService();
			TravelVO tvo = tsvc.getOneTravel(travelno);
			req.setAttribute("travelvo", tvo);
			String url = "/Front/MemTravel/WatchOneTravelByMemno.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url);
			successView.forward(req, res);
		}

		if ("SignUp".equals(action)) {
			// if(session.getAttribute("memvo")==null){
			// String url = req.getContextPath()+"/Front/Mem/MemLogin.jsp";
			// res.sendRedirect(url);
			// return;
			// }
			Integer travelno = Integer.parseInt(req.getParameter("travelno"));
			MemVO memvo = (MemVO) session.getAttribute("memvo");
			TrajoinService tjsvc = new TrajoinService();
			tjsvc.addTrajoin(travelno, memvo.getMemno());
			String url = "/Front/MemTravel/ListTravelByMemno.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url);
			successView.forward(req, res);
		}
		if ("DeleteByMem".equals(action)) {
			TrajoinService tjsvc = new TrajoinService();
			Integer travelno = Integer.parseInt(req.getParameter("travelno"));
			MemVO memvo = (MemVO) session.getAttribute("memvo");
			tjsvc.deleteByMem(travelno, memvo.getMemno());
			String url = "/Front/MemTravel/ListTravelByMemno.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url);
			successView.forward(req, res);
		}
		if ("paytravel".equals(action)) {
			MemVO memvo = (MemVO) session.getAttribute("memvo");
			Integer travelno = Integer.parseInt(req.getParameter("travelno"));
			if (memvo == null) {
				session.setAttribute("location", req.getContextPath()
						+ "/travel/TravelServlet?action=WatchTravel&travelno="+travelno);
				RequestDispatcher rd = req
						.getRequestDispatcher("/Front/Mem/MemLogin.jsp");
				rd.forward(req, res);
				return;
			}else{
				req.setAttribute("travelno", travelno);
				String url = "/Front/Travel/PayTravel.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
				return;
			}
		}
	}
}
