<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.travel.model.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	TravelService travelsvc = new TravelService();
	List<TravelVO> list = travelsvc.getAll();
	pageContext.setAttribute("list", list);
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>套裝行程列表</title>
</head>
<jsp:include page="/Back/back_index.jsp"/>
<body>
	<div class="container">
		<h2>套裝行程管理</h2>
		<ol class="breadcrumb" style="background-color: rgb(66, 139, 202)">
			<li><a href="<%=request.getContextPath()%>/Back/back_index.jsp"
				style="color: white;">首頁</a></li>
			<li class="active" style="color: white;">套裝行程列表</li>
		</ol>
		<table class="table table-bordered">
			<tr>
				<th>行程圖片</th>
				<th>行程名稱</th>
				<th>報名人數</th>
				<th>截止日期</th>
				<th>報名費</th>
				<th>行程狀態</th>
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
					<td style="line-height: 150px;">${travelvo.travelname}</td>	
					<td style="line-height: 150px;">${travelvo.travellimit}</td>
					<td style="line-height: 150px;">${travelvo.traveldeadline}</td>
					<td style="line-height: 150px;">${travelvo.travelprice}</td>
					<td style="line-height: 150px;">${travelvo.travelstatus}</td>
					<td>
					<br><br><br>
					<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/travel/TravelServlet">
			    		 <input type="submit" value="檢視行程" class="btn btn-info"> 
			    		 <input type="hidden" name="travelno" value="${travelvo.travelno}">
				   	     <input type="hidden" name="action"	value="UpdateOneTravel">
				    </FORM>
					</td>
					<td>
					<br><br><br>
					<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/travel/TravelServlet">
			    		 <input type="submit" value="刪除行程" class="btn btn-danger" ${(travelvo.travelstatus=='上架中')?'disabled':''}> 
			    		 <input type="hidden" name="travelno" value="${travelvo.travelno}">
				   	     <input type="hidden" name="action"	value="DeleteOneTravel">
				    </FORM>
					</td>				
				</tr>
			</c:forEach>
		</table>
		<a class="btn btn-primary" href="<%=request.getContextPath()%>/Back/Travel/AddNewTravel.jsp" role="button">新增行程</a>
		<%@ include file="pages/page2.file"%>
	</div>
</body>
</html>