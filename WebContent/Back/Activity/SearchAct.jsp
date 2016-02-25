<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.activity.model.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>活動管理</title>
<jsp:include page="/Back/back_index.jsp"/>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
<script src="<%=request.getContextPath()%>/Back/Spot/js/jquery.twzipcode.min.js"></script>
<script>
$(function () 
		{
		    $('#contown').twzipcode(
		    {
				countyName: "country",
		        districtName: "district",
		        countySel: "${ActVO.actcon}",
		        districtSel: "${ActVO.acttown}"
		    });
		});
</script>
</head>
<body>
<jsp:useBean id="actSvc" class="com.activity.model.ActivityService" />
<%

List<ActivityVO> list= (List<ActivityVO>)session.getAttribute("list");
if(list==null)
{
	list = actSvc.getAll();
	session.setAttribute("list",list );
}


%>
	<div class="container">
		<h2>活動管理</h2>
		<ol class="breadcrumb" style="background-color: rgb(66, 139, 202)">
			<li><a href="<%=request.getContextPath()%>/Back/back_index.jsp"
				style="color: white;">首頁</a></li>
			<li class="active" style="color: white;">活動管理</li>
		</ol>
		<form class="form-inline" action="<%=request.getContextPath()%>/act/Activity_Servlet" method="post">
			<div id="contown" class="form-group">
		    	<div  data-role="zipcode" data-style="hide"></div>  
		    </div>
		    <div class="form-group">
		    	<input type="checkbox" name="actstatus" value="上架">上架
		    </div>
		    <div class="form-group">
		    	<input type="text" name="actname" class="form-control" placeholder="請輸入名稱">
		    </div>
		    <div class="form-group">
		    	<input type="submit" value="搜尋" class="form-control" >
		    	<input type="hidden" name="action" value="search">
		    	<input type="hidden" name="requestURL" value="<%=request.getServletPath()%>">
		    </div>
		    <div class="form-group">${result}</div>
		</form>		
		<form class="form-inline" action="<%=request.getContextPath() %>/Back/Activity/NewAct.jsp" method="post">
			<input type="submit" value="新增活動" class="form-control btn btn-primary">
			<input type="hidden" name="requestURL" value="<%=request.getServletPath()%>">
		</form>
			<table class="table table-hover">
			<tr>
				<th>活動編號</th>
				<th>縣市</th>
				<th>鄉鎮</th>
				<th>名稱</th>
				<th>電話</th>			
				<th>狀態</th>
				<th>開始日期</th>
				<th>結束日期</th>
				<th></th>
				<th></th>
			</tr>
			<%@ include file="pages/page1.file" %>
			<c:forEach var="ActVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
			<tr>
				<td>${ActVO.actno}</td>
				<td>${ActVO.actcon}</td>
				<td>${ActVO.acttown}</td>
				<td>${ActVO.actname}</td>
				<td>${ActVO.actphone}</td>		
				<td>${ActVO.actstatus}</td>
				<td>${ActVO.actbegin}</td>	
				<td>${ActVO.actend}</td>				
				<td>
					<form action="<%=request.getContextPath() %>/act/Activity_Servlet" method="post">
						<input type="submit" value="檢視活動" class="form-control btn btn-info">
						<input type="hidden" name="actno" value="${ActVO.actno }">
						<input type="hidden" name="action" value="update">
						<input type="hidden" name="isupdate" value="no">
						<input type="hidden" name="requestURL" value="<%=request.getServletPath() %>"> 					
					</form>
				</td>
				<td>
					<form action="<%=request.getContextPath()%>/act/Activity_Servlet" method="post">						
						<input type="submit" value="刪除活動" class="form-control btn btn-danger">
						<input type="hidden" name="action" value="delete">
						<input type="hidden" name="actno" value="${ActVO.actno }">
						<input type="hidden" name="requestURL" value="<%=request.getServletPath() %>">
					</form>
				</td>
			</tr>
			</c:forEach>
		</table>
		<%@ include file="pages/page2.file" %>
	</div>	
	<div class="col-sm-2"></div>
</body>
</html>