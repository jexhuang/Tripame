<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.spot.model.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>留言內容</title>
<jsp:include page="/Back/back_index.jsp"/>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<script src="<%=request.getContextPath()%>/Back/Spot/js/jquery.twzipcode.min.js"></script>
</head>
<jsp:useBean id="MemSvc" scope="page" class="com.mem.model.MemService"/>
<jsp:useBean id="SpotSvc" scope="page" class="com.spot.model.SpotService"/>
<body>
<div class="container">
		<h2>會員推薦旅遊點管理</h2>
		<ol class="breadcrumb" style="background-color: rgb(66, 139, 202)">
				<li><a href="<%=request.getContextPath()%>/Back/back_index.jsp"
					style="color: white;">首頁</a></li>
					<li><a href="<%=request.getContextPath()%>/Back/Spot/SearchSpot.jsp"
					style="color: white;">旅遊點管理</a></li>
				<li class="active" style="color: white;">留言內容</li>
		</ol>
		<h2><p class="bg-success">${message }</p></h2>		
		<c:if test="${list!=null }">
			<table class="table table-hover">
			<tr>				
				<th>留言編號</th>
				<th>景點名稱</th>
				<th>會員名稱</th>
				<th>內容</th>
				<th>發文時間</th>
			</tr>				
			
				<c:forEach var="SpotBoardVO" items="${list }">
					<tr>
						<td>
							${SpotBoardVO.sbno }
						</td>
						<td>
							<c:forEach var="SpotVO" items="${SpotSvc.all}">
								<c:if test="${SpotBoardVO.spotno==SpotVO.spotno }">
									${SpotVO.spotname }
								</c:if>
							</c:forEach>
						</td>
						<td>
							<c:forEach var="MemVO" items="${MemSvc.all}">
								<c:if test="${SpotBoardVO.memno==MemVO.memno }">
									${MemVO.memname }
								</c:if>
							</c:forEach>
						</td>
						<td>
							${SpotBoardVO.sbcontent }
						</td>
						<td>
							${SpotBoardVO.sbtime }
						</td>
						<td>
							<form action="<%=request.getContextPath()%>/spotboard/SpotBoard_Servlet" method="post">
								<input type="submit" value="刪除" class="form-control btn btn-warning">
								<input type="hidden" name="action" value="delete">
								<input type="hidden" name="sbno" value="${SpotBoardVO.sbno }">
								<input type="hidden" name="spotno" value="${SpotBoardVO.spotno }">
							</form>
						</td>
					</tr>
					</c:forEach>				
			</table>
			</c:if>
			<a class="btn btn-default" href="<%=request.getContextPath()%>/Back/Spot/SearchSpot.jsp" role="button">取消</a>
		</div>
	
</body>
</html>