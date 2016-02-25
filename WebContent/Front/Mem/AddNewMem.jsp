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
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap.min.css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>註冊會員</title>
<script src="http://code.jquery.com/jquery-1.10.2.js"></script>
  <script src="http://code.jquery.com/ui/1.11.2/jquery-ui.js"></script>
</head>
<script>
function showPic(){
var reader = new FileReader();
reader.onload = function (event) {
  document.getElementById("myPic").src = event.target.result;};
reader.readAsDataURL(document.getElementById("pic").files[0]);
}

function getIdInfo(){	
	  //===實作(填入程式碼)
		var xhr=new XMLHttpRequest();
	  //設定好回呼函數 
	  xhr.onreadystatechange=function(){
		  if(xhr.readyState==4){
			  if(xhr.status==200){
				  document.getElementById("IdShowPanel").innerHTML=xhr.responseText;
				  }
			  else{
				  alert(xhr.status);
				  }
			  }
		  }
	  //建立好Get連接與送出請求
		var url="<%=request.getContextPath()%>/mem/MemServlet?action=checkid&memid="+document.getElementById("id").value;
		xhr.open("Get",url,true);
		xhr.send(null);
	};
	function getPwInfo(){	
		  //===實作(填入程式碼)
			var xhr=new XMLHttpRequest();
		  //設定好回呼函數 
		  xhr.onreadystatechange=function(){
			  if(xhr.readyState==4){
				  if(xhr.status==200){
					  document.getElementById("PwShowPanel").innerHTML=xhr.responseText;
					  }
				  else{
					  alert(xhr.status);
					  }
				  }
			  }
		  //建立好Get連接與送出請求
			var url="<%=request.getContextPath()%>/mem/MemServlet?action=checkpw&mempw="
				+ document.getElementById("pw").value;
		xhr.open("Get", url, true);
		xhr.send(null);
	};
</script>
<script>
$(document).ready(function(){
	$( "#effect" ).hide();
	$("#effect2").hide();
	$( "#effect" ).show( "bounce",1000,after);
	 
  });
  function after()
  {
	  $("#effect2").show("puff",1000);
  }
</script>
<body>
	<div class="container">
	<div class="jumbotron" style="background-color:lightblue;">
   			 <h1 style="font-family:'Comic Sans MS';color:red;text-align:center">Welcome To Tripame</h1>      
  		</div>
		<div class="col-sm-offset-3">
			<c:if test="${not empty errorMsgs}">			
						<span id="effect">感謝您註冊會員，但請先修正以下錯誤:</span><br>
				<p class="help-block" id="effect2" style="width:250px;color:red">
					<c:forEach var="message" items="${errorMsgs}">
							${message}<br>
					</c:forEach>
				</p>
			</c:if>
		</div>
		<form class="form-horizontal" role="form"
			action="<%=request.getContextPath()%>/mem/MemServlet" method=post
			enctype="multipart/form-data">
			<div class="form-group form-group-lg">
				<label class="col-sm-3 control-label" for="pic">大頭貼:</label>
				<div class="col-sm-4">
					<img id="myPic" height="300" width="250" /> <input type="file"
						id="pic" name="mempic" onChange="showPic()" />
				</div>

			</div>
			<div class="form-group form-group-lg">
				<label class="col-sm-3 control-label" for="name">姓名:</label>
				<div class="col-sm-4">
					<input type="text" id="name" placeholder="輸入名稱" name="memname"
						class="form-control" maxlength=10 value="${memvo.memname}" />
				</div>
			</div>
			<div class="form-group form-group-lg">
				<label class="col-sm-3 control-label" for="id">帳號:</label>
				<div class="col-sm-4">
					<input type="text" id="id" placeholder="輸入帳號" name="memid"
						maxlength=10 class="form-control" value="${memvo.memid}"
						onChange="getIdInfo()" />
					<div id="IdShowPanel" style="color:red"></div>
				</div>
			</div>
			<div class="form-group form-group-lg">
				<label class="col-sm-3 control-label" for="pw">密碼:</label>
				<div class="col-sm-4">
					<input type="password" id="pw" placeholder="輸入密碼" name="mempw"
						maxlength=10 class="form-control" value="${memvo.mempw}"
						onChange="getPwInfo()" />
					<div id="PwShowPanel" style="color:red"></div>
				</div>
			</div>
			<div class="form-group form-group-lg">
				<label class="col-sm-3 control-label" for="email">信箱:</label>
				<div class="col-sm-4">
					<input type="email" id="email" placeholder="輸入信箱" name="mememail"
						class="form-control" maxlength=40 value="${memvo.mememail}" />
				</div>
			</div>
			<div class="form-group">
				<div class="col-sm-offset-3 col-sm-4">
					<button type="submit" class="btn btn-success">送出</button>
					<a class="btn btn-warning"
						href="<%=request.getContextPath()%>/Front/Mem/MemLogin.jsp"
						role="button">取消</a> <input type="hidden" name="action"
						value="Add_New_Mem">
				</div>
			</div>
		</form>
	</div>
</body>
</html>