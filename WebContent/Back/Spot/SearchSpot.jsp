<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.spot.model.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>旅遊點管理</title>
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
				countySel: "${SpotVO.spotcon}",
		        districtSel: "${SpotVO.spottown}"
		    });
		});
</script>
</head>
<body>
<jsp:useBean id="spotSvc" class="com.spot.model.SpotService" />
<%

List<SpotVO> list= (List<SpotVO>)session.getAttribute("list");
if(list==null){
	list=spotSvc.getAll();
	session.setAttribute("list",list );
}


%>
	
<div class="container">
	<h2>旅遊點管理</h2>
		<ol class="breadcrumb" style="background-color: rgb(66, 139, 202)">
			<li><a href="<%=request.getContextPath()%>/Back/back_index.jsp"
				style="color: white;">首頁</a></li>
			<li class="active" style="color: white;">旅遊點管理</li>
		</ol>
	<div class="col-sm-12">		
		<form class="form-inline" action="<%=request.getContextPath()%>/spot/Spot_Servlet" method="post">
			<div id="contown" class="form-group">
		    	<div  data-role="zipcode" data-style="hide"></div>  
		    </div>
		    <div class="form-group">
		    	<select name="spotclass">
		    		<option>欲搜尋分類</option>
		    		<option>景點</option>
		    		<option>美食</option>
		    		<option>住宿</option>
		    	</select>
		    </div>
		    <div class="form-group">
		    	<input type="checkbox" name="spotstatus" value="上架">上架
		    </div>
		    <div class="form-group">
		    	<input type="text" name="spotname" class="form-control" placeholder="請輸入名稱">
		    </div>
		    <div class="form-group">
		    	<input type="submit" value="搜尋" class="form-control" >
		    	<input type="hidden" name="action" value="search">
		    	<input type="hidden" name="requestURL" value="<%=request.getServletPath()%>">
		    </div>
		    <div class="form-group">${result}</div>
		</form>		
		<form class="form-inline" action="<%=request.getContextPath() %>/Back/Spot/NewSpot.jsp" method="post">
			<input type="submit" value="新增旅遊點" class="form-control btn btn-primary">
			<input type="hidden" name="requestURL" value="<%=request.getServletPath()%>">
		</form>
			<table class="table table-hover">
			<tr>
				<th>旅遊點編號</th>
				<th>會員編號</th>
				<th>分類</th>
				<th>類別</th>
				<th>縣市</th>
				<th>鄉鎮</th>
				<th>名稱</th>
				<th>電話</th>			
				<th>狀態</th>
				<th></th>
				<th></th>
			</tr>
			<%@ include file="pages/page1.file" %>
			<c:forEach var="SpotVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
			<tr>
				<td>${SpotVO.spotno}</td>
				<td>${SpotVO.memno}</td>
				<td>${SpotVO.spotclass}</td>
				<td>${SpotVO.spotsort}</td>
				<td>${SpotVO.spotcon}</td>
				<td>${SpotVO.spottown}</td>
				<td>${SpotVO.spotname}</td>
				<td>${SpotVO.spotphone}</td>		
				<td>${SpotVO.spotstatus}</td>			
				<td>
					<form action="<%=request.getContextPath() %>/spot/Spot_Servlet" method="post">
						<input type="submit" value="檢視旅遊點" class="form-control btn btn-info">
						<input type="hidden" name="spotno" value="${SpotVO.spotno }">
						<input type="hidden" name="action" value="update">
						<input type="hidden" name="isupdate" value="no">
						<input type="hidden" name="requestURL" value="<%=request.getServletPath() %>"> 					
					</form>
				</td>
				<td>
					<form action="<%=request.getContextPath() %>/spotboard/SpotBoard_Servlet" method="post">
						<input type="submit" value="檢視留言板" class="form-control btn btn-warning">
						<input type="hidden" name="spotno" value="${SpotVO.spotno }">
						<input type="hidden" name="action" value="find_talk">
						<input type="hidden" name="requestURL" value="<%=request.getServletPath() %>"> 					
					</form>
				</td>
			</tr>
			</c:forEach>
		</table>
		<%@ include file="pages/page2.file" %>
	</div>	
</div>

</body>
</html>