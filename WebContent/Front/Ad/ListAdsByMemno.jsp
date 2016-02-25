<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.ad.model.*"%>
<%@ page import="com.mem.model.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="memvo" scope="session" class="com.mem.model.MemVO" />
<jsp:useBean id="adsvc" class="com.ad.model.AdService" />
<%-- <c:forEach var="advo" items="${adsvc.all}" varStatus="status"> --%>
<%-- 	<c:if test="${(advo.adstatus=='審核成功')||(advo.adstatus=='上架中') }"> --%>
<%-- 		<c:set var="count" value="${status.count}" scope="page"/> --%>
<%-- 	</c:if> --%>
<%-- </c:forEach> --%>
<c:set var="time" value="${(adsvc.endDate).getTime()}" scope="request" />
<html>
<head>
<%
	List<AdVO> list=adsvc.getAll();
int count=0;
int c=0;
for(AdVO advo:list){
	if((advo.getAdstatus().equals("上架中"))||(advo.getAdstatus().equals("審核成功"))){
		count++;
	}
	if(advo.getMemno().equals(memvo.getMemno())){
		c=1;
	}
}

pageContext.setAttribute("c", c);
pageContext.setAttribute("count", count);

response.setHeader("Cache-Control", "no-store");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);
%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>廣告列表</title>
</head>
<jsp:include page="/Front/select_page.jsp" />
<style>
#time { ${(
	count >9)?'': 'display: none'
}
}
</style>
<script>
	var currentTimestamp30 = ${time};
	function showTime() {
		var today = new Date();
		var currentTimestamp1 = today.getTime();
		var dis = currentTimestamp30 - currentTimestamp1;
		var a = Math.floor(dis / 86400000);// 天
		var b = dis % 86400000;
		var c = Math.floor(b / 3600000);// 時
		var d = b % 3600000;
		var e = Math.floor(d / 60000);// 分		
		var f = d % 60000;
		var g = Math.floor(f / 1000);//秒
		document.getElementById("timePanel").innerHTML = a + "天:" + c + "小時:"
				+ e + "分:" + g + "秒";
	}
	function init() {
		showTime();
		window.setInterval(showTime, 1000);
	}
	window.onload = init;
</script>
<script type="text/javascript">
	function blinklink() {
		if (!document.getElementById('blink').style.color) {
			document.getElementById('blink').style.color = "red";
		}
		if (document.getElementById('blink').style.color == "red") {
			document.getElementById('blink').style.color = "yellow";
		} else {
			document.getElementById('blink').style.color = "red";
		}
		timer = setTimeout("blinklink()", 300);
	}
</script>
<body onload="blinklink();">
	<div class="container">
		<ol class="breadcrumb">
			<li><a href="<%=request.getContextPath()%>/Front/front_index.jsp">首頁</a></li>
			<li><a href="<%=request.getContextPath()%>/Front/Trip/memRoute.jsp">會員專區</a></li>
			<li class="active">我的廣告</li>
		</ol>
		<c:if test="${c<1 }">
			<div class="jumbotron" style="background-color: black;">
				<a id="blink"
					href="#">
					<h1 align="center"  style="font-family:微軟正黑體">新增您第一個廣告吧!</h1>
				</a>
			</div>
		</c:if>
		<c:if test="${c>0}">
			<table class="table table-bordered">
				<tr>
					<th>廣告照片</th>
					<th>廣告名稱</th>
					<th>廣告狀態</th>
					<th>上架時間</th>
					<th>下架時間</th>
					<th>回覆訊息</th>
					<th></th>
				</tr>

				<c:forEach var="advo" items="${adsvc.all}">
					<c:if test="${advo.memno==memvo.memno }">
						<tr align='center' valign='middle'>
							<td><img
								src="<%=request.getContextPath()%>/ads/AdsPicReader?adsno=${advo.adno}"
								height="160" width="284"></td>
							<td style="line-height: 140px;">${advo.adname}</td>
							<td style="line-height: 140px;">${advo.adstatus}</td>
							<td style="line-height: 140px;">${advo.adbegin}</td>
							<td style="line-height: 140px;">${advo.adend}</td>
							<td style="line-height: 140px;">${advo.admessage}</td>
							<td>
								<FORM METHOD="post"
									ACTION="<%=request.getContextPath()%>/ads/AdsServlet">
									<input type="submit" value="檢視廣告" class="btn btn-info">
									<input type="hidden" name="adno" value="${advo.adno}">
									<input type="hidden" name="action" value="UpdateOneAdByMemno">
								</FORM> <br>
								<FORM METHOD="post"
									ACTION="<%=request.getContextPath()%>/ads/AdsServlet">
									<input type="submit" value="刪除廣告" class="btn btn-danger">
									<input type="hidden" name="adno" value="${advo.adno}">
									<input type="hidden" name="action" value="deleteOneAdByMemno">
								</FORM> <br>
								<FORM METHOD="get"
									ACTION="<%=request.getContextPath()%>/Front/Ad/MemPayAd.jsp">
									<input type="submit" value="廣告付款" class="btn btn-success"
										${(advo.adstatus=='審核成功')?'':'disabled'}>
								</FORM>
							</td>
						</tr>
					</c:if>
				</c:forEach>
			</table>
		</c:if>
		<a class="btn btn-primary btn-lg"
				href="<%=request.getContextPath()%>/Front/Ad/AddNewAds.jsp"
				role="button" ${(count>9)?'disabled':''}> 新增廣告 </a><div id="time">可新增倒數:<span id="timePanel"></span></div>
	</div>
</body>
</html>