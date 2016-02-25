<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.forums.model.*"%>
<%@ page import="com.forumsrep.model.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:useBean id="forsvc" class="com.forums.model.ForumsService" />
<jsp:useBean id="repsvc" class="com.forumsrep.model.ForumsrepService" />
<jsp:useBean id="forvo" scope="session"
	class="com.forums.model.ForumsVO" />
<jsp:useBean id="memSvc" scope="page" class="com.mem.model.MemService" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	List<ForumsrepVO> list = new ArrayList<ForumsrepVO>();
	if (pageContext.getAttribute("list") == null) {
		List<ForumsrepVO> list1 = repsvc.getAll();
		for (ForumsrepVO repvo : list1) {
			if (forvo.getForno().equals(repvo.getForno())) {
				list.add(repvo);
			}
		}
		pageContext.setAttribute("list", list);
	}
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>討論區詳情</title>
</head>
<style>
#page {
	display: none;
}
</style>
<jsp:include page="/Front/select_page.jsp" />
<body>
	<div class="container">
		<a href="<%=request.getContextPath()%>/Front/Forums/ListAllForums.jsp"><font
			style="font-size: 30px;">回討論區列表</font></a>
		<%@ include file="pages1/page1.file"%>
		<table cellpadding="0" cellspacing="0" border="2" width="100%"
			align="center" style="border-bottom-width: 0px;">
			<tr style="background-color: #259EF5; color: white; font-size: 20px;">
				<th align="center"></th>
				<th align="center" style="padding: 10px">${forvo.fortheme}</th>
			</tr>
			<tr>
				<td style="padding-left: 36px;"><br> <img
					src="<%=request.getContextPath()%>/mem/MemPicReader?memno=${forvo.memno}"
					height="150" width="150" /> <br> <br> <c:forEach
						var="memVO" items="${memSvc.all}">
						<c:if test="${forvo.memno==memVO.memno}">
							<strong>${memVO.memname}</strong>
						</c:if>
					</c:forEach></td>
				<td valign="top"
					style="padding-left: 14px; word-wrap: break-word; word-break: break-all;"><strong><br>${forvo.forcontent}
				</strong></td>
			</tr>
			<tr>
				<td width="20%" class="foot">&nbsp;</td>
				<td colspan="2" class="foot">
					<div align="right">
						<c:if test="${forvo.memno==memvo.memno}">
							<a
								href="<%=request.getContextPath()%>/forums/ForumsServlet?action=updatebymem&forno=${forvo.forno}">編輯</a>
							&nbsp&nbsp
							<a
								href="<%=request.getContextPath()%>/forums/ForumsServlet?action=deletebymem&forno=${forvo.forno}">刪除</a>
							&nbsp&nbsp
					</c:if>
						發文時間:${forvo.fortime}&nbsp&nbsp

					</div>
				</td>
			</tr>
		</table>


		<c:forEach var="repvo" items="${list}" begin="<%=pageIndex%>"
			end="<%=pageIndex+rowsPerPage-1%>">
			<br>
			<table cellpadding="0" cellspacing="0" border="2" width="100%"
				align="center" style="border-bottom-width: 0px;">
				<tr
					style="background-color: #259EF5; color: white; font-size: 20px;">
					<th align="center"></th>
					<th align="center" style="padding: 10px">FW:${forvo.fortheme}</th>
				</tr>
				<tr>
					<td style="padding-left: 36px;"><br> <img
						src="<%=request.getContextPath()%>/mem/MemPicReader?memno=${repvo.memno}"
						height="150" width="150" /> <br> <br> <c:forEach
							var="memVO" items="${memSvc.all}">
							<c:if test="${repvo.memno==memVO.memno}">
								<strong>${memVO.memname}</strong>
							</c:if>
						</c:forEach></td>
					<td valign="top"
						style="padding-left: 14px; word-wrap: break-word; word-break: break-all;"><strong><br>${repvo.repcontent}
					</strong></td>
				</tr>
				<tr>
					<td width="20%" class="foot">&nbsp;</td>
					<td colspan="2" class="foot">
						<div align="right">
							<c:if test="${repvo.memno==memvo.memno}">
								<a href="<%=request.getContextPath()%>/forums/ForumsServlet?action=updaterepbymem&repno=${repvo.repno}&forno=${forvo.forno}">編輯</a>
								&nbsp&nbsp
								<a href="<%=request.getContextPath()%>/forums/ForumsServlet?action=deleterepbymem&repno=${repvo.repno}&forno=${forvo.forno}">刪除</a>
								&nbsp&nbsp
							</c:if>
							回文時間:${repvo.reptime}&nbsp&nbsp
						</div>
					</td>
				</tr>
			</table>
		</c:forEach>
		<%@ include file="pages1/page2.file"%>
		<table>
			<tr>
				<td><br>
				 <a class="btn btn-primary btn-lg" href="<%=request.getContextPath()%>/forums/ForumsServlet?action=repforumsbymem&forno=${forvo.forno}" role="button">回覆文章</a>	
				</td>
				<td width="74%">&nbsp;</td>
				<td><br> <a
					href="<%=request.getContextPath()%>/Front/Forums/ListAllForums.jsp"><font
						style="font-size: 30px;">回討論區列表</font></a></td>
			</tr>
		</table>
	</div>
</body>
</html>