package com.activity.controller;

import java.io.IOException;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.activity.model.ActivityService;
import com.activity.model.ActivityVO;
import com.ad.model.AdService;
import com.ad.model.AdVO;


public class FrontAct_Servlet extends HttpServlet 
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
		if("front_search_ad".equals(action))
		{
			Integer adno = Integer.parseInt(req.getParameter("adno"));
			AdService adSvc = new AdService();
			ActivityService actSvc = new ActivityService();
			//一個月活動查詢
			String beginmon = null;
			Calendar rightNow = Calendar.getInstance();
			rightNow.add(Calendar.MONTH, 1);
			int year = rightNow.get(Calendar.YEAR);
			int month = rightNow.get(Calendar.MONTH)+1;
			if(month<10)
			{
				beginmon = "0" + month;
			}
			else
			{
				beginmon = month + "";
			}
			
			Map<String,String[]> actmap = new TreeMap<>();			
			actmap.put("actbegin", new String[]{year + "-" + beginmon + "-01"});
			List<ActivityVO> list = actSvc.getAll(actmap);
			List<ActivityVO> list2 = new ArrayList<>();
			for(ActivityVO li : list)
			{
				if(li.getActbegin().after(Date.valueOf(year + "-" + (month-1) + "-01")) || li.getActbegin().equals(Date.valueOf(year + "-" + (month-1) + "-01")))
				{
					list2.add(li);
				}
			}
			req.setAttribute("actList", list2);
			
			//廣告內容
			AdVO adVO = adSvc.getOneAd(adno);
			req.setAttribute("adVO", adVO);
			RequestDispatcher dispatcher = req.getRequestDispatcher("/Front/Activity/ActDetail_Ad.jsp");
			dispatcher.forward(req, res);
			return;
		}
		if("front_search_con".equals(action))
		{
			ActivityService actSvc = new ActivityService();
			AdService adSvc = new AdService();
			//縣市			
			String actcon = null;
			if(req.getParameter("country")!=null)
			{
				actcon = new String(req.getParameter("country").getBytes("ISO-8859-1"),"UTF-8");
			}
			else
			{
				actcon = "基隆市";
			}
			//縣市活動查詢
			Map<String,String[]> map = new TreeMap<>();
			map.put("actcon", new String[]{actcon});
			List<ActivityVO> result = actSvc.getAll(map);
			req.setAttribute("result", result);
			//一個月活動查詢
			String beginmon = null;
			Calendar rightNow = Calendar.getInstance();
			int year = rightNow.get(Calendar.YEAR);
			int month = rightNow.get(Calendar.MONTH)+1;
			int date = rightNow.get(Calendar.DATE);
			if(month<10)
			{
				beginmon = "0" + month;
			}
			else
			{
				beginmon = month + "";
			}
			
			Map<String,String[]> actmap = new TreeMap<>();			
			actmap.put("actbegin", new String[]{year + "-" + beginmon + "-" + date});
			actmap.put("actend", new String[]{year + "-" + beginmon + "-" + date});
			List<ActivityVO> list = actSvc.getAll(actmap);

			req.setAttribute("actList", list);
			req.setAttribute("actcon", actcon);
			
			//廣告輪播
			AdVO adVO = new AdVO();
			List<AdVO> adList = adSvc.getAll();
			List<AdVO> adResult = new ArrayList<>();
			for(AdVO ad : adList)
			{
				if("上架中".equals(ad.getAdstatus()))
				{
					adResult.add(ad);
					adVO = ad;
				}
			}
			req.setAttribute("adResult", adResult);
			req.setAttribute("advo", adVO);
			RequestDispatcher dispatcher = null;
				dispatcher = req.getRequestDispatcher("/Front/Activity/SearchAct.jsp");				
			dispatcher.forward(req, res);
			return;
			
		}
		if("front_search_one".equals(action))
		{
			Integer actno = Integer.parseInt(req.getParameter("actno"));
			ActivityService actSvc = new ActivityService();
			//活動細節
			ActivityVO actVO = actSvc.findAct(actno);
			req.setAttribute("actVO", actVO);
			//一個月活動查詢
			String beginmon = null;
			Calendar rightNow = Calendar.getInstance();
			int year = rightNow.get(Calendar.YEAR);
			int month = rightNow.get(Calendar.MONTH)+1;
			int date = rightNow.get(Calendar.DATE);
			if(month<10)
			{
				beginmon = "0" + month;
			}
			else
			{
				beginmon = month + "";
			}
			
			Map<String,String[]> actmap = new TreeMap<>();			
			actmap.put("actbegin", new String[]{year + "-" + beginmon + "-" + date});
			actmap.put("actend", new String[]{year + "-" + beginmon + "-" + date});
			List<ActivityVO> list = actSvc.getAll(actmap);
			req.setAttribute("actList", list);
			RequestDispatcher dispatcher = req.getRequestDispatcher("/Front/Activity/ActDetail.jsp");
			dispatcher.forward(req, res);
			return;
		}
	}

}
