<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:useBean id="memSvc" scope="page" class="com.mem.model.MemService" />
<%
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>修改套裝行程</title>
</head>
<jsp:include page="/Back/back_index.jsp" />
<link rel="stylesheet" href="http://code.jquery.com/ui/1.11.2/themes/smoothness/jquery-ui.css">
  <script src="http://code.jquery.com/jquery-1.10.2.js"></script>
  <script src="http://code.jquery.com/ui/1.11.2/jquery-ui.js"></script>
<script>
	function showPic() {
		var reader = new FileReader();
		reader.onload = function(event) {
			document.getElementById("myPic").src = event.target.result;
		};
		reader.readAsDataURL(document.getElementById("pic").files[0]);
	}
</script>
<script>
  $(function() {
    $( "#from" ).datepicker({
      defaultDate: "+1w",
      changeMonth: true,
      numberOfMonths: 1,
      dateFormat:'yy-mm-dd',
      onClose: function( selectedDate ) {
        $( "#to" ).datepicker( "option", "minDate", selectedDate );
      }
    });
    $( "#to" ).datepicker({
      defaultDate: "+1w",
      changeMonth: true,
      numberOfMonths: 1,
      dateFormat:'yy-mm-dd',
      onClose: function( selectedDate ) {
        $( "#from" ).datepicker( "option", "maxDate", selectedDate );
      }
    });
    
  });
</script>
<body>
	<div class="container" style="margin-top:-30px;">
		<h2>套裝行程管理</h2>
		<ol class="breadcrumb" style="background-color: rgb(66, 139, 202)">
			<li><a href="<%=request.getContextPath()%>/Back/back_index.jsp"
				style="color: white;">首頁</a></li>
			<li><a href="<%=request.getContextPath()%>/Back/Travel/ListAllTravel.jsp"
				style="color: white;">套裝行程列表</a></li>
			<li class="active" style="color: white;">修改套裝行程</li>
		</ol>
		<div class="col-sm-offset-3">
			<div>
		<c:if test="${errorMsgs!=null }">
		<span>請修正以下錯誤</span>
			<ul>
				<c:forEach var="message" items="${errorMsgs}">
				<li style="color:red;">${message }
				</c:forEach>
			</ul>
		</c:if>			
		</div>
		</div>
		<form class="form-horizontal" role="form"
			action="<%=request.getContextPath()%>/travel/TravelServlet"
			method="post" enctype="multipart/form-data">
			<div class="form-group">
				<label class="col-sm-3 control-label" for="pic">圖片:</label>
				<div class="col-sm-7">
					<img
						src="<%=request.getContextPath()%>/travel/TravelPicReader?travelno=${travelvo.travelno}"
						id="myPic" height="300" width="460" /> <input type="file"
						id="pic" name="pic" onChange="showPic()" />
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label" for="begin">開始日期</label>
				<div class="col-sm-3">
					<input type="text" id="from" name="begin" class="form-control"
						value="${travelvo.travelbegin}" />
				</div>
				<label class="col-sm-1 control-label" for="end">結束日期</label>
				<div class="col-sm-3">
					<input type="text" id="to" name="end" class="form-control"
						value="${travelvo.travelend}" />
				</div>
			</div>
			<br>
			<div class="form-group">
				<label class="col-sm-3 control-label" for="limit">限制人數</label>
				<div class="col-sm-3">
					<input type="text" id="limit" name="limit"
						value="${travelvo.travellimit}" class="form-control" maxlength="10"/>
				</div>
			</div>
			<br>
			<div class="form-group">
				<label class="col-sm-3 control-label" for="price">報名費</label>
				<div class="col-sm-3">
					<input type="text" id="price" name="price"
						value="${travelvo.travelprice}" class="form-control" maxlength="10"/>
				</div>
			</div>
			<br>
			<div class="form-group">
				<label class="col-sm-3 control-label" for="site">行程名稱:</label>
				<div class="col-sm-7">
					<input type="text" id="site" placeholder="輸入行程名稱" name="name"
						maxlength=150 value="${travelvo.travelname }" class="form-control" maxlength="50"/>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label">行程狀態:</label>
				<div class="col-sm-2">
					<select name="status" class="form-control">
						<option value="待上架"
							${(travelvo.travelstatus=='待上架')?'selected':''}>待上架</option>
						<option value="上架中"
							${(travelvo.travelstatus=='上架中')?'selected':''}>上架中</option>
						<option value="已下架"
							${(travelvo.travelstatus=='已下架')?'selected':''}>已下架</option>
					</select>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-3 control-label" for="site">行程簡介:</label>
				<div class="col-md-9">
					<jsp:include page="/Back/Travel/replace.jsp" />
				</div>
			</div>
			<div class="form-group">
				<div class="col-sm-offset-3 col-sm-5">
					<input type="submit" class="btn btn-default" value="確認"
						onClick="btnSubmit();"> <a class="btn btn-default"
						href="<%=request.getContextPath()%>/Back/Travel/ListAllTravel.jsp"
						role="button">取消</a> <input type="hidden" name="travelno"
						value="${travelvo.travelno}"> <input type="hidden"
						name="action" value="UpdateTravel">
				</div>
			</div>
			<div class="form-group">
			<div class="col-sm-offset-3 col-sm-5">
				<table>
					<tr>
						<th>報名會員</th>
					</tr>
					<tr>
						<c:forEach var="tjvo" items="${list}">
							<c:forEach var="memVO" items="${memSvc.all}">
								<c:if test="${tjvo.memno==memVO.memno}">
									<td>${memVO.memname}</td>
								</c:if>
							</c:forEach>
						</c:forEach>
					</tr>
				</table>
				</div>
			</div>
		</form>

	</div>
</body>
</html>