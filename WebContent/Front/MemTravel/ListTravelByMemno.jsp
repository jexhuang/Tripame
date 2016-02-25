<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.travel.model.*"%>
<%@ page import="com.trajoin.model.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="memvo" scope="session" class="com.mem.model.MemVO"/>
<jsp:useBean id="tjsvc" class="com.trajoin.model.TrajoinService"/>
<jsp:useBean id="travelsvc" class="com.travel.model.TravelService"/>
<%
	List<TrajoinVO> list3=tjsvc.getAll();
	List<TravelVO> list1 = travelsvc.getAll();
	List<TravelVO> list = new ArrayList<TravelVO>();
	int c=0;
	for(TrajoinVO tjvo:list3){
		if(tjvo.getMemno().equals(memvo.getMemno())){
			for (TravelVO tvo : list1) {
					if(tjvo.getTravelno().equals(tvo.getTravelno())){
						list.add(tvo);
						c=1;
					}
			}
		}
	}
	pageContext.setAttribute("list", list);
	pageContext.setAttribute("c", c);
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>套裝行程列表</title>
</head>
<jsp:include page="/Front/select_page.jsp" />
<script type="text/javascript">
	function blinklink() {
		if (!document.getElementById('blink').style.color) {
			document.getElementById('blink').style.color = "red";
		}
		if (document.getElementById('blink').style.color == "red") {
			document.getElementById('blink').style.color = "yellow";
		} else {
			document.getElementById('blink').style.color = "red";
		}
		timer = setTimeout("blinklink()", 300);
	}
</script>
<body onload="blinklink()">
	<div class="container">
	<ol class="breadcrumb">
			<li><a href="<%=request.getContextPath()%>/Front/front_index.jsp">首頁</a></li>
			<li><a href="<%=request.getContextPath()%>/Front/Trip/memRoute.jsp">會員專區</a></li>
			<li class="active">已報名的行程</li>
		</ol>
		<c:if test="${c<1}">
			<div class="jumbotron" style="background-color: black;">
				<a id="blink" href="<%=request.getContextPath()%>/Front/Travel/ListTravel.jsp">
				<h1 align="center"  style="font-family:微軟正黑體">快來報名我們的套裝行程吧!</h1>
				</a>
			</div>
		</c:if>
		<c:if test="${c>0}">
		<table class="table table-bordered">
			<tr>
				<th>行程圖片</th>
				<th>行程名稱</th>
				<th>報名人數</th>
				<th>截止日期</th>
				<th>報名費</th>
				<th>&nbsp</th>
				<th>&nbsp</th>
			</tr>
			<%@ include file="pages/page1.file"%>
			<c:forEach var="travelvo" items="${list}" begin="<%=pageIndex%>"
				end="<%=pageIndex+rowsPerPage-1%>">
				<tr align='center' valign='middle'>
					<td><img
						src="<%=request.getContextPath()%>/travel/TravelPicReader?travelno=${travelvo.travelno}"
						height="150" width="150"></td>
					<td style="line-height: 140px;">${travelvo.travelname}</td>
					<td style="line-height: 140px;">${travelvo.travellimit}</td>
					<td style="line-height: 140px;">${travelvo.traveldeadline}</td>
					<td style="line-height: 140px;">${travelvo.travelprice}</td>
					<td>
					<br><br>
						<FORM METHOD="post"
							ACTION="<%=request.getContextPath()%>/travel/TravelServlet">
							<input type="submit" value="詳細內容" class="btn btn-info"> <input type="hidden"
								name="travelno" value="${travelvo.travelno}"> <input
								type="hidden" name="action" value="WatchTravelByMem">
						</FORM>
					</td>
					<td>
					<br><br>
					<FORM METHOD="get"
							ACTION="<%=request.getContextPath()%>/Front/MemTravel/MemPayTravel.jsp">
							<input type="submit" value="我要退費" class="btn btn-danger"> 
							<input type="hidden" name="travelno" value="${travelvo.travelno}">
					</FORM>
					</td>
				</tr>
			</c:forEach>
		</table>
		<%@ include file="pages/page2.file"%>
		</c:if>
	</div>
</body>
</html>