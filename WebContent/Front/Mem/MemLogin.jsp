<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!-- <META HTTP-EQUIV='Refresh' content='3;URL=https://tw.yahoo.com'> -->
<%
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
	//response.setHeader("Refresh", "3;URL=https://yahoo.com.tw");
%>
<script>
	function statusChangeCallback(response) {
		console.log('statusChangeCallback');
		console.log(response);
		if (response.status === 'connected') {
			fblogin();
		} else if (response.status === 'not_authorized') {
			document.getElementById('status').innerHTML = 'Please log '
					+ 'into this app.';
		} else {
			document.getElementById('status').innerHTML = 'Please log '
					+ 'into Facebook.';
		}
	}
	function checkLoginState() {
		FB.getLoginStatus(function(response) {
			statusChangeCallback(response);
		});
	}

	window.fbAsyncInit = function() {
		FB.init({
			appId : 707761816007436,
			cookie : false, // enable cookies to allow the server to access 
			// the session
			xfbml : true, // parse social plugins on this page
			version : 'v2.1' // use version 2.1
		});

		FB.getLoginStatus(function(response) {
			statusChangeCallback(response);
		});

	};

	// Load the SDK asynchronously
	(function(d, s, id) {
		var js, fjs = d.getElementsByTagName(s)[0];
		if (d.getElementById(id))
			return;
		js = d.createElement(s);
		js.id = id;
		js.src = "//connect.facebook.net/en_US/sdk.js";
		fjs.parentNode.insertBefore(js, fjs);
	}(document, 'script', 'facebook-jssdk'));

	function testAPI() {
		console.log('Welcome!  Fetching your information.... ');
		FB.api('/me',function(response) {
							console.log('Successful login for: '
									+ response.name);
							document.getElementById('status').innerHTML = 'Thanks for logging in, '
									+ response.name+ response.email  +response.id+'!';
						});
		FB.api('/me/picture?type=large', function(response) {
			document.getElementById('status1').innerHTML = response.data.url;
		});
	}
		function fblogin(){	
			  //===實作(填入程式碼)
				var xhr=new XMLHttpRequest();
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
			  
			  FB.api('/me',function(response) {
				  name=response.name;
				  email=response.email;
				  fbid=response.id;
// 				  FB.api('/me/picture',function(response) {
// 					  pic=response.data.url;
// 				  });
			  });
			  //建立好Get連接與送出請求
				var url="<%=request.getContextPath()%>/mem/MemServlet?action=FBLogin&name="+name+"&email="+email+"&id="+fbid;
				xhr.open("Get",url,true);
				xhr.send(null);
			};
	
</script>
<link
	href="<%=request.getContextPath()%>/Front/forIndex/layoutit/css/bootstrap.min.css"
	rel="stylesheet">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>會員登入</title>
</head>
<body>
	<div class="container">
		<div class="jumbotron" style="background-color: lightblue;">
			<h1
				style="font-family: 'Comic Sans MS'; color: red; text-align: center">Welcome
				To Tripame</h1>
		</div>

		<form role="form"
			action="<%=request.getContextPath()%>/mem/MemServlet" method=post>
			<div class="row">
				<div class="col-md-4"></div>
				<div class="col-md-4">
					<div class="form-group">
						<label for="id">帳號:</label>
						<div>
							<input type="text" id="id" placeholder="輸入帳號" name="memid" maxlength="10"
								class="form-control" />
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-4"></div>
				<div class="col-md-4">
					<div class="form-group">
						<label for="pw">密碼:</label>
						<div>
							<input type="password" id="pw" placeholder="輸入密碼" name="mempw" maxlength="10"
								class="form-control" />
						</div>
					</div>
					<div></div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-4"></div>
				<div class="col-md-4">
					<div>
						<div id="fb-root"></div>
						<fb:login-button scope="public_profile,email" onlogin="checkLoginState();" data-size="large">
						</fb:login-button>
						<div id="IdShowPanel"></div>
						<button type="submit" class="btn btn-success btn-lg">登入</button>
						<a class="btn btn-info btn-lg"
							href="<%=request.getContextPath()%>/Front/Mem/AddNewMem.jsp"
							role="button">註冊</a> <a class="btn btn-warning btn-lg"
							href="<%=request.getContextPath()%>/Front/Mem/ForgetPw.jsp"
							role="button">忘記密碼</a> <input type="hidden" name="action"
							value="Mem_Login">
					</div>
				</div>
			</div>
	</form>
	</div>

</body>
</html>