<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.travel.model.*"%>
<%@ page import="com.trajoin.model.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="tjsvc" class="com.trajoin.model.TrajoinService"/>
<jsp:useBean id="travelsvc" class="com.travel.model.TravelService"/>
<%
	List<TravelVO> list1 = travelsvc.getAll();
	List<TravelVO> list = new ArrayList<TravelVO>();
	for (TravelVO tvo : list1) {
		if (tvo.getTravelstatus().equals("上架中")) {
			list.add(tvo);
		}
	}
	pageContext.setAttribute("list", list);
%>
<html>
<head>
<style>
#page {
	display: none;
}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>套裝行程列表</title>
</head>
<jsp:include page="/Front/select_page.jsp" />
<body>
	<div class="container">
		<div class="row clearfix">
		<div class="col-md-12 column">
				<ol class="breadcrumb">
				<li><a
						href="<%=request.getContextPath()%>/Front/front_index.jsp">首頁</a></li>
					<li class="active">套裝行程列表</li>
				</ol>
		</div>
		</div>
	 	<div class="jumbotron" style="background-color:rgb(66,139,202);">
   			 <marquee behavior="alternate" scrollamount="20"><h1 style="font-family:'微軟正黑體';color: white;">歡迎報名套裝行程</h1></marquee>      
  		</div>
		<table class="table">
			<tr>
				<th>行程圖片</th>
				<th>行程名稱</th>
				<th>限制人數</th>
				<th>截止日期</th>
				<th>報名費</th>
				<th>&nbsp</th>
			</tr>
			<%@ include file="pages/page1.file"%>
			<c:forEach var="travelvo" items="${list}" begin="<%=pageIndex%>"
				end="<%=pageIndex+rowsPerPage-1%>">
				<tr>
					<td><img
						src="<%=request.getContextPath()%>/travel/TravelPicReader?travelno=${travelvo.travelno}"
						height="150" width="150"></td>
					<td style="line-height: 120px;">${travelvo.travelname}</td>
					<td style="line-height: 120px;">${travelvo.travellimit}</td>
					<td style="line-height: 120px;">${travelvo.traveldeadline}</td>
					<td style="line-height: 120px;">${travelvo.travelprice}</td>
					<td>
					<br><br>
						<FORM METHOD="post"
							ACTION="<%=request.getContextPath()%>/travel/TravelServlet">
							<input type="submit" value="詳細內容" class="btn btn-info"> <input type="hidden"
								name="travelno" value="${travelvo.travelno}"> <input
								type="hidden" name="action" value="WatchTravel">
						</FORM>	
					</td>
					
				</tr>
			</c:forEach>
		</table>
		<%@ include file="pages/page2.file"%>
	</div>
</body>
</html>