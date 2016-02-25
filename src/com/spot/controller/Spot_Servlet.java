package com.spot.controller;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.spot.model.SpotService;
import com.spot.model.SpotVO;

@WebServlet("/spot/Spot_Servlet")
@MultipartConfig(fileSizeThreshold=1024*1024, maxFileSize=5*1024*1024, maxRequestSize=5*5*1024*1024)
public class Spot_Servlet extends HttpServlet 
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
		//輸入
		if("insert".equals(action))
		{		
			List<String> errorMsgs = new LinkedList<>();
			req.setAttribute("errorMsgs", errorMsgs);
			try
			{
				SpotService spotSvc = new SpotService();
				Part part = req.getPart("spotpic");
				String spotclass = null;
				if("請選擇".equals(req.getParameter("spotclass")))
				{
					errorMsgs.add("請選擇分類");					
				}
				else
				{
					spotclass = req.getParameter("spotclass").trim();
				}				
				String spotcon = null;
				String spottown = null;
				if(req.getParameter("country").trim().length()!=0 && req.getParameter("district").trim().length()!=0)
				{
					spotcon = req.getParameter("country").trim();
					spottown = req.getParameter("district").trim();					
				}
				else
				{
					errorMsgs.add("請選擇縣市和鄉鎮");
				}				
				String spotname = null;
				if(req.getParameter("spotname").trim().length()!=0)
				{
					spotname = req.getParameter("spotname").trim();					
				}
				else
				{
					errorMsgs.add("請輸入名稱");
				}
				String spotphone = null;
				if(req.getParameter("spotphone").trim().length()!=0)
				{
					spotphone = req.getParameter("spotphone").trim();					
				}
				else
				{
					spotphone="無";
				}
				String spotaddress = null;
				if(req.getParameter("spotaddress").trim().length()!=0)
				{
					spotaddress = req.getParameter("spotaddress").trim();					
				}
				else
				{
					errorMsgs.add("請輸入地址");
				}
				String spotcontent = null;
				if(req.getParameter("spotcontent").trim().length()!=0)
				{
					spotcontent = req.getParameter("spotcontent").trim();					
				}
				else
				{
					spotcontent = "無";
				}
				String spotsite = null;
				if(req.getParameter("spotsite").trim().length()!=0)
				{
					spotsite = req.getParameter("spotsite").trim();					
				}
				else
				{
					spotsite = "無";
				}
				String spotsort = req.getParameter("spotsort").trim();
				Integer spotlook = Integer.parseInt(req.getParameter("spotlook").trim());
				Double spotlat = Double.parseDouble(req.getParameter("spotlat").trim());;
				Double spotlong = Double.parseDouble(req.getParameter("spotlong").trim());
				String spotstatus = req.getParameter("spotstatus").trim();
				Integer spotstay = 0; 
				if(req.getParameter("spotstay").trim().length()!=0)
				{
					try
					{
						spotstay = Integer.parseInt(req.getParameter("spotstay").trim());
					}
					catch(NumberFormatException e)
					{
						errorMsgs.add("停留時間請填整數");
					}
				}
				else
				{
					spotstay = 60;
				}
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
						while((read = fin.read(temp)) >=0)
						{
							buffer.write(temp,0,read);
						}
					}
					catch (IOException e)
					{
						e.printStackTrace();
					}
					data = buffer.toByteArray();
				}
				if(fin != null)
				{
					fin.close();
				}
				if(!errorMsgs.isEmpty())
				{
					SpotVO spotVO = new SpotVO();
					spotVO.setSpotclass(spotclass);
					spotVO.setSpotcon(spotcon);
					spotVO.setSpottown(spottown);
					spotVO.setSpotname(spotname);
					spotVO.setSpotphone(spotphone);
					spotVO.setSpotaddress(spotaddress);
					spotVO.setSpotcontent(spotcontent);
					spotVO.setSpotpic(data);
					spotVO.setSpotsite(spotsite);
					spotVO.setSpotsort(spotsort);
					spotVO.setSpotlook(spotlook);
					spotVO.setSpotlat(spotlat);
					spotVO.setSpotlong(spotlong);
					spotVO.setSpotstatus(spotstatus);
					spotVO.setSpotstay(spotstay);
					req.setAttribute("SpotVO", spotVO);
					RequestDispatcher dispatcher = req.getRequestDispatcher("/Back/Spot/NewSpot.jsp");
					dispatcher.forward(req, res);
				}
				else
				{
					spotSvc.insertSpot(10001,spotclass,spotcon,spottown,spotname,spotphone,spotaddress,
							spotcontent,spotsite,spotsort,spotlook,spotlat,spotlong,spotstatus,spotstay,
							data);
					RequestDispatcher dispatcher = req.getRequestDispatcher(requestURL);
					dispatcher.forward(req, res);
				}
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
			
			return;
		}
		if("search".equals(action))
		{
			String spotcon = null;
			String spottown = null;
			String spotclass = null;
			String spotname = req.getParameter("spotname");
			String[] spotstatus = null;
			Map<String ,String[]> map = new TreeMap<>();
			SpotService spotSvc = new SpotService();
			try
			{
				spotcon = req.getParameter("country");
				map.put("spotcon", new String[]{spotcon});
			}
			catch(NullPointerException e){}
			try
			{
				spottown = req.getParameter("district");
				map.put("spottown", new String[]{spottown});
			}
			catch(NullPointerException e){}
			try
			{
				spotstatus = req.getParameterValues("spotstatus");
				map.put("spotstatus", new String[]{spotstatus[0]});
			}
			catch(NullPointerException e){}
			try
			{
				spotclass = req.getParameter("spotclass");
				if(!"欲搜尋分類".equals(spotclass))
				{
					map.put("spotclass", new String[]{spotclass});
				}				
			}
			catch(NullPointerException e){}
			map.put("spotname", new String[]{spotname});
			List<SpotVO> list = spotSvc.getAll(map);
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
			int spotno = Integer.parseInt(req.getParameter("spotno"));
			String isupdate = req.getParameter("isupdate");
			
			SpotService spotSvc = new SpotService();
			SpotVO spotVO = spotSvc.findSpot(spotno);
			
			if("no".equals(isupdate))
			{
				
				req.setAttribute("SpotVO", spotVO);
				RequestDispatcher sucessView = req.getRequestDispatcher("/Back/Spot/UpdateSpot.jsp");
				sucessView.forward(req, res);
			}
			else if("yes".equals(isupdate))
			{
				List<String> errorMsgs = new LinkedList<>();
				req.setAttribute("errorMsgs", errorMsgs);
				Part part = req.getPart("spotpic");
				String spotclass = null;
				if("請選擇".equals(req.getParameter("spotclass").trim()))
				{
					errorMsgs.add("請選擇分類");
				}
				else
				{
					spotclass = req.getParameter("spotclass").trim();
				}
				String spotaddress = null;
				if(req.getParameter("spotaddress").trim().length()!=0)
				{
					spotaddress = req.getParameter("spotaddress").trim();					
				}
				else
				{
					errorMsgs.add("請輸入地址");
				}
				String spotcon = null;
				String spottown = null;
				if(req.getParameter("country").trim().length()!=0 && req.getParameter("district").trim().length()!=0)
				{
					spotcon = req.getParameter("country").trim();
					spottown = req.getParameter("district").trim();					
				}
				else
				{
					errorMsgs.add("請選擇縣市和鄉鎮");
				}
				String spotname = req.getParameter("spotname").trim();
				if(req.getParameter("spotname").trim().length()!=0)
				{
					spotname = req.getParameter("spotname").trim();					
				}
				else
				{
					errorMsgs.add("請輸入名稱");
				}
				String spotphone = req.getParameter("spotphone").trim();
				if(req.getParameter("spotphone").trim().length()!=0)
				{
					spotphone = req.getParameter("spotphone").trim();					
				}
				else
				{
					spotphone = "無";
				}
				String spotcontent = null;
				if(req.getParameter("spotcontent").trim().length()!=0)
				{
					spotcontent = req.getParameter("spotcontent").trim();					
				}
				else
				{
					spotcontent = "無";
				}
				String spotsite = req.getParameter("spotsite").trim();
				if(req.getParameter("spotsite").trim().length()!=0)
				{
					spotsite = req.getParameter("spotsite").trim();					
				}
				else
				{
					spotsite = "無";
				}
				String spotsort = req.getParameter("spotsort").trim();
				Integer spotlook = Integer.parseInt(req.getParameter("spotlook").trim());
				Double spotlat = Double.parseDouble(req.getParameter("spotlat").trim());
				Double spotlong = Double.parseDouble(req.getParameter("spotlong").trim());
				String spotstatus = req.getParameter("spotstatus").trim();
				Integer spotstay = 0;
				if(req.getParameter("spotstay").trim().length()!=0)
				{
					try
					{
						spotstay = Integer.parseInt(req.getParameter("spotstay").trim());
					}
					catch(NumberFormatException e)
					{
						errorMsgs.add("停留時間請填整數");
					}
				}
				else
				{
					spotstay = 60;
				}
				
				InputStream fin = part.getInputStream();
				byte[] data=new byte[0];
				if(fin.available()==0)
				{
					data=spotVO.getSpotpic();
				}
				else
				{
					ByteArrayOutputStream buffer = new ByteArrayOutputStream();
					byte[] temp = new byte[4096];
					int read;
					try
					{
						while((read = fin.read(temp)) >=0)
						{
							buffer.write(temp,0,read);
						}
					}
					catch (IOException e)
					{
						e.printStackTrace();
					}
					data = buffer.toByteArray();
					fin.close();
				}
				if(!errorMsgs.isEmpty())
				{
					req.setAttribute("SpotVO", spotVO);
					RequestDispatcher dispatcher = req.getRequestDispatcher("/Back/Spot/UpdateSpot.jsp");
					dispatcher.forward(req, res);
				}
				else
				{
					session.removeAttribute("list");
					spotSvc.updateSpot(spotno,10001,spotclass,spotcon,spottown,spotname,spotphone,spotaddress,
							spotcontent,spotsite,spotsort,spotlook,spotlat,spotlong,spotstatus,spotstay,data);
					
					RequestDispatcher dispatcher = req.getRequestDispatcher(requestURL);				
					dispatcher.forward(req, res);
				}				
			}			
			return;
		}
	}
}
