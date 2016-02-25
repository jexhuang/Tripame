<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.mem.model.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	MemService memsvc = new MemService();

	List<MemVO> list = memsvc.getAll();
	if (request.getParameter("memid") != null) {
		for (MemVO memvo : list) {
			if (memvo.getMemid().equals(
					request.getParameter("memid").trim())) {
				list = new ArrayList<MemVO>();
				list.add(memvo);
			}
		}
	}
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
<title>會員列表</title>
</head>
<jsp:include page="/Back/back_index.jsp"/>
<body>
	<div class="container">
		<h2>會員管理</h2>
		<ol class="breadcrumb" style="background-color:rgb(66,139,202)">
			<li><a href="<%=request.getContextPath()%>/Back/back_index.jsp" style="color:white;">首頁</a></li>
			<li class="active" style="color:white;">會員列表</li>
		</ol>
		
		<form class="form-inline"
			action="<%=request.getContextPath()%>/Back/Mem/ListMem.jsp">
			<div class="form-group">
				<label for="memid">輸入欲查詢會員帳號:</label>
				<div>
					<input type="text" id="memid" name="memid" />
					<button type="submit" class="btn btn-default btn-sm">搜尋</button>
				</div>
			</div>
		</form>

		<table class="table table-bordered">
			<tr>
				<th>會員大頭貼</th>
				<th>會員編號</th>
				<th>會員姓名</th>
				<th>會員帳號</th>
				<th>會員信箱</th>
				<th>會員狀態</th>
				<th>會員認證碼</th>
			</tr>
			<%@ include file="pages/page1.file"%>
			<c:forEach var="memvo" items="${list}" begin="<%=pageIndex%>"
				end="<%=pageIndex+rowsPerPage-1%>">
				<tr align='center' valign='middle'>
					<td><img
						src="<%=request.getContextPath()%>/mem/MemPicReader?memno=${memvo.memno}"
						height="88" width="88"></td>
					<td style="line-height: 88px;">${memvo.memno}</td>
					<td style="line-height: 88px;">${memvo.memname}</td>
					<td style="line-height: 88px;">${memvo.memid}</td>
					<td style="line-height: 88px;">${memvo.mememail}</td>
					<td style="line-height: 88px;">${memvo.memstatus}</td>
					<td style="line-height: 88px;">${memvo.memcode}</td>
				</tr>
			</c:forEach>
		</table>
		<%@ include file="pages/page2.file"%>
	</div>
</body>
</html>