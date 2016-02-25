package com.activity.controller;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Date;
import java.util.LinkedList;
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
import javax.servlet.http.Part;

import com.activity.model.ActivityService;
import com.activity.model.ActivityVO;



@WebServlet("/act/Activity_Servlet")
@MultipartConfig(fileSizeThreshold=1024*1024, maxFileSize=5*1024*1024, maxRequestSize=5*5*1024*1024)
public class Activity_Servlet extends HttpServlet 
{
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req,res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException 
	{
		req.setCharacterEncoding("utf-8");// 處理中文檔名
		res.setContentType("text/html; charset=UTF-8");
		PrintWriter out = res.getWriter();
		HttpSession session=req.getSession();
		String action = req.getParameter("action");
		String requestURL = req.getParameter("requestURL");
		if ("address".equals(action)) {
			String con = req.getParameter("con");
			String con1 = new String(con.getBytes("ISO-8859-1"), "UTF-8");
			String dis = req.getParameter("dis");
			String dis1 = new String(dis.getBytes("ISO-8859-1"), "UTF-8");
			out.println(con1 + dis1);
		}
		if("insert".equals(action))
		{
			ActivityService actSvc = new ActivityService();
			List<String> errorMsgs = new LinkedList<>();
			req.setAttribute("errorMsgs", errorMsgs);
			String actaddress = req.getParameter("actaddress").trim();
			if(actaddress.trim().length()==0)
			{
				errorMsgs.add("請輸入地址");
			}
			String actsite = null;
			if(req.getParameter("actsite").trim().length()!=0)
			{
				actsite = req.getParameter("actsite").trim();
			}
			else
			{
				actsite = "無";
			}
			String actname = req.getParameter("actname").trim();
			if(actname.trim().length()==0)
			{
				errorMsgs.add("請輸入名稱");
			}
			String actorg = req.getParameter("actorg").trim();
			if(actorg.trim().length()==0)
			{
				errorMsgs.add("請輸入主辦單位");
			}
			String actphone = req.getParameter("actphone").trim();
			if(actphone.trim().length()!=0)
			{
				actphone = req.getParameter("actphone").trim();
			}
			else
			{
				actphone = "無";
			}
			String actcon = null;
			String acttown = null;
			if(req.getParameter("country").trim().length()!=0 && req.getParameter("district").trim().length()!=0)
			{
				actcon = req.getParameter("country").trim();
				acttown = req.getParameter("district").trim();				
			}
			else
			{
				errorMsgs.add("請選擇縣市和鄉鎮");
			}
			String actstatus = req.getParameter("actstatus").trim();
			Integer actstay = null;
			if(req.getParameter("actstay").trim().length()!=0)
			{				
				try
				{
					actstay = Integer.parseInt(req.getParameter("actstay").trim());
				}
				catch(NumberFormatException e)
				{
					errorMsgs.add("停留時間請輸入整數");
				}
			}
			else
			{
				actstay = 60;
			}
			Integer acthours = null;
			if(req.getParameter("acthours").trim().length()!=0)
			{
				try
				{
					acthours = Integer.parseInt(req.getParameter("acthours"));
				}
				catch(NumberFormatException e)
				{
					errorMsgs.add("營業時間請填入整數");
				}
			}
			else
			{
				acthours = 800;
			}			
			Integer actprice = null;
			if(req.getParameter("actprice").length()!=0)
			{
				try
				{
					actprice = Integer.parseInt(req.getParameter("actprice"));
				}
				catch(NumberFormatException e)
				{
					errorMsgs.add("價格請輸入數字");
				}
			}
			else
			{
				actprice = 0;
			}	
			Double actlat = Double.parseDouble(req.getParameter("actlat"));
			Double actlong = Double.parseDouble(req.getParameter("actlong"));
			Date actbegin = null;
			Date actend = null;
			try
			{
				actbegin = Date.valueOf(req.getParameter("actbegin"));
				actend = Date.valueOf(req.getParameter("actend"));
			}
			catch(IllegalArgumentException e)
			{
				errorMsgs.add("請選擇開始和結束日期");
			}
			String actcontent = null;
			if(req.getParameter("actcontent").trim().length()!=0)
			{
				actcontent = req.getParameter("actcontent");
			}
			else
			{
				actcontent = "無";
			}
			Part part = req.getPart("actpic");
			InputStream fin = part.getInputStream();
			byte[] data = null;
			if(fin.available()==0)
			{
				errorMsgs.add("請放入圖片");
			}
			else
			{
				ByteArrayOutputStream buffer = new ByteArrayOutputStream();
				byte[] temp = new byte[4096];
				int read;
				try
				{
					
					while((read = fin.read(temp)) >= 0)
					{
						buffer.write(temp, 0, read);;
					}
				}
				catch(IOException e)
				{
					e.printStackTrace();
				}
				data = buffer.toByteArray();
			}
			if(fin!=null)
			{
				fin.close();
			}
			if(!errorMsgs.isEmpty())
			{
				ActivityVO activityVO = new ActivityVO();
				activityVO.setActaddress(actaddress);
				activityVO.setActsite(actsite);
				activityVO.setActname(actname);
				activityVO.setActorg(actorg);
				activityVO.setActphone(actphone);
				activityVO.setActcon(actcon);
				activityVO.setActtown(acttown);
				activityVO.setActstatus(actstatus);
				activityVO.setActstay(actstay);
				activityVO.setActhours(acthours);
				activityVO.setActprice(actprice);
				activityVO.setActlat(actlat);
				activityVO.setActlong(actlong);
				activityVO.setActbegin(actbegin);
				activityVO.setActend(actend);
				activityVO.setActcontent(actcontent);
				activityVO.setActpic(data);
				req.setAttribute("ActVO", activityVO);
				RequestDispatcher dispatcher = req.getRequestDispatcher("/Back/Activity/NewAct.jsp");
				dispatcher.forward(req, res);
			}
			else
			{
				System.out.println(actbegin);
				actSvc.insertAct(actcon, acttown, actname, actphone, actaddress, actcontent, actsite, actorg, actbegin, actend,
						acthours, actlat, actlong, actprice, actstatus, actstay, data);
				RequestDispatcher dispatcher = req.getRequestDispatcher(requestURL);
				dispatcher.forward(req, res);
			}
			return;
		}
		if("search".equals(action))
		{
			String actcon = null;
			String acttown = null;
			String actname = req.getParameter("actname");
			String[] actstatus = null;
			Map<String ,String[]> map = new TreeMap<>();
			ActivityService actSvc = new ActivityService();
			try
			{
				actcon = req.getParameter("country");
				map.put("actcon", new String[]{actcon});
			}
			catch(NullPointerException e){}
			try
			{
				acttown = req.getParameter("district");
				map.put("acttown", new String[]{acttown});
			}
			catch(NullPointerException e){}
			try
			{
				actstatus = req.getParameterValues("actstatus");
				map.put("actstatus", new String[]{actstatus[0]});
			}
			catch(NullPointerException e){}
			
			map.put("actname", new String[]{actname});
			List<ActivityVO> list = actSvc.getAll(map);
			if(list.size()==0)
			{
				req.setAttribute("result", "未搜尋到結果");
			}
			session.setAttribute("list", list);
			RequestDispatcher sucessView = req.getRequestDispatcher(requestURL);
			sucessView.forward(req, res);
			return;
		}
		if("update".equals(action))
		{
			Integer actno = Integer.parseInt(req.getParameter("actno"));
			String isupdate = req.getParameter("isupdate");
			
			ActivityService actSvc = new ActivityService();
			ActivityVO actVO = actSvc.findAct(actno);
			
			if("no".equals(isupdate))
			{
				req.setAttribute("ActVO", actVO);
				RequestDispatcher sucessView = req.getRequestDispatcher("/Back/Activity/UpdateAct.jsp");
				sucessView.forward(req, res);
			}
			if("yes".equals(isupdate))
			{
				List<String> errorMsgs = new LinkedList<>();
				req.setAttribute("errorMsgs", errorMsgs);
				String actaddress = null;
				if(req.getParameter("actaddress").trim().length()!=0)
				{
					actaddress = req.getParameter("actaddress");					
				}
				else
				{
					errorMsgs.add("請輸入地址");
				}
				String actsite = null;
				if(req.getParameter("actsite").trim().length()!=0)
				{
					actsite = req.getParameter("actsite");
				}
				else
				{
					actsite = "無";
				}
				String actname = null;
				if(req.getParameter("actname").trim().length()!=0)
				{
					actname = req.getParameter("actname");
				}
				else
				{
					errorMsgs.add("請輸入名稱");					
				}
				String actorg = null;
				if(req.getParameter("actorg").trim().length()!=0)
				{
					actorg = req.getParameter("actorg");
				}
				else
				{					
					errorMsgs.add("請輸入主辦單位");
				}
				String actphone = null;
				if(req.getParameter("actphone").trim().length()!=0)
				{
					actphone = req.getParameter("actphone");					
				}
				else
				{
					errorMsgs.add("請輸入電話");
				}
				String actcon = null;
				String acttown = null;
				if(req.getParameter("country").trim().length()!=0 && req.getParameter("district").trim().length()!=0)
				{
					actcon = req.getParameter("country");
					acttown = req.getParameter("district");					
				}
				else
				{
					errorMsgs.add("請選擇縣市和鄉鎮");
				}
				String actstatus = req.getParameter("actstatus");
				Integer actstay = null;
				if(req.getParameter("actstay").trim().length()!=0)
				{
					try
					{
						actstay = Integer.parseInt(req.getParameter("actstay"));
					}
					catch(NumberFormatException e)
					{
						errorMsgs.add("停留時間請輸入整數");
					}
				}
				else
				{
					actstay = 60;
				}
				
				Integer acthours = null;
				if(req.getParameter("acthours").trim().length()!=0)
				{
					try
					{
						acthours = Integer.parseInt(req.getParameter("acthours"));
					}
					catch(NumberFormatException e)
					{
						errorMsgs.add("請輸入開業時間(ex:800)");
					}
				}
				else
				{
					acthours = 800;
				}
				Integer actprice = null;
				if(req.getParameter("actprice").trim().length()!=0)
				{
					try
					{
						actprice = Integer.parseInt(req.getParameter("actprice"));
					}
					catch(NumberFormatException e)
					{
						errorMsgs.add("價格請輸入數字");
					}
				}
				else
				{
					actprice = 0;
				}				
				Double actlat = Double.parseDouble(req.getParameter("actlat"));
				Double actlong = Double.parseDouble(req.getParameter("actlong"));
				Date actbegin = null;
				Date actend = null;
				try
				{
					actbegin = Date.valueOf(req.getParameter("actbegin"));
					actend = Date.valueOf(req.getParameter("actend"));
				}
				catch(IllegalArgumentException e)
				{
					errorMsgs.add("請選擇開始日期和結束日期");
				}
				String actcontent = null;
				if(req.getParameter("actcontent").trim().length()!=0)
				{
					actcontent = req.getParameter("actcontent").trim();
				}
				else
				{
					actcontent = "無";
				}
				Part part = req.getPart("actpic");
				InputStream fin = part.getInputStream();
				byte[] data = null;
				if(fin.available()==0)
				{
					data=actVO.getActpic();
				}
				else
				{
					ByteArrayOutputStream buffer = new ByteArrayOutputStream();
					byte[] temp = new byte[4096];
					int read;
					try
					{
						
						while((read = fin.read(temp)) >= 0)
						{
							buffer.write(temp, 0, read);;
						}
					}
					catch(IOException e)
					{
						e.printStackTrace();
					}
					data = buffer.toByteArray();
				}
				if(fin!=null)
				{
					fin.close();
				}
				if(!errorMsgs.isEmpty())
				{
					ActivityVO activityVO = new ActivityVO();
					activityVO.setActaddress(actaddress);
					activityVO.setActsite(actsite);
					activityVO.setActname(actname);
					activityVO.setActorg(actorg);
					activityVO.setActphone(actphone);
					activityVO.setActcon(actcon);
					activityVO.setActtown(acttown);
					activityVO.setActstatus(actstatus);
					activityVO.setActstay(actstay);
					activityVO.setActhours(acthours);
					activityVO.setActprice(actprice);
					activityVO.setActlat(actlat);
					activityVO.setActlong(actlong);
					activityVO.setActbegin(actbegin);
					activityVO.setActend(actend);
					activityVO.setActcontent(actcontent);
					activityVO.setActpic(data);
					activityVO.setActno(actno);
					req.setAttribute("ActVO", activityVO);
					RequestDispatcher dispatcher = req.getRequestDispatcher("/Back/Activity/UpdateAct.jsp");
					dispatcher.forward(req, res);
					return;
				}
				else
				{
					session.removeAttribute("list");
					actSvc.updateAct(actno,actcon, acttown, actname, actphone, actaddress, actcontent, actsite, actorg, actbegin, actend,
							acthours, actlat, actlong, actprice, actstatus, actstay, data);
					RequestDispatcher dispatcher = req.getRequestDispatcher(requestURL);
					dispatcher.forward(req, res);
					return;
				}
			}
		}
		if("delete".equals(action))
		{
			Integer actno = Integer.parseInt(req.getParameter("actno"));
			
			ActivityService actSvc = new ActivityService();
			actSvc.deleteAct(actno);
			session.removeAttribute("list");
			RequestDispatcher dispatcher = req.getRequestDispatcher(requestURL);
			dispatcher.forward(req, res);
			return;
		}
	}

}
