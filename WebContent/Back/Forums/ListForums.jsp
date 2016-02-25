<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.forums.model.*"%>
<%@ page import="com.forumsrep.model.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:useBean id="forsvc" class="com.forums.model.ForumsService" />
<jsp:useBean id="repsvc" class="com.forumsrep.model.ForumsrepService" />
<jsp:useBean id="memSvc" scope="page" class="com.mem.model.MemService" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	List<ForumsVO> list = forsvc.getAll();
	pageContext.setAttribute("list", list);
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>討論區列表</title>
</head>
<jsp:include page="/Back/back_index.jsp"/>
<body>
	<div class="container">
		<h2>討論區管理</h2>
		<ol class="breadcrumb" style="background-color: rgb(66, 139, 202)">
			<li><a href="<%=request.getContextPath()%>/Back/back_index.jsp"
				style="color: white;">首頁</a></li>
			<li class="active" style="color: white;">討論區列表</li>
		</ol>
		<table class="table" cellpadding="6" cellspacing="1" border="0"
			width="100%" align="center">
			<tr align="left" style="background-color: rgb(66, 139, 202);">
				<td nowrap="nowrap" width="5%" align="center" style="color: white"><strong>類別</strong></td>
				<td nowrap="nowrap" align="center" style="color: white"><strong>主題</strong></td>
				<td nowrap="nowrap" width="10%" align="center" style="color: white"><strong>作者</strong></td>
				<td nowrap="nowrap" width="20%" align="center" style="color: white"><strong>發佈日期</strong></td>
				<td nowrap="nowrap" width="5%" align="center" style="color: white"><strong>回覆</strong></td>
				<td nowrap="nowrap" width="20%" align="center" style="color: white"><strong>最後發表</strong></td>
			</tr>
			<%@ include file="pages/page1.file"%>
			<c:forEach var="forvo" items="${list}" begin="<%=pageIndex%>"
				end="<%=pageIndex+rowsPerPage-1%>">
				<tr>
					<td nowrap="nowrap" style="padding: 20px;">${forvo.forclass}</td>
					<td style="padding: 20px;"><a
						href="<%=request.getContextPath()%>/forums/ForumsServlet?action=BackWatchFor&forno=${forvo.forno}">${forvo.fortheme}</a></td>
					<td style="padding: 20px;"><c:forEach var="memVO"
							items="${memSvc.all}">
							<c:if test="${forvo.memno==memVO.memno}">
	                    ${memVO.memname}
                    </c:if>
						</c:forEach></td>
					<td style="padding: 20px;">${forvo.fortime}</td>
					<td style="padding: 20px;">${repsvc.getCount(forvo.forno)}</td>
					<td style="padding: 20px;">${repsvc.getLastTime(forvo.forno)}
					</td>

				</tr>
			</c:forEach>
		</table>
		<%@ include file="pages/page2.file"%>
		<br> 
	</div>
</body>
</html>