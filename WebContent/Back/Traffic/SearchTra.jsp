<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.traffic.model.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>交通管理</title>
<jsp:include page="/Back/back_index.jsp"/>
</head>
<body>
<jsp:useBean id="traSvc" class="com.traffic.model.TrafficService" />
<%

List<TrafficVO> list= (List<TrafficVO>)session.getAttribute("list");
if(list==null){
	list=traSvc.getAll();
	session.setAttribute("list",list );
}
%>
	
<div class="container">
		<h2>交通管理</h2>
		<ol class="breadcrumb" style="background-color: rgb(66, 139, 202)">
			<li><a href="<%=request.getContextPath()%>/Back/back_index.jsp"
				style="color: white;">首頁</a></li>
			<li class="active" style="color: white;">交通管理</li>
		</ol>
		<form class="form-inline" action="<%=request.getContextPath()%>/traffic/traffic.do" method="post">
			<div class="form-group">
				<select name="tracon" class="form-control">
					<option>請選擇縣市</option>
					<option>基隆縣</option>
					<option>台北市</option>
					<option>新北市</option>
					<option>桃園市</option>
					<option>新竹縣</option>
					<option>苗栗縣</option>
					<option>台中市</option>
					<option>南投縣</option>
					<option>彰化縣</option>
					<option>雲林縣</option>
					<option>嘉義縣</option>
					<option>台南市</option>
					<option>高雄市</option>
					<option>屏東縣</option>
					<option>台東縣</option>
					<option>花蓮縣</option>
					<option>宜蘭縣</option>
				</select>
			</div>
		    <div class="form-group">
		    	<select name="traclass" class="form-control">
		    		<option>請選擇工具</option>
					<option>客運</option>
					<option>機車</option>
					<option>計程車</option>
				</select>
		    </div>
		    <div class="form-group">
		    	<input type="text" name="traname" class="form-control" placeholder="請輸入名稱">
		    </div>
		    <div class="form-group">
		    	<input type="submit" value="搜尋" class="form-control" >
		    	<input type="hidden" name="action" value="search">
		    	<input type="hidden" name="requestURL" value="<%=request.getServletPath()%>">
		    </div>
		    <div class="form-group">${result}</div>
		</form>	
		<form class="form-inline" action="<%=request.getContextPath() %>/Back/Traffic/NewTra.jsp" method="post" style="margin-top:5px;">
			<input type="submit" value="新增資訊" class="form-control btn btn-primary">
			<input type="hidden" name="requestURL" value="<%=request.getServletPath()%>">
		</form>
			<table class="table table-hover">
			<tr>
				<th>交通編號編號</th>
				<th>名稱</th>
				<th>類別</th>
				<th>縣市</th>
				<th></th>
				<th></th>
			</tr>
			<%@ include file="pages/page1.file" %>
			<c:forEach var="TraVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
			<tr>
				<td>${TraVO.trano}</td>
				<td>${TraVO.traname}</td>
				<td>${TraVO.traclass}</td>
				<td>${TraVO.tracon}</td>			
				<td>
					<form action="<%=request.getContextPath() %>/traffic/traffic.do" method="post">
						<input type="submit" value="檢視資訊" class="form-control btn btn-info">
						<input type="hidden" name="trano" value="${TraVO.trano }">
						<input type="hidden" name="action" value="getOne_For_Update">
						<input type="hidden" name="requestURL" value="<%=request.getServletPath() %>">					
					</form>
				</td>
				<td>
					<form action="<%=request.getContextPath() %>/traffic/traffic.do" method="post">
						<input type="submit" value="刪除資訊" class="form-control btn btn-danger">
						<input type="hidden" name="trano" value="${TraVO.trano }">
						<input type="hidden" name="action" value="delete">
						<input type="hidden" name="requestURL" value="<%=request.getServletPath() %>"> 					
					</form>
				</td>
			</tr>
			</c:forEach>
		</table>
		<%@ include file="pages/page2.file" %>
	</div>
</body>
</html>