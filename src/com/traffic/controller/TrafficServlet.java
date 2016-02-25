package com.traffic.controller;

import java.io.*;
import java.util.*;

import javax.servlet.*;
import javax.servlet.http.*;

import com.traffic.model.*;

public class TrafficServlet extends HttpServlet {

	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		res.setContentType("text/html; charset=UTF-8");
		String action = req.getParameter("action");
		
		HttpSession session = req.getSession();
		
		if("search".equals(action))
		{
			String requestURL = req.getParameter("requestURL");
			String tracon = req.getParameter("tracon").trim();
			String traclass = req.getParameter("traclass").trim();
			String traname = req.getParameter("traname").trim();
			
			TrafficService traSvc = new TrafficService();
			Map<String,String[]> map = new TreeMap<>();
			if(!"請選擇縣市".equals(tracon))
			{
				map.put("tracon", new String[]{tracon});
			}
			if(!"請選擇工具".equals(traclass))
			{
				map.put("traclass", new String[]{traclass});
			}
			if(traname.length()!=0)
			{
				map.put("traname", new String[]{traname});
			}
			List<TrafficVO> list = traSvc.getAll(map);
			session.setAttribute("list", list);
			
			RequestDispatcher successView = req.getRequestDispatcher(requestURL);// 成功轉交 update_emp_input.jsp
			successView.forward(req, res);
			return;
		}
		if("search2".equals(action))
		{
			String requestURL = req.getParameter("requestURL");
			String tracon = req.getParameter("tracon").trim();
			String traclass = req.getParameter("traclass").trim();
			String traname = req.getParameter("traname").trim();
			TrafficService traSvc = new TrafficService();
			Map<String,String[]> map = new TreeMap<>();
			String stclass = null;
			if("bus".equals(traclass))
			{
				stclass = "客運";
			}
			else if("ride".equals(traclass))
			{
				stclass = "機車";
			}
			else if("taxi".equals(traclass))
			{
				stclass = "計程車";
			}
			map.put("traclass", new String[]{stclass});
			if(!"請選擇縣市".equals(tracon))
			{
				map.put("tracon", new String[]{tracon});
			}
			if(traname.length()!=0)
			{
				map.put("traname", new String[]{traname});
			}
			List<TrafficVO> list = traSvc.getAll(map);
			session.setAttribute("list", list);
			RequestDispatcher successView = req.getRequestDispatcher(requestURL + "?traclass=" + traclass);// 成功轉交 update_emp_input.jsp
			successView.forward(req, res);
			return;
		}
		if ("getOne_For_Update".equals(action)) { // 來自listAllEmp.jsp的請求	
		
			/***************************1.接收請求參數****************************************/
			Integer trano = new Integer(req.getParameter("trano"));
				
			/***************************2.開始查詢資料****************************************/
			TrafficService trafficSvc = new TrafficService();
			TrafficVO trafficVO = trafficSvc.getOneTraffic(trano);
								
			/***************************3.查詢完成,準備轉交(Send the Success view)************/
			req.setAttribute("trafficVO", trafficVO);         // 資料庫取出的empVO物件,存入req
			RequestDispatcher successView = req.getRequestDispatcher("/Back/Traffic/UpdateTra.jsp");// 成功轉交 update_emp_input.jsp
			successView.forward(req, res);
			return;
		}
				
		if ("update".equals(action)) 
		{
			String requestURL = req.getParameter("requestURL");
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
					
			/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
			Integer trano = new Integer(req.getParameter("trano").trim());
			String tracon = req.getParameter("tracon").trim();
			String traaddress = req.getParameter("traaddress").trim();
			if(traaddress.length()==0)
			{
				errorMsgs.add("請輸入地址");
			}
			String trasite = req.getParameter("trasite").trim();
			if(trasite.length()==0)
			{
				trasite = "無";
			}
			String traclass = req.getParameter("traclass").trim();
				
			String traname = req.getParameter("traname").trim();
			if(traname.length()==0)
			{				
				errorMsgs.add("請輸入名稱.");
			}
								
			String traphone = req.getParameter("traphone").trim();
			if(traphone.length()==0)
			{
				traphone = "無";
			}
			
			TrafficVO trafficVO = new TrafficVO();
			trafficVO.setTrano(trano);
			trafficVO.setTraclass(traclass);
			trafficVO.setTraname(traname);
			trafficVO.setTraphone(traphone);
			trafficVO.setTracon(tracon);
			trafficVO.setTraaddress(traaddress);
			trafficVO.setTrasite(trasite);				
			// Send the use back to the form, if there were errors
			if (!errorMsgs.isEmpty())
			{
				req.setAttribute("trafficVO", trafficVO); // 含有輸入格式錯誤的empVO物件,也存入req
				RequestDispatcher failureView = req.getRequestDispatcher("/traffic/update_traffic_input.jsp");
				failureView.forward(req, res);
				return; //程式中斷
			}
				
			/***************************2.開始修改資料*****************************************/
			TrafficService trafficSvc = new TrafficService();
			trafficVO = trafficSvc.updateTraffic(trano, traclass, traname, traphone, tracon, traaddress, trasite);
				
			/***************************3.修改完成,準備轉交(Send the Success view)*************/
			req.setAttribute("trafficVO", trafficVO); // 資料庫update成功後,正確的的empVO物件,存入req
			session.removeAttribute("list");
			RequestDispatcher successView = req.getRequestDispatcher(requestURL); // 修改成功後,轉交listOneEmp.jsp
			successView.forward(req, res);
			return;
		}

        if ("insert".equals(action)) { // 來自addEmp.jsp的請求  
        	String requestURL = req.getParameter("requestURL");
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			/***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/
			String traclass = req.getParameter("traclass").trim();
			if(traclass.length()==0)
			{
				traclass = "無";
			}
			String tracon = req.getParameter("tracon").trim();
			if(tracon.length()==0)
			{
				errorMsgs.add("請選擇縣市");
			}
			String traaddress = req.getParameter("traaddress").trim();
			if(traaddress.length()==0)
			{
				errorMsgs.add("請輸入地址");
			}
			String trasite = req.getParameter("trasite").trim();
			if(trasite.trim().length()==0)
			{
				trasite = "無";
			}
								
			String traname = req.getParameter("traname").trim();
			if(traname.length()==0)
			{
				errorMsgs.add("請輸入名稱.");					
			}
							
			String traphone = req.getParameter("traphone").trim();
			if(traphone.length()==0)
			{					
				traphone = "無";
			}

			TrafficVO trafficVO = new TrafficVO();
			trafficVO.setTraclass(traclass);
			trafficVO.setTraname(traname);
			trafficVO.setTraphone(traphone);
			trafficVO.setTracon(tracon);
			trafficVO.setTraaddress(traaddress);
			trafficVO.setTrasite(trasite);

			// Send the use back to the form, if there were errors
			if (!errorMsgs.isEmpty()) 
			{
				req.setAttribute("trafficVO", trafficVO); // 含有輸入格式錯誤的empVO物件,也存入req
				RequestDispatcher failureView = req.getRequestDispatcher("/Back/Traffic/NewTra.jsp");
				failureView.forward(req, res);
				return;
			}
			/***************************2.開始新增資料***************************************/
			TrafficService trafficSvc = new TrafficService();
			trafficVO = trafficSvc.addTraffic(traclass, traname, traphone, tracon, traaddress, trasite);
			/***************************3.新增完成,準備轉交(Send the Success view)***********/
			session.removeAttribute("list");
			RequestDispatcher successView = req.getRequestDispatcher(requestURL); // 新增成功後轉交listAllEmp.jsp
			successView.forward(req, res);				
				
		}
		
		
		if ("delete".equals(action)) { // 來自listAllEmp.jsp

			String requestURL = req.getParameter("requestURL");
			/***************************1.接收請求參數***************************************/
			Integer trano = new Integer(req.getParameter("trano"));
				
			/***************************2.開始刪除資料***************************************/
			TrafficService trafficSvc = new TrafficService();
			trafficSvc.deleteTraffic(trano);
			session.removeAttribute("list");
			/***************************3.刪除完成,準備轉交(Send the Success view)***********/								
			RequestDispatcher successView = req.getRequestDispatcher(requestURL);// 刪除成功後,轉交回送出刪除的來源網頁
			successView.forward(req, res);
				
		}
	}
}
