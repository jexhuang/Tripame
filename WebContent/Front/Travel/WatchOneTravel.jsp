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
	boolean isSignup = true;
	if (session.getAttribute("memvo") != null) {
		MemVO memvo = (MemVO) session.getAttribute("memvo");
		TravelVO travelvo = (TravelVO) request.getAttribute("travelvo");
		List<TrajoinVO> list = tjsvc.getOneTrajoin(travelvo
				.getTravelno());
		for (TrajoinVO tjvo : list) {
			if (tjvo.getMemno().equals(memvo.getMemno())) {
				isSignup = false;
			}
		}
	}
	TravelVO travelvo = (TravelVO) request.getAttribute("travelvo");
	List<TrajoinVO> list = tjsvc.getOneTrajoin(travelvo.getTravelno());
	for (TrajoinVO tjvo : list) {
		count++;
	}
	pageContext.setAttribute("count", count);
	pageContext.setAttribute("isSignup", isSignup);
%>
</head>
<jsp:include page="/Front/select_page.jsp" />
<body>
	<div class="container">
		<div class="row clearfix">
		<div class="col-md-12 column">
				<ol class="breadcrumb">
				<li><a
						href="<%=request.getContextPath()%>/Front/front_index.jsp">首頁</a></li>
				<li><a
						href="<%=request.getContextPath()%>/Front/Travel/ListTravel.jsp">套裝行程列表</a></li>
					<li class="active">套裝行程</li>
				</ol>
		</div>
		</div>
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
							<td>限制人數</td>
							<td>${travelvo.travellimit}</td>
						</tr>
						<tr>
							<td>報名人數</td>
							<td>
								<div class="progress">
									<div class="progress-bar progress-bar-striped active"
										role="progressbar" aria-valuenow="${count}" aria-valuemin="0"
										aria-valuemax="${travelvo.travellimit}"
										style="width: ${(count/travelvo.travellimit)*100}%">${count}</div>
							</td>
						</tr>
						<tr>
							<td>
								<FORM METHOD="get"
									ACTION="<%=request.getContextPath()%>/travel/TravelServlet">
									<input type="submit" value="點我報名" class="btn btn-success"
										${((isSignup)||(count==travelvo.travellimit))?'':'disabled'}>
										 <input type="hidden" name="travelno" value="${travelvo.travelno}">
										 <input type="hidden" name="action" value="paytravel">
										 
								</FORM>
							</td>
							<td>
								<FORM METHOD="get"
									ACTION="<%=request.getContextPath()%>/travel/TravelServlet">
									<input type="submit" value="點我也可以報名" class="btn btn-success"
										${((isSignup)||(count==travelvo.travellimit))?'':'disabled'}> <input type="hidden"
										name="travelno" value="${travelvo.travelno}">
										<input type="hidden" name="action" value="paytravel">
								</FORM>
							</td>
						</tr>
					</table>
				<td><img
					src="<%=request.getContextPath()%>/travel/TravelPicReader?travelno=${travelvo.travelno}"
					height="350" width="500"></td>
				</td>
			</tr>
			<tr>
				<td>${travelvo.travelcontent}</td>
			</tr>

		</table>
	</div>
</body>
</html>
