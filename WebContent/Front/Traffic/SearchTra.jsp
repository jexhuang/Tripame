<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.traffic.model.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>交通資訊</title>
<jsp:include page="/Front/select_page.jsp"/>
</head>
<body>
<jsp:useBean id="traSvc" class="com.traffic.model.TrafficService"/>
<%session.removeAttribute("list"); %>
<div class="container">
	<div role="tabpanel">
	  <!-- Nav tabs -->
		  <ul class="nav nav-tabs" role="tablist">
		    <li role="presentation" class="active"><a href="#train" aria-controls="train" role="tab" data-toggle="tab">台鐵</a></li>
		    <li role="presentation"><a href="#high_train" aria-controls="high_train" role="tab" data-toggle="tab">高鐵</a></li>
		    <li role="presentation"><a href="#bus" aria-controls="bus" role="tab" data-toggle="tab">客運</a></li>
		    <li role="presentation"><a href="#ride" aria-controls="ride" role="tab" data-toggle="tab">機車</a></li>
		    <li role="presentation"><a href="#taxi" aria-controls="taxi" role="tab" data-toggle="tab">計程車</a></li>
		  </ul>
	  <!-- Tab panes -->
		  <div class="tab-content"  style="text-align:center;">
		  	<!-- 火車 -->
		    <div role="tabpanel" class="tab-pane active" id="train">
		    	<iframe src="http://twtraffic.tra.gov.tw/twrail/" width=100% height=800px frameborder=0></iframe>
		    </div>
		    <!-- 高鐵 -->
		    <div role="tabpanel" class="tab-pane" id="high_train">
		    	<iframe src="http://www.thsrc.com.tw/index.html?force=1" width=100% height=800px frameborder=0></iframe>
		    </div>
		    <!-- 客運 -->
		    <div role="tabpanel" class="tab-pane" id="bus">
		    	<iframe src="<%=request.getContextPath() %>/Front/Traffic/Tool.jsp?traclass=bus" width=100% height=800px frameborder=0></iframe>
		    </div>
		    <!-- 機車 -->
		    <div role="tabpanel" class="tab-pane" id="ride">
		    	<iframe src="<%=request.getContextPath() %>/Front/Traffic/Tool.jsp?traclass=ride" width=100% height=800px frameborder=0></iframe>
		    </div>
		    <!-- 計程車 -->
		    <div role="tabpanel" class="tab-pane" id="taxi">
		    	<iframe src="<%=request.getContextPath() %>/Front/Traffic/Tool.jsp?traclass=taxi" width=100% height=800px frameborder=0></iframe>
		    </div>
	    </div>	    
	   </div>
  </div>
</body>
</html>