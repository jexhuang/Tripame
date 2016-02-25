package com.trip.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.sql.*;

import javax.sql.DataSource;

import com.mem.model.MemVO;
import com.route.model.RouteDAO;
import com.route.model.RouteService;
import com.route.model.RouteVO;
import com.spot.model.SpotService;
import com.spot.model.SpotVO;
import com.trip.model.TripService;
import com.trip.model.TripVO;

@WebServlet("/TripServlet")
public class TripServlet extends HttpServlet {

	public TripServlet() {
		super();
	}

	protected void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		doPost(req, res);
	}

	@SuppressWarnings({ "unchecked" })
	protected void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8"); // 處理中文檔名
		res.setContentType("text/html; charset=UTF-8");
		PrintWriter out = res.getWriter();
		
		String action = req.getParameter("action");// 取得使用者所執行的查詢動作
		String area = req.getParameter("map");// 取得動態地圖所選的縣市
		String tmpArea = req.getParameter("tmpArea");// 取得使用者所選的縣市
		String tripplan = req.getParameter("tripplan");// 取得使用者所執行的行程規划動作
		String saveRecive = req.getParameter("saveRecive");// 取得使用者所執行的儲存或修改行程動作
		String deleteTrip = req.getParameter("delete");// 取得使用者所執行的刪除行程動作
		String checkRoute = req.getParameter("checkRoute");// 取得使用者所執行的檢視行程動作
		String check = req.getParameter("checkIt");

		if ("check".equals(check)) {
			String[] viewArray = req.getParameterValues("viewArray[]");// 取得spotno
			Integer stayTimeCount = 0;
			boolean hourse = false;
			if(viewArray==null){
				out.println("boom");
				return;//防止500發生爆炸
			}
			for (int i = 0; i < viewArray.length; i++) {
				Integer spotNo = Integer.valueOf(viewArray[i]);
				SpotService spotSvc = new SpotService();
				Integer spot = spotSvc.findSpot(spotNo).getSpotstay();
				stayTimeCount += spot;
				
				if (spotSvc.findSpot(spotNo).getSpotclass().equals("住宿")){
					hourse=true;
				}
			}
			if(stayTimeCount<300 && hourse==true){
				out.println(1);//提示增加景點
			}else if (stayTimeCount>300 && hourse==false){
				out.println(2);//提示增加住宿
			}else if (stayTimeCount<300 && hourse==false){
				out.println(3);//提示增加景點與住宿
			}
		}

		// 地圖與分類的複合查詢
		if (tmpArea != null && "classSearch".equals(action)) {

			String class1 = req.getParameter("class");// 取得景點類別名稱
			class1 = new String(class1.getBytes("ISO-8859-1"), "UTF-8");
			tmpArea = new String(tmpArea.getBytes("ISO-8859-1"), "UTF-8");

			SpotService spotSvc = new SpotService();
			Map<String, String[]> map = new TreeMap<>();

			map.put("spotclass", new String[] { class1 });
			map.put("spotcon", new String[] { tmpArea });

			List<SpotVO> spotList = spotSvc.getAll(map);
			req.setAttribute("spotList", spotList);

			String url = "/Front/Trip/spotView.jsp";
			RequestDispatcher successView = getServletContext()
					.getRequestDispatcher(url); // 成功轉交spotView.jsp
			successView.forward(req, res);

		}
		// 分類查詢
		if (tmpArea == null && "classSearch".equals(action)) {

			String str = req.getParameter("class");
			str = new String(str.getBytes("ISO-8859-1"), "UTF-8");
			SpotService spotSvc = new SpotService();
			Map<String, String[]> map = new TreeMap<>();

			map.put("spotclass", new String[] { str });

			List<SpotVO> spotList = spotSvc.getAll(map);
			req.setAttribute("spotList", spotList);
			String url = "/Front/Trip/spotView.jsp";
			RequestDispatcher successView = getServletContext()
					.getRequestDispatcher(url); // 成功轉交spotView.jsp
			successView.forward(req, res);

		}
		// 關鍵字查詢
		if ("searchSpot".equals(action)) {
			String str = req.getParameter("spot");
			str = new String(str.getBytes("ISO-8859-1"), "UTF-8");

			if (str.equals("")) {
				return;
			}
			SpotService spotSvc = new SpotService();
			Map<String, String[]> map = new TreeMap<>();

			map.put("spotname", new String[] { str });

			List<SpotVO> spotList = spotSvc.getAll(map);
			req.setAttribute("spotList", spotList);
			String url = "/Front/Trip/spotView.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交spotView.jsp
			successView.forward(req, res);

		}
		// 地圖查詢
		if ("searchArea".equals(area)) { // 來自select_page.jsp的請求
			String str = req.getParameter("area");
			String searchOption = req.getParameter("searchOption");
			str = new String(str.getBytes("ISO-8859-1"), "UTF-8");
			searchOption = new String(searchOption.getBytes("ISO-8859-1"),
					"UTF-8");

			SpotService spotSvc = new SpotService();
			Map<String, String[]> map = new TreeMap<>();
			if ("分類".equals(searchOption)) {
				map.put("spotcon", new String[] { str });
			} else {
				map.put("spotclass", new String[] { searchOption });
				map.put("spotcon", new String[] { str });
			}

			List<SpotVO> spotList = spotSvc.getAll(map);
			req.setAttribute("spotList", spotList);
			req.setAttribute("tmpArea", str);
			String url = "/Front/Trip/spotView.jsp";
			RequestDispatcher successView = getServletContext()
					.getRequestDispatcher(url); // 成功轉交spotView.jsp
			successView.forward(req, res);

		}

		// 行程規劃按鈕
		if ("tripplan".equals(tripplan)) {
			Map<String, ArrayList<String>> viewName = new TreeMap<String, ArrayList<String>>();// 儲存顯示於景點表的景點名稱
			Map<String, ArrayList<String>> viewAddr = new TreeMap<String, ArrayList<String>>();// 儲存各個景點的地址
			Map<String, ArrayList<Integer>> viewNo = new TreeMap<String, ArrayList<Integer>>();// 儲存各個景點的編號

			SpotService spotSvc = new SpotService();
			String views = "";// 景點表的天數頁籤名稱
			String tripName = req.getParameter("tripName");
			String tripno = req.getParameter("tripno");
			Integer days = Integer.valueOf(req.getParameter("days"));
			String[] twArray = new String[2];
			twArray[0] = req.getParameter("country").toString();
			twArray[1] = req.getParameter("district").toString();

			String[] dateArray = new String[4];
			dateArray[0] = req.getParameter("dateBegin");
			dateArray[1] = req.getParameter("fromTime");
			dateArray[2] = req.getParameter("dateEnd");
			dateArray[3] = req.getParameter("toTime");

			for (int i = 0; i < days; i++) {
				ArrayList<String> list = new ArrayList<String>();// 儲存旅遊點名稱
				ArrayList<String> listAddr = new ArrayList<String>();// 儲存旅遊點地址
				ArrayList<Integer> listNo = new ArrayList<Integer>();// 儲存旅遊點編號
				// 儲存旅遊點經緯度
				SpotVO spotVO;
				views = "day" + (i + 1);
				if (req.getParameterValues(views) != null) {// 取出景hidden中名為day1,2,3...中的景點陣列
					String[] tmp = req.getParameterValues(views);
					for (int j = 0; j < tmp.length; j++) {
						spotVO = spotSvc.findSpot(Integer.valueOf(tmp[j]));
						list.add(spotVO.getSpotname());
						listAddr.add(spotVO.getSpotaddress());
						listNo.add(Integer.valueOf(tmp[j]));

					}
					viewName.put(views, list);
					viewAddr.put(views, listAddr);
					viewNo.put(views, listNo);
				}
			}
			HttpSession session = req.getSession();
			session.setAttribute("viewNo", viewNo);
			req.setAttribute("tripName", tripName);
			req.setAttribute("tripno", tripno);
			req.setAttribute("viewName", viewName);
			req.setAttribute("viewAddr", viewAddr);
			req.setAttribute("twArea", twArray);
			req.setAttribute("dateArray", dateArray);

			String url = "/Front/Trip/checkRoute.jsp";
			RequestDispatcher successView = getServletContext()
					.getRequestDispatcher(url); // 成功轉交checkRoute.jsp
			successView.forward(req, res);

		}

		// 儲存行程
		if ("saveTrip".equals(saveRecive)) {
			HttpSession session = req.getSession();
			TripService tripSvc = new TripService();
			RouteService routeSvc = new RouteService();

			String tripNo = req.getParameter("tripno");
			String tripName = req.getParameter("tripName");
			String dateBegin = req.getParameter("dateBegin");
			String fromTime = req.getParameter("fromTime");
			String dateEnd = req.getParameter("dateEnd");
			String toTime = req.getParameter("toTime");
			Double departureLat = Double.parseDouble(req
					.getParameter("departureLat"));
			Double departureLong = Double.parseDouble(req
					.getParameter("departureLong"));

			String strBegin = dateBegin + " " + fromTime;
			String strEnd = dateEnd + " " + toTime;

			MemVO memVO = (MemVO) session.getAttribute("memvo");
			Integer memNo = memVO.getMemno();
			Map<String, ArrayList<Integer>> viewNo = (Map<String, ArrayList<Integer>>) session
					.getAttribute("viewNo");// 取得景點編號
			if(viewNo==null){
				System.out.println("null");
			}
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");

			try {
				Date begin = sdf.parse(strBegin);
				Date end = sdf.parse(strEnd);
				java.sql.Timestamp tripbegin = new java.sql.Timestamp(
						begin.getTime());
				java.sql.Timestamp tripend = new java.sql.Timestamp(
						end.getTime());
				if (tripNo.equals("")) {
					// 新增trip資料後,回傳剛剛新增的tripno
					Integer tripno = tripSvc.addTrip(memNo, tripName,
							departureLong, departureLat, tripbegin, tripend);
					for (int i = 1; i <= viewNo.size(); i++) {// 控制天數
						for (int j = 0; j < viewNo.get("day" + i).size(); j++) {// 控制該天的景點數
							Integer actno;// 暫存活動編號
							Integer spotno = viewNo.get("day" + i).get(j);
							if (spotno > 10000) {
								actno = 1000;
								routeSvc.addRoute(tripno, spotno, actno,
										(j + 1), String.valueOf(i));

							} else {// 小於10000,則是活動編號

							}
						}
					}
				} else {
					routeSvc.deleteRoute(Integer.parseInt(tripNo));
					tripSvc.deleteTrip(Integer.parseInt(tripNo));
					Integer tripno = tripSvc.addTrip(memNo, tripName,
							departureLong, departureLat, tripbegin, tripend);
					for (int i = 1; i <= viewNo.size(); i++) {// 控制天數
						for (int j = 0; j < viewNo.get("day" + i).size(); j++) {// 控制該天的景點數
							Integer actno;// 暫存活動編號
							Integer spotno = viewNo.get("day" + i).get(j);
							if (spotno > 10000) {
								actno = 1000;
								routeSvc.addRoute(tripno, spotno, actno,
										(j + 1), String.valueOf(i));

							} else {// 小於10000,則是活動編號

							}
						}
					}
				}

				String url = req.getContextPath() + "/Front/Trip/memRoute.jsp";
				res.sendRedirect(url);
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
		// 刪除行程
		if ("deleteTrip".equals(deleteTrip)) {
			String tripNo = req.getParameter("tripNo");
			RouteService routeSvc = new RouteService();
			TripService tripSvc = new TripService();
			routeSvc.deleteRoute(Integer.parseInt(tripNo));
			tripSvc.deleteTrip(Integer.parseInt(tripNo));

			String url = req.getContextPath() + "/Front/Trip/memRoute.jsp";
			res.sendRedirect(url);
		}
		// 檢視行程
		if ("checkRoute".equals(checkRoute)) {

			Map<String, ArrayList<String>> viewName = new TreeMap<String, ArrayList<String>>();// 儲存顯示於景點表的景點名稱
			Map<String, ArrayList<String>> viewAddr = new TreeMap<String, ArrayList<String>>();// 儲存各個景點的地址
			Map<String, ArrayList<Integer>> viewNo = new TreeMap<String, ArrayList<Integer>>();// 儲存各個景點的編號

			Integer tripno = Integer.parseInt(req.getParameter("tripno"));// 取得使用者所執行的檢視行程動作
			TripService tripSvc = new TripService();
			RouteService routeSvc = new RouteService();
			TripVO tripVO = tripSvc.getOneTrip(tripno);
			Integer maxday = routeSvc.getMaxDay(tripno);// 取得最大天數

			for (int i = 1; i <= maxday; i++) {
				String views = "day" + i;
				ArrayList<String> list = new ArrayList<String>();// 儲存旅遊點名稱
				ArrayList<String> listAddr = new ArrayList<String>();// 儲存旅遊點地址
				ArrayList<Integer> listNo = new ArrayList<Integer>();// 儲存旅遊點編號
				List<RouteVO> routeList = routeSvc.findByForeignKey(tripno, i);
				for (int j = 0; j < routeList.size(); j++) {
					list.add(routeSvc
							.getSpotsByspotno(routeList.get(j).getSpotno())
							.get(0).getSpotname());// 先找出route表中的spotno再找出spot表的spotname
					listAddr.add(routeSvc
							.getSpotsByspotno(routeList.get(j).getSpotno())
							.get(0).getSpotaddress());
					listNo.add(routeSvc
							.getSpotsByspotno(routeList.get(j).getSpotno())
							.get(0).getSpotno());
				}
				viewName.put(views, list);
				viewAddr.put(views, listAddr);
				viewNo.put(views, listNo);
			}

			SimpleDateFormat yMd = new SimpleDateFormat("yyyy-MM-dd");
			SimpleDateFormat hm = new SimpleDateFormat("hh:mm a");

			String[] dateArray = new String[4];
			dateArray[0] = yMd.format(tripVO.getTripbegin());
			dateArray[1] = hm.format(tripVO.getTripbegin());
			dateArray[2] = yMd.format(tripVO.getTripend());
			dateArray[3] = hm.format(tripVO.getTripend());

			String[] latlong = new String[2];
			latlong[0] = tripSvc.getOneTrip(tripno).getTriplong().toString();
			latlong[1] = tripSvc.getOneTrip(tripno).getTriplat().toString();
			req.setAttribute("tripno", tripno);
			req.setAttribute("latlong", latlong);
			req.setAttribute("tripName", tripSvc.getOneTrip(tripno)
					.getTripname());
			req.setAttribute("viewNo", viewNo);
			req.setAttribute("viewName", viewName);
			req.setAttribute("viewAddr", viewAddr);
			req.setAttribute("dateArray", dateArray);

			String url = "/Front/Trip/checkRoute.jsp";
			RequestDispatcher successView = getServletContext()
					.getRequestDispatcher(url); // 成功轉交checkRoute.jsp
			successView.forward(req, res);
		}
		// 修改行程
		if ("reciveTrip".equals(saveRecive)) {

			HttpSession session = req.getSession();
			TripService tripSvc = new TripService();
			RouteService routeSvc = new RouteService();

			String tripNo = req.getParameter("tripno");
			String tripName = req.getParameter("tripName");
			if (tripName.length() == 0) {
				tripName = "我的行程";
			}
			String dateBegin = req.getParameter("dateBegin");
			String fromTime = req.getParameter("fromTime");
			String dateEnd = req.getParameter("dateEnd");
			String toTime = req.getParameter("toTime");
			Double departureLat = Double.parseDouble(req
					.getParameter("departureLat"));
			Double departureLong = Double.parseDouble(req
					.getParameter("departureLong"));

			String strBegin = dateBegin + " " + fromTime;
			String strEnd = dateEnd + " " + toTime;

			MemVO memVO = (MemVO) session.getAttribute("memvo");
			Integer memNo = memVO.getMemno();
			Map<String, ArrayList<Integer>> viewNo = (Map<String, ArrayList<Integer>>) session
					.getAttribute("viewNo");// 取得景點編號

			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
			Integer tripno = 0;
			try {
				Date begin = sdf.parse(strBegin);
				Date end = sdf.parse(strEnd);
				java.sql.Timestamp tripbegin = new java.sql.Timestamp(
						begin.getTime());
				java.sql.Timestamp tripend = new java.sql.Timestamp(
						end.getTime());
				if (tripNo.equals("")) {
					// 新增trip資料後,回傳剛剛新增的tripno
					tripno = tripSvc.addTrip(memNo, tripName, departureLong,
							departureLat, tripbegin, tripend);
					for (int i = 1; i <= viewNo.size(); i++) {// 控制天數
						for (int j = 0; j < viewNo.get("day" + i).size(); j++) {// 控制該天的景點數
							Integer actno;// 暫存活動編號
							Integer spotno = viewNo.get("day" + i).get(j);
							if (spotno > 10000) {
								actno = 1000;
								routeSvc.addRoute(tripno, spotno, actno,
										(j + 1), String.valueOf(i));

							} else {// 小於10000,則是活動編號

							}
						}
					}
				} else {
					routeSvc.deleteRoute(Integer.parseInt(tripNo));
					tripSvc.deleteTrip(Integer.parseInt(tripNo));
					tripno = tripSvc.addTrip(memNo, tripName, departureLong,
							departureLat, tripbegin, tripend);
					for (int i = 1; i <= viewNo.size(); i++) {// 控制天數
						for (int j = 0; j < viewNo.get("day" + i).size(); j++) {// 控制該天的景點數
							Integer actno;// 暫存活動編號
							Integer spotno = viewNo.get("day" + i).get(j);
							if (spotno > 10000) {
								actno = 1000;
								routeSvc.addRoute(tripno, spotno, actno,
										(j + 1), String.valueOf(i));

							} else {// 小於10000,則是活動編號

							}
						}
					}
				}

			} catch (ParseException e) {
				e.printStackTrace();
			}

			Map<String, ArrayList<String>> viewName = new TreeMap<String, ArrayList<String>>();// 儲存顯示於景點表的景點名稱
			Map<String, ArrayList<String>> viewAddr = new TreeMap<String, ArrayList<String>>();// 儲存各個景點的地址
			TreeMap<String, ArrayList<Integer>> viewNo1 = new TreeMap<String, ArrayList<Integer>>();// 儲存各個景點的編號
			String tripNo1 = req.getParameter("tripno");

			Integer tripno1 = 0;// 取得使用者所執行的檢視行程動作
			if (tripno != 0) {
				tripno1 = tripno;
			} else {
				tripno1 = Integer.parseInt(tripNo1);
			}
			TripService tripSvc1 = new TripService();
			RouteService routeSvc1 = new RouteService();
			TripVO tripVO1 = tripSvc1.getOneTrip(tripno1);

			Integer maxday = routeSvc.getMaxDay(tripno1);// 取得最大天數

			for (int i = 1; i <= maxday; i++) {
				String views = "day" + i;
				ArrayList<String> list = new ArrayList<String>();// 儲存旅遊點名稱
				ArrayList<String> listAddr = new ArrayList<String>();// 儲存旅遊點地址
				ArrayList<Integer> listNo = new ArrayList<Integer>();// 儲存旅遊點編號
				List<RouteVO> routeList = routeSvc.findByForeignKey(tripno1, i);
				for (int j = 0; j < routeList.size(); j++) {
					list.add(routeSvc1
							.getSpotsByspotno(routeList.get(j).getSpotno())
							.get(0).getSpotname());// 先找出route表中的spotno再找出spot表的spotname
					listAddr.add(routeSvc1
							.getSpotsByspotno(routeList.get(j).getSpotno())
							.get(0).getSpotaddress());
					listNo.add(routeSvc1
							.getSpotsByspotno(routeList.get(j).getSpotno())
							.get(0).getSpotno());
				}
				viewName.put(views, list);
				viewAddr.put(views, listAddr);
				viewNo1.put(views, listNo);
			}

			SimpleDateFormat yMd = new SimpleDateFormat("yyyy-MM-dd");
			SimpleDateFormat hm = new SimpleDateFormat("hh:mm a");

			String[] dateArray = new String[4];
			dateArray[0] = yMd.format(tripVO1.getTripbegin());
			dateArray[1] = hm.format(tripVO1.getTripbegin());
			dateArray[2] = yMd.format(tripVO1.getTripend());
			dateArray[3] = hm.format(tripVO1.getTripend());

			String[] latlong = new String[2];
			latlong[0] = tripSvc1.getOneTrip(tripno1).getTriplong().toString();
			latlong[1] = tripSvc1.getOneTrip(tripno1).getTriplat().toString();

			req.setAttribute("latlong", latlong);
			req.setAttribute("tripName", tripSvc1.getOneTrip(tripno1)
					.getTripname());
			req.setAttribute("tripno", tripno1);
			req.setAttribute("viewName", viewName);
			req.setAttribute("viewAddr", viewAddr);
			req.setAttribute("dateArray", dateArray);
			req.setAttribute("viewNo", viewNo1);
			
			String url = "/Front/Trip/memtrip1.jsp";
			RequestDispatcher successView = getServletContext()
					.getRequestDispatcher(url); // 成功轉交checkRoute.jsp
			successView.forward(req, res);
		}

	}// doPost_end
}
