package com.page.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.ad.model.*;
import com.mem.model.*;

public class FrontSelectPage extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req,res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		String page=req.getParameter("page");
		HttpSession session=req.getSession();
		if ("memroute".equals(page)){
			String url = req.getContextPath()+"/Front/Trip/memRoute.jsp";
			res.sendRedirect(url);
			return;
		}
		if ("memtrip".equals(page)){
			String url = req.getContextPath()+"/Front/Trip/memtrip.jsp";
			res.sendRedirect(url);
			return;
		}
		if("memad".equals(page)){
			String url = req.getContextPath()+"/Front/Ad/ListAdsByMemno.jsp";
			res.sendRedirect(url);
			return;
		}
		if("memtravel".equals(page)){
			String url = req.getContextPath()+"/Front/MemTravel/ListTravelByMemno.jsp";
			res.sendRedirect(url);
			return;
		}
		if("memrec".equals(page)){
			String url = req.getContextPath()+"/Front/Rec/ListRecByMemno.jsp";
			res.sendRedirect(url);
			return;
		}
		if("memmanager".equals(page)){
			String url = req.getContextPath()+"/Front/Mem/UpdateMem.jsp";
			res.sendRedirect(url);
			return;
		}
		if("memlogin".equals(page)){
		    session.setAttribute("location", req.getContextPath()+"/spot/FrontSpot_Servlet?action=front_search_con&page=spot");
			String url = req.getContextPath()+"/Front/Mem/MemLogin.jsp";
			res.sendRedirect(url);
			return;
		}
		if("memlogout".equals(page)){
			session.removeAttribute("memvo");
			String url = req.getContextPath()+"/spot/FrontSpot_Servlet?action=front_search_con&page="+page;
			res.sendRedirect(url);
			return;
		}
		if("travel".equals(page)){
			String url = req.getContextPath()+"/Front/Travel/ListTravel.jsp";
			res.sendRedirect(url);
			return;
		}
		if("spot".equals(page)){
			String url = req.getContextPath()+"/spot/FrontSpot_Servlet?action=front_search_con&page="+page;
			res.sendRedirect(url);
			return;
		}
		if("food".equals(page)){
			String url = req.getContextPath()+"/spot/FrontSpot_Servlet?action=front_search_con&page="+page;
			res.sendRedirect(url);
			return;
		}
		if("room".equals(page)){
			String url = req.getContextPath()+"/spot/FrontSpot_Servlet?action=front_search_con&page="+page;
			res.sendRedirect(url);
			return;
		}
		if("activity".equals(page))
		{
			String url = req.getContextPath()+"/act/FrontAct_Servlet?action=front_search_con";
			res.sendRedirect(url);
			return;
		}
		if("forums".equals(page)){
			String url = req.getContextPath()+"/Front/Forums/ListAllForums.jsp";
			res.sendRedirect(url);
			return;
		}
		if("traffic".equals(page))
		{
			String url = req.getContextPath()+"/Front/Traffic/SearchTra.jsp";
			res.sendRedirect(url);
			return;
		}
	}

}
