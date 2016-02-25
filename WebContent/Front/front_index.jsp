<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
response.setHeader("Cache-Control", "no-store");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);
%>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="">
<meta name="author" content="">

<title>Tripame</title>
<!-- Bootstrap Core CSS -->
<link href="<%=request.getContextPath()%>/Front/forIndex/css/bootstrap.min.css" rel="stylesheet" type="text/css">
<!-- Fonts -->
<link href="<%=request.getContextPath()%>/Front/forIndex/font-awesome/css/font-awesome.min.css" rel="stylesheet"
	type="text/css">
<link href="<%=request.getContextPath()%>/Front/forIndex/css/animate.css" rel="stylesheet" />
<!-- Squad theme CSS -->
<link href="<%=request.getContextPath()%>/Front/forIndex/css/style.css" rel="stylesheet">
<link href="<%=request.getContextPath()%>/Front/forIndex/color/default.css" rel="stylesheet">
<!-- 自訂的首頁 CSS -->
<link href="<%=request.getContextPath()%>/Front/forIndex/css/frontCustomize.css" rel="stylesheet">
</head>

<body id="page-top" data-spy="scroll" data-target=".navbar-custom">
	<!-- Preloader -->
	<div id="preloader">
		<div id="load"></div>
	</div>

	<nav class="navbar navbar-custom navbar-fixed-top" role="navigation">
	<div class="container">
		<div class="navbar-header page-scroll">
			<button type="button" class="navbar-toggle" data-toggle="collapse"
				data-target=".navbar-main-collapse">
				<i class="fa fa-bars"></i>
			</button>
			<a class="navbar-brand" href="Index.html"> <a href="#"><h1>TRIPAME</h1></a></a>
		</div>

		<!-- Collect the nav links, forms, and other content for toggling -->
		<div
			class="collapse navbar-collapse navbar-right navbar-main-collapse">
			<ul class="nav navbar-nav">
				<li><a href="<%=request.getContextPath()%>/tripame/FrontSelectPage?page=spot"><span
							class="glyphicon glyphicon-search" aria-hidden="true"></span>景點查詢</a></li>
				<li><a href="<%=request.getContextPath()%>/tripame/FrontSelectPage?page=food"><span class="glyphicon glyphicon-cutlery"
							aria-hidden="true"></span>美食導覽</a></li>
				<li><a href="<%=request.getContextPath()%>/tripame/FrontSelectPage?page=room"><span class="glyphicon glyphicon-home"
							aria-hidden="true"></span>住宿指南</a></li>
				<li><a href="<%=request.getContextPath()%>/tripame/FrontSelectPage?page=activity"><span class="glyphicon glyphicon-flash"
							aria-hidden="true"></span>活動快報</a></li>
				<li><a href="<%=request.getContextPath()%>/tripame/FrontSelectPage?page=traffic"><span class="glyphicon glyphicon-road"
							aria-hidden="true"></span>交通資訊</a></li>
				<li><a href="<%=request.getContextPath()%>/tripame/FrontSelectPage?page=travel"><span class="glyphicon glyphicon-list-alt"
							aria-hidden="true"></span>套裝行程</a></li>
				<li><a href="<%=request.getContextPath()%>/tripame/FrontSelectPage?page=forums"><span class="glyphicon glyphicon-comment"
							aria-hidden="true"></span>討論區</a></li>
				<li class="active"><a href="<%=request.getContextPath()%>/tripame/FrontSelectPage?page=memroute"><span
							class="glyphicon glyphicon-log-in" aria-hidden="true"></span>會員專區</a></li>
			</ul>
		</div>
		<!-- /.navbar-collapse -->
	</div>
	<!-- /.container --> </nav>

	<!-- Section: intro -->
	<section id="intro" class="intro">

	<div class="slogan">
		<h2>WELCOME TO Tripame</h2>
		<h4>You can create your Trip</h4>
		<br>
		<h4>Now enjoy it!</h4>
	</div>
	<div class="page-scroll">
		<p>
			<a href="<%=request.getContextPath()%>/tripame/FrontSelectPage?page=memtrip" class="btn-huge button btn-huge"> <i
				class="fa fa-angle-double-down animated"><font style="font-family:微軟正黑體"> 行 程 規 劃</font> </i>
			</a>
		</p>
	</div>
	</section>
	<!-- /Section: intro -->

	<!-- Section: about -->
	<section id="about" class="home-section text-center">
	<div class="heading-about">
		<div class="container">
			<div class="row">
				<div class="col-lg-8 col-lg-offset-2">
					<div class="wow bounceInDown" data-wow-delay="0.4s">
						<div class="section-heading">
							<h2>&nbsp;關 &nbsp;於&nbsp;我&nbsp; 們</h2>
							<i class="fa fa-2x fa-angle-down"></i>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="container">

		<div class="row">
			<div class="col-lg-2 col-lg-offset-5">
				<hr class="marginbot-50">
			</div>
		</div>
		<div class="row">
			<div class="col-xs-6 col-sm-3 col-md-3">
				<div class="wow bounceInUp" data-wow-delay="0.2s">
					<div class="team boxed-grey">
						<div class="inner">
							<h5>黃揚傑</h5>
							<p class="subtitle">組長</p>
							<div class="avatar">
								<img src="<%=request.getContextPath()%>/Front/forIndex/img/team/1.png" alt=""
									class="img-responsive img-circle" />
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="col-xs-6 col-sm-3 col-md-3">
				<div class="wow bounceInUp" data-wow-delay="0.5s">
					<div class="team boxed-grey">
						<div class="inner">
							<h5>何堅皓</h5>
							<p class="subtitle">組員</p>
							<div class="avatar">
								<img src="<%=request.getContextPath()%>/Front/forIndex/img/team/2.jpg" alt=""
									class="img-responsive img-circle" />
							</div>

						</div>
					</div>
				</div>
			</div>
			<div class="col-xs-6 col-sm-3 col-md-3">
				<div class="wow bounceInUp" data-wow-delay="0.8s">
					<div class="team boxed-grey">
						<div class="inner">
							<h5>賴銀洲</h5>
							<p class="subtitle">組員</p>
							<div class="avatar">
								<img src="<%=request.getContextPath()%>/Front/forIndex/img/team/3.jpg" alt=""
									class="img-responsive img-circle" />
							</div>

						</div>
					</div>
				</div>
			</div>
			<div class="col-xs-6 col-sm-3 col-md-3">
				<div class="wow bounceInUp" data-wow-delay="1s">
					<div class="team boxed-grey">
						<div class="inner">
							<h5>黃傑聖</h5>
							<p class="subtitle">組員</p>
							<div class="avatar">
								<img src="<%=request.getContextPath()%>/Front/forIndex/img/team/4.jpg" alt=""
									class="img-responsive img-circle" />
							</div>

						</div>
					</div>
				</div>
			</div>
			<div class="col-xs-6 col-sm-3 col-md-3">
				<div class="wow bounceInUp" data-wow-delay="1.2s">
					<div class="team boxed-grey">
						<div class="inner">
							<h5>黃進龍</h5>
							<p class="subtitle">組員</p>
							<div class="avatar">
								<img src="<%=request.getContextPath()%>/Front/forIndex/img/team/5.png" alt=""
									class="img-responsive img-circle" />
							</div>
						</div>
					</div>
				</div>
			</div>

		</div>
	</div>
	</section>
	<!-- /Section: about -->


	<!-- Section: services -->
	<section id="service" class="home-section text-center bg-gray">

	<div class="heading-about">
		<div class="container">
			<div class="row">
				<div class="col-lg-8 col-lg-offset-2">
					<div class="wow bounceInDown" data-wow-delay="0.4s">
						<div class="section-heading">
							<h2>&nbsp;緣&nbsp;起&nbsp;</h2>
							<i class="fa fa-2x fa-angle-down"></i>
						</div>
					</div>
				</div>
				<div class="col-sm-12 col-md-12">
					<div class="wow fadeInLeft" data-wow-delay="0.2s">
						<div class="service-box">
							<div class="service-desc">
								<p>想要自己規劃行程 卻沒有一個網站可以把所有旅遊資訊提供給我 並且幫我規劃行程
								<h4>於是……</h4>
								</p>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="container">
		<div class="row">
			<div class="col-lg-2 col-lg-offset-5">
				<hr class="marginbot-50">
			</div>
		</div>
		<div class="row">
			<div class="col-lg-8 col-lg-offset-2">
				<div class="wow bounceInDown" data-wow-delay="0.4s">
					<div class="section-heading">
						<h2>&nbsp;目&nbsp;標&nbsp;</h2>
						<i class="fa fa-2x fa-angle-down"></i>
					</div>
				</div>
			</div>
			<div class="col-sm-12 col-md-12">
				<div class="wow fadeInUp" data-wow-delay="0.2s">
					<div class="service-box">
						<div class="service-desc">
							<p>提供一個完整的旅遊平台 讓人人都可以規劃自己的行程以及
							<h4>享受它！</h4>
							</p>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	</section>
	<!-- /Section: services -->




	<!-- Section: contact -->
	<section id="contact" class="home-section text-center">
	<div class="heading-contact">
		<div class="container">
			<div class="row">
				<div class="col-lg-8 col-lg-offset-2">
					<div class="wow bounceInDown" data-wow-delay="0.4s">
						<div class="section-heading">
							<h2>聯絡我們</h2>
							<i class="fa fa-2x fa-angle-down"></i>

						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="container">

		<div class="row">
			<div class="col-lg-2 col-lg-offset-5">
				<hr class="marginbot-50">
			</div>
		</div>
		<div class="row">
			<div class="col-lg-8">
				<div class="boxed-grey">
					<form id="contact-form">
						<div class="row">
							<div class="col-md-6">
								<div class="form-group">
									<label for="name"> 姓名</label> <input type="text"
										class="form-control" id="name" placeholder="Enter name"
										required="required" />
								</div>
								<div class="form-group">
									<label for="email"> Email</label>
									<div class="input-group">
										<span class="input-group-addon"><span
											class="glyphicon glyphicon-envelope"></span> </span> <input
											type="email" class="form-control" id="email"
											placeholder="Enter email" required="required" />
									</div>
								</div>
							</div>
							<div class="col-md-6">
								<div class="form-group">
									<label for="name"> 訊息內容</label>
									<textarea name="message" id="message" class="form-control"
										rows="9" cols="25" required="required" placeholder="Message"></textarea>
								</div>
							</div>
							<div class="col-md-12">
								<button type="submit" class="btn btn-skin pull-right"
									id="btnContactUs">傳送</button>
							</div>
						</div>
					</form>
				</div>
			</div>

			<div class="col-lg-4">
				<div class="widget-contact">
					<h4>所在地</h4>

					<address>
						<strong>黑桃一組, Inc.</strong><br> 桃園縣中壢市中央大學資策會<br> <abbr
							title="Phone">P:</abbr> (123) 456-7890
					</address>

					<address>
						<strong>Email</strong><br> <a href="mailto:#">gn667226@hotmail.com</a>
					</address>
				</div>
			</div>
		</div>

	</div>
	</section>
	<!-- /Section: contact -->

	<footer>
	<div class="container">
		<div class="row">
			<div class="col-md-12 col-lg-12">
				<div class="wow shake" data-wow-delay="0.4s">
					<div class="page-scroll marginbot-30">
						<a href="#intro" id="totop" class="btn btn-circle"> <i
							class="fa fa-angle-double-up animated"></i>
						</a>
					</div>
				</div>
				<p>&copy; Copyright © Tripame Taiwan 2014-2015. All rights
					reserved.</p>
			</div>
		</div>
	</div>
	</footer>

	<!-- Core JavaScript Files -->
	<script src="<%=request.getContextPath()%>/Front/forIndex/js/jquery.min.js"></script>
	<script src="<%=request.getContextPath()%>/Front/forIndex/js/bootstrap.min.js"></script>
	<script src="<%=request.getContextPath()%>/Front/forIndex/js/jquery.easing.min.js"></script>
	<script src="<%=request.getContextPath()%>/Front/forIndex/js/jquery.scrollTo.js"></script>
	<script src="<%=request.getContextPath()%>/Front/forIndex/js/wow.min.js"></script>
	<!-- Custom Theme JavaScript -->
	<script src="<%=request.getContextPath()%>/Front/forIndex/js/custom.js"></script>

</body>
</html>