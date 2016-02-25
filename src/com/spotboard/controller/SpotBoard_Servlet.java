package com.spotboard.controller;

import java.io.IOException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.mem.model.MemService;
import com.mem.model.MemVO;
import com.spot.model.SpotService;
import com.spot.model.SpotVO;
import com.spotboard.model.SpotboardService;
import com.spotboard.model.SpotboardVO;


public class SpotBoard_Servlet extends HttpServlet 
{
	private static final long serialVersionUID = 1L;
 
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException 
	{
		doPost(req,res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException 
	{
		req.setCharacterEncoding("utf-8");// 處理中文檔名
		res.setContentType("text/html; charset=UTF-8");
		String action = req.getParameter("action");
		String requestURL = req.getParameter("requestURL");
		HttpSession session = req.getSession();
		if("insert".equals(action))
		{

			if(session.getAttribute("memvo")==null)
			{
				session.setAttribute("location",req.getParameter("location"));
				res.sendRedirect(req.getContextPath()+"/Front/Mem/MemLogin.jsp");
				return;
			}
			if(req.getParameter("sbcontent").isEmpty())
			{
				String location=req.getParameter("location");
				res.sendRedirect(location);	
				return;
			}
			else
			{
				String sbcontent = req.getParameter("sbcontent");
				Integer spotno = Integer.parseInt(req.getParameter("spotno"));
				SpotboardService sbSvc = new SpotboardService();				
				MemVO memVO = (MemVO)session.getAttribute("memvo");			
				
				SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				Timestamp now = new Timestamp(System.currentTimeMillis());
				String str = df.format(now);
				
				sbSvc.insertSb(spotno, memVO.getMemno(), sbcontent, Timestamp.valueOf(str));			
				String location=req.getParameter("location");
				res.sendRedirect(location);	
				return;
			}
			
		}
		if("find_talk".equals(action))
		{
			String spotno = req.getParameter("spotno");
			SpotboardService spotboardSvc = new SpotboardService();
			Map<String,String[]> map = new TreeMap<>();
			map.put("spotno", new String[]{spotno});
			map.put("order by", new String[]{"sbtime desc"});
			List<SpotboardVO> list = spotboardSvc.getAll(map);
			req.setAttribute("list", list);
			RequestDispatcher dispatcher = req.getRequestDispatcher("/Back/Spotboard/SearchSpotBoard.jsp");
			dispatcher.forward(req, res);
			return;
		}
		if("delete".equals(action))
		{
			
			if(requestURL==null)
			{	
				Integer sbno = Integer.parseInt(req.getParameter("sbno"));
				SpotboardService spotboardSvc = new SpotboardService();
				String spotno = req.getParameter("spotno");				
				spotboardSvc.delete(sbno);
				req.setAttribute("message", "留言編號" + sbno + "刪除成功");
								
				Map<String,String[]> map = new TreeMap<>();
				map.put("spotno", new String[]{spotno});
				map.put("order by", new String[]{"sbtime desc"});
				List<SpotboardVO> list = spotboardSvc.getAll(map);
				req.setAttribute("list", list);
				RequestDispatcher dispatcher = req.getRequestDispatcher("/Back/Spotboard/SearchSpotBoard.jsp");
				dispatcher.forward(req, res);
				return;
			}
			else
			{
				Integer sbno = Integer.parseInt(req.getParameter("sbno"));
				SpotboardService spotboardSvc = new SpotboardService();
				spotboardSvc.delete(sbno);				
				res.sendRedirect(requestURL);
			}
			
		}
	}

}
