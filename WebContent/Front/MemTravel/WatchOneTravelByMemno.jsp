<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.travel.model.*"%>
<%@ page import="com.trajoin.model.*"%>
<%@ page import="com.mem.model.*"%>
<%@ page import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>套裝行程</title>
<jsp:useBean id="tjsvc" class="com.trajoin.model.TrajoinService" />
<%
	int count = 0;
	if (session.getAttribute("memvo") != null) {
		MemVO memvo = (MemVO) session.getAttribute("memvo");
		TravelVO travelvo = (TravelVO) request.getAttribute("travelvo");
		List<TrajoinVO> list = tjsvc.getOneTrajoin(travelvo
				.getTravelno());
		for (TrajoinVO tjvo : list) {
			count++;
		}
	}
	pageContext.setAttribute("count", count);
%>
</head>
<jsp:include page="/Front/select_page.jsp" />
<body>
	<div class="container">
		<ol class="breadcrumb">
			<li><a href="<%=request.getContextPath()%>/Front/front_index.jsp">首頁</a></li>
			<li><a href="<%=request.getContextPath()%>/Front/Trip/memRoute.jsp">會員專區</a></li>
			<li><a
				href="<%=request.getContextPath()%>/Front/MemTravel/ListTravelByMemno.jsp">已報名的行程</a></li>
			<li class="active">行程詳細資訊</li>
		</ol>
		<table class="table">
			<tr>
				<td>
					<table class="table table-hover">
						<tr>
							<td>行程名稱</td>
							<td>${travelvo.travelname}</td>

						</tr>
						<tr>
							<td>開始日期</td>
							<td>${travelvo.travelbegin}</td>
						</tr>
						<tr>
							<td>結束日期</td>
							<td>${travelvo.travelend}</td>
						</tr>
						<tr>
							<td>截止日期</td>
							<td>${travelvo.traveldeadline}</td>
						</tr>
						<tr>
							<td>報名費</td>
							<td>${travelvo.travelprice}</td>
						</tr>
						<tr>
							<td>報名人數</td>
							<td>${count}/ ${travelvo.travellimit}</td>
						</tr>
					</table>
				<td><img
					src="<%=request.getContextPath()%>/travel/TravelPicReader?travelno=${travelvo.travelno}"
					height="300" width="500"></td>
				</td>

			</tr>
			<tr>
				<td>${travelvo.travelcontent}</td>
			</tr>

		</table>
	</div>
</body>
</html>