<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.rec.model.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	RecService recsvc = new RecService();
	List<RecVO> list = recsvc.getAll();
	pageContext.setAttribute("list", list);
%>
<jsp:useBean id="memSvc" scope="page" class="com.mem.model.MemService" />

<html>
<head>
<%
response.setHeader("Cache-Control", "no-store");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);
%>
<link href="<%=request.getContextPath()%>/Front/forIndex/layoutit/css/bootstrap.min.css" rel="stylesheet">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>會員推薦旅遊點列表</title>
</head>
<jsp:include page="/Back/back_index.jsp"/>
<body>
	<div class="container">
		<h2>會員推薦旅遊點管理</h2>
		<ol class="breadcrumb" style="background-color: rgb(66, 139, 202)">
				<li><a href="<%=request.getContextPath()%>/Back/back_index.jsp"
					style="color: white;">首頁</a></li>
				<li class="active" style="color: white;">會員推薦旅遊點列表</li>
		</ol>
		<table class="table table-bordered">
			<tr>
				<th>旅遊點照片</th>
				<th>旅遊點編號</th>
				<th>會員名稱</th>
				<th>旅遊點名稱</th>
				<th>旅遊點狀態</th>
				<th>&nbsp</th>	
			</tr>
			<%@ include file="pages/page1.file"%>
			<c:forEach var="recvo" items="${list}" begin="<%=pageIndex%>"
				end="<%=pageIndex+rowsPerPage-1%>">
				<tr align='center' valign='middle'>
					<td><img
						src="<%=request.getContextPath()%>/rec/RecPicReader?recno=${recvo.recno}"
						height="110" width="196"></td>
					<td style="line-height: 100px;">${recvo.recno}</td>	
					<td style="line-height: 100px;">
					<c:forEach var="memVO" items="${memSvc.all}">
                    <c:if test="${recvo.memno==memVO.memno}">
	                    ${memVO.memname}
                    </c:if>
               	    </c:forEach>
					</td>
					<td style="line-height: 100px;">${recvo.recname}</td>
					<td style="line-height: 100px;">${recvo.recstatus}</td>
					<td>
					<br><br>
					<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/rec/RecServlet">
			    		 <input type="submit" value="檢視旅遊點" class="btn btn-info"> 
			    		 <input type="hidden" name="recno" value="${recvo.recno}">
				   	     <input type="hidden" name="action"	value="UpdateOneRec">
				     </FORM>
					</td>				
				</tr>
			</c:forEach>
		</table>
		<%@ include file="pages/page2.file"%>
	</div>
</body>
</html>