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
<title>修改廣告</title>
</head>
<jsp:include page="/Front/select_page.jsp" />
<style>
.hide {
	display: none
}

.con { ${(
	advo .adstatus=='請修改')?'': 'display: none'
}

}
.dis { ${(
	advo .adstatus=='請修改')?'': 'display: none'
}
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
</script>
<body>
	<div class="container">
	<ol class="breadcrumb">
			<li><a href="<%=request.getContextPath()%>/Front/front_index.jsp">首頁</a></li>
			<li><a href="<%=request.getContextPath()%>/Front/Trip/memRoute.jsp">會員專區</a></li>
			<li><a href="<%=request.getContextPath()%>/Front/Ad/ListAdsByMemno.jsp">我的廣告</a></li>
			<li class="active">更新廣告</li>
		</ol>
		<div class="col-sm-offset-3">
			<c:if test="${not empty errorMsgs}">
						感謝您新增廣告，但請先修正以下錯誤:<br>
				<p class="help-block" style="color:red">
					<c:forEach var="message" items="${errorMsgs}">
							${message}<br>
					</c:forEach>
				</p>
			</c:if>
		</div>

		<form action="<%=request.getContextPath()%>/ads/AdsServlet"
			method=post enctype="multipart/form-data">
			<table class="table">
				<tr>
					<td><div class="form-group">
							<img id="myPic"
								src="<%=request.getContextPath()%>/ads/AdsPicReader?adsno=${advo.adno}"
								height="400" width="600"> <input type="file" id="pic"
								name="adpic" ${(advo.adstatus=='請修改')?'':'disabled'}
								onChange="showPic()">
						</div></td>
					<td>
						<table>
							<tr>
								<td>
									<div class="form-group">
										<label for="class">廣告分類</label> <select class="form-control"
											id="class" name="adclass"
											${(advo.adstatus=='請修改')?'':'disabled'}>
											<option value="美食" ${(advo.adclass=='美食')?'selected':'' }>美食</option>
									<option value="住宿" ${(advo.adclass=='住宿')?'selected':'' }>住宿</option>
									<option value="景點" ${(advo.adclass=='景點')?'selected':'' }>景點</option>
										</select>
									</div>
								</td>
							</tr>
							<tr>
								<td>
									<div class="form-group">
										<label for="name">名稱</label> <input type="text" 
											class="form-control" id="name" name="adname" maxlength=20 size="40"
											value="${advo.adname}"
											${(advo.adstatus=='請修改')?'':'disabled'}>
									</div>
								</td>
							</tr>
							<tr>
								<td>
									<div class="form-group">
										<label for="phone">電話</label> <input type="text"
											class="form-control" id="phone" name="adphone" maxlength=20 size="40"
											value="${advo.adphone}"
											${(advo.adstatus=='請修改')?'':'disabled'}>
									</div>
								</td>
							</tr>
							<tr>
								<td>
									<div class="form-group">
										<label for="site">網址</label> <input type="text"
											class="form-control" id="site" name="adsite" maxlength=150 size="40"
											value="${advo.adsite}"
											${(advo.adstatus=='請修改')?'':'disabled'}>
									</div>
								</td>
							</tr>
						</table>
					</td>

				</tr>
				<tr>
					<td>
						<div class="form-group">
							<label for="address">地址:</label>
							<div id="contown">
								<div data-role="county" data-style="con"></div>
								<div data-role="district" data-style="dis"></div>
								<div data-role="zipcode" data-style="hide"></div>
							</div>
							<jsp:include page="Lat_Long.jsp" />
						</div>
					</td>
					<td>
						<div class="form-group">
							<label for="content">簡介</label>
							<textarea class="form-control" id="content" name="adcontent" rows="20" cols="50"
								${(advo.adstatus=='請修改')?'':'disabled'}>${advo.adcontent}</textarea>
						</div>
					</td>
				</tr>
			</table>
			<input type="hidden" name="admessage" value="${advo.admessage}">
			<input type="hidden" name="adsort" value="${advo.adsort}"> <input
				type="hidden" name="adstatus" value="${advo.adstatus}"> <input
				type="hidden" name="adno" value="${advo.adno}"> <input
				type="hidden" name="adbegin" value="${advo.adbegin}"> <input
				type="hidden" name="adend" value="${advo.adend}"> <input
				type="hidden" name="action" value="UpdateByMem">
			<button type="submit" class="btn btn-default">確認</button>
		</form>
	</div>
</body>
</html>