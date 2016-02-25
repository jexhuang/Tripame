package com.page.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class BackSelectPage extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
			doPost(req,res);
	}
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8"); // 處理中文檔名
		res.setContentType("text/html; charset=UTF-8");
		String page=req.getParameter("page");
		HttpSession session=req.getSession();
		PrintWriter out = res.getWriter();

		if("mem".equals(page)){
			String url = req.getContextPath()+"/Back/Mem/ListMem.jsp";
			res.sendRedirect(url);
			return;
		}
		if("ad".equals(page)){
			String url = req.getContextPath()+"/Back/Ad/ListAllAds.jsp";
			res.sendRedirect(url);
			return;
		}
		if("travel".equals(page)){
			String url = req.getContextPath()+"/Back/Travel/ListAllTravel.jsp";
			res.sendRedirect(url);
			return;
		}
		if("rec".equals(page)){
			String url = req.getContextPath()+"/Back/Rec/ListAllRec.jsp";
			res.sendRedirect(url);
			return;
		}
		if("emp".equals(page)){
			String url = req.getContextPath()+"/Back/Emp/ListEmp.jsp";
			res.sendRedirect(url);
			return;
		}
		if("login".equals(page)){
			String url = req.getContextPath()+"/Back/Emp/EmpLogin.jsp";
			res.sendRedirect(url);
			return;
		}
		if("logout".equals(page)){
			session.removeAttribute("empvo");
			String url = req.getContextPath()+"/Back/Emp/EmpLogin.jsp";
			res.sendRedirect(url);
			return;
		}
		if("auth".equals(page)){
			String url = req.getContextPath()+"/Back/back_index.jsp?auth=Insufficient permissions";
			res.sendRedirect(url);
			return;
		}
		if("activity".equals(page)){
			session.removeAttribute("list");
			String url = req.getContextPath()+"/Back/Activity/SearchAct.jsp";
			res.sendRedirect(url);
		}
		if("spot".equals(page)){
			session.removeAttribute("list");
			String url = req.getContextPath()+"/Back/Spot/SearchSpot.jsp";
			res.sendRedirect(url);
		}
		if("forums".equals(page)){
			String url = req.getContextPath()+"/Back/Forums/ListForums.jsp";
			res.sendRedirect(url);
			return;
		}
		if("traffic".equals(page)){
			session.removeAttribute("list");
			String url = req.getContextPath()+"/Back/Traffic/SearchTra.jsp";
			res.sendRedirect(url);
		}
	}

}
