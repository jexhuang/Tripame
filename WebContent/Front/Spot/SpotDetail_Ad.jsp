<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.mem.model.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>廣告簡介</title>
<jsp:include page="/Front/select_page.jsp"/>
</head>
<body>
<jsp:useBean id="SpotBoard" scope="page" class="com.spotboard.model.SpotboardService"/>
<jsp:useBean id="Mem" scope="page" class="com.mem.model.MemService"/>
<%

	if((MemVO)session.getAttribute("memvo")!=null)
	{
		MemVO memvo = (MemVO)session.getAttribute("memvo");
	}
%>
<div class="container">
<div class="row clearfix">
	<div class="row" style="WORD-BREAK:break-all;">
		<div class="col-md-12 column">			
			<div class="col-md-8">
				<div class="panel panel-primary">
					<div class="panel-heading" style="text-align:center;">基本資訊</div>
					<div class="panel-body">
						<div class="row">
							<div class="col-md-8">
								<table class="table table-hover">
									<tr>
										<th width="100">縣市鄉鎮:</th>
										<td>${adVO.adcon }${adVO.adtown }</td>
									</tr>
									<tr>
										<th>名稱:</th>
										<td style="color:#0080FF;"><b>${adVO.adname }</b></td>
									</tr>
									<tr>
										<th>電話:</th>
										<td>${adVO.adphone }</td>
									</tr>
									<tr>
										<th>地址:</th>
										<td>${adVO.adaddress }</td>
									</tr>
									<tr>
										<th>官網:</th>
										<td><a href="${(adVO.adsite=='無')?'#':adVO.adsite }" >${adVO.adsite }</a></td>
									</tr>
								</table>
							</div>
							<div class="col-md-4">
								<img class="img-thumbnail" style="width:200px;height:200px" src="<%=request.getContextPath()%>/ads/AdsPicReader?adsno=${adVO.adno}">
							</div>							
						</div>
					</div>
				</div>
				<div class="panel panel-primary">
					<div class="panel-heading" style="text-align:center;">基本簡介</div>
					<div class="panel-body">
						&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp${adVO.adcontent }
					</div>
				</div>

				</div>
			</div>
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
										<div><a href="${param.requestURL }?action=front_search_con&country=基隆市&spotclass=${param.spotclass}">基隆市</a></div>
										<div><a href="${param.requestURL }?action=front_search_con&country=台北市&spotclass=${param.spotclass}">台北市</a></div>
										<div><a href="${param.requestURL }?action=front_search_con&country=新北市&spotclass=${param.spotclass}">新北市</a></div>
										<div><a href="${param.requestURL }?action=front_search_con&country=桃園市&spotclass=${param.spotclass}">桃園市</a></div>
										<div><a href="${param.requestURL }?action=front_search_con&country=新竹縣&spotclass=${param.spotclass}">新竹縣</a></div>
										<div><a href="${param.requestURL }?action=front_search_con&country=新竹市&spotclass=${param.spotclass}">新竹市</a></div>
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
										<div><a href="${param.requestURL }?action=front_search_con&country=苗栗縣&spotclass=${param.spotclass}">苗栗縣</a></div>
										<div><a href="${param.requestURL }?action=front_search_con&country=台中市&spotclass=${param.spotclass}">台中市</a></div>
										<div><a href="${param.requestURL }?action=front_search_con&country=彰化縣&spotclass=${param.spotclass}">彰化縣</a></div>
										<div><a href="${param.requestURL }?action=front_search_con&country=南投縣&spotclass=${param.spotclass}">南投縣</a></div>
										<div><a href="${param.requestURL }?action=front_search_con&country=雲林縣&spotclass=${param.spotclass}">雲林縣</a></div>
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
										<div><a href="${param.requestURL }?action=front_search_con&country=嘉義縣&spotclass=${param.spotclass}">嘉義縣</a></div>
										<div><a href="${param.requestURL }?action=front_search_con&country=嘉義市&spotclass=${param.spotclass}">嘉義市</a></div>
										<div><a href="${param.requestURL }?action=front_search_con&country=台南市&spotclass=${param.spotclass}">台南市</a></div>
										<div><a href="${param.requestURL }?action=front_search_con&country=高雄市&spotclass=${param.spotclass}">高雄市</a></div>
										<div><a href="${param.requestURL }?action=front_search_con&country=屏東縣&spotclass=${param.spotclass}">屏東縣</a></div>
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
										<div><a href="${param.requestURL }?action=front_search_con&country=宜蘭縣&spotclass=${param.spotclass}">宜蘭縣</a></div>
										<div><a href="${param.requestURL }?action=front_search_con&country=花蓮縣&spotclass=${param.spotclass}">花蓮縣</a></div>
										<div><a href="${param.requestURL }?action=front_search_con&country=台東縣&spotclass=${param.spotclass}">台東縣</a></div>
									</div>
								</div>
							</div>
						</div>
					</div>					
				</form>
				
			</div>
		</div>
	</div>
</div>	
</body>
</html>