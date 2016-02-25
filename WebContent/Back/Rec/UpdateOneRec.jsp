<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.rec.model.*"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
%>
<link
	href="<%=request.getContextPath()%>/Front/forIndex/layoutit/css/bootstrap.min.css"
	rel="stylesheet">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>修改會員推薦旅遊點狀態</title>
</head>
<jsp:include page="/Back/back_index.jsp" />
<body>
	<div class="container">
		<h2>會員推薦旅遊點管理</h2>
		<ol class="breadcrumb" style="background-color: rgb(66, 139, 202)">
				<li><a href="<%=request.getContextPath()%>/Back/back_index.jsp"
					style="color: white;">首頁</a></li>
					<li><a href="<%=request.getContextPath()%>/Back/Rec/ListAllRec.jsp"
					style="color: white;">會員推薦旅遊點列表</a></li>
				<li class="active" style="color: white;">修改會員推薦旅遊點狀態</li>
		</ol>
		<table class="table">
			<tr>
				<td>
					<table class="table table-hover">
						<tr>
							<td>旅遊點編號</td>
							<td>${recvo.recno}</td>

						</tr>
						<tr>
							<td>會員名稱</td>
							<td>${memname}</td>
						</tr>
						<tr>
							<td>旅遊點分類</td>
							<td>${recvo.recclass}</td>
						</tr>
						<tr>
							<td>縣市</td>
							<td>${recvo.reccon}</td>
						</tr>
						<tr>
							<td>鄉鎮</td>
							<td>${recvo.rectown}</td>
						</tr>
						<tr>
							<td>地址</td>
							<td>${recvo.recaddress}</td>
						</tr>
						<tr>
							<td>名稱</td>
							<td>${recvo.recname}</td>
						</tr>
						<tr>
							<td>電話</td>
							<td>${recvo.recphone}</td>
						</tr>
						<tr>
							<td>網址</td>
							<td>${recvo.recsite}</td>
						</tr>
					</table>
				<td><img
					src="<%=request.getContextPath()%>/rec/RecPicReader?recno=${recvo.recno}"
					height="380" width="600"></td>
			<tr>
				<td>簡介:<br> ${recvo.reccontent}
				</td>
			</tr>
			<tr>
				<td>
					<form action="<%=request.getContextPath()%>/rec/RecServlet"
						method=post>
						<div class="form-group">
							<label>狀態</label> <select name="status" class="form-control">
								<option value="審核中" ${(recvo.recstatus=='審核中')?'selected':''}>審核中</option>
								<option value="請修改" ${(recvo.recstatus=='請修改')?'selected':''}>請修改</option>
								<option value="審核成功" ${(recvo.recstatus=='審核成功')?'selected':''}>審核成功</option>
							</select>
						</div>
						<div class="form-group">
							<label for="message">修改建議</label> <input type="text"
								class="form-control" id="message" name="recmessage" maxlength="75"
								value="${recvo.recmessage}">
						</div>
						<input type="hidden" name="recno" value="${recvo.recno}">
						<input type="hidden" name="action" value="UpdateStatus">
						<button type="submit" class="btn btn-default">確認</button>
						<a class="btn btn-default"
						href="<%=request.getContextPath()%>/Back/Rec/ListAllRec.jsp"
						role="button">取消</a>
					</form>
				</td>
			</tr>
		</table>
	</div>
</body>
</html>