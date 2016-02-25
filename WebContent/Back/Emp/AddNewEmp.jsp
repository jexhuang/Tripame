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
<title>員工新增</title>
</head>
<jsp:include page="/Back/back_index.jsp" />
<script>
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
		var url="<%=request.getContextPath()%>/emp/EmpServlet?action=checkid&empid="+document.getElementById("id").value;
		xhr.open("Get",url,true);
		xhr.send(null);
	};
</script>
<body>
	<div class="container">
		<h2>員工管理</h2>
		<ol class="breadcrumb" style="background-color:rgb(66,139,202)">
			<li><a href="<%=request.getContextPath()%>/Back/back_index.jsp" style="color:white;">首頁</a></li>
			<li><a href="<%=request.getContextPath()%>/Back/Emp/ListEmp.jsp" style="color: white;">員工列表</a></li>
			<li class="active" style="color:white;">員工新增</li>
		</ol>
		<div class="col-sm-offset-2">
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
		<br>
		<form class="form-horizontal" role="form"
			action="<%=request.getContextPath()%>/emp/EmpServlet" method=post>
					<div class="form-group">
						<label class="col-sm-2 control-label" for="name">姓名:</label>
						<div class="col-sm-5">
							<input type="text" id="name" placeholder="輸入名稱" name="empname"
								class="form-control" maxlength=10 value="${empvo1.empname}" />
						</div>
					</div>

					<div class="form-group">
						<label class="col-sm-2 control-label" for="id">帳號:</label>
						<div class="col-sm-5">
							<input type="text" id="id" placeholder="輸入帳號" name="empid"
								maxlength=10 class="form-control" value="${empvo1.empid}"
								onChange="getIdInfo()" />
							<div id="IdShowPanel" style="color:red"></div>
						</div>
					</div>

					<div class="form-group">
						<label class="col-sm-2 control-label" for="email">信箱:</label>
						<div class="col-sm-5">
							<input type="email" id="email" placeholder="輸入信箱" name="empemail"
								class="form-control" maxlength=50 value="${empvo1.empemail}" />
						</div>
					</div>
			<div class="form-group">
				<div class="col-sm-offset-2 col-sm-5">
					<button type="submit" class="btn btn-default">確認</button>
					<a class="btn btn-default"
						href="<%=request.getContextPath()%>/Back/Emp/ListEmp.jsp"
						role="button">取消</a> <input type="hidden" name="action"
						value="Add_New_Emp">
				</div>
			</div>
		</form>
	</div>
</body>
</html>

