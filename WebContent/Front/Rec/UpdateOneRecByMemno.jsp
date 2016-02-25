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
<title>修改推薦旅遊點</title>
</head>
<jsp:include page="/Front/select_page.jsp" />
<style>
.hide {
	display: none
}

.con { ${(
	recvo .recstatus=='請修改')?'': 'display: none'
}

}
.dis { ${(
	recvo .recstatus=='請修改')?'': 'display: none'
}
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
</script>
<body>
	<div class="container">
	<ol class="breadcrumb">
			<li><a href="<%=request.getContextPath()%>/Front/front_index.jsp">首頁</a></li>
			<li><a href="<%=request.getContextPath()%>/Front/Trip/memRoute.jsp">會員專區</a></li>
			<li><a
				href="<%=request.getContextPath()%>/Front/Rec/ListRecByMemno.jsp">我的推薦旅遊點</a></li>
			<li class="active">更新推薦旅遊點</li>
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
		<form action="<%=request.getContextPath()%>/rec/RecServlet"
			method=post enctype="multipart/form-data">
			<table class="table">
				<tr>
				<td><div class="form-group">
							<img id="myPic"
								src="<%=request.getContextPath()%>/rec/RecPicReader?recno=${recvo.recno}"
								height="400" width="600"> <input type="file" id="pic"
								name="recpic" ${(recvo.recstatus=='請修改')?'':'disabled'}
								onChange="showPic()">
						</div></td>
					<td>
						<table>
							<tr>
								<td>
									<div class="form-group">
										<label for="class">分類</label>
										 <select class="form-control"
											id="class" name="recclass"
											${(recvo.recstatus=='請修改')?'':'disabled'}>
											<option value="美食" ${(recvo.recclass=='美食')?'selected':'' }>美食</option>
						<option value="住宿" ${(recvo.recclass=='住宿')?'selected':'' }>住宿</option>
						<option value="景點" ${(recvo.recclass=='景點')?'selected':'' }>景點</option>
										</select>
									</div>
								</td>
							</tr>
							<tr>
								<td>
									<div class="form-group">
										<label for="name">名稱</label> <input type="text"
											class="form-control" id="name" name="recname" maxlength=20 size="40"
											value="${recvo.recname}"
											${(recvo.recstatus=='請修改')?'':'disabled'}>
									</div>
								</td>
							</tr>
							<tr>
								<td>
									<div class="form-group">
										<label for="phone">電話</label> <input type="text"
											class="form-control" id="phone" name="recphone" maxlength=20 size="40"
											value="${recvo.recphone}"
											${(recvo.recstatus=='請修改')?'':'disabled'}>
									</div>
								</td>
							</tr>
							<tr>
								<td>
									<div class="form-group">
										<label for="site">網址</label> <input type="text" 
											class="form-control" id="site" name="recsite" maxlength=150 size="40"
											value="${recvo.recsite}"
											${(recvo.recstatus=='請修改')?'':'disabled'}>
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
							<textarea class="form-control" id="content" name="reccontent" rows="20" cols="50"
								${(recvo.recstatus=='請修改')?'':'disabled'}>${recvo.reccontent}</textarea>
						</div>
					</td>
				</tr>
			</table>
			<input type="hidden" name="recmessage" value="${recvo.recmessage}">
			<input type="hidden" name="recsort" value="${recvo.recsort}">
			<input type="hidden" name="recstatus" value="${recvo.recstatus}">
			<input type="hidden" name="recno" value="${recvo.recno}"> <input
				type="hidden" name="action" value="UpdateByMem">
			<button type="submit" class="btn btn-default">確認</button>
		</form>
	</div>
</body>
</html>