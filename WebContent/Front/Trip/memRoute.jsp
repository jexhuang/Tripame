<%@ page language="java" contentType="text/html; charset=BIG5"
	pageEncoding="BIG5"%>
<%@ page import="com.spot.model.*"%>
<%@ page import="com.trip.model.*"%>
<%@ page import="com.mem.model.*"%>
<%@ page import="com.route.model.*"%>
<%@ page import="java.util.*"%>
<%
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=BIG5">
<title>我的行程</title>
<style>
hr {
	background-color: red;
}

.tripFrame {
	border: 1px solid #cccccc;
	margin-left: 65px;
	margin-top: 10px;
	float: left;
	box-shadow: 2px 2px 5px 2px #cccccc;
	border-radius: 10px;
}

a img:hover {
	opacity: 0.85;
}
</style>
<script>
function deleteTrip(tripno){
	var xhr=new XMLHttpRequest();
	var name = "#"+tripno;
	  //設定好回呼函數 
	  xhr.onreadystatechange=function(){
		  if(xhr.readyState==4){
			  if(xhr.status==200){
					$(name).empty();
					window.location.reload();
				  }
			  else{
				  alert(xhr.status);
				  }
			  }
		  };
	  //建立好Get連接與送出請求
		var url='<%=request.getContextPath()%>'+ "/Trip/tripplan?delete=deleteTrip&tripNo=" + tripno;
		xhr.open("Get", url, true);
		xhr.send(null);
		return false;
	}
</script>
</head>
<jsp:include page="/Front/select_page.jsp" />
<body style="font-family: '微軟正黑體'">
	<div class="container">
		<div class="row clearfix">
			<div class="col-md-12 column">
				<ol class="breadcrumb">
				<li><a
						href="<%=request.getContextPath()%>/Front/front_index.jsp">首頁</a></li>
					<li><a
						href="<%=request.getContextPath()%>/Front/Trip/memRoute.jsp">會員專區</a></li>
					<li class="active">我的行程</li>
				</ol>
			</div>
		</div>
		<div class="row clearfix">
			<div class="col-md-12 column" >
					<img
						src="<%=request.getContextPath()%>/mem/MemPicReader?memno=${memvo.memno}"
						width="120" height="160">
					<font style="font-family: '微軟正黑體';font-size:36px">${memvo.memname}玩過的行程</font>
					<HR>
				</div>		
			

		</div>
		
		<div class="row clearfix">
			<div class="col-md-12 column">
				<%
					MemVO memVO = new MemVO();
					RouteVO routeVO = new RouteVO();
					memVO = (MemVO) session.getAttribute("memvo");

					Integer memno = memVO.getMemno();//取得目前使用者的會員編號

					TripService tripSvc = new TripService();
					RouteService routeSvc = new RouteService();

					List<TripVO> tripList = new ArrayList<TripVO>();
					List<SpotVO> spotList = new ArrayList<SpotVO>();

					tripList = tripSvc.getTripsByMemno(memno);

					for (int i = tripList.size() - 1; i >= 0; i--) {//取出list中的所有資料
							Integer tripno = tripList.get(i).getTripno();//由trip表取出tripno

							routeVO = routeSvc.getSpotno(tripno);////由route表找出符合tripno欄位且routeSeq及days欄位微1的tripno欄位
							if (routeVO == null) {
									continue;
							}
							String tripbegin[] = tripList.get(i).getTripbegin()
										.toLocaleString().split(":");
							String begin = tripbegin[0] + ":" + tripbegin[1];
							String tripend[] = tripList.get(i).getTripend()
										.toLocaleString().split(":");
							String end = tripend[0] + ":" + tripend[1];

							Integer spotno = routeVO.getSpotno();//由route表取出spotno

							String imgUrl = "<img src='" + request.getContextPath()
										+ "/spot/SpotList_Img?spotno=" + spotno
										+ "' width='215' height='160' title='檢視行程'>";

							out.println("<div id='"
										+ tripno
										+ "' class='col-md-3 column tripFrame' style='text-align:center;'><form  class='form-horizontal' role='form' action='"
										+ request.getContextPath()
										+ "/Trip/route' method='post'>");
								out.println("<head'><h3 style=\"font-family:'微軟正黑體'\";><button type='button' class='close' name='deleteButton' data-dismiss='modal' aria-hidden='true' onclick='deleteTrip("
										+ tripno
										+ ")'>X</button>"
										+ tripList.get(i).getTripname() + "</h3></head><hr>");
								out.println("<body><a href='" + request.getContextPath()
										+ "/Trip/tripplan?checkRoute=checkRoute&tripno="+tripList.get(i).getTripno()
										+ "' role='button' class='btn'>" + imgUrl
										+ "</a></body><hr>");
								out.println("<footer>開始：" + begin + "<br>結束：" + end
										+ "</footer>");
								out.println("<input type='hidden' name='tripNo' value='"
										+ tripno + "'></form>");
								out.println("</div>");//col-md-4_close
							}
				%>
			</div>
		</div>
	</div>
</body>
</html>

