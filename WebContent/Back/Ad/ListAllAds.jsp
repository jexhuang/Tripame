<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.ad.model.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	AdService adsvc = new AdService();
	List<AdVO> list = adsvc.getAll();
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
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>廣告列表</title>
</head>
<jsp:include page="/Back/back_index.jsp"/>
<body>
	<div class="container">
		<h2>廣告管理</h2>
		<ol class="breadcrumb" style="background-color: rgb(66, 139, 202)">
			<li><a href="<%=request.getContextPath()%>/Back/back_index.jsp"
				style="color: white;">首頁</a></li>
			<li class="active" style="color: white;">廣告管理</li>
		</ol>
		<table class="table table-bordered">
			<tr>
				<th>廣告照片</th>
				<th>廣告編號</th>
				<th>會員名稱</th>
				<th>廣告名稱</th>
				<th>廣告狀態</th>
				<th>上架時間</th>
				<th>下架時間</th>
				<th>&nbsp</th>	
			</tr>
			<%@ include file="pages/page1.file"%>
			<c:forEach var="advo" items="${list}" begin="<%=pageIndex%>"
				end="<%=pageIndex+rowsPerPage-1%>">
				<tr align='center' valign='middle'>
					<td><img
						src="<%=request.getContextPath()%>/ads/AdsPicReader?adsno=${advo.adno}"
						height="110" width="196"></td>
					<td style="line-height: 100px;">${advo.adno}</td>	
					<td style="line-height: 100px;">
					<c:forEach var="memVO" items="${memSvc.all}">
                    <c:if test="${advo.memno==memVO.memno}">
	                    ${memVO.memname}
                    </c:if>
               	    </c:forEach>
					</td>
					<td style="line-height: 100px;">${advo.adname}</td>
					<td style="line-height: 100px;">${advo.adstatus}</td>
					<td style="line-height: 100px;">${advo.adbegin}</td>
					<td style="line-height: 100px;">${advo.adend}</td>
					<td>
					<br><br>
					<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/ads/AdsServlet">
			    		 <input type="submit" value="檢視廣告" class="btn btn-info"> 
			    		 <input type="hidden" name="adno" value="${advo.adno}">
				   	     <input type="hidden" name="action"	value="UpdateOneAd">
				     </FORM>
					</td>				
				</tr>
			</c:forEach>
		</table>
		<%@ include file="pages/page2.file"%>
	</div>
</body>
</html>