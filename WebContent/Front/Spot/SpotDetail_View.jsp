<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.mem.model.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>詳細資訊</title>
<jsp:include page="/Front/select_page.jsp" />
</head>
<body>
	<jsp:useBean id="SpotBoard" scope="page"
		class="com.spotboard.model.SpotboardService" />
	<jsp:useBean id="Mem" scope="page" class="com.mem.model.MemService" />
	<%
		if ((MemVO) session.getAttribute("memvo") != null) {
			MemVO memvo = (MemVO) session.getAttribute("memvo");
		}
	%>
	<div class="container">
		<div class="row clearfix">
			<div class="row" style="WORD-BREAK: break-all;">
				<div class="col-md-12 column">
					<div class="col-md-8">
						<div class="panel panel-primary">
							<div class="panel-heading" style="text-align: center;">基本資訊</div>
							<div class="panel-body">
								<div class="row">
									<div class="col-md-8">
										<table class="table table-hover">
											<tr>
												<th width="100">縣市鄉鎮:</th>
												<td>${spotVO.spotcon }${spotVO.spottown }</td>
											</tr>
											<tr>
												<th>名稱:</th>
												<td style="color: #0080FF;"><b>${spotVO.spotname }</b></td>
											</tr>
											<tr>
												<th>電話:</th>
												<td>${spotVO.spotphone }</td>
											</tr>
											<tr>
												<th>地址:</th>
												<td>${spotVO.spotaddress }</td>
											</tr>
											<tr>
												<th>官網:</th>
												<td><a
													href="${(spotVO.spotsite=='無')?'#':spotVO.spotsite }">${spotVO.spotsite }</a></td>
											</tr>
										</table>
									</div>
									<div class="col-md-4">
										<img class="img-thumbnail" style="width: 200px; height: 200px"
											src="<%=request.getContextPath()%>/spot/SpotList_Img?spotno=${spotVO.spotno }">
									</div>
								</div>
							</div>
						</div>
						<div class="panel panel-primary">
							<div class="panel-heading" style="text-align: center;">基本簡介</div>
							<div class="panel-body">
								&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp${spotVO.spotcontent }</div>
						</div>
						<div class="panel panel-primary">
							<div class="panel-heading" style="text-align: center;">留言板</div>
							<div class="panel-body">
								<form
									action="<%=request.getContextPath()%>/spotboard/SpotBoard_Servlet"
									method="post">
									<div class="form-group">
										<div class="col-md-2">
											<c:if test="${memvo==null }">
												<img
													src="<%=request.getContextPath()%>/Front/Spot/head.jpg"
													style="width: 80px; height: 80px; margin-top: 15px">
											</c:if>
											<c:if test="${memvo!=null }">
												<img
													src="<%=request.getContextPath()%>/mem/MemPicReader?memno=${memvo.memno}"
													style="width: 80px; height: 80px; margin-top: 15px">
											</c:if>

										</div>
										<div class="col-md-10">
											<label>留言</label>
											<textarea style="WORD-BREAK: break-all;" name="sbcontent"
												class="form-control" rows="2"></textarea>
											<input type="submit" value="留言" class="btn btn-primary">
											<input type="hidden" name="location"
												value="<%=request.getContextPath()%>/spot/FrontSpot_Servlet?<%=request.getQueryString()%>">
											<input type="hidden" name="action" value="insert"> <input
												type="hidden" name="spotno" value="${spotVO.spotno }">
										</div>
									</div>
								</form>
								<div class="form-group">
									<table class="table table-hover">
										<c:forEach var="SpotBoardVO" items="${SpotBoard.all }">
											<c:if test="${SpotBoardVO.spotno==spotVO.spotno }">
												<c:forEach var="MemVO" items="${Mem.all }">
													<c:if test="${MemVO.memno==SpotBoardVO.memno }">
														<tr>
															<td>${MemVO.memname }</td>
															<td style="word-wrap: break-word; word-break: break-all;">${SpotBoardVO.sbcontent }</td>
															<td>${SpotBoardVO.sbtime }</td>
															<td><c:if test="${memvo.memname==MemVO.memname }">
																	<form id="my_form${SpotBoardVO.sbno}"
																		action="<%=request.getContextPath()%>/spotboard/SpotBoard_Servlet"
																		method="post">
																		<input type="hidden" name="action" value="delete">
																		<input type="hidden" name="requestURL"
																			value="<%=request.getContextPath()%>/spot/FrontSpot_Servlet?<%=request.getQueryString()%>">
																		<input type="hidden" name="sbno"
																			value="${SpotBoardVO.sbno}"> <a
																			href="javascript:{}"
																			class="glyphicon glyphicon-remove"
																			style="color: red;"
																			onclick="document.getElementById('my_form${SpotBoardVO.sbno}').submit();"></a>
																	</form>
																</c:if></td>
														</tr>
													</c:if>
												</c:forEach>

											</c:if>
										</c:forEach>

									</table>
								</div>
							</div>

						</div>
					</div>
				</div>
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
													href="<%=request.getContextPath()%>/spot/FrontSpot_Servlet?action=front_search_con&requestURL=<%=request.getParameter("requestURL") %>&country=基隆市&spotclass=${spotclass}">基隆市</a>
											</div>
											<div>
												<a
													href="<%=request.getContextPath()%>/spot/FrontSpot_Servlet?action=front_search_con&requestURL=<%=request.getParameter("requestURL") %>&country=台北市&spotclass=${spotclass}">台北市</a>
											</div>
											<div>
												<a
													href="<%=request.getContextPath()%>/spot/FrontSpot_Servlet?action=front_search_con&requestURL=<%=request.getParameter("requestURL") %>&country=新北市&spotclass=${spotclass}">新北市</a>
											</div>
											<div>
												<a
													href="<%=request.getContextPath()%>/spot/FrontSpot_Servlet?action=front_search_con&requestURL=<%=request.getParameter("requestURL") %>&country=桃園市&spotclass=${spotclass}">桃園市</a>
											</div>
											<div>
												<a
													href="<%=request.getContextPath()%>/spot/FrontSpot_Servlet?action=front_search_con&requestURL=<%=request.getParameter("requestURL") %>&country=新竹縣&spotclass=${spotclass}">新竹縣</a>
											</div>
											<div>
												<a
													href="<%=request.getContextPath()%>/spot/FrontSpot_Servlet?action=front_search_con&requestURL=<%=request.getParameter("requestURL") %>&country=新竹市&spotclass=${spotclass}">新竹市</a>
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
													href="<%=request.getContextPath()%>/spot/FrontSpot_Servlet?action=front_search_con&requestURL=<%=request.getParameter("requestURL") %>&country=苗栗縣&spotclass=${spotclass}">苗栗縣</a>
											</div>
											<div>
												<a
													href="<%=request.getContextPath()%>/spot/FrontSpot_Servlet?action=front_search_con&requestURL=<%=request.getParameter("requestURL") %>&country=台中市&spotclass=${spotclass}">台中市</a>
											</div>
											<div>
												<a
													href="<%=request.getContextPath()%>/spot/FrontSpot_Servlet?action=front_search_con&requestURL=<%=request.getParameter("requestURL") %>&country=彰化縣&spotclass=${spotclass}">彰化縣</a>
											</div>
											<div>
												<a
													href="<%=request.getContextPath()%>/spot/FrontSpot_Servlet?action=front_search_con&requestURL=<%=request.getParameter("requestURL") %>&country=南投縣&spotclass=${spotclass}">南投縣</a>
											</div>
											<div>
												<a
													href="<%=request.getContextPath()%>/spot/FrontSpot_Servlet?action=front_search_con&requestURL=<%=request.getParameter("requestURL") %>&country=雲林縣&spotclass=${spotclass}">雲林縣</a>
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
													href="<%=request.getContextPath()%>/spot/FrontSpot_Servlet?action=front_search_con&requestURL=<%=request.getParameter("requestURL") %>&country=嘉義縣&spotclass=${spotclass}">嘉義縣</a>
											</div>
											<div>
												<a
													href="<%=request.getContextPath()%>/spot/FrontSpot_Servlet?action=front_search_con&requestURL=<%=request.getParameter("requestURL") %>&country=嘉義市&spotclass=${spotclass}">嘉義市</a>
											</div>
											<div>
												<a
													href="<%=request.getContextPath()%>/spot/FrontSpot_Servlet?action=front_search_con&requestURL=<%=request.getParameter("requestURL") %>&country=台南市&spotclass=${spotclass}">台南市</a>
											</div>
											<div>
												<a
													href="<%=request.getContextPath()%>/spot/FrontSpot_Servlet?action=front_search_con&requestURL=<%=request.getParameter("requestURL") %>&country=高雄市&spotclass=${spotclass}">高雄市</a>
											</div>
											<div>
												<a
													href="<%=request.getContextPath()%>/spot/FrontSpot_Servlet?action=front_search_con&requestURL=<%=request.getParameter("requestURL") %>&country=屏東縣&spotclass=${spotclass}">屏東縣</a>
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
													href="<%=request.getContextPath()%>/spot/FrontSpot_Servlet?action=front_search_con&requestURL=<%=request.getParameter("requestURL") %>&country=宜蘭縣&spotclass=${spotclass}">宜蘭縣</a>
											</div>
											<div>
												<a
													href="<%=request.getContextPath()%>/spot/FrontSpot_Servlet?action=front_search_con&requestURL=<%=request.getParameter("requestURL") %>&country=花蓮縣&spotclass=${spotclass}">花蓮縣</a>
											</div>
											<div>
												<a
													href="<%=request.getContextPath()%>/spot/FrontSpot_Servlet?action=front_search_con&requestURL=<%=request.getParameter("requestURL") %>&country=台東縣&spotclass=${spotclass}">台東縣</a>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</form>
					<div class="panel panel-primary" style="text-align: center;">
						<div class="panel-heading">Top熱門${spotclass }</div>
						<div class="panel-body">
							<c:forEach var="Famaus" items="${famaus }">
								<div style="text-align: center;">
									<a
										href="<%=request.getContextPath()%>/spot/FrontSpot_Servlet?action=front_search_one&requestURL=<%=request.getParameter("requestURL") %>&spotno=${Famaus.spotno}">
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
</body>
</html>