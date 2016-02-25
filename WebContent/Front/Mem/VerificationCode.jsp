<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.mem.model.*"%>
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
<title>驗證碼</title>
</head>
<body>
	<div class="container">
		<div class="jumbotron" style="background-color: lightblue;">
			<h1
				style="font-family: 'Comic Sans MS'; color: red; text-align: center">Welcome
				To Tripame</h1>
		</div>
		<div class="row">
				<div class="col-md-4"></div>
				<div class="col-md-4">
		${memvo.memname}您好，您尚未驗證
		</div></div>
		<form role="form"
			action="<%=request.getContextPath()%>/mem/MemServlet" method=post>
			<div class="row">
				<div class="col-md-4"></div>
				<div class="col-md-4">
			<div class="form-group">
				<label for="code">請輸入驗證碼:</label>
				<div>
					<input type="text" id="code" placeholder="輸入驗證碼" name="memcode"
						class="form-control" maxlength="10" />
				</div>
			</div></div></div>
			<div class="row">
				<div class="col-md-4"></div>
				<div class="col-md-4">
			<div>
				<div>
					<button type="submit" class="btn btn-default">確定</button>
					<a class="btn btn-default"
						href="<%=request.getContextPath()%>/Front/Mem/MemLogin.jsp"
						role="button">取消</a> <input type="hidden" name="action"
						value="Verification_Code">
				</div>
			</div></div></div>
		</form>
	</div>
</body>
</html>