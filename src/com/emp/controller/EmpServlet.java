package com.emp.controller;

import java.io.*;
import java.util.LinkedList;
import java.util.List;

import javax.mail.MessagingException;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.Part;

import TestDB.MailService;

import com.emp.model.*;

@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 5 * 1024 * 1024, maxRequestSize = 5 * 5 * 1024 * 1024)
public class EmpServlet extends HttpServlet {

	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		doPost(req, res);
	}

	public static String getRegSN() {
		String regsn = "";
		int pwlength = 8;
		String[] RegSNContent = { "0", "1", "2", "3", "4", "5", "6", "7", "8",
				"9", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K",
				"L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W",
				"X", "Y", "Z", "a", "b", "c", "d", "e", "f", "g", "h", "i",
				"j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u",
				"v", "w", "x", "y", "z" };
		for (int i = 0; i < pwlength; i++)
			regsn += RegSNContent[(int) (Math.random() * RegSNContent.length)];
		return regsn;
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
			String empid = (req.getParameter("empid")).trim();
			EmpService empsvc = new EmpService();
			List<EmpVO> list = empsvc.getAll();
			if (empid.length() < 4) {
				out.println("帳號需大於等於4個字");
				return;
			}
			if (!(empid.matches(regex))) {
				out.println("帳號須為英數字組合");
				return;
			}
			for (EmpVO empvo : list) {
				if (empvo.getEmpid().equals(empid)) {
					out.println("帳號已重複");
					return;
				}
			}
			out.println("帳號可使用");
			return;
		}
		if ("Add_New_Emp".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			String name = req.getParameter("empname");
			if (name.length() == 0) {
				errorMsgs.add("你沒輸入名字");
			}
			String id = req.getParameter("empid");
			if (id.length() < 4) {
				errorMsgs.add("帳號需大於等於四個字");
			} else if (!(id.matches(regex))) {
				errorMsgs.add("帳號需為英數字");
			}
			EmpService empsvc = new EmpService();
			List<EmpVO> list = empsvc.getAll();
			for (EmpVO empvo : list) {
				if (empvo.getEmpid().equals(id)) {
					out.println("帳號已重複");
					return;
				}
			}
			String email = req.getParameter("empemail");
			if (email.length() == 0) {
				errorMsgs.add("你沒輸入信箱");
			}
			EmpVO empvo = new EmpVO();
			empvo.setEmpname(name);
			empvo.setEmpid(id);
			empvo.setEmpemail(email);

			if (!errorMsgs.isEmpty()) {
				req.setAttribute("empvo1", empvo);
				RequestDispatcher failureView = req
						.getRequestDispatcher("/Back/Emp/AddNewEmp.jsp");
				failureView.forward(req, res);
				return;// 程式中斷
			}
			String p = getRegSN();
			System.out.println(p);
			char pwc[] = p.toCharArray();
			char b;
			StringBuffer sb = new StringBuffer();
			for (int i = 0; i < pwc.length; i++) {
				b = (char) ((char) pwc[i] ^ 7);
				sb.append(b);
			}
			String pw = sb.toString();
			empsvc.addEmp(name, id, pw, email, "disable", "disable", "disable",
					"disable", "disable", "disable", "disable", "disable",
					"disable");
			MailService ms=new MailService();
			try {
				ms.sendPassword(name,p , email);
			} catch (MessagingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
//			req.setAttribute("pw", p);
//			req.setAttribute("name", name);
//			req.setAttribute("email", email);
//			RequestDispatcher dispatcher = req
//					.getRequestDispatcher("/Back/Emp/JavaMailProccess.jsp");
//			dispatcher.include(req, res);

			String url = "/Back/Emp/ListEmp.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url);
			successView.forward(req, res);
		}
		if ("updateEmp".equals(action)) {
			Integer empno = Integer.parseInt(req.getParameter("empno"));
			EmpService empsvc = new EmpService();
			EmpVO empvo = empsvc.getOneEmp(empno);
			req.setAttribute("empvo", empvo);
			RequestDispatcher dispatcher = req
					.getRequestDispatcher("/Back/Emp/UpdateEmp.jsp");
			dispatcher.forward(req, res);
		}
		if ("UpdateEmpByEmp".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			Integer empno = Integer.parseInt(req.getParameter("empno"));
			EmpService empsvc = new EmpService();
			EmpVO empvo = empsvc.getOneEmp(empno);
			String empname = req.getParameter("empname");
			if (empname.length() == 0) {
				errorMsgs.add("請輸入名字");
			}
			if (!errorMsgs.isEmpty()) {
				req.setAttribute("empvo", empvo);
				RequestDispatcher failureView = req
						.getRequestDispatcher("/Back/Emp/UpdateEmp.jsp");
				failureView.forward(req, res);
				return;// 程式中斷
			}
			empsvc.updateEmp(empno, empname, empvo.getEmpid(),
					empvo.getEmppw(), empvo.getEmpemail(), empvo.getEmpad(),
					empvo.getEmptravel(), empvo.getEmpactivity(),
					empvo.getEmpemp(), empvo.getEmpforums(), empvo.getEmprec(),
					empvo.getEmpmem(), empvo.getEmpspot(),
					empvo.getEmptraffic());
			EmpVO empvo1 = empsvc.getOneEmp(empno);
			EmpVO empvo2 = (EmpVO) session.getAttribute("empvo");
			if (empvo2 != null) {
				if (empvo2.getEmpno().equals(empno)) {
					session.setAttribute("empvo", empvo1);
				}
			}
			res.sendRedirect(req.getContextPath() + "/Back/Emp/ListEmp.jsp");
			return;

		}

		if ("Emp_Login".equals(action)) {
			String id = req.getParameter("empid");
			String p = req.getParameter("emppw");
			char pwc[] = p.toCharArray();
			char b;
			StringBuffer sb = new StringBuffer();
			for (int i = 0; i < pwc.length; i++) {
				b = (char) ((char) pwc[i] ^ 7);
				sb.append(b);
			}
			String pw = sb.toString();
			System.out.println(pw);
			EmpService empsvc = new EmpService();
			List<EmpVO> list = empsvc.getAll();
			for (EmpVO empvo : list) {
				if ((empvo.getEmpid().trim().equals(id))
						&& (empvo.getEmppw().trim().equals(pw))) {
					session.setAttribute("empvo", empvo);
					String url = (String) session.getAttribute("backlocation");
					if(url!=null)
					res.sendRedirect(url);
					else
					res.sendRedirect(req.getContextPath()+"/Back/back_index.jsp");
					return;
				}
			}
			res.sendRedirect(req.getContextPath() + "/Back/Emp/EmpLogin.jsp");
			return;
		}

		if ("UpdateEmpAuth".equals(action)) {
			Integer empno = Integer.parseInt(req.getParameter("empno"));
			EmpService empsvc = new EmpService();
			EmpVO empvo = empsvc.getOneEmp(empno);
			String emp = req.getParameter("emp");
			if (emp == null) {
				emp = "disable";
			}
			String ad = req.getParameter("ad");
			if (ad == null) {
				ad = "disable";
			}
			String mem = req.getParameter("mem");
			if (mem == null) {
				mem = "disable";
			}
			String activity = req.getParameter("activity");
			if (activity == null) {
				activity = "disable";
			}
			String spot = req.getParameter("spot");
			if (spot == null) {
				spot = "disable";
			}
			String forums = req.getParameter("forums");
			if (forums == null) {
				forums = "disable";
			}
			String rec = req.getParameter("rec");
			if (rec == null) {
				rec = "disable";
			}
			String traffic = req.getParameter("traffic");
			if (traffic == null) {
				traffic = "disable";
			}
			String travel = req.getParameter("travel");
			if (travel == null) {
				travel = "disable";
			}
			empsvc.updateEmp(empno, empvo.getEmpname(), empvo.getEmpid(),
					empvo.getEmppw(), empvo.getEmpemail(), ad, travel,
					activity, emp, forums, rec, mem, spot, traffic);
			EmpVO empvo1 = empsvc.getOneEmp(empno);
			EmpVO empvo2 = (EmpVO) session.getAttribute("empvo");
			if (empvo2 != null) {
				if (empvo2.getEmpno().equals(empno)) {
					session.setAttribute("empvo", empvo1);
				}
			}
			res.sendRedirect(req.getContextPath() + "/Back/Emp/ListEmp.jsp");
			return;
		}

	}
}
