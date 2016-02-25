<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page import="com.spot.model.*"%>
<%@ page import="java.util.*"%>
<%
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
%>
<jsp:useBean id="spotSvc" scope="page"
	class="com.spot.model.SpotService" />

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=BIG5">
<title>Tripame行程規劃</title>
</head>
<jsp:include page="/Front/select_page.jsp" />
<style>
#map {
	width: 100%;
	height: 70%;
}

#sortable {
	list-style: none;
	margin: 0;
	padding: 0;
	width: 100%;
}

#sortable li {
	margin: 0 3px 3px 3px;
	font-size: 16px;
	line-height: 5px;
	height: 40px;
	text-align: center;
}
</style>

<script>
	$(function() {
		btnSaveStatus=false;//儲存行程是否被點選
		var btnDetail = false;
		$("#resizable").hide();
		$("#tripNameErr").hide();
		$("#opener").click(function() {
			if (btnDetail) {
				document.getElementById("opener").innerHTML = "開啟路線資訊";
				btnDetail = false;
			} else {
				document.getElementById("opener").innerHTML = "關閉路線資訊";
				btnDetail = true;
			}

			$("#resizable").toggle(1000);
			
		});
		//景點表
		$("#tabs").tabs();
		//地址轉經緯度
        var add = document.getElementById("departure1").value + document.getElementById("departure2").value;
        var departureLat = document.getElementById("departureLat");
        var departureLong = document.getElementById("departureLong");
        var geocoder = new google.maps.Geocoder();

        geocoder.geocode( { address: add}, function(results, status) {

            if (status == google.maps.GeocoderStatus.OK) {

            	departureLat.value = results[0].geometry.location.lng();

       			departureLong.value = results[0].geometry.location.lat();

            }

        });
      //經緯度轉地址    
      if('${latlong}'!=null){
    	  if($("#long").val()!=""){
          	var geocoder = new google.maps.Geocoder();
          	var lng = $("#lat").val();
          	var lat = $("#long").val();
          	var latlng = new google.maps.LatLng(lat, lng);
          	geocoder.geocode({'latLng': latlng}, function(results, status) {
          	   if (results[3]) {
          		  var str1 = (results[3].formatted_address).split("");
          		  departure1 = str1[5]+str1[6]+str1[7];
          		  departure2 = str1[8]+str1[9]+str1[10];
          		
          	    	$("#departure1").val(departure1);
          	    	$("#departure2").val(departure2);
          	    } 
          	});
          	  
          }; 
      }
        
});//$(function{})end


</script>
<!-- googleMap -->
<script>
        var directionsDisplay;
        var directionsService = new google.maps.DirectionsService();
        var map;

        function initialize() {
            directionsDisplay = new google.maps.DirectionsRenderer();
            var heysong = new google.maps.LatLng(24.993113, 121.234304 );
            var mapOptions = {
                zoom: 13,
                center: heysong,
                autoLocation : true
            }
            map = new google.maps.Map(document.getElementById('map'), mapOptions);
            directionsDisplay.setMap(map);
            directionsDisplay.setPanel(document.getElementById('resizable'));
        }
        function callMap(i) {
        	
        	var start = '';
			var end = '';
			var waypts = [];//從[0]開始

			var name = "day" + i;//天數名稱
			var viewCount = "viewCount" + i;//該天的景點數
			//alert("第"+i+"天");
			for (var j = 0; j < document.getElementById(viewCount).value; j++) {
				if (j == 0) {
					start = document.getElementsByClassName(name)[j].value;
					continue;
				} 
				if ( (i == parseInt('${fn:length(viewName)}')) && j == (document.getElementById(viewCount).value)-1){
					waypts.push({
						location : document.getElementsByClassName(name)[j].value,
						stopover : true
					});
					end = $("#departure1").val() + $("#departure2").val();
					continue;
	        	}
				if (j == (document.getElementById(viewCount).value)-1){
					end = document.getElementsByClassName(name)[j].value;
					continue;
				}
				
				waypts.push({
					location : document.getElementsByClassName(name)[j].value,
					stopover : true
				});
			}//for_end 
            var request = {
                origin: start,
                destination: end,
                waypoints: waypts,
                optimizeWaypoints: true,
                travelMode: google.maps.TravelMode.DRIVING
            };
            directionsService.route(request, function(response, status) {
                if (status == google.maps.DirectionsStatus.OK) {
                  directionsDisplay.setDirections(response);
                }
              });
        }

        google.maps.event.addDomListener(window, 'load', initialize);

</script>
<script>
function saveTrip(){
	var tripName = $("#tripName").val();
	if(tripName==""){
		$("#tripNameErr").show(300);
		return false;
	}
	else{
		$("#saveRecive").val("saveTrip");
		$("#tripForm").submit();
	}
}
function clearErr(){
	$("#tripNameErr").hide();
}
function reciveTrip(){
	$("#saveRecive").val("reciveTrip");
	$("#tripForm").submit();
}

</script>

<body class="cbp-spmenu-push" onload="callMap(1)">
	<input type="hidden" id="long" value="${latlong[0]}">
	<input type="hidden" id="lat" value="${latlong[1]}">
	<div class="container">
		<form id="tripForm" class="form-horizontal" role="form"
			action="<%=request.getContextPath()%>/Mem/memRoute" method="post">
			<input type="hidden" id="departureLat" name="departureLat"
				value="${latlong[1]}"> <input type="hidden"
				id="departureLong" name="departureLong" value="${latlong[0]}">
			<div class="row clearfix">
				<div class="col-md-12 column">
					<ol class="breadcrumb">
						<li><a
							href="<%=request.getContextPath()%>/Front/front_index.jsp">Home</a></li>
						<li><a
							href="<%=request.getContextPath()%>/Front/Trip/memtrip.jsp">行程規劃</a></li>
						<li class="active">儲存行程</li>
					</ol>
				</div>
			</div>
			<div class="row clearfix">
				<div class="col-md-12 column">
					<div class="row clearfix">
						<div class="col-md-12 column">
							<div class="col-md-3 column">
								<label><p class="text-info">出發地</p></label><br> <input
									id="departure1" name="departure1" class="form-control"
									type="text" value="${twArea[0]}" readonly /> <input
									id="departure2" name="departure2" class="form-control"
									type="text" value="${twArea[1]}" readonly />
							</div>
							<div class="col-md-6 column ">
								<div class="row clearfix">
									<div class="form-group">
										<div class="controls controls-row col-md-6 column">
											<label><p class="text-info">開始日期 & 結束日期</p></label><br>
											<div class="row clearfix">
												<div class="col-md-8 column">
													<div class="input-group ">

														<input type="text" id="from" name="dateBegin"
															class="form-control"
															style="font-size: 8px; text-align: center;"
															value="${dateArray[0]}" readonly><span
															class="input-group-addon" id="basic-addon1"><span
															class="input-group-btn glyphicon glyphicon-calendar"></span></span>

													</div>
													<div class="input-group ">

														<input type="text" id="to" name="dateEnd"
															class="form-control"
															style="font-size: 8px; text-align: center;"
															value="${dateArray[2]}" readonly> <span
															class="input-group-addon" id="basic-addon1"><span
															class="input-group-btn glyphicon glyphicon-calendar"></span></span>

													</div>
												</div>
												<div class="col-md-4 column">

													<div class="row clearfix">
														<input id="fromTime" name="fromTime" class="form-control"
															type="text" placeholder="00:00" value="${dateArray[1]}"
															readonly />
													</div>
													<div class="row clearfix">
														<input id="toTime" name="toTime" class="form-control"
															type="text" class="time" placeholder="23:59"
															value="${dateArray[3]}" readonly />
													</div>
												</div>
											</div>
										</div>
										<div class="controls controls-row col-md-6 column ">
											<label><p class="text-info">行程主題</p></label><br> <input
												id="tripName" name="tripName" class="form-control"
												type="text" onchange="clearErr()" value="${tripName}">
											<SPAN id="tripNameErr" style="color: red;">請輸入行程主題</SPAN>
										</div>
									</div>
								</div>
							</div>
							<div class="col-md-1 column"></div>
							<div class="col-md-2 column">

								<button class="btn btn-warning btn-lg btn-block"  onclick="reciveTrip()">修改行程</button>
								<submit class="btn btn-success btn-lg btn-block"  onclick="saveTrip()">儲存行程</submit> 
								<input type="hidden" name="saveRoute" value="saveRoute"> <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<input type="hidden" name="tripno" value="${tripno}"> <a href="#" id="opener">開啟路線資訊</a>
								<input type="hidden" id ="saveRecive" name="saveRecive" >
							</div>
						</div>
					</div>

					<div class="row clearfix">
						<div class="col-md-12 column" style="margin-top: 20px;">
							<div class="col-md-3 column">
								<div id="tabs">
									<ul>
										<c:forEach var="i" begin="1" end="${fn:length(viewName)}">
											<li><a href='#tabs-${i}' id="tab${i}"
												onclick="callMap(${i})">${i}</a></li>

										</c:forEach>
									</ul>
									<%
										TreeMap<String, ArrayList<String>> map = (TreeMap) request
																			.getAttribute("viewName");
																	TreeMap<String, ArrayList<String>> viewAddr = (TreeMap) request
																			.getAttribute("viewAddr");
																	for (int i = 1; i <= map.size(); i++) {
																		out.println("<div id='tabs-" + i + "'>");
																		out.println("<ul id='sortable'>");
																		ArrayList<String> x = map.get("day" + i);
																		int count = 0;
																		for (String j : x) {
																			out.println("<li class='ui-state-default'><span class='ui-icon ui-icon-arrowthick-2-n-s'></span>"
																					+ j + "</li>");
																			out.println("<input type='hidden' class='viewName" + i
																					+ "' value=" + j + ">");
																			count++;
																		}

																		out.println("<input type='hidden' id='viewCount" + i
																				+ "' value=" + count + ">");
																		count = 1;//歸零重新計數該天的景點數

																		ArrayList<String> y = viewAddr.get("day" + i);
																		for (String j : y) {
																			out.println("<input type='hidden' class='day" + i
																					+ "' value=" + j + ">");
																		}
																		out.println("</ul></div>");
																	}
									%>
								</div>
							</div>
							<div class="col-md-9 column">
								<!-- googleMap顯示區 -->
								<div id="map"></div>
								<div id="resizable" class="ui-widget-content"
									style="position: absolute; left: 100%; top: 0; width: 30%; overflow: auto; background: white; height: 100%;"></div>
							</div>
						</div>
					</div>

				</div>

			</div>
			<!-- col-md-12 column_off -->
		</form>
	</div>
</body>
</html>