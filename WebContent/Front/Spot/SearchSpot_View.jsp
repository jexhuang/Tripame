<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.ad.model.*"%>
<%@ page import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>${spotclass }列表</title>
<jsp:include page="/Front/select_page.jsp" />

<script>
	$(document).ready(function() {
		$('.carousel').carousel({
			interval : 2000
		})
	})
</script>
</head>
<body>
	<div class="container">
		<div class="row clearfix">
			<div class="row" style="WORD-BREAK: break-all;">
				<div class="col-md-12 column">
					<!-- 鄉鎮搜尋&廣告 -->
					<div class="col-md-8">
						<!-- 廣告 -->
						<div>
							<div class="panel panel-default" style="text-align: center;">

								<div class="panel-body">
									<div id="carousel-example-generic" class="carousel slide"
										data-ride="carousel">
										<!-- Indicators -->
										<ol class="carousel-indicators">
											<li data-target="#carousel-example-generic" data-slide-to="0"
												class="active"></li>
											<li data-target="#carousel-example-generic" data-slide-to="1"></li>
											<li data-target="#carousel-example-generic" data-slide-to="2"></li>
											<li data-target="#carousel-example-generic" data-slide-to="3"></li>
											<li data-target="#carousel-example-generic" data-slide-to="4"></li>
										</ol>

										<!-- Wrapper for slides -->
										<div class="carousel-inner" role="listbox">
											<c:forEach var="Ad" items="${adResult }">
												<c:if test="${Ad.adno==advo.adno }">
													<div class="item active" align="center">
														<form id="my_form${Ad.adno }"
															action="<%=request.getContextPath()%>/spot/FrontSpot_Servlet"
															method="post">
															<input type="hidden" name="action"
																value="front_search_ad"> <input type="hidden"
																name="adno" value="${Ad.adno}"> <input
																type="hidden" name="spotclass" value="${spotclass }">
															<input type="hidden" name="requestURL"
																value="<%=request.getContextPath()%>/spot/FrontSpot_Servlet">
															<a href="javascript:{}"
																onclick="document.getElementById('my_form${Ad.adno}').submit();">
																<img
																src="<%=request.getContextPath() %>/ads/AdsPicReader?adsno=${Ad.adno}"
																style="width: 720px; height: 394px">
															</a>
															<div class="carousel-caption">
																<h2>${Ad.adname }</h2>
															</div>
														</form>
													</div>
												</c:if>
												<c:if test="${Ad.adno!=advo.adno }">
													<div class="item" align="center">
														<form id="my_form${Ad.adno }"
															action="<%=request.getContextPath()%>/spot/FrontSpot_Servlet"
															method="post">
															<input type="hidden" name="action"
																value="front_search_ad"> <input type="hidden"
																name="adno" value="${Ad.adno}"> <input
																type="hidden" name="spotclass" value="${spotclass }">
															<input type="hidden" name="requestURL"
																value="<%=request.getContextPath()%>/spot/FrontSpot_Servlet">
															<a href="javascript:{}"
																onclick="document.getElementById('my_form${Ad.adno}').submit();">
																<img
																src="<%=request.getContextPath() %>/ads/AdsPicReader?adsno=${Ad.adno}"
																style="width: 720px; height: 394px">
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
										<a class="left carousel-control"
											href="#carousel-example-generic" role="button"
											data-slide="prev"> <span
											class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
											<span class="sr-only">Previous</span>
										</a> <a class="right carousel-control"
											href="#carousel-example-generic" role="button"
											data-slide="next"> <span
											class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
											<span class="sr-only">Next</span>
										</a>
									</div>
								</div>
							</div>
						</div>
						<div class="panel panel-primary" style="text-align: center;">
							<div class="panel-heading">
								<h3 class="panel-title">【${spotcon }】鄉鎮導覽</h3>
							</div>
							<div class="panel-body">
								<c:forEach var="SpotCon" items="${SpotCon }">
									<span><a href="#${SpotCon}">${SpotCon }</a></span>
								</c:forEach>
							</div>
						</div>
						<c:forEach var="SpotCon" items="${SpotCon }">
							<div class="panel panel-default">
								<div class="panel-heading">
									<a id="${SpotCon }"></a>${SpotCon}</div>
								<div class="panel-body">
									<c:forEach var="result" items="${result }">
										<c:if test="${SpotCon==result.spottown }">
										《
											<a
												href="<%=request.getContextPath()%>/spot/FrontSpot_Servlet?action=front_search_one&requestURL=<%=request.getServletPath() %>&spotno=${result.spotno}">${result.spotname }</a>
										》
										</c:if>
									</c:forEach>
								</div>
							</div>
						</c:forEach>
					</div>
					<!-- 縣市搜尋 -->
					<div class="col-md-4">
						<form>
							<div class="panel panel-primary" style="text-align: center;">
								<div class="panel-heading">
									<h3 class="panel-title">縣市導覽</h3>
								</div>
								<!-- 北部縣市搜尋 -->
								<div class="panel-group" id="panel-468961">
									<div class="panel panel-default">
										<div class="panel-heading">
											<a class="panel-title" data-toggle="collapse"
												data-parent="#panel-468961" href="#panel-element-270854">北部</a>
										</div>
										<div id="panel-element-270854"
											class="panel-collapse collapse in">
											<div class="panel-body">
												<div>
													<a
														href="<%=request.getContextPath()%>/spot/FrontSpot_Servlet?action=front_search_con&requestURL=<%=request.getServletPath() %>&country=基隆市&spotclass=${spotclass}">基隆市</a>
												</div>
												<div>
													<a
														href="<%=request.getContextPath()%>/spot/FrontSpot_Servlet?action=front_search_con&requestURL=<%=request.getServletPath() %>&country=台北市&spotclass=${spotclass}">台北市</a>
												</div>
												<div>
													<a
														href="<%=request.getContextPath()%>/spot/FrontSpot_Servlet?action=front_search_con&requestURL=<%=request.getServletPath() %>&country=新北市&spotclass=${spotclass}">新北市</a>
												</div>
												<div>
													<a
														href="<%=request.getContextPath()%>/spot/FrontSpot_Servlet?action=front_search_con&requestURL=<%=request.getServletPath() %>&country=桃園市&spotclass=${spotclass}">桃園市</a>
												</div>
												<div>
													<a
														href="<%=request.getContextPath()%>/spot/FrontSpot_Servlet?action=front_search_con&requestURL=<%=request.getServletPath() %>&country=新竹縣&spotclass=${spotclass}">新竹縣</a>
												</div>
												<div>
													<a
														href="<%=request.getContextPath()%>/spot/FrontSpot_Servlet?action=front_search_con&requestURL=<%=request.getServletPath() %>&country=新竹市&spotclass=${spotclass}">新竹市</a>
												</div>
											</div>
										</div>
									</div>
									<!-- 中部縣市搜尋 -->
									<div class="panel panel-default">
										<div class="panel-heading">
											<a class="panel-title" data-toggle="collapse"
												data-parent="#panel-468961" href="#panel-element-254136">中部</a>
										</div>
										<div id="panel-element-254136" class="panel-collapse collapse">
											<div class="panel-body">
												<div>
													<a
														href="<%=request.getContextPath()%>/spot/FrontSpot_Servlet?action=front_search_con&requestURL=<%=request.getServletPath() %>&country=苗栗縣&spotclass=${spotclass}">苗栗縣</a>
												</div>
												<div>
													<a
														href="<%=request.getContextPath()%>/spot/FrontSpot_Servlet?action=front_search_con&requestURL=<%=request.getServletPath() %>&country=台中市&spotclass=${spotclass}">台中市</a>
												</div>
												<div>
													<a
														href="<%=request.getContextPath()%>/spot/FrontSpot_Servlet?action=front_search_con&requestURL=<%=request.getServletPath() %>&country=彰化縣&spotclass=${spotclass}">彰化縣</a>
												</div>
												<div>
													<a
														href="<%=request.getContextPath()%>/spot/FrontSpot_Servlet?action=front_search_con&requestURL=<%=request.getServletPath() %>&country=南投縣&spotclass=${spotclass}">南投縣</a>
												</div>
												<div>
													<a
														href="<%=request.getContextPath()%>/spot/FrontSpot_Servlet?action=front_search_con&requestURL=<%=request.getServletPath() %>&country=雲林縣&spotclass=${spotclass}">雲林縣</a>
												</div>
											</div>
										</div>
									</div>
									<!-- 南部縣市搜尋 -->
									<div class="panel panel-default">
										<div class="panel-heading">
											<a class="panel-title" data-toggle="collapse"
												data-parent="#panel-468961" href="#panel-element-254133">南部</a>
										</div>
										<div id="panel-element-254133" class="panel-collapse collapse">
											<div class="panel-body">
												<div>
													<a
														href="<%=request.getContextPath()%>/spot/FrontSpot_Servlet?action=front_search_con&requestURL=<%=request.getServletPath() %>&country=嘉義縣&spotclass=${spotclass}">嘉義縣</a>
												</div>
												<div>
													<a
														href="<%=request.getContextPath()%>/spot/FrontSpot_Servlet?action=front_search_con&requestURL=<%=request.getServletPath() %>&country=嘉義市&spotclass=${spotclass}">嘉義市</a>
												</div>
												<div>
													<a
														href="<%=request.getContextPath()%>/spot/FrontSpot_Servlet?action=front_search_con&requestURL=<%=request.getServletPath() %>&country=台南市&spotclass=${spotclass}">台南市</a>
												</div>
												<div>
													<a
														href="<%=request.getContextPath()%>/spot/FrontSpot_Servlet?action=front_search_con&requestURL=<%=request.getServletPath() %>&country=高雄市&spotclass=${spotclass}">高雄市</a>
												</div>
												<div>
													<a
														href="<%=request.getContextPath()%>/spot/FrontSpot_Servlet?action=front_search_con&requestURL=<%=request.getServletPath() %>&country=屏東縣&spotclass=${spotclass}">屏東縣</a>
												</div>
											</div>
										</div>
									</div>
									<!-- 東部縣市搜尋 -->
									<div class="panel panel-default">
										<div class="panel-heading">
											<a class="panel-title" data-toggle="collapse"
												data-parent="#panel-468961" href="#panel-element-254939">東部</a>
										</div>
										<div id="panel-element-254939" class="panel-collapse collapse">
											<div class="panel-body">
												<div>
													<a
														href="<%=request.getContextPath()%>/spot/FrontSpot_Servlet?action=front_search_con&requestURL=<%=request.getServletPath() %>&country=宜蘭縣&spotclass=${spotclass}">宜蘭縣</a>
												</div>
												<div>
													<a
														href="<%=request.getContextPath()%>/spot/FrontSpot_Servlet?action=front_search_con&requestURL=<%=request.getServletPath() %>&country=花蓮縣&spotclass=${spotclass}">花蓮縣</a>
												</div>
												<div>
													<a
														href="<%=request.getContextPath()%>/spot/FrontSpot_Servlet?action=front_search_con&requestURL=<%=request.getServletPath() %>&country=台東縣&spotclass=${spotclass}">台東縣</a>
												</div>
											</div>
											<!-- xxx -->
										</div>
									</div>
								</div>
							</div>
						</form>
						<!-- 熱門景點 -->
						<div class="panel panel-primary" style="text-align: center;">
							<div class="panel-heading">Top熱門${spotclass }</div>
							<div class="panel-body">
								<c:forEach var="Famaus" items="${famaus }">
									<div style="text-align: center;">
										<a
											href="<%=request.getContextPath()%>/spot/FrontSpot_Servlet?action=front_search_one&requestURL=<%=request.getServletPath() %>&spotno=${Famaus.spotno}">
											<img
											src="<%=request.getContextPath()%>/spot/SpotList_Img?spotno=${Famaus.spotno}"
											style="width: 150px; height: 150px">
											<div>${Famaus.spotname }</div>
											<br>
										<br>
										</a>
									</div>
								</c:forEach>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>