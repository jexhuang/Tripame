<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
response.setHeader("Cache-Control", "no-store");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);
%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>帳號管理</title>
</head>
<jsp:include page="/Front/select_page.jsp"/>
<script>
function showPic(){
var reader = new FileReader();
reader.onload = function (event) {
  document.getElementById("myPic").src = event.target.result;};
reader.readAsDataURL(document.getElementById("pic").files[0]);
}
</script>
<body>

	<div class="container">
	<ol class="breadcrumb">
			<li><a href="<%=request.getContextPath()%>/Front/front_index.jsp">首頁</a></li>
			<li><a href="<%=request.getContextPath()%>/Front/Trip/memRoute.jsp">會員專區</a></li>
			<li class="active">帳號管理</li>
		</ol>
		<div class="col-sm-offset-3">
					<c:if test="${not empty errorMsgs}">
						請修正以下錯誤:<br>
						<p class="help-block" style="color:red">
							<c:forEach var="message" items="${errorMsgs}">
							${message}<br>
							</c:forEach>
						</p>
					</c:if>
		</div>
		<form role="form" class="form-horizontal"
			action="<%=request.getContextPath()%>/mem/MemServlet" method=post
			enctype="multipart/form-data">
			<div class="form-group form-group-lg">
				<label class="col-sm-3 control-label" for="pic">大頭貼:</label>
				<div class="col-sm-6">
					<img id="myPic" src="<%=request.getContextPath()%>/mem/MemPicReader?memno=${memvo.memno}" height="300" width="250">
					<input type="file" id="pic" name="mempic" onChange="showPic()" ${(memvo.memcode=='fbmem')?'disabled':'' }/>
				</div>
			</div>
			<div class="form-group form-group-lg">
				<label class="col-sm-3 control-label" for="id">帳號:</label>
				<div class="col-sm-4">
					<input type="text" id="id" value="${memvo.memid}" name="memid"
						class="form-control" readonly />
				</div>
			</div>
				<div class="form-group form-group-lg">
				<label class="col-sm-3 control-label" for="name">姓名:</label>
				<div class="col-sm-4">
					<input type="text" id="name" value="${memvo.memname}"
						name="memname" class="form-control" ${(memvo.memcode=='fbmem')?'readonly':'' } maxlength="10"/>
				</div>
			</div>
			<div class="form-group form-group-lg">
				<label class="col-sm-3 control-label" for="pw">密碼:</label>
				<div class="col-sm-4">
					<input type="password" id="pw" value="${memvo.mempw}" name="mempw"
						class="form-control" ${(memvo.memcode=='fbmem')?'readonly':'' } maxlength="10"/>
				</div>
			</div>
			<div class="form-group form-group-lg">
				<label class="col-sm-3 control-label" for="email">信箱:</label>
				<div class="col-sm-4">
					<input type="email" id="email" value="${memvo.mememail}"
						name="mememail" class="form-control" readonly />
				</div>
			</div>
			<div class="form-group">
				<div class="col-sm-offset-3 col-sm-5">
					<button type="submit" class="btn btn-default">確認</button>
					<a class="btn btn-default" href="<%=request.getContextPath()%>/Front/Mem/UpdateMem.jsp" role="button">取消</a>
					<input type="hidden" name="action" value="UpdateMem">
					<input type="hidden" name="memno" value="${memvo.memno}">
					<input type="hidden" name="memcode" value="${memvo.memcode}">
				</div>
			</div>
		</form>
	</div>
</body>
</html>