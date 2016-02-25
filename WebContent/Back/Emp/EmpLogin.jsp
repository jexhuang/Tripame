<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
response.setHeader("Cache-Control", "no-store");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);
%>
<link href="<%=request.getContextPath()%>/Front/forIndex/layoutit/css/bootstrap.min.css" rel="stylesheet">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>員工登入</title>
</head>
<body>
<div class="container">
	<div class="jumbotron" style="background-color:lightblue;">
   			 <h1 style="font-family:'Comic Sans MS';color:red;text-align:center">Tripame後端管理系統</h1>      
  		</div>
		<form role="form" action="<%=request.getContextPath()%>/emp/EmpServlet" method=post>
		<div class="row">
			<div class="col-md-4"></div>
  			<div class="col-md-4">
			<div class="form-group">
				<label for="id">帳號:</label>
					<input type="text" id="id" placeholder="輸入帳號" name="empid" class="form-control" />
			</div>
			</div></div>
			<div class="row">
			<div class="col-md-4"></div>
  			<div class="col-md-4">
			<div class="form-group">
				<label for="pw">密碼:</label>
					<input type="password" id="pw" placeholder="輸入密碼" name="emppw" class="form-control" />
			</div>
			</div></div>
			<div class="row">
			<div class="col-md-4"></div>
  			<div class="col-md-4">
				<div>
					<button type="submit" class="btn btn-primary btn-lg">登入</button>
					<input type="hidden" name="action" value="Emp_Login">
				</div>
			</div></div>
		</form>
</div>
</body>
</html>