<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.traffic.model.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
</head>
<body>
<%
	List<TrafficVO> list= (List<TrafficVO>)session.getAttribute("list");
	if(list==null)
	{	
		TrafficService traSvc = new TrafficService();
		Map<String,String[]> map = new TreeMap<String,String[]>();
		String traclass = null;
		if("bus".equals(request.getParameter("traclass")))
		{
			traclass = "客運";
		}
		else if("ride".equals(request.getParameter("traclass")))
		{
			traclass = "機車";
		}
		else if("taxi".equals(request.getParameter("traclass")))
		{
			traclass = "計程車";
		}
		map.put("traclass", new String[]{traclass});
		list = traSvc.getAll(map);
		pageContext.setAttribute("list", list);
	}
%>
	<br>
	<form class="form-inline" action="<%=request.getContextPath()%>/traffic/traffic.do" method="post">
		<div class="form-group">
			<select name="tracon" class="form-control">
				<option>請選擇縣市</option>
				<option>基隆縣</option>
				<option>台北市</option>
				<option>新北市</option>
				<option>桃園市</option>
				<option>新竹縣</option>
				<option>苗栗縣</option>
				<option>台中市</option>
				<option>南投縣</option>
				<option>彰化縣</option>
				<option>雲林縣</option>
				<option>嘉義縣</option>
				<option>台南市</option>
				<option>高雄市</option>
				<option>屏東縣</option>
				<option>台東縣</option>
				<option>花蓮縣</option>
				<option>宜蘭縣</option>
			</select>
		</div>
		<div class="form-group">
	    	<input type="text" name="traname" class="form-control" placeholder="請輸入名稱">
		 </div>
		 <div class="form-group">
		   	<input type="submit" value="搜尋" class="form-control" >
		   	<input type="hidden" name="action" value="search2">
		   	<input type="hidden" name="traclass" value="${param.traclass }">
		   	<input type="hidden" name="requestURL" value="<%=request.getServletPath()%>">
		</div>
		<div class="form-group">${result}</div>
	</form>		
<table class="table"  style="text-align:center;">
	<tr>
		<th style="width:15%;text-align:center;">名稱</th>
	<c:if test="${param.traclass=='taxi' }">
		<th style="width:50%;text-align:center;">縣市</th>    
		<th style="width:35%;text-align:center;">電話</th>	
	</c:if>
	<c:if test="${param.traclass=='ride' }">
		<th style="width:50%;text-align:center;">地址</th>    
		<th style="width:35%;text-align:center;">電話</th>
	</c:if>
	<c:if test="${param.traclass=='bus' }">
		<th style="width:50%;text-align:center;">地址</th>    
		<th style="width:35%;text-align:center;">官網</th>
	</c:if>
		<th></th>
	</tr>
	<%@ include file="pages/page1.file" %>
	<c:forEach var="travo" items="${list}">
	<tr>
			<td>${travo.traname }</td>
		<c:if test="${param.traclass=='taxi' }">
			<td>${travo.tracon }</td>
			<td>${travo.traphone }</td>				
		</c:if>
		<c:if test="${param.traclass=='ride' }">
			<td>${travo.traaddress }</td>
			<td>${travo.traphone }</td>	
		</c:if>
		<c:if test="${param.traclass=='bus' }">
			<td>${travo.traaddress }</td>
			<td>${travo.trasite }</td>	
		</c:if>
		<td>
			<!-- 彈跳視窗 -->
			<button type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#${travo.trano }">詳細資訊</button>
			<!-- Modal -->
			<div class="modal fade" id="${travo.trano }" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">						    
							<h4 class="modal-title" id="myModalLabel">${travo.traname }</h4>
						</div>
						<div class="modal-body">
							<table style="text-align:center">
							<tr>
								<td style="padding:10px">電話:&nbsp<span>${travo.traphone }</span></td>
							</tr>
							<tr>
								<td style="padding:10px">地址:&nbsp<span>${travo.traaddress }</span></td>
							</tr>	
							<tr>
								<td style="padding:10px">網址:&nbsp<span>${travo.trasite }</span></td>
							<c:if test=""></c:if>
							</tr>
							</table>	

						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
						</div>
					</div>
				</div>
			</div>
		</td>
	</tr>
	</c:forEach>
</table>
</body>
</html>