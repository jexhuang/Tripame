package com.mem.controller;

import java.io.*;
import java.util.LinkedList;
import java.util.List;

import javax.mail.MessagingException;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.Part;

import TestDB.FPwMailService;
import TestDB.MailService;
import TestDB.MemMailService;

import com.mem.model.MemDAO;
import com.mem.model.MemService;
import com.mem.model.MemVO;

@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 5 * 1024 * 1024, maxRequestSize = 5 * 5 * 1024 * 1024)
public class MemServlet extends HttpServlet {

	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8"); // 處理中文檔名
		res.setContentType("text/html; charset=UTF-8");
		PrintWriter out = res.getWriter();
		String action = req.getParameter("action");
		HttpSession session = req.getSession();
		String regex = "^.[A-Za-z0-9]+$";
		if ("checkid".equals(action)) {
			String memid = (req.getParameter("memid")).trim();
			MemService memsvc = new MemService();
			List<MemVO> list = memsvc.getAll();
			if (memid.length() < 4) {
				out.println("帳號需大於等於4個字");
				return;
			}
			if (!(memid.matches(regex))) {
				out.println("帳號須為英數字組合");
				return;
			}
			for (MemVO memvo : list) {
				if (memvo.getMemid().equals(memid)) {
					out.println("帳號已重複");
					return;
				}
			}
			out.println("帳號可使用");
		}

		if ("checkpw".equals(action)) {
			String mempw = (req.getParameter("mempw")).trim();
			if (mempw.length() < 4) {
				out.println("密碼需大於等於4個字");
				return;
			}
			out.println("密碼可使用");
		}

		if ("ForgetPw".equals(action)) {
			String id = req.getParameter("memid");
			String email = req.getParameter("mememail");
			MemService memsvc = new MemService();
			List<MemVO> list = memsvc.getAll();
			for (MemVO memvo : list) {
				if ((memvo.getMemid()).equals(id)
						&& (memvo.getMememail()).equals(email)) {
					String pw = "";
					int a = 0;
					for (int i = 0; i < 4; i++) {
						a = (int) Math.floor(Math.random() * 10);
						pw += a + "";
					}
					MemService memsvc1 = new MemService();
					memsvc1.updateMem(memvo.getMemno(), memvo.getMemname(),
							memvo.getMemid(), pw, memvo.getMememail(),
							memvo.getMemcode(), memvo.getMemstatus(),
							memvo.getMempic());

					FPwMailService ms = new FPwMailService();
					try {
						ms.sendPassword(memvo.getMemname(), pw,
								memvo.getMememail());
					} catch (MessagingException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}

					// req.setAttribute("fname", memvo.getMemname());
					// req.setAttribute("fpw", pw);
					// req.setAttribute("femail", memvo.getMememail());
					// RequestDispatcher dispatcher = req
					// .getRequestDispatcher("/Front/Mem/JavaMailProccess.jsp");
					// dispatcher.include(req, res);

					String url = "/Front/Mem/MemLogin.jsp";
					RequestDispatcher successView = req
							.getRequestDispatcher(url);
					successView.forward(req, res);
					return;
				}
			}
			res.sendRedirect(req.getContextPath() + "/Front/Mem/ForgetPw.jsp");
			return;
		}

		if ("UpdateMem".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			Part part = req.getPart("mempic");
			MemVO memvo = (MemVO) session.getAttribute("memvo");
			byte[] pic = memvo.getMempic();
			String name = req.getParameter("memname");
			if (name.length() == 0) {
				errorMsgs.add("你沒輸入名字");
			}
			String id = req.getParameter("memid");
			Integer no = Integer.parseInt(req.getParameter("memno"));
			String pw = req.getParameter("mempw");
			String code = req.getParameter("memcode");
			String email = req.getParameter("mememail");
			if (pw.length() < 4) {
				errorMsgs.add("密碼需大於等於四個字");
			}
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
				data = pic;
			}
			if (!errorMsgs.isEmpty()) {
				RequestDispatcher failureView = req
						.getRequestDispatcher("/Front/Mem/UpdateMem.jsp");
				failureView.forward(req, res);
				return;// 程式中斷
			}

			MemService memsvc = new MemService();
			MemVO memvo1 = memsvc.updateMem(no, name, id, pw, email, code,
					"enable", data);
			session.setAttribute("memvo", memvo1);
			fin.close();

			String url = "/Front/Mem/UpdateMem.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url);
			successView.forward(req, res);
		}

		if ("Add_New_Mem".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			Part part = req.getPart("mempic");
			String name = req.getParameter("memname");
			if (name.length() == 0) {
				errorMsgs.add("請輸入名字");
			}
			String id = req.getParameter("memid");
			if (id.length() < 4) {
				errorMsgs.add("帳號需大於等於四個字");
			} else if (!(id.matches(regex))) {
				errorMsgs.add("帳號需為英數字");
			}
			MemService memsvc = new MemService();
			List<MemVO> list = memsvc.getAll();
			for (MemVO memvo : list) {
				if (memvo.getMemid().equals(id)) {
					errorMsgs.add("帳號已重複");
				}
			}
			String pw = req.getParameter("mempw");
			if (pw.length() < 4) {
				errorMsgs.add("密碼需大於等於四個字");
			}
			String email = req.getParameter("mememail");
			if (email.length() == 0) {
				errorMsgs.add("請輸入Email");
			}
			String x = "";
			int a = 0;
			for (int i = 0; i < 4; i++) {
				a = (int) Math.floor(Math.random() * 10);
				x += a + "";
			}
			String code = x.trim();
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

			MemVO memvo = new MemVO();
			memvo.setMememail(email);
			memvo.setMemid(id);
			memvo.setMempw(pw);
			memvo.setMemname(name);

			if (!errorMsgs.isEmpty()) {
				req.setAttribute("memvo", memvo);
				RequestDispatcher failureView = req
						.getRequestDispatcher("/Front/Mem/AddNewMem.jsp");
				failureView.forward(req, res);
				return;// 程式中斷
			}
			MemService memsvc1 = new MemService();
			memsvc1.addMem(name, id, pw, email, code, "disable", data);
			fin.close();

			MemMailService mms = new MemMailService();
			try {
				mms.sendPassword(code, name, email);
			} catch (MessagingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			// req.setAttribute("code", code);
			// req.setAttribute("name", name);
			// req.setAttribute("email", email);
			// RequestDispatcher dispatcher = req
			// .getRequestDispatcher("/Front/Mem/JavaMailProccess.jsp");
			// dispatcher.include(req, res);

			String url = "/Front/Mem/MemLogin.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url);
			successView.forward(req, res);
		}
		if ("Verification_Code".equals(action)) {
			String code = req.getParameter("memcode").trim();
			MemVO memvo = (MemVO) session.getAttribute("memvo");
			String memcode = memvo.getMemcode();
			if (code.equals(memcode)) {
				MemService memsvc = new MemService();
				memsvc.updateMem(memvo.getMemno(), memvo.getMemname(),
						memvo.getMemid(), memvo.getMempw(),
						memvo.getMememail(), memvo.getMemcode(), "enable",
						memvo.getMempic());
				res.sendRedirect(req.getContextPath()
						+ "/Front/Mem/MemLogin.jsp");
			} else {
				res.sendRedirect(req.getContextPath()
						+ "/Front/Mem/VerificationCode.jsp");
			}

		}

		if ("Mem_Login".equals(action)) {
			String id = req.getParameter("memid");
			String pw = req.getParameter("mempw");
			MemService memsvc = new MemService();
			List<MemVO> list = memsvc.getAll();
			for (MemVO memvo : list) {
				if ((memvo.getMemid().trim().equals(id))
						&& (memvo.getMempw().trim().equals(pw))) {

					if (memvo.getMemstatus().trim().equals("disable")) {
						session.setAttribute("memvo", memvo);
						String url = "/Front/Mem/VerificationCode.jsp";
						RequestDispatcher verification = req
								.getRequestDispatcher(url); // 成功轉交listOneEmp.jsp
						verification.forward(req, res);
						return;
					} else {
						session.setAttribute("memvo", memvo);

						String url = (String) session.getAttribute("location");
						res.sendRedirect(url);
						return;
					}

				}
			}
			String url = "/Front/Mem/MemLogin.jsp";
			RequestDispatcher verification = req.getRequestDispatcher(url);
			verification.forward(req, res);

		}
		if ("FBLogin".equals(action)) {
			String name = req.getParameter("name");
			String name2 = new String(name.getBytes("ISO-8859-1"), "UTF-8");
			String email = req.getParameter("email");
			String id = req.getParameter("id");
			//https://graph.facebook.com/10202643896093128/picture?type=large
			MemService memsvc = new MemService();
			List<MemVO> list = memsvc.getAll();
			for (MemVO memvo : list) {
				if ((memvo.getMemid().trim().equals(email))
						&& (memvo.getMempw().trim().equals(id))) {
					session.setAttribute("memvo", memvo);
					String url = (String) session.getAttribute("location");
					out.println("<META HTTP-EQUIV='Refresh' content='1;URL="+url+"'>");				
//					res.sendRedirect(url);
					return;
				}
			}
			String picUrl="https://graph.facebook.com/"+id+"/picture?type=large";
			InputStream fin=GetURLPic.GetPic(picUrl);
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
			memsvc.addMem(name2, email, id, email, "fbmem", "enable", data);
			MemVO memVO = new MemVO();
			memVO.setMemname(name2);
			memVO.setMemid(email);
			memVO.setMempw(id);
			memVO.setMememail(email);
			memVO.setMemcode("fbmem");
			memVO.setMemstatus("enable");
			memVO.setMempic(data);
			fin.close();
			session.setAttribute("memvo", memVO);
			out.println("<META HTTP-EQUIV='Refresh' content='1;URL="+req.getContextPath()+"/Front/Mem/MemLogin.jsp"+"'>");	
			return;
			
		}
	}

}
