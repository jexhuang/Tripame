package com.spot.controller;

import java.io.IOException;
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

import com.ad.model.AdService;
import com.ad.model.AdVO;
import com.spot.model.SpotService;
import com.spot.model.SpotVO;

public class FrontSpot_Servlet extends HttpServlet 
{
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException 
	{
		doPost(req, res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException 
	{
		req.setCharacterEncoding("utf-8");// 處理中文檔名
		res.setContentType("text/html; charset=UTF-8");
		String action = req.getParameter("action");
		String requestURL = req.getParameter("requestURL");
		if("front_search_ad".equals(action))
		{
			Integer adno = Integer.parseInt(req.getParameter("adno"));
			AdService adSvc = new AdService();
			
			AdVO adVO = adSvc.getOneAd(adno);
			req.setAttribute("adVO", adVO);
			RequestDispatcher dispatcher = req.getRequestDispatcher("/Front/Spot/SpotDetail_Ad.jsp");
			dispatcher.forward(req, res);
			return;
		}
		if ("front_search_one".equals(action)) 
		{
			Integer spotno = Integer.parseInt(req.getParameter("spotno"));
			SpotService spotSvc = new SpotService();
			SpotVO spotVO = spotSvc.findSpot(spotno);
			req.setAttribute("spotVO", spotVO);
			Integer count = spotVO.getSpotlook()+1;
			spotSvc.updateSpot(spotVO.getSpotno(), spotVO.getMemno(),
					spotVO.getSpotclass(), spotVO.getSpotcon(),
					spotVO.getSpottown(), spotVO.getSpotname(), spotVO.getSpotphone(),
					spotVO.getSpotaddress(), spotVO.getSpotcontent(), spotVO.getSpotsite(), spotVO.getSpotsort(), count,
					spotVO.getSpotlat(), spotVO.getSpotlong(), spotVO.getSpotstatus(), spotVO.getSpotstay(), spotVO.getSpotpic());
			String spotclass = spotVO.getSpotclass();
			String spotcon = spotVO.getSpotcon();
			Map<String, String[]> map = new TreeMap<>();
			map.put("spotclass", new String[] { spotclass });
			map.put("order by", new String[] { "spotlook desc" });
			map.put("spotcon", new String[] { spotcon });
			map.put("rownum", new String[] { "<= 5" });
			List<SpotVO> famaus = spotSvc.getAll(map);
			req.setAttribute("famaus", famaus);
			req.setAttribute("spotclass", spotclass);
			RequestDispatcher dispatcher = req.getRequestDispatcher("/Front/Spot/SpotDetail_View.jsp");
			dispatcher.forward(req, res);
			return;
		}
		// 前端縣市搜尋
		if ("front_search_con".equals(action)) 
		{
			SpotService spotSvc = new SpotService();
			AdService adSvc = new AdService();
			
			String page = req.getParameter("page");			
			String spotcon = null;
			String spotclass = null;
			// 縣市
			if (req.getParameter("country") == null) 
			{
				spotcon = "基隆市";
			} else 
			{
				spotcon = new String(req.getParameter("country").getBytes(
						"ISO-8859-1"), "UTF-8");
			}
			// 分類
			if (req.getParameter("spotclass") == null) 
			{
				switch (page) 
				{
				case "spot":
					spotclass = "景點";
					break;
				case "food":
					spotclass = "美食";
					break;
				case "room":
					spotclass = "住宿";
					break;
				}
			} 
			else 
			{
				spotclass = new String(req.getParameter("spotclass").getBytes("ISO-8859-1"), "UTF-8");
			}
			req.setAttribute("spotclass", spotclass);
			req.setAttribute("spotcon", spotcon);
			
			// 該縣市所有景點、美食、住宿
			
			Map<String, String[]> map = new TreeMap<>();
			map.put("spotclass", new String[] { spotclass });
			map.put("spotcon", new String[] { spotcon });
			map.put("order by", new String[] { "spotno desc" });
			List<SpotVO> result = spotSvc.getAll(map);
			req.setAttribute("result", result);

			// 熱門景點、美食、住宿
			Map<String, String[]> map2 = new TreeMap<>();
			map2.put("spotclass", new String[] { spotclass });
			map2.put("order by", new String[] { "spotlook desc" });
			map2.put("spotcon", new String[] { spotcon });
			map2.put("rownum", new String[] { "<= 5" });
			List<SpotVO> famaus = spotSvc.getAll(map2);
			req.setAttribute("famaus", famaus);
			
			//廣告
			AdVO advo = new AdVO();
			List<AdVO> adResult = new ArrayList<>();
			List<AdVO> adList = adSvc.getAll();
			for(AdVO ad : adList)
			{
				if("上架中".equals(ad.getAdstatus()))
				{
					adResult.add(ad);
					advo = ad;
				}
			}
			req.setAttribute("advo", advo);
			req.setAttribute("adResult", adResult);
			
			// 該縣市的所有鄉鎮
			List<String> list = new ArrayList<>();
			switch (spotcon) 
			{
			case "基隆市":
				list.add("仁愛區");
				list.add("信義區");
				list.add("中正區");
				list.add("中山區");
				list.add("安樂區");
				list.add("暖暖區");
				list.add("七堵區");
				break;
			case "台北市":
				list.add("中正區");
				list.add("大同區");
				list.add("中山區");
				list.add("松山區");
				list.add("大安區");
				list.add("萬華區");
				list.add("信義區");
				list.add("士林區");
				list.add("北投區");
				list.add("內湖區");
				list.add("南港區");
				list.add("文山區");
				break;
			case "新北市":
				list.add("萬里區");
				list.add("金山區");
				list.add("板橋區");
				list.add("汐止區");
				list.add("深坑區");
				list.add("石碇區");
				list.add("瑞芳區");
				list.add("平溪區");
				list.add("雙溪區");
				list.add("貢寮區");
				list.add("新店區");
				list.add("坪林區");
				list.add("烏來區");
				list.add("永和區");
				list.add("中和區");
				list.add("土城區");
				list.add("三峽區");
				list.add("樹林區");
				list.add("鶯歌區");
				list.add("三重區");
				list.add("新莊區");
				list.add("泰山區");
				list.add("林口區");
				list.add("蘆洲區");
				list.add("五股區");
				list.add("八里區");
				list.add("淡水區");
				list.add("三芝區");
				list.add("石門區");
				break;
			case "桃園市":
				list.add("中壢區");
				list.add("平鎮區");
				list.add("龍潭區");
				list.add("楊梅區");
				list.add("新屋區");
				list.add("觀音區");
				list.add("桃園區");
				list.add("龜山區");
				list.add("八德區");
				list.add("大溪區");
				list.add("復興區");
				list.add("大園區");
				list.add("蘆竹區");
				break;
			case "新竹縣":
				list.add("竹北市");
				list.add("湖口鄉");
				list.add("新豐鄉");
				list.add("新埔鎮");
				list.add("關西鎮");
				list.add("芎林鄉");
				list.add("寶山鄉");
				list.add("竹東鎮");
				list.add("五峰鄉");
				list.add("橫山鄉");
				list.add("尖石鄉");
				list.add("北埔鄉");
				list.add("峨嵋鄉");
				break;
			case "新竹市":
				list.add("東區");
				list.add("北區");
				list.add("香山區");
				break;
			case "苗栗縣":
				list.add("竹南鎮");
				list.add("頭份鎮");
				list.add("三灣鄉");
				list.add("南莊鄉");
				list.add("獅潭鄉");
				list.add("後龍鎮");
				list.add("通霄鎮");
				list.add("苑裡鎮");
				list.add("苗栗市");
				list.add("造橋鄉");
				list.add("頭屋鄉");
				list.add("公館鄉");
				list.add("大湖鄉");
				list.add("泰安鄉");
				list.add("銅鑼鄉");
				list.add("三義鄉");
				list.add("西湖鄉");
				list.add("卓蘭鎮");
				break;
			case "台中市":
				list.add("中區");
				list.add("東區");
				list.add("南區");
				list.add("西區");
				list.add("北區");
				list.add("北屯區");
				list.add("西屯區");
				list.add("南屯區");
				list.add("太平區");
				list.add("大裡區");
				list.add("霧峰區");
				list.add("烏日區");
				list.add("豐原區");
				list.add("後裡區");
				list.add("石岡區");
				list.add("東勢區");
				list.add("和平區");
				list.add("新社區");
				list.add("潭子區");
				list.add("大雅區");
				list.add("神岡區");
				list.add("大肚區");
				list.add("沙鹿區");
				list.add("龍井區");
				list.add("梧棲區");
				list.add("清水區");
				list.add("大甲區");
				list.add("外埔區");
				list.add("大安區");
				break;
			case "彰化縣":
				list.add("彰化市");
				list.add("芬園鄉");
				list.add("花壇鄉");
				list.add("秀水鄉");
				list.add("鹿港鎮");
				list.add("福興鄉");
				list.add("線西鄉");
				list.add("和美鎮");
				list.add("伸港鄉");
				list.add("員林鎮");
				list.add("社頭鄉");
				list.add("永靖鄉");
				list.add("埔心鄉");
				list.add("溪湖鎮");
				list.add("大村鄉");
				list.add("埔鹽鄉");
				list.add("田中鎮");
				list.add("北斗鎮");
				list.add("田尾鄉");
				list.add("埤頭鄉");
				list.add("溪州鄉");
				list.add("竹塘鄉");
				list.add("二林鎮");
				list.add("大城鄉");
				list.add("芳苑鄉");
				list.add("二水鄉");
				break;
			case "南投縣":
				list.add("南投市");
				list.add("中寮鄉");
				list.add("草屯鎮");
				list.add("國姓鄉");
				list.add("埔裡鎮");
				list.add("仁愛鄉");
				list.add("名間鄉");
				list.add("集集鎮");
				list.add("水裡鄉");
				list.add("魚池鄉");
				list.add("信義鄉");
				list.add("竹山鎮");
				list.add("鹿谷鄉");
				break;
			case "雲林縣":
				list.add("斗南鎮");
				list.add("大埤鄉");
				list.add("虎尾鎮");
				list.add("土庫鎮");
				list.add("褒忠鄉");
				list.add("東勢鄉");
				list.add("臺西鄉");
				list.add("崙背鄉");
				list.add("麥寮鄉");
				list.add("斗六市");
				list.add("林內鄉");
				list.add("古坑鄉");
				list.add("莿桐鄉");
				list.add("西螺鎮");
				list.add("二崙鄉");
				list.add("北港鎮");
				list.add("水林鄉");
				list.add("口湖鄉");
				list.add("四湖鄉");
				list.add("元長鄉");
				break;
			case "嘉義縣":
				list.add("番路鄉");
				list.add("梅山鄉");
				list.add("竹崎鄉");
				list.add("阿里山");
				list.add("中埔鄉");
				list.add("大埔鄉");
				list.add("水上鄉");
				list.add("鹿草鄉");
				list.add("太保市");
				list.add("朴子市");
				list.add("東石鄉");
				list.add("六腳鄉");
				list.add("新港鄉");
				list.add("民雄鄉");
				list.add("大林鎮");
				list.add("溪口鄉");
				list.add("義竹鄉");
				list.add("布袋鎮");
				break;
			case "嘉義市":
				list.add("東區");
				list.add("西區");
				break;
			case "台南市":
				list.add("中西區");
				list.add("東區");
				list.add("南區");
				list.add("北區");
				list.add("安平區");
				list.add("安南區");
				list.add("永康區");
				list.add("歸仁區");
				list.add("新化區");
				list.add("左鎮區");
				list.add("玉井區");
				list.add("楠西區");
				list.add("南化區");
				list.add("仁德區");
				list.add("關廟區");
				list.add("龍崎區");
				list.add("官田區");
				list.add("麻豆區");
				list.add("佳裡區");
				list.add("西港區");
				list.add("七股區");
				list.add("將軍區");
				list.add("學甲區");
				list.add("北門區");
				list.add("新營區");
				list.add("後壁區");
				list.add("白河區");
				list.add("東山區");
				list.add("六甲區");
				list.add("下營區");
				list.add("柳營區");
				list.add("鹽水區");
				list.add("善化區");
				list.add("大內區");
				list.add("山上區");
				list.add("新市區");
				list.add("安定區");
				break;
			case "高雄市":
				list.add("新興區");
				list.add("前金區");
				list.add("苓雅區");
				list.add("鹽埕區");
				list.add("鼓山區");
				list.add("旗津區");
				list.add("前鎮區");
				list.add("三民區");
				list.add("楠梓區");
				list.add("小港區");
				list.add("左營區");
				list.add("仁武區");
				list.add("大社區");
				list.add("岡山區");
				list.add("路竹區");
				list.add("阿蓮區");
				list.add("田寮鄉");
				list.add("燕巢區");
				list.add("橋頭區");
				list.add("梓官區");
				list.add("彌陀區");
				list.add("永安區");
				list.add("湖內鄉");
				list.add("鳳山區");
				list.add("大寮區");
				list.add("林園區");
				list.add("鳥松區");
				list.add("大樹區");
				list.add("旗山區");
				list.add("美濃區");
				list.add("六龜區");
				list.add("內門區");
				list.add("杉林區");
				list.add("甲仙區");
				list.add("桃源區");
				list.add("那瑪夏區");
				list.add("茂林區");
				list.add("茄萣區");
				break;
			case "屏東縣":
				list.add("屏東市");
				list.add("三地門");
				list.add("霧臺鄉");
				list.add("瑪家鄉");
				list.add("九如鄉");
				list.add("裡港鄉");
				list.add("高樹鄉");
				list.add("鹽埔鄉");
				list.add("長治鄉");
				list.add("麟洛鄉");
				list.add("竹田鄉");
				list.add("內埔鄉");
				list.add("萬丹鄉");
				list.add("潮州鎮");
				list.add("泰武鄉");
				list.add("來義鄉");
				list.add("萬巒鄉");
				list.add("崁頂鄉");
				list.add("新埤鄉");
				list.add("南州鄉");
				list.add("林邊鄉");
				list.add("東港鎮");
				list.add("琉球鄉");
				list.add("佳冬鄉");
				list.add("新園鄉");
				list.add("枋寮鄉");
				list.add("枋山鄉");
				list.add("春日鄉");
				list.add("獅子鄉");
				list.add("車城鄉");
				list.add("牡丹鄉");
				list.add("恆春鎮");
				list.add("滿州鄉");
				break;
			case "宜蘭縣":
				list.add("宜蘭市");
				list.add("頭城鎮");
				list.add("礁溪鄉");
				list.add("壯圍鄉");
				list.add("員山鄉");
				list.add("羅東鎮");
				list.add("三星鄉");
				list.add("大同鄉");
				list.add("五結鄉");
				list.add("冬山鄉");
				list.add("蘇澳鎮");
				list.add("南澳鄉");
				list.add("釣魚台列嶼");
				break;
			case "花蓮縣":
				list.add("花蓮市");
				list.add("新城鄉");
				list.add("秀林鄉");
				list.add("吉安鄉");
				list.add("壽豐鄉");
				list.add("鳳林鎮");
				list.add("光復鄉");
				list.add("豐濱鄉");
				list.add("瑞穗鄉");
				list.add("萬榮鄉");
				list.add("玉裡鎮");
				list.add("卓溪鄉");
				list.add("富裡鄉");
				break;
			case "台東縣":
				list.add("臺東市");
				list.add("綠島鄉");
				list.add("蘭嶼鄉");
				list.add("延平鄉");
				list.add("卑南鄉");
				list.add("鹿野鄉");
				list.add("關山鎮");
				list.add("海端鄉");
				list.add("池上鄉");
				list.add("東河鄉");
				list.add("成功鎮");
				list.add("長濱鄉");
				list.add("太麻裡鄉");
				list.add("金峰鄉");
				list.add("大武鄉");
				list.add("達仁鄉");
				break;
			}			
			req.setAttribute("SpotCon", list);
			
			RequestDispatcher dispatcher = null;
			if (requestURL == null) {
				dispatcher = req
						.getRequestDispatcher("/Front/Spot/SearchSpot_View.jsp");
			} else {
				dispatcher = req.getRequestDispatcher(requestURL);
			}
			dispatcher.forward(req, res);
			return;
		}
	}
}
