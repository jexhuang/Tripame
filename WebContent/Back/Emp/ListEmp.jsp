<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.emp.model.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	EmpService empsvc = new EmpService();
	List<EmpVO> list = empsvc.getAll();
	pageContext.setAttribute("list", list);
%>
<html>
<head>
<%
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>員工列表</title>
</head>
<jsp:include page="/Back/back_index.jsp" />
<body>
	<div class="container">
		<h2>員工管理</h2>
		<ol class="breadcrumb" style="background-color: rgb(66, 139, 202)">
			<li><a href="<%=request.getContextPath()%>/Back/back_index.jsp"
				style="color: white;">首頁</a></li>
			<li class="active" style="color: white;">員工列表</li>
		</ol>
		<table class="table table-bordered">
			<tr>
				<th><font size="3">員工姓名</font></th>
				<th><font size="3">員工管理</font></th>
				<th><font size="3">會員管理</font></th>
				<th><font size="3">廣告管理</font></th>
				<th><font size="3">交通管理</font></th>
				<th><font size="3">活動管理</font></th>
				<th><font size="3">討論區管理</font></th>
				<th><font size="3">旅遊點管理</font></th>
				<th><font size="3">套裝行程管理</font></th>
				<th><font size="3">會員旅遊點管理</font></th>
				<th>&nbsp</th>
				<th>&nbsp</th>
			</tr>
			<%@ include file="pages/page1.file"%>
			<c:forEach var="empvo" items="${list}" begin="<%=pageIndex%>"
				end="<%=pageIndex+rowsPerPage-1%>">
				<tr align='center' valign='middle'>
					<form class="form-horizontal" role="form"
						action="<%=request.getContextPath()%>/emp/EmpServlet" method=post>
						<td>${empvo.empname}</td>
						<td><input type="checkbox" name="emp" value="enable"
							style="width: 25px; height: 25px"
							${(empvo.empemp=='enable')?'checked style="display:none"':''}></td>
						<td><input type="checkbox" name="mem" value="enable"
							style="width: 25px; height: 25px"
							${(empvo.empmem=='enable')?'checked style="display:none"':''}></td>
						<td><input type="checkbox" name="ad" value="enable"
							style="width: 25px; height: 25px"
							${(empvo.empad=='enable')?'checked style="display:none"':''}></td>
						<td><input type="checkbox" name="traffic" value="enable"
							style="width: 25px; height: 25px"
							${(empvo.emptraffic=='enable')?'checked style="display:none"':''}></td>
						<td><input type="checkbox" name="activity" value="enable"
							style="width: 25px; height: 25px"
							${(empvo.empactivity=='enable')?'checked style="display:none"':''}></td>
						<td><input type="checkbox" name="forums" value="enable"
							style="width: 25px; height: 25px"
							${(empvo.empforums=='enable')?'checked style="display:none"':''}></td>
						<td><input type="checkbox" name="spot" value="enable"
							style="width: 25px; height: 25px"
							${(empvo.empspot=='enable')?'checked style="display:none"':''}></td>
						<td><input type="checkbox" name="travel" value="enable"
							style="width: 25px; height: 25px"
							${(empvo.emptravel=='enable')?'checked style="display:none"':''}></td>
						<td><input type="checkbox" name="rec" value="enable"
							style="width: 25px; height: 25px"
							${(empvo.emprec=='enable')?'checked style="display:none"':''}></td>
						<td>
							<button type="submit" class="btn btn-warning">更新權限</button> <input
							type="hidden" name="action" value="UpdateEmpAuth"> <input
							type="hidden" name="empno" value="${empvo.empno}">
						</td>
						<td><a class="btn btn-info"
							href="<%=request.getContextPath()%>/emp/EmpServlet?action=updateEmp&empno=${empvo.empno}"
							role="button">檢視資料</a></td>
					</form>
				</tr>
			</c:forEach>
		</table>
		<a class="btn btn-primary"
			href="<%=request.getContextPath()%>/Back/Emp/AddNewEmp.jsp"
			role="button">新增員工</a>
		<%@ include file="pages/page2.file"%>
	</div>
</body>
</html>