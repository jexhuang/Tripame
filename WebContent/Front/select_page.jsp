<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Tripame</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<%@ include file="/Front/jsandcss"%>
</head>
<body>
	<div class="container">
		<div class="row clearfix">
			<div class="col-md-12 column">
				<nav class="navbar navbar-inverse navbar-custom" role="navigation">

				<div class="navbar-header">
					<button type="button" class="navbar-toggle" data-toggle="collapse"
						data-target="#bs-example-navbar-collapse-1">
						<span class="icon-bar"></span><span class="icon-bar"></span><span
							class="icon-bar"></span>
					</button>
					<a class="navbar-brand"
						href="<%=request.getContextPath()%>/Front/front_index.jsp"><h4 style="font-size:24px;">Tripame</h4></a>
				</div>

				<div class="collapse navbar-collapse"
					id="bs-example-navbar-collapse-1">
					<ul class="nav navbar-nav">
						<li><a
							href="<%=request.getContextPath()%>/tripame/FrontSelectPage?page=spot"><h4 style="font-size:18px">
									<span class="glyphicon glyphicon-search" aria-hidden="true"></span>景點查詢
								</h4></a></li>
						<li><a
							href="<%=request.getContextPath()%>/tripame/FrontSelectPage?page=food"><h4 style="font-size:18px">
									<span class="glyphicon glyphicon-cutlery" aria-hidden="true"></span>美食搜索
								</h4></a></li>
						<li><a
							href="<%=request.getContextPath()%>/tripame/FrontSelectPage?page=room"><h4 style="font-size:18px">
									<span class="glyphicon glyphicon-home" aria-hidden="true"></span>住宿指南
								</h4></a></li>
						
						<li><a href="<%=request.getContextPath()%>/tripame/FrontSelectPage?page=activity"><h4 style="font-size:18px">
									<span class="glyphicon glyphicon-flash" aria-hidden="true"></span>活動快報
								</h4></a></li>
						<li><a
							href="<%=request.getContextPath()%>/tripame/FrontSelectPage?page=traffic"><h4 style="font-size:18px">
									<span class="glyphicon glyphicon-road" aria-hidden="true"></span>交通資訊
								</h4></a></li>
						<li><a
							href="<%=request.getContextPath()%>/tripame/FrontSelectPage?page=travel"><h4 style="font-size:18px">
									<span class="glyphicon glyphicon-list-alt" aria-hidden="true"></span>套裝行程
								</h4></a></li>
						<li><a
							href="<%=request.getContextPath()%>/tripame/FrontSelectPage?page=forums"><h4 style="font-size:18px">
									<span class="glyphicon glyphicon-comment" aria-hidden="true"></span>討論區
								</h4></a></li>
					</ul>
					<%
						Object status = session.getAttribute("memvo");
						if (status == null) {
					%>
					<ul class="nav navbar-nav navbar-right">
						<li class="dropdown"><a href="#" class="dropdown-toggle"
							data-toggle="dropdown"><h4 style="font-size:20px">
									會員專區<strong class="caret"></strong>
								</h4></a>
							<ul class="dropdown-menu">
								<li><a
									href="<%=request.getContextPath()%>/tripame/FrontSelectPage?page=memmanager"><span
										class="glyphicon glyphicon-cog" aria-hidden="true"></span>&nbsp;帳號管理</a></li>
								<li class="divider"></li>
								<li><a
									href="<%=request.getContextPath()%>/tripame/FrontSelectPage?page=memroute"><span
										class="glyphicon glyphicon-file" aria-hidden="true"></span>&nbsp;我的行程</a></li>
								<li class="divider"></li>
								<li><a
									href="<%=request.getContextPath()%>/tripame/FrontSelectPage?page=memtrip"><span
										class="glyphicon glyphicon-list" aria-hidden="true"></span>&nbsp;行程規劃</a></li>
								<li class="divider"></li>
								<li><a
									href="<%=request.getContextPath()%>/tripame/FrontSelectPage?page=memad"><span
										class="glyphicon glyphicon-thumbs-up" aria-hidden="true"></span>&nbsp;我的廣告</a></li>
								<li class="divider"></li>
								<li><a
									href="<%=request.getContextPath()%>/tripame/FrontSelectPage?page=memtravel"><span
										class="glyphicon glyphicon-list-alt" aria-hidden="true"></span>&nbsp;已報名的行程</a></li>
								<li class="divider"></li>
								<li><a
									href="<%=request.getContextPath()%>/tripame/FrontSelectPage?page=memrec"><span
										class="glyphicon glyphicon-star" aria-hidden="true"></span>&nbsp;我的推薦旅遊點</a></li>
								<li class="divider"></li>
								<li><a
									href="<%=request.getContextPath()%>/tripame/FrontSelectPage?page=memlogin"><span
										class="glyphicon glyphicon-log-in" aria-hidden="true"></span>&nbsp;登入</a></li>
							</ul></li>
					</ul>
					<%
						} else {
					%>
					<ul class="nav navbar-nav navbar-right">
						<li class="dropdown"><a href="#" class="dropdown-toggle"
							data-toggle="dropdown"><h4 style="font-size:20px">${memvo.memname}<span
										class="glyphicon glyphicon-user" aria-hidden="true"></span><strong
										class="caret"></strong>
								</h4></a>
							<ul class="dropdown-menu">
								<li><a
									href="<%=request.getContextPath()%>/tripame/FrontSelectPage?page=memmanager"><span
										class="glyphicon glyphicon-cog" aria-hidden="true"></span>&nbsp;帳號管理</a></li>
								<li class="divider"></li>
								<li><a
									href="<%=request.getContextPath()%>/tripame/FrontSelectPage?page=memroute"><span
										class="glyphicon glyphicon-file" aria-hidden="true"></span>&nbsp;我的行程</a></li>
								<li class="divider"></li>
								<li><a
									href="<%=request.getContextPath()%>/tripame/FrontSelectPage?page=memtrip"><span
										class="glyphicon glyphicon-list" aria-hidden="true"></span>&nbsp;行程規劃</a></li>
								<li class="divider"></li>
								<li><a
									href="<%=request.getContextPath()%>/tripame/FrontSelectPage?page=memad"><span
										class="glyphicon glyphicon-thumbs-up" aria-hidden="true"></span>&nbsp;我的廣告</a></li>
								<li class="divider"></li>
								<li><a
									href="<%=request.getContextPath()%>/tripame/FrontSelectPage?page=memtravel"><span
										class="glyphicon glyphicon-list-alt" aria-hidden="true"></span>&nbsp;已報名的行程</a></li>
								<li class="divider"></li>
								<li><a
									href="<%=request.getContextPath()%>/tripame/FrontSelectPage?page=memrec"><span
										class="glyphicon glyphicon-star" aria-hidden="true"></span>&nbsp;我的推薦旅遊點</a></li>
								<li class="divider"></li>
								<li><a
									href="<%=request.getContextPath()%>/tripame/FrontSelectPage?page=memlogout"><span
										class="glyphicon glyphicon-log-out" aria-hidden="true"></span>&nbsp;登出</a></li>
							</ul></li>
					</ul>

					<%
						}
					%>
				</div>
				</nav>
			</div>
		</div>
	</div>
</body>
</html>