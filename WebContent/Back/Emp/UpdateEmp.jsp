<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
response.setHeader("Cache-Control", "no-store");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);
%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>帳號管理</title>
</head>
<jsp:include page="/Back/back_index.jsp"/>
<body>
	<div class="container">
		<h2>員工管理</h2>
		<ol class="breadcrumb" style="background-color: rgb(66, 139, 202)">
			<li><a href="<%=request.getContextPath()%>/Back/back_index.jsp"
				style="color: white;">首頁</a></li>
			<li><a href="<%=request.getContextPath()%>/Back/Emp/ListEmp.jsp"
				style="color: white;">員工列表</a></li>	
			<li class="active" style="color: white;">檢視員工資料</li>
		</ol>
		<div class="col-sm-offset-3">
					<div>
		<c:if test="${errorMsgs!=null }">
		<span>請修正以下錯誤</span>
			<ul>
				<c:forEach var="message" items="${errorMsgs}">
				<li style="color:red;">${message }
				</c:forEach>
			</ul>
		</c:if>			
		</div>
		</div>
		<br>
		<form role="form" class="form-horizontal"
			action="<%=request.getContextPath()%>/emp/EmpServlet" method=post>
			<div class="form-group form-group-lg">
				<label class="col-sm-3 control-label" for="name">姓名:</label>
				<div class="col-sm-5">
					<input type="text" id="name" value="${empvo.empname}" maxlength="10"
						name="empname" class="form-control" />
				</div>
			</div>
			<div class="form-group form-group-lg">
				<label class="col-sm-3 control-label" for="id">帳號:</label>
				<div class="col-sm-5">
					<input type="text" id="id" value="${empvo.empid}" name="empid"
						class="form-control" readonly />
				</div>
			</div>
			<div class="form-group form-group-lg">
				<label class="col-sm-3 control-label" for="email">信箱:</label>
				<div class="col-sm-5">
					<input type="email" id="email" value="${empvo.empemail}"
						name="empemail" class="form-control" readonly />
				</div>
			</div>
			<div class="form-group">
				<div class="col-sm-offset-3 col-sm-5">
					<button type="submit" class="btn btn-default">確認</button>
					<a class="btn btn-default" href="<%=request.getContextPath()%>/Back/Emp/ListEmp.jsp" role="button">取消</a>
					<input type="hidden" name="action" value="UpdateEmpByEmp">
					<input type="hidden" name="empno" value="${empvo.empno}">
				</div>
			</div>
		</form>
	</div>
</body>
</html>