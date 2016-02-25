<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>新增推薦旅遊點</title>
</head>
<jsp:include page="/Front/select_page.jsp" />
<style>
.hide {
	display: none
}

textarea {
	resize: none;
}
</style>
<script>
	$(function() {
		$('#contown').twzipcode({
			countyName : "country",
			districtName : "district",
			countySel : "${recvo.reccon}",
			districtSel : "${recvo.rectown}"
		});
	});
	function showPic() {
		var reader = new FileReader();
		reader.onload = function(event) {
			document.getElementById("myPic").src = event.target.result;
		};
		reader.readAsDataURL(document.getElementById("pic").files[0]);
	}
	function insert() {
		document.getElementById("name").value = "阿珍米干";
		document.getElementById("phone").value = "03-4664948";
		document.getElementById("site").value = "無";
		document.getElementById("content").value = "在中壢的平鎮市的忠貞市場附近有許多家的米干店，因為這以前有很多的眷村有住很多的雲南人，有一些手藝很好的雲南媽媽會做很多道地的雲南菜，雖然現在有的眷村已改建但是好味道依然留在這裡，所以我覺得要吃雲南菜就要到這來，味道道地價格又比外面便宜，許多我最喜歡的米干店就是位於中山路的阿珍米干這裡有最道地的雲南味，地址：桃園市平鎮區中山路106號";
	}
</script>
<body>

	<div class="container">
		<ol class="breadcrumb">
			<li><a
				href="<%=request.getContextPath()%>/Front/front_index.jsp">首頁</a></li>
			<li><a
				href="<%=request.getContextPath()%>/Front/Trip/memRoute.jsp">會員專區</a></li>
			<li><a
				href="<%=request.getContextPath()%>/Front/Rec/ListRecByMemno.jsp">我的推薦旅遊點</a></li>
			<li class="active">新增推薦旅遊點</li>
		</ol>
		<div class="col-sm-offset-1">
			<c:if test="${not empty errorMsgs}">
						感謝您新增廣告，但請先修正以下錯誤:<br>
				<p class="help-block" style="color:red">
					<c:forEach var="message" items="${errorMsgs}">
							${message}<br>
					</c:forEach>
				</p>
			</c:if>
		</div>
		<form class="form-horizontal" role="form"
			action="<%=request.getContextPath()%>/rec/RecServlet" method="post"
			enctype="multipart/form-data">
			<table>
				<tr>
					<td>
						<div class="form-group">
							<label class="col-sm-3 control-label" for="pic">圖片:</label>
							<div class="col-sm-7">
								<img id="myPic" height="300" width="460" /> <input type="file"
									id="pic" name="recpic" onChange="showPic()" />
							</div>
						</div>
					</td>
					<td>
						<div class="form-group">
							<label class="col-sm-4 control-label" for="name">名稱:</label>
							<div class="col-sm-7">
								<input type="text" id="name" placeholder="輸入名稱" name="recname"
									maxlength=20 value="${recvo.recname}" class="form-control" />
							</div>
						</div> <br>
						<div class="form-group">
							<label class="col-sm-4 control-label" for="class">類別:</label>
							<div class="col-sm-7">
								<select class="form-control" id="class" name="recclass">
									<option value="美食" ${(recvo.recclass=='美食')?'selected':'' }>美食</option>
									<option value="住宿" ${(recvo.recclass=='住宿')?'selected':'' }>住宿</option>
									<option value="景點" ${(recvo.recclass=='景點')?'selected':'' }>景點</option>
								</select>
							</div>
						</div> <br>

						<div class="form-group">
							<label class="col-sm-4 control-label" for="phone">電話:</label>
							<div class="col-sm-7">
								<input type="text" id="phone" placeholder="輸入電話" name="recphone"
									maxlength=20 value="${recvo.recphone }" class="form-control" />
							</div>
						</div> <br>

						<div class="form-group">
							<label class="col-sm-4 control-label" for="site">官網:</label>
							<div class="col-sm-7">
								<input type="text" id="site" placeholder="輸入網址" name="recsite"
									maxlength=150 value="${recvo.recsite }" class="form-control" />
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<td>﻿
						<div class="form-group">
							<label class="col-sm-3 control-label" for="recdress">地址:</label>
							<div class="col-sm-7">
								<div id="contown">
									<div data-role="zipcode" data-style="hide"></div>
								</div>

							</div>
						</div> <jsp:include page="Add_Lat_Long.jsp" />
					</td>
					<td><br>
						<div class="form-group">
							<label class="col-sm-4 control-label" for="content">簡介:</label>
							<div class="col-sm-7">
								<Textarea class="form-control" id="content" cols="100" rows="16"
									name="reccontent">${recvo.reccontent}</Textarea>
							</div>
						</div></td>
				</tr>
				<tr>
					<td>
						<div class="form-group">
							<div class="col-sm-offset-3 col-sm-5">
								<button type="submit" class="btn btn-default">確認</button>
								<a class="btn btn-default"
									href="<%=request.getContextPath()%>/Front/Rec/ListRecByMemno.jsp"
									role="button">取消</a> <input type="hidden" name="action"
									value="Add_New_Rec">
									<input type="button" value="神奇小按鈕" onclick="insert()" class="btn btn-primary" />
							</div>
						</div>
					</td>
				</tr>
			</table>
		</form>
	</div>

</body>
</html>