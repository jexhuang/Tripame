<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.traffic.model.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>新增交通資訊</title>
<jsp:include page="/Back/back_index.jsp" />
</head>
<script>
	function insert() {
		document.getElementsByName("traname")[0].value = "聯合計程車";
		document.getElementsByName("traaddress")[0].value = "桃園縣中壢市龍昌路163號";
		document.getElementsByName("trasite")[0].value = "無";
		document.getElementsByName("traphone")[0].value = "03-4666664";
	}
</script>
<body>
	<div class="container">
		<h2>交通管理</h2>
		<ol class="breadcrumb" style="background-color: rgb(66, 139, 202)">
			<li><a href="<%=request.getContextPath()%>/Back/back_index.jsp"
				style="color: white;">首頁</a></li>
			<li><a href="<%=request.getContextPath()%>/Back/Traffic/SearchTra.jsp"
				style="color: white;">交通管理</a></li>
			<li class="active" style="color: white;">新增交通資訊</li>
		</ol>
		<div class="col-sm-offset-2">
			<div>
				<c:if test="${errorMsgs!=null }">
					<span>請修正以下錯誤</span>
					<ul>
						<c:forEach var="message" items="${errorMsgs}">
							<li style="color: red;">${message }
						</c:forEach>
					</ul>
				</c:if>
			</div>
		</div>

		<form class="form-horizontal"
			action="<%=request.getContextPath()%>/traffic/traffic.do"
			method=post>
			<br>
			<div class="form-group">
				<label class="col-sm-2 control-label">名稱</label>
				<div class="col-sm-5">
					<input type="text" name="traname" value="${trafficVO.traname }"
						class="form-control" maxlength="20">
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label">分類</label>
				<div class="col-sm-5">
					<select name="traclass" class="form-control">
						<option ${(trafficVO.traclass=='客運')?'selected':'' }>客運</option>
						<option ${(trafficVO.traclass=='機車')?'selected':'' }>機車</option>
						<option ${(trafficVO.traclass=='計程車')?'selected':'' }>計程車</option>
					</select>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label">縣市</label>
				<div class="col-sm-5">
					<select name="tracon" class="form-control">
						<option ${(trafficVO.tracon=='基隆縣')?'selected':'' }>基隆縣</option>
						<option ${(trafficVO.tracon=='台北市')?'selected':'' }>台北市</option>
						<option ${(trafficVO.tracon=='新北市')?'selected':'' }>新北市</option>
						<option ${(trafficVO.tracon=='桃園市')?'selected':'' }>桃園市</option>
						<option ${(trafficVO.tracon=='新竹縣')?'selected':'' }>新竹縣</option>
						<option ${(trafficVO.tracon=='苗栗縣')?'selected':'' }>苗栗縣</option>
						<option ${(trafficVO.tracon=='台中市')?'selected':'' }>台中市</option>
						<option ${(trafficVO.tracon=='南投縣')?'selected':'' }>南投縣</option>
						<option ${(trafficVO.tracon=='彰化縣')?'selected':'' }>彰化縣</option>
						<option ${(trafficVO.tracon=='雲林縣')?'selected':'' }>雲林縣</option>
						<option ${(trafficVO.tracon=='嘉義縣')?'selected':'' }>嘉義縣</option>
						<option ${(trafficVO.tracon=='台南市')?'selected':'' }>台南市</option>
						<option ${(trafficVO.tracon=='高雄市')?'selected':'' }>高雄市</option>
						<option ${(trafficVO.tracon=='屏東縣')?'selected':'' }>屏東縣</option>
						<option ${(trafficVO.tracon=='台東縣')?'selected':'' }>台東縣</option>
						<option ${(trafficVO.tracon=='花蓮縣')?'selected':'' }>花蓮縣</option>
						<option ${(trafficVO.tracon=='宜蘭縣')?'selected':'' }>宜蘭縣</option>
					</select>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label">地址</label>
				<div class="col-sm-5">
					<input type="text" name="traaddress"
						value="${trafficVO.traaddress }" class="form-control"
						maxlength="75">
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label">電話</label>
				<div class="col-sm-5">
					<input type="text" name="traphone" value="${trafficVO.traphone }"
						class="form-control" maxlength="20">
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label">官網</label>
				<div class="col-sm-5">
					<input type="text" name="trasite" value="${trafficVO.trasite }"
						class="form-control" maxlength="150">
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label"></label>
				<div class="col-sm-5">
					<input type="submit" value="確認" class="btn btn-default"> <a
						class="btn btn-default"
						href="<%=request.getContextPath() %>${param.requestURL }"
						role="button">取消</a> <input type="button" value="神奇小按鈕"
						onclick="insert()" class="btn btn-primary" />
				</div>
			</div>
			<input type="hidden" name="action" value="insert"> <input
				type="hidden" name="requestURL" value="${param.requestURL }">
		</form>
	</div>
</body>
</html>