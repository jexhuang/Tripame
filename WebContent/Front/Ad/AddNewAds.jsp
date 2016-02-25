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
<title>新增廣告</title>
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
			countySel : "${advo.adcon}",
			districtSel : "${advo.adtown}"
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
		document.getElementById("name").value = "資策會JAVA班";
		document.getElementById("phone").value = "03-4257387";
		document.getElementById("site").value = "http://chungli2.iiiedu.org.tw/chungli/";
		document.getElementById("content").value = "資策會數位教育研究所國際人才發展中心位於國立中央大學校區內，於 1984 年成立，已二十餘年，其成立宗旨以辦理資訊人才推廣與資訊軟體研究發展為主；資訊人才推廣係與中央大學合作，並秉持資策會優良的傳統，加上在地用心經營，國際人才發展中心已成為北台灣地區資訊人才培訓的重要據點。地址：桃園市中壢區中大路300號";
	}
</script>
<body>

	<div class="container">
		<ol class="breadcrumb">
			<li><a href="<%=request.getContextPath()%>/Front/front_index.jsp">首頁</a></li>
			<li><a href="<%=request.getContextPath()%>/Front/Trip/memRoute.jsp">會員專區</a></li>
			<li><a
				href="<%=request.getContextPath()%>/Front/Ad/ListAdsByMemno.jsp">我的廣告</a></li>
			<li class="active">新增廣告</li>
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
			action="<%=request.getContextPath()%>/ads/AdsServlet" method="post"
			enctype="multipart/form-data">
			<table>
				<tr>
					<td>
						<div class="form-group">
							<label class="col-sm-3 control-label" for="pic">圖片:</label>
							<div class="col-sm-7">
								<img id="myPic" height="300" width="460" /> <input type="file"
									id="pic" name="adpic" onChange="showPic()" />
							</div>
						</div>
					</td>
					<td>
						<div class="form-group">
							<label class="col-sm-4 control-label" for="name">名稱:</label>
							<div class="col-sm-7">
								<input type="text" id="name" placeholder="輸入名稱" name="adname"
									maxlength=20 value="${advo.adname}" class="form-control" />
							</div>
						</div> <br>

						<div class="form-group">
							<label class="col-sm-4 control-label" for="class">類別:</label>
							<div class="col-sm-7">
								<select class="form-control" id="class" name="adclass">
									<option value="美食" ${(advo.adclass=='美食')?'selected':'' }>美食</option>
									<option value="住宿" ${(advo.adclass=='住宿')?'selected':'' }>住宿</option>
									<option value="景點" ${(advo.adclass=='景點')?'selected':'' }>景點</option>
								</select>
							</div>
						</div> <br>

						<div class="form-group">
							<label class="col-sm-4 control-label" for="phone">電話:</label>
							<div class="col-sm-7">
								<input type="text" id="phone" placeholder="輸入電話" name="adphone"
									maxlength=20 value="${advo.adphone }" class="form-control" />
							</div>
						</div> <br>

						<div class="form-group">
							<label class="col-sm-4 control-label" for="site">官網:</label>
							<div class="col-sm-7">
								<input type="text" id="site" placeholder="輸入網址" name="adsite"
									maxlength=150 value="${advo.adsite }" class="form-control" />
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<td>﻿
						<div class="form-group">
							<label class="col-sm-3 control-label" for="address">地址:</label>
							<div class="col-sm-7">
								<div id="contown">
									<div data-role="zipcode" data-style="hide"></div>
								</div>
								
							</div>
						</div>
						<jsp:include page="Add_Lat_Long.jsp" />
					</td>
					<td><br>
						<div class="form-group">
							<label class="col-sm-4 control-label" for="content">簡介:</label>
							<div class="col-sm-7">
								<Textarea class="form-control" id="content" cols="100" rows="16"
									name="adcontent">${advo.adcontent}</Textarea>
							</div>
						</div></td>
				</tr>
				<tr>
					<td>
						<div class="form-group">
							<div class="col-sm-offset-3 col-sm-5">
								<button type="submit" class="btn btn-default">確認</button>
								<a class="btn btn-default"
									href="<%=request.getContextPath()%>/Front/Ad/ListAdsByMemno.jsp"
									role="button">取消</a> <input type="hidden" name="action"
									value="Add_New_Ads">
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