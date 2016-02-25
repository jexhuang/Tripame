package com.forums.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.forums.model.*;
import com.forumsrep.model.*;
import com.mem.model.MemVO;

public class ForumsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		doPost(req, res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8"); // 處理中文檔名
		res.setContentType("text/html; charset=UTF-8");
		PrintWriter out = res.getWriter();
		String action = req.getParameter("action");
		HttpSession session = req.getSession();
		if ("WatchFor".equals(action)) {
			Integer forno = Integer.parseInt(req.getParameter("forno"));
			ForumsService forsvc = new ForumsService();
			ForumsVO forvo = forsvc.getOneForums(forno);
			session.setAttribute("forvo", forvo);
			RequestDispatcher rd = req
					.getRequestDispatcher("/Front/Forums/WatchOneForums.jsp");
			rd.forward(req, res);
			return;
		}
		if ("Add_New_Forums".equals(action)) {
			MemVO memvo = (MemVO) session.getAttribute("memvo");
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			if (memvo == null) {
				res.sendRedirect(req.getContextPath()
						+ "/Front/Mem/MemLogin.jsp");
				return;
			}
			String content = req.getParameter("editor2");
			if (content.length() == 0) {
				errorMsgs.add("請輸入文章內容");
			}
			String forclass = req.getParameter("forclass");
			String theme = req.getParameter("theme");
			if (theme.length() == 0) {
				errorMsgs.add("請輸入標題");
			}
			ForumsVO fvo = new ForumsVO();
			fvo.setForclass(forclass);
			fvo.setForcontent(content);
			fvo.setFortheme(theme);
			if (!errorMsgs.isEmpty()) {
				req.setAttribute("forvo", fvo);
				RequestDispatcher failureView = req
						.getRequestDispatcher("/Front/Forums/AddNewForums.jsp");
				failureView.forward(req, res);
				return;
			}
			SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Timestamp now = new Timestamp(System.currentTimeMillis());
			String str = df.format(now);
			ForumsService forsvc = new ForumsService();
			forsvc.addForums(memvo.getMemno(), forclass, theme, content,
					Timestamp.valueOf(str));
			res.sendRedirect(req.getContextPath()
					+ "/Front/Forums/ListAllForums.jsp");
			return;
		}
		if ("AddForums".equals(action)) {
			MemVO memvo = (MemVO) session.getAttribute("memvo");
			if (memvo == null) {
				// session.setAttribute("location", req.getRequestURI());
				session.setAttribute("location", req.getContextPath()
						+ "/Front/Forums/AddNewForums.jsp");
				res.sendRedirect(req.getContextPath()
						+ "/Front/Mem/MemLogin.jsp");
				return;
			} else {
				session.removeAttribute("forvo");
				res.sendRedirect(req.getContextPath()
						+ "/Front/Forums/AddNewForums.jsp");
				return;
			}

		}
		if ("updatebymem".equals(action)) {
			Integer forno = Integer.parseInt(req.getParameter("forno"));
			ForumsService forsvc = new ForumsService();
			ForumsVO forvo = forsvc.getOneForums(forno);
			req.setAttribute("forvo", forvo);
			RequestDispatcher failureView = req
					.getRequestDispatcher("/Front/Forums/UpdateForumsByMem.jsp");
			failureView.forward(req, res);
			return;

		}
		if ("deletebymem".equals(action)) {
			Integer forno = Integer.parseInt(req.getParameter("forno"));
			ForumsService forsvc = new ForumsService();
			ForumsrepService forrepsvc = new ForumsrepService();
			forrepsvc.deleteForumsrep(forno);
			forsvc.deleteForums(forno);
			res.sendRedirect(req.getContextPath()
					+ "/Front/Forums/ListAllForums.jsp");
			return;

		}
		if ("UpdateForumsByMem".equals(action)) {
			MemVO memvo = (MemVO) session.getAttribute("memvo");
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			Integer forno = Integer.parseInt(req.getParameter("forno"));
			String content = req.getParameter("editor2");
			if (content.length() == 0) {
				errorMsgs.add("請輸入文章內容");
			}
			String forclass = req.getParameter("forclass");
			String theme = req.getParameter("theme");
			if (theme.length() == 0) {
				errorMsgs.add("請輸入標題");
			}
			ForumsVO fvo = new ForumsVO();
			fvo.setForclass(forclass);
			fvo.setForno(forno);
			fvo.setForcontent(content);
			fvo.setFortheme(theme);
			if (!errorMsgs.isEmpty()) {
				req.setAttribute("forvo", fvo);
				RequestDispatcher failureView = req
						.getRequestDispatcher("/Front/Forums/UpdateForumsByMem.jsp");
				failureView.forward(req, res);
				return;
			}
			SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Timestamp now = new Timestamp(System.currentTimeMillis());
			String str = df.format(now);
			ForumsService forsvc = new ForumsService();
			forsvc.updateForums(forno, memvo.getMemno(), forclass, theme,
					content, Timestamp.valueOf(str));
			res.sendRedirect(req.getContextPath()
					+ "/forums/ForumsServlet?action=WatchFor&forno=" + forno);
			return;
		}
		if ("repforumsbymem".equals(action)) {
			Integer forno = Integer.parseInt(req.getParameter("forno"));
			MemVO memvo = (MemVO) session.getAttribute("memvo");
			if (memvo == null) {
				session.setAttribute("location", req.getContextPath()
						+ "/forums/ForumsServlet?action=WatchFor&forno=" + forno);
				res.sendRedirect(req.getContextPath()
						+ "/Front/Mem/MemLogin.jsp");
				return;
			} else {
				session.removeAttribute("forvo");
				req.setAttribute("forno", forno);
				RequestDispatcher failureView = req
						.getRequestDispatcher("/Front/Forums/AddForumsRep.jsp");
				failureView.forward(req, res);
				return;

			}
		}
		if ("Add_New_ForumsRep".equals(action)) {
			MemVO memvo = (MemVO) session.getAttribute("memvo");
			Integer forno = Integer.parseInt(req.getParameter("forno"));
			String content = req.getParameter("editor2");
			if(content.length()==0){
				content="無輸入內容";
			}
			SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Timestamp now = new Timestamp(System.currentTimeMillis());
			String str = df.format(now);
			ForumsrepService repsvc = new ForumsrepService();
			repsvc.addForumsrep(forno, memvo.getMemno(), content,
					Timestamp.valueOf(str));
			res.sendRedirect(req.getContextPath()
					+ "/forums/ForumsServlet?action=WatchFor&forno=" + forno);
			return;
		}
		if ("deleterepbymem".equals(action)) {
			Integer forno = Integer.parseInt(req.getParameter("forno"));
			Integer repno = Integer.parseInt(req.getParameter("repno"));
			ForumsrepService repsvc = new ForumsrepService();
			repsvc.deleteByRepno(repno);
			res.sendRedirect(req.getContextPath()
					+ "/forums/ForumsServlet?action=WatchFor&forno=" + forno);
			return;
		}
		if("updaterepbymem".equals(action)){
			Integer forno = Integer.parseInt(req.getParameter("forno"));
			Integer repno = Integer.parseInt(req.getParameter("repno"));
			ForumsrepService repsvc = new ForumsrepService();
			ForumsrepVO repvo=repsvc.findByRepno(repno);
			session.removeAttribute("forvo");
			req.setAttribute("repvo", repvo);
			req.setAttribute("forno", forno);
			RequestDispatcher failureView = req
					.getRequestDispatcher("/Front/Forums/UpdateForumsRepByMem.jsp");
			failureView.forward(req, res);
			return;
		}
		if("UpdateForumsRep".equals(action)){
			Integer forno = Integer.parseInt(req.getParameter("forno"));
			Integer repno = Integer.parseInt(req.getParameter("repno"));
			String content = req.getParameter("editor2");
			if(content.length()==0){
				content="無輸入內容";
			}
			ForumsrepService repsvc = new ForumsrepService();
			MemVO memvo=(MemVO)session.getAttribute("memvo");
			SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Timestamp now = new Timestamp(System.currentTimeMillis());
			String str = df.format(now);
			repsvc.updateForumsrep(repno, forno, memvo.getMemno(), content, Timestamp.valueOf(str));
			res.sendRedirect(req.getContextPath()+"/forums/ForumsServlet?action=WatchFor&forno=" + forno);
			return;
		}
		if ("BackWatchFor".equals(action)) {
			Integer forno = Integer.parseInt(req.getParameter("forno"));
			ForumsService forsvc = new ForumsService();
			ForumsVO forvo = forsvc.getOneForums(forno);
			session.setAttribute("forvo", forvo);
			RequestDispatcher rd = req
					.getRequestDispatcher("/Back/Forums/WatchOneForums.jsp");
			rd.forward(req, res);
			return;
		}
		if("deletebyemp".equals(action)){
			Integer forno = Integer.parseInt(req.getParameter("forno"));
			ForumsService forsvc = new ForumsService();
			ForumsrepService forrepsvc = new ForumsrepService();
			forrepsvc.deleteForumsrep(forno);
			forsvc.deleteForums(forno);
			res.sendRedirect(req.getContextPath()
					+ "/Back/Forums/ListForums.jsp");
			return;
		}
		if("updaterepbyemp".equals(action)){
			Integer forno = Integer.parseInt(req.getParameter("forno"));
			Integer repno = Integer.parseInt(req.getParameter("repno"));
			ForumsrepService repsvc = new ForumsrepService();
			ForumsrepVO repvo=repsvc.findByRepno(repno);
			repsvc.updateForumsrep(repno, forno, repvo.getMemno(), "因發文內容不當，系統將文章隱藏", repvo.getReptime());
			res.sendRedirect(req.getContextPath()+"/forums/ForumsServlet?action=BackWatchFor&forno=" + forno);
			return;
		}
		if ("deleterepbyemp".equals(action)) {
			Integer forno = Integer.parseInt(req.getParameter("forno"));
			Integer repno = Integer.parseInt(req.getParameter("repno"));
			ForumsrepService repsvc = new ForumsrepService();
			repsvc.deleteByRepno(repno);
			res.sendRedirect(req.getContextPath()+"/forums/ForumsServlet?action=BackWatchFor&forno=" + forno);
			return;
		}
	}

}
