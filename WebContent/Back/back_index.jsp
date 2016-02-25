<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">

<title>Tripame後端管理平台</title>

<!-- Bootstrap Core CSS -->
<link
	href="<%=request.getContextPath()%>/Back/forIndex/css/bootstrap.min.css"
	rel="stylesheet">

<!-- Custom CSS -->
<link
	href="<%=request.getContextPath()%>/Back/forIndex/css/sb-admin.css"
	rel="stylesheet">

<!-- Morris Charts CSS -->
<link
	href="<%=request.getContextPath()%>/Back/forIndex/css/plugins/morris.css"
	rel="stylesheet">

<!-- Custom Fonts -->
<link
	href="<%=request.getContextPath()%>/Back/forIndex/font-awesome/css/font-awesome.min.css"
	rel="stylesheet" type="text/css">
<link rel="stylesheet"
	href="http://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css">

</head>

<body style="background-color:white">

	<div id="wrapper">

		<!-- Navigation -->
		<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
			<!-- Brand and toggle get grouped for better mobile display -->
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target=".navbar-ex1-collapse">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand"
					href="<%=request.getContextPath()%>/Back/back_index.jsp"><span
					class="glyphicon glyphicon-home" aria-hidden="true"></span>
					Tripame後端管理平台</a>
			</div>
			<!-- Top Menu Items -->
			<ul class="nav navbar-right top-nav">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown"><i class="fa fa-user"></i> ${(sessionScope.empvo==null)?'尚未登入':''} ${sessionScope.empvo.empname}<b
						class="caret"></b></a>
					<ul class="dropdown-menu">
					<c:if test="${sessionScope.empvo==null}">
						<li><a href="<%=request.getContextPath()%>/tripame/BackSelectPage?page=login"><i class="fa fa-fw fa-power-off"></i>登入</a></li>
					</c:if>
					<c:if test="${sessionScope.empvo!=null}">
						<li><a href="<%=request.getContextPath()%>/tripame/BackSelectPage?page=logout"><i class="fa fa-fw fa-power-off"></i>登出</a></li>
					</c:if>
					</ul></li>
			</ul>
			<!-- Sidebar Menu Items - These collapse to the responsive navigation menu on small screens -->
			<div class="collapse navbar-collapse navbar-ex1-collapse"
				style="font-size: 16px;style="background-color:white;">
				<ul class="nav navbar-nav side-nav" style="font-size: 16px;background-color:white;">
					<li><a href="<%=request.getContextPath()%>/tripame/BackSelectPage?page=mem"><i class="fa fa-fw"></i><span
							class="glyphicon glyphicon-user" aria-hidden="true"></span>會員管理</a></li>
					<li><a href="<%=request.getContextPath()%>/tripame/BackSelectPage?page=emp"><i class="fa fa-fw"></i><span
							class="glyphicon glyphicon-user" aria-hidden="true"></span>員工管理</a></li>
					<li><a href="<%=request.getContextPath()%>/tripame/BackSelectPage?page=activity"><i class="fa fa-fw"></i><span
							class="glyphicon glyphicon-star-empty" aria-hidden="true"></span>活動管理</a>
					</li>
					<li><a href="<%=request.getContextPath()%>/tripame/BackSelectPage?page=ad"><i class="fa fa-fw"></i><span
							class="glyphicon glyphicon-thumbs-up" aria-hidden="true"></span>廣告管理</a>
					</li>
					<li><a href="<%=request.getContextPath()%>/tripame/BackSelectPage?page=traffic"><i class="fa fa-fw"></i><span
							class="glyphicon glyphicon-plane" aria-hidden="true"></span>交通管理</a></li>
					<li><a href="<%=request.getContextPath()%>/tripame/BackSelectPage?page=forums"><i class="fa fa-fw"></i><span
							class="glyphicon glyphicon-comment" aria-hidden="true"></span>討論區管理</a></li>
					<li><a href="<%=request.getContextPath()%>/tripame/BackSelectPage?page=travel"><i class="fa fa-fw"></i><span
							class="glyphicon glyphicon-camera" aria-hidden="true"></span>套裝行程管理</a></li>
					<li><a href="<%=request.getContextPath()%>/tripame/BackSelectPage?page=spot"><i class="fa fa-fw"></i><span
							class="glyphicon glyphicon-tower" aria-hidden="true"></span>旅遊點管理</a></li>
					<li><a href="<%=request.getContextPath()%>/tripame/BackSelectPage?page=rec"><i class="fa fa-fw"></i><span
							class="glyphicon glyphicon-bookmark" aria-hidden="true"></span>會員旅遊點管理</a></li>
				</ul>
			</div>
			<!-- /.navbar-collapse -->
		</nav>
		<h1>${param.auth}</h1>
	</div>
	
	<!-- /#wrapper -->

	<!-- jQuery -->
	<script src="<%=request.getContextPath()%>/Back/forIndex/js/jquery.js"></script>

	<!-- Bootstrap Core JavaScript -->
	<script
		src="<%=request.getContextPath()%>/Back/forIndex/js/bootstrap.min.js"></script>

<!-- github.io delivers wrong content-type - but you may want to include FontAwesome in 'wysiwyg-editor.css' -->

	<!-- Morris Charts JavaScript -->
	<script
		src="<%=request.getContextPath()%>/Back/forIndex/js/plugins/morris/raphael.min.js"></script>
	<script
		src="<%=request.getContextPath()%>/Back/forIndex/js/plugins/morris/morris.min.js"></script>
	<script
		src="<%=request.getContextPath()%>/Back/forIndex/js/plugins/morris/morris-data.js"></script>
	
</body>

</html>
