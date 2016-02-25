<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.activity.model.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>活動快報</title>
<jsp:include page="/Front/select_page.jsp"/>

<script>
$(document).ready(function()
{	
	$('.carousel').carousel({
		  interval: 2000
		})
})
</script>
</head>
<body>
<div class="container">
<div class="row clearfix">
	<div class="row" style="WORD-BREAK:break-all;">
		<div class="col-md-12 column">
			<!-- 鄉鎮搜尋&廣告 -->
			<div class="col-md-8">
			<!-- 廣告 -->			
			<div class="panel panel-default" style="text-align:center;">
				<div class="panel-body">
					<div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
					  <!-- Indicators -->
					  <ol class="carousel-indicators">
					    <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
					    <li data-target="#carousel-example-generic" data-slide-to="1"></li>
					    <li data-target="#carousel-example-generic" data-slide-to="2"></li>
					    <li data-target="#carousel-example-generic" data-slide-to="3"></li>
					    <li data-target="#carousel-example-generic" data-slide-to="4"></li>
					  </ol>
				
				  <!-- Wrapper for slides -->
				  <div class="carousel-inner" role="listbox" style="background-color:#ffffff;">			  			 				    
				    <c:forEach var="Ad" items="${adResult }" >
					    <c:if test="${Ad.adno==advo.adno }">					    
				  		 <div class="item active" align="center">
				  		 	<form id="my_form${Ad.adno }" action="<%=request.getContextPath()%>/act/FrontAct_Servlet" method="post">
					  		 	<input type="hidden" name="action" value="front_search_ad">
					  		 	<input type="hidden" name="adno" value="${Ad.adno}">
					  		 	<a href="javascript:{}" onclick="document.getElementById('my_form${Ad.adno}').submit();">
					      			<img src="<%=request.getContextPath() %>/ads/AdsPicReader?adsno=${Ad.adno}" style="width:720px;height:394px">				      		
					      		</a>
					      		<div class="carousel-caption">
				      				<h2>${Ad.adname }</h2>
				      		 	</div>
					  		</form>			  		 					      		 	
				     	 </div>
					  	</c:if>
					  	<c:if test="${Ad.adno!=advo.adno }">
					  	<div class="item" align="center">
				  		 	<form id="my_form${Ad.adno }" action="<%=request.getContextPath()%>/act/FrontAct_Servlet" method="post">
					  		 	<input type="hidden" name="action" value="front_search_ad">
					  		 	<input type="hidden" name="adno" value="${Ad.adno}">
					  		 	<a href="javascript:{}" onclick="document.getElementById('my_form${Ad.adno}').submit();">
					      			<img src="<%=request.getContextPath() %>/ads/AdsPicReader?adsno=${Ad.adno}" style="width:720px;height:394px">				      		
					      		</a>
					      		<div class="carousel-caption">
				      				<h2>${Ad.adname }</h2>
				      		 	</div>
					  		</form>			  		 					      		 	
				     	 </div>
					  	</c:if>					  	
				  	</c:forEach>
				  </div>				 				
				  <!-- Controls -->
					  <a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
					    <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
					    <span class="sr-only">Previous</span>
					  </a>
					  <a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
					    <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
					    <span class="sr-only">Next</span>
					  </a>
					</div>
				</div>
			</div>			
			<div class="panel panel-primary" style="text-align:center;">
				<div class="panel-heading">【${actcon }】活動</div>
				<div class="panel-body">
					<c:forEach var="result" items="${result }">
					《
						<a href="<%=request.getContextPath()%>/act/FrontAct_Servlet?action=front_search_one&actno=${result.actno}">${result.actname }</a>
					》
					</c:forEach>
				</div>
			</div>			
			</div>
			<!-- 縣市搜尋 -->
			<div class="col-md-4">
				<form>
					<div class="panel panel-primary" style="text-align:center;">
						<div class="panel-heading" ><h3 class="panel-title">縣市導覽</h3></div>
						<!-- 北部縣市搜尋 -->
						<div class="panel-group" id="panel-468961">
							<div class="panel panel-default">
								<div class="panel-heading">
						 			<a class="panel-title" data-toggle="collapse" data-parent="#panel-468961" href="#panel-element-270854">北部</a>
								</div>
								<div id="panel-element-270854" class="panel-collapse collapse in">
									<div class="panel-body">
										<div><a href="<%=request.getContextPath()%>/act/FrontAct_Servlet?action=front_search_con&country=基隆市">基隆市</a></div>
										<div><a href="<%=request.getContextPath()%>/act/FrontAct_Servlet?action=front_search_con&country=台北市">台北市</a></div>
										<div><a href="<%=request.getContextPath()%>/act/FrontAct_Servlet?action=front_search_con&country=新北市">新北市</a></div>
										<div><a href="<%=request.getContextPath()%>/act/FrontAct_Servlet?action=front_search_con&country=桃園市">桃園市</a></div>
										<div><a href="<%=request.getContextPath()%>/act/FrontAct_Servlet?action=front_search_con&country=新竹縣">新竹縣</a></div>
										<div><a href="<%=request.getContextPath()%>/act/FrontAct_Servlet?action=front_search_con&country=新竹市">新竹市</a></div>
									</div>
								</div>
							</div>
							<!-- 中部縣市搜尋 -->
							<div class="panel panel-default">
								<div class="panel-heading">
						 			<a class="panel-title" data-toggle="collapse" data-parent="#panel-468961" href="#panel-element-254136">中部</a>
								</div>
								<div id="panel-element-254136" class="panel-collapse collapse">
									<div class="panel-body">
										<div><a href="<%=request.getContextPath()%>/act/FrontAct_Servlet?action=front_search_con&country=苗栗縣">苗栗縣</a></div>
										<div><a href="<%=request.getContextPath()%>/act/FrontAct_Servlet?action=front_search_con&country=台中市">台中市</a></div>
										<div><a href="<%=request.getContextPath()%>/act/FrontAct_Servlet?action=front_search_con&country=彰化縣">彰化縣</a></div>
										<div><a href="<%=request.getContextPath()%>/act/FrontAct_Servlet?action=front_search_con&country=南投縣">南投縣</a></div>
										<div><a href="<%=request.getContextPath()%>/act/FrontAct_Servlet?action=front_search_con&country=雲林縣">雲林縣</a></div>
									</div>
								</div>
							</div>
							<!-- 南部縣市搜尋 -->
							<div class="panel panel-default">
								<div class="panel-heading">
						 			<a class="panel-title" data-toggle="collapse" data-parent="#panel-468961" href="#panel-element-254133">南部</a>
								</div>
								<div id="panel-element-254133" class="panel-collapse collapse">
									<div class="panel-body">
										<div><a href="<%=request.getContextPath()%>/act/FrontAct_Servlet?action=front_search_con&country=嘉義縣">嘉義縣</a></div>
										<div><a href="<%=request.getContextPath()%>/act/FrontAct_Servlet?action=front_search_con&country=嘉義市">嘉義市</a></div>
										<div><a href="<%=request.getContextPath()%>/act/FrontAct_Servlet?action=front_search_con&country=台南市">台南市</a></div>
										<div><a href="<%=request.getContextPath()%>/act/FrontAct_Servlet?action=front_search_con&country=高雄市">高雄市</a></div>
										<div><a href="<%=request.getContextPath()%>/act/FrontAct_Servlet?action=front_search_con&country=屏東縣">屏東縣</a></div>
									</div>
								</div>
							</div>
							<!-- 東部縣市搜尋 -->
							<div class="panel panel-default">
								<div class="panel-heading">
						 			<a class="panel-title" data-toggle="collapse" data-parent="#panel-468961" href="#panel-element-254939">東部</a>
								</div>
								<div id="panel-element-254939" class="panel-collapse collapse">
									<div class="panel-body">
										<div><a href="<%=request.getContextPath()%>/act/FrontAct_Servlet?action=front_search_con&country=宜蘭縣">宜蘭縣</a></div>
										<div><a href="<%=request.getContextPath()%>/act/FrontAct_Servlet?action=front_search_con&country=花蓮縣">花蓮縣</a></div>
										<div><a href="<%=request.getContextPath()%>/act/FrontAct_Servlet?action=front_search_con&country=台東縣">台東縣</a></div>
									</div>
								</div>
							</div>
						</div>
					</div>					
				</form>
			<!-- 月內活動 -->
			<div class="panel panel-primary" style="text-align:center;">
				<div class="panel-heading">進行中活動</div>
				<div class="panel-body">
				<marquee onMouseOver="this.stop()" onMouseOut="this.start()" height="200" direction="up" scrolldelay="4" scrollamount="5">
					<c:forEach var="actList" items="${actList }">
					<div class="list-group">
						<a href="<%=request.getContextPath()%>/act/FrontAct_Servlet?action=front_search_one&actno=${actList.actno}" class="list-group-item active">
						    <h4 class="list-group-item-heading">${actList.actname }</h4>
						    <p class="list-group-item-text">
						    	<span>縣市鄉鎮:${actList.actcon }${actList.acttown }</span>
						    	<br>
						    	<span>開始日期:${actList.actbegin }</span>
						    	<br>
						    	<span>結束日期:${actList.actend }</span>
						    </p>
	  					</a>
					</div>						
					</c:forEach>
				</marquee>
				</div>
			</div>
			</div>
		</div>
	</div>
</div>
</div>
</body>
</html>