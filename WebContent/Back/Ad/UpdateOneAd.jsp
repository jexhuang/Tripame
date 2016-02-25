<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.ad.model.*"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);

	AdService adsvc = new AdService();
	List<AdVO> list = adsvc.getAll();
	int count = 0;
	for (AdVO advo : list) {
		if (advo.getAdstatus().equals("上架中")) {
			count++;
		}
	}
	pageContext.setAttribute("count", count);
%>
<%-- <c:remove var="c"/> --%>
<%-- <jsp:useBean id="adsvca" class="com.ad.model.AdService" scope="page"/> --%>
<%-- <c:forEach var="advo" items="${adsvca.all}" varStatus="status"> --%>
<%-- 	<c:if test="${(advo.adstatus=='上架中')}"> --%>
<%-- 		<c:set var="c" value="${status.count}" scope="page"/> --%>
<%-- 		${status.count} --%>
<%-- 	</c:if> --%>
<%-- </c:forEach> --%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>修改廣告狀態</title>
</head>
<jsp:include page="/Back/back_index.jsp" />
<body>
<div class="container">
	<h2>廣告管理</h2>
		<ol class="breadcrumb" style="background-color: rgb(66, 139, 202)">
			<li><a href="<%=request.getContextPath()%>/Back/back_index.jsp"
				style="color: white;">首頁</a></li>
			<li><a href="<%=request.getContextPath()%>/Back/Ad/ListAllAds.jsp"
				style="color: white;">廣告列表</a></li>
			<li class="active" style="color: white;">修改廣告狀態</li>
		</ol>
	<table class="table">
		<tr>
			<td>
				<table class="table table-hover">
					<tr>
						<td>廣告編號</td>
						<td>${advo.adno}</td>

					</tr>
					<tr>
						<td>會員名稱</td>
						<td>${memname}</td>
					</tr>
					<tr>
						<td>廣告分類</td>
						<td>${advo.adclass}</td>
					</tr>
					<tr>
						<td>縣市</td>
						<td>${advo.adcon}</td>
					</tr>
					<tr>
						<td>鄉鎮</td>
						<td>${advo.adtown}</td>
					</tr>
					<tr>
						<td>地址</td>
						<td>${advo.adaddress}</td>
					</tr>
					<tr>
						<td>名稱</td>
						<td>${advo.adname}</td>
					</tr>
					<tr>
						<td>電話</td>
						<td>${advo.adphone}</td>
					</tr>
					<tr>
						<td>網址</td>
						<td>${advo.adsite}</td>
					</tr>
				</table>
			<td><img
				src="<%=request.getContextPath()%>/ads/AdsPicReader?adsno=${advo.adno}"
				height="380" width="600"></td>
			</td>
		</tr>
		<tr>
			<td>
			簡介:<br>
			${advo.adcontent}
			</td>
		</tr>
		<tr>
			<td>
				<form action="<%=request.getContextPath()%>/ads/AdsServlet"
					method=post>
					<div class="form-group">
						<label>狀態</label> <select name="status" class="form-control">
							<option value="審核中" ${(advo.adstatus=='審核中')?'selected':''}>審核中</option>
							<option value="請修改" ${(advo.adstatus=='請修改')?'selected':''}>請修改</option>
							<option value="審核成功" ${(advo.adstatus=='審核成功')?'selected':''}>審核成功</option>
							<option value="上架中" ${(advo.adstatus=='上架中')?'selected':''}
								${(count>4)?'disabled':'' }>上架中</option>
							<option value="已下架" ${(advo.adstatus=='已下架')?'selected':''}>已下架</option>
						</select>
					</div>
					<div class="form-group">
						<label for="message">修改建議</label> <input type="text" maxlength="75"
							class="form-control" id="message" name="admessage"
							value="${advo.admessage}">
					</div>
					<input type="hidden" name="adsort" value="${advo.adsort}">
					<input type="hidden" name="adno" value="${advo.adno}"> <input
						type="hidden" name="action" value="UpdateStatus">
					<button type="submit" class="btn btn-default">確認</button>
					<a class="btn btn-default"
						href="<%=request.getContextPath()%>/Back/Ad/ListAllAds.jsp"
						role="button">取消</a>
				</form>
			</td>
		</tr>
	</table>
</div>
</body>
</html>