<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.spot.model.*"%>
<%
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
%>
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>Tripame行程規劃</title>
<style>
body {
	font-family: "微軟正黑體";
}

.sortable {
	list-style: none;
	margin: 0;
	padding: 0;
	width: 100%;
}

.sortable li {
	margin: 0 3px 3px 3px;
	font-size: 16px;
	line-height: 5px;
	height: 40px;
}
a.myWord:hover{
	color:orange;
}
</style>

</head>
<jsp:include page="/Front/select_page.jsp" />

<script>
	//**************************全域變數*************************
	$(function() {
		
		tmpArea = $("#tmpArea").val();
		tabStatus = 1;
		clickEndDate = false;
		diff=0;//儲存日期相減
		count=1;
		viewArray = new Array();
		tabCount=1;
		tabStatusArray1= new Array();//用來儲存使用者上一個點選過的tabs
		tabStatusArray1[0]=1;
		$("#tabs").tabs();
		$("#departureErr").hide();
		$("#fromErr").hide();
		$("#endErr").hide();
		$(".sortable").sortable();
		$(".sortable").disableSelection();

	});
	
	$(function() {
		$("#to").button().change(function() {
			addTab();
			clickEndDate=true;
		});
		$("#from").button().change(function() {
		});
		var tabTemplate = "<li><a href='#\{href\}' onclick='tabNumber(tabStatus);checkIt()'>#\{label\}</a></li>";
		var tabs = $("#tabs").tabs();
		// actual addTab function: adds new tab using the input from the form above
		function addTab() {

			for (var i = ${fn:length(viewName)}+1; i <= date(); i++) {
				var label = i, id = "tabs-" + i, li = $(tabTemplate.replace(
						/#\{href\}/g, "#" + id).replace(/#\{label\}/g, label).replace(/tabStatus/g,i)),tabContentHtml= "<ul class='sortable' id=\"sortable"+i+"\"></ul>";
				tabs.find(".ui-tabs-nav").append(li);
				tabs.append("<div class ='addDiv' id='" + id + "'>"
						+ tabContentHtml + "</div>");
				tabs.tabs("refresh");
			}
			sortable();
		}
		// addTab button: just opens the dialog
		$("#to").button().change(function() {
			addTab();
			clickEndDate=true;
		});
		$("#from").button().change(function() {
		});

	});//(function(){})_end
	
	function checkIt(){
		
		var tmpTab = tabStatusArray1[tabStatusArray1.length-2];//取回使用者上次使用點選的tabs數值
		var xhr=new XMLHttpRequest();
		var name = "day"+tmpTab;
		var dayViews = document.getElementsByName(name).length;
		var viewArray = new Array();
		var param ="";
		for(var j=0;j<dayViews;j++){
			viewArray[j] = document.getElementsByName(name)[j].value;//取得使用者現在點選中的各個spotno
			param += "&&viewArray[]="+ viewArray[j];
		}
		 $.ajax({
	         url: "<%=request.getContextPath()%>/Trip/tripplan?checkIt=check&totalDays="+diff,
	         data: param,
	         type:"Get",
	         dataType:'text',

	         success: function(msg){
	        	 var obj = document.getElementById("my");
	        	 if(msg==1){
            		 obj.innerHTML= "<img title='小提示:您在第"+tmpTab+"天規劃的景點數有點少，您可以試著再加入一些景點!' src='<%=request.getContextPath()%>/Front/forIndex/img/icons/idea13_light.jpg' onclick='hey(tmpTab);'>";
            	 } else if(msg==2){
            		 obj.innerHTML= "<img title='小提示:您是不是忘記在第"+tmpTab+"天加入住宿地點！' src='<%=request.getContextPath()%>/Front/forIndex/img/icons/idea13_light.jpg' onclick='hey(tmpTab);'>";
            	 }else if(msg==3){
            		 obj.innerHTML= "<img title='小提示:1.您在第"+tmpTab+"天規劃的景點數有點少，您可以試著再加入一些景點!2.您是不是忘記在第"+tmpTab+"天加入住宿地點！' src='<%=request.getContextPath()%>/Front/forIndex/img/icons/idea13_light.jpg' onclick='hey(tmpTab);'>";
            	 }else {
            		 obj.innerHTML= "<img src='<%=request.getContextPath()%>/Front/forIndex/img/icons/idea13.jpg'>";
            	 }
	         },
	          error:function(xhr, ajaxOptions, thrownError){ 

	          }
	     });
	}
	

	//**************************日期選擇器**************************
	$('#from').click(function() {
		var date = $("#from").datepicker("getDate");
		date = $.datepicker.formatDate("yy 年 M d 日", date);
	});
	
	$(function() {
		$("#from").datepicker({

			defaultDate : "+0w",
			changeMonth : true,
			numberOfMonths : 2,
			minDate : -0,
			dateFormat : 'yy-mm-dd',
			onClose : function(selectedDate) {
				$("#to").datepicker("option", "minDate", selectedDate);
			}
		});
	});
	$(function() {
		$("#to").datepicker(

		{
			defaultDate : "+0w",
			changeMonth : true,
			numberOfMonths : 2,
			minDate : -0,
			dateFormat : 'yy-mm-dd',
			onClose : function(selectedDate) {
				$("#from").datepicker("option", "maxDate", selectedDate);
			}
		});
	});

	//window.onload
	function twMap() {
		//************************** 動態台灣地圖**************************
		var str = window.location.pathname;
		var res = str.split("/");
		var path = window.location.protocol + "//" + window.location.host + "/"
				+ res[1];
		function resetMap(obj, local) {
			obj
					.addEventListener(
							"mouseover",
							function() {
								document.getElementById("mapDiv").innerHTML = "<img src=\""
										+ path
										+ "/Front/forIndex/img/taiwanMap/"
										+ local
										+ ".png\" width='120' height='220' usemap='#TestMap' class='twMap'>";
							});

			obj
					.addEventListener(
							"mouseout",
							function() {
								document.getElementById("mapDiv").innerHTML = "<img src=\""
										+ path
										+ "/Front/forIndex/img/taiwanMap/taiwan.png\" width='120' height='220' usemap='#TestMap' class='twMap'>";
							});

		}
		var objpingtung = document.getElementById("pingtung");

		resetMap(objpingtung, "pingtung");

		var objKaohsiung = document.getElementById("kaohsiung");
		resetMap(objKaohsiung, "kaohsiung");

		var objTainan = document.getElementById("tainan");
		resetMap(objTainan, "tainan");

		var objchiayi = document.getElementById("chiayi");
		resetMap(objchiayi, "chiayi");

		var objyunlin = document.getElementById("yunlin");
		resetMap(objyunlin, "yunlin");

		var objchanghua = document.getElementById("changhua");
		resetMap(objchanghua, "changhua");

		var objtaichung = document.getElementById("taichung");
		resetMap(objtaichung, "taichung");

		var objmiaoli = document.getElementById("miaoli");
		resetMap(objmiaoli, "miaoli");

		var objhsinchu = document.getElementById("hsinchu");
		resetMap(objhsinchu, "hsinchu");

		var objtaoyuan = document.getElementById("taoyuan");
		resetMap(objtaoyuan, "taoyuan");

		var objtaipei = document.getElementById("taipei");
		resetMap(objtaipei, "taipei");
		
		var objtaipei = document.getElementById("newpei");
		resetMap(objtaipei, "newpei");
		
		var objtaipei = document.getElementById("keelung");
		resetMap(objtaipei, "keelung");

		var objilan = document.getElementById("ilan");
		resetMap(objilan, "ilan");

		var objhualien = document.getElementById("hualien");
		resetMap(objhualien, "hualien");

		var objtaitung = document.getElementById("taitung");
		resetMap(objtaitung, "taitung");

		var objnantou = document.getElementById("nantou");
		resetMap(objnantou, "nantou");
		
	};

	//日期相減
	function date() {
		var fromDate = $("#from")[0].value;
		var toDate = $("#to")[0].value;
		diff = new Date(toDate) - new Date(fromDate);
		diff = Math.abs(diff);
		diff = (diff / 1000 / 60 / 60 / 24) + 1; // 由亳秒轉成天
		return diff;
	}
	
	//**************************景點表**************************	
	$(function() {
		tabStatus=1;
		var tabs = $("#tabs").tabs();
		$(".sortable").sortable();
		$(".sortable").disableSelection();
		
		
	});
	function tabNumber(e){
		tabStatus=e;//記錄使用者點選哪個tabs
		tabStatusArray1[tabCount]=e;
		tabCount+=1;
	}
	//AJAX_分類搜尋
	function classSearch(classValue){
	  var xhr=new XMLHttpRequest();
	  var tmp = $("#tmpArea").val();
	  //設定好回呼函數 
	  xhr.onreadystatechange=function(){
		  if(xhr.readyState==4){
			  if(xhr.status==200){
				  document.getElementById("showDiv").innerHTML=xhr.responseText;
				  }
			  }
		  };
	  //建立好Get連接與送出請求
		var url="<%=request.getContextPath()%>/Trip/tripplan?action=classSearch&tmpArea="+tmp+"&class="+classValue;
		xhr.open("Get",url,true);
		xhr.send(null);
	}
	//AJAX_搜尋景點
	function searchSpot(){
		  var xhr=new XMLHttpRequest();
		  //設定好回呼函數 
		  xhr.onreadystatechange=function(){
			  if(xhr.readyState==4){
				  if(xhr.status==200){
					  document.getElementById("showDiv").innerHTML=xhr.responseText;
					  document.getElementById("spotKeyWd").value= "";
					  }
				  }
			  };
		  //建立好Get連接與送出請求
			var url="<%=request.getContextPath()%>/Trip/tripplan?action=searchSpot&spot="+ $('#spotKeyWd').val();
		xhr.open("Get", url, true);
		xhr.send(null);
	}
	
	//AJAX-地圖搜尋
	function clickArea(area){
		var xhr=new XMLHttpRequest();
		var searched = $("#searchOption").val();
		document.getElementById("tmpArea").value= area;//儲存隱藏域的使用者選的地名
		  //設定好回呼函數 
		  xhr.onreadystatechange=function(){
			  if(xhr.readyState==4){
				  if(xhr.status==200){
					  document.getElementById("showDiv").innerHTML=xhr.responseText;

					  }
				  }
			  };
		  //建立好Get連接與送出請求
			var url='<%=request.getContextPath()%>'
				+ "/Trip/tripplan?map=searchArea&searchOption=" + searched
				+ "&area=" + area;
		xhr.open("Get", url, true);
		xhr.send(null);
		return false;
	}
	function btnTrip() {
		var country = document.getElementsByName("country")[0].value;
		var from = $("#from").val();
		$("input[name='tripName']").val('${tripName}');
		var to = $("#to").val();
		if (country == ""){
			$("#departureErr").toggle(300);
		}
		if (from == ""){
			$("#fromErr").toggle(300);
		}
		if (to == ""){
			$("#endErr").toggle(300);
		}
		$("input[name='days']").val(date());
		$("#tripForm").submit();
	}
	function clearErrDepart() {
		$("#departureErr").hide();
	}
	function clearErrFromDate() {
		$("#fromErr").hide();
	}
	function clearErrToDate() {
		$("#endErr").hide();
	}

	$(function() {
		var geocoder = new google.maps.Geocoder();
		var lat = ${latlong[0]};
		var lng = ${latlong[1]};
		var latlng = new google.maps.LatLng(lat, lng);

		geocoder.geocode({
			'latLng' : latlng
		}, function(results, status) {
			if (results[3]) {
				var str1 = (results[3].formatted_address).split("");
				departure1 = str1[5] + str1[6] + str1[7];
				departure2 = str1[8] + str1[9] + str1[10];

				$('#TWmap').twzipcode({
					countyName : "country",
					districtName : "district",
					countySel : departure1,
					districtSel : departure2
				});
			}
		});

		;
	});
	function removeView(i){
    	var name = "#li"+i;
        $(name).remove();
        
};


</script>

<body onload="twMap();clickArea('桃園')">
	<!--隱藏域_儲存使用者選的地名 -->
	<input type="hidden" id="tmpArea" value="" />
	<div class="container">
		<div class="row clearfix">
			<div class="col-md-12 column">
				<ol class="breadcrumb">
				<li><a
						href="<%=request.getContextPath()%>/Front/front_index.jsp">首頁</a></li>
					<li><a
						href="<%=request.getContextPath()%>/Front/Trip/memRoute.jsp">會員專區</a></li>
					<li class="active">修改行程</li>
				</ol>
			</div>
		</div>
		<form id="tripForm" class="form-horizontal" role="form"
			action="<%=request.getContextPath()%>/Trip/route" method="post">
			<div class="row clearfix">
				<div class="col-md-12 column">
					<div class="col-md-3 column">
						<label><p class="text-info">出發地</p></label><br>
						<div id="TWmap" class="btn-group">
							<div data-role="zipcode" data-style="hide"></div>
							<div data-name="country" data-role="county" style="float: left;"
								onclick="clearErrDepart()"></div>
							<div data-name="district" data-role="district"
								style="float: left;" onclick="clearErrDepart()"></div>
						</div>
						<br> <SPAN id="departureErr" style="color: red;">請選擇出發地</SPAN>
					</div>

					<div class="col-md-7 column ">
						<div class="form-group">
							<div class="controls controls-row col-md-6 column ">
								<div class="row clearfix">
									<label><p class="text-info">開始日期</p></label><br>
									<div class="col-md-7 column">
										<div class="row clearfix">
											<div class="input-group ">
												<input type="text" id="from" name="dateBegin"
													class="form-control" style="font-size: 8px;"
													onclick="clearErrFromDate()" value="${dateArray[0]}"><span
													class="input-group-addon" id="basic-addon1"><span
													class="input-group-btn glyphicon glyphicon-calendar"></span></span>
											</div>
											<SPAN id="fromErr" style="color: red;">請選擇開始日期</SPAN>
										</div>
									</div>
									<div class="col-md-5 column">
										<div class="row clearfix">
											<input id="fromTime" name="fromTime" class="form-control"
												type="text" value="${dateArray[1]}" />
											<script>
												$(function() {
													$('#fromTime').timepicker();
												});
											</script>
										</div>
									</div>
								</div>
							</div>
							<div class="controls controls-row col-md-6 column ">
								<label><p class="text-info">結束日期</p></label><br>
								<div class="col-md-7 column">
									<div class="row clearfix">
										<div class="input-group ">
											<input type="text" id="to" name="dateEnd"
												class="form-control" style="font-size: 8px;"
												onclick="clearErrToDate()" value="${dateArray[2]}">
											<span class="input-group-addon" id="basic-addon1"><span
												class="input-group-btn glyphicon glyphicon-calendar"></span></span>
										</div>
										<SPAN id="endErr" style="color: red;">請選擇結束日期</SPAN>
									</div>
								</div>

								<div class="col-md-5 column">
									<div class="row clearfix">
										<input id="toTime" name="toTime" class="form-control"
											type="text" class="time" value="${dateArray[3]}" />
										<script>
											$(function() {
												$('#toTime').timepicker();

											});
										</script>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="col-md-2 column">
						<div class="form-group">
							<label><p class="text-info">分類查詢</p></label><br>
							<p>
								<select class="form-control" size="1" name="spotclass"
									id="searchOption" onchange="classSearch(this.value);">
									<option>分類</option>
									<option value="景點">景點</option>
									<option value="美食">美食</option>
									<option value="住宿">住宿</option>
								</select>
							</p>
							<div class="input-group">
								<input type="text" class="form-control" placeholder="查詢景點名稱"
									id="spotKeyWd" value=""> <span class="input-group-btn">
									<button class="btn btn-default" type="button"
										onclick="searchSpot()">Go!</button>
								</span>
							</div>

						</div>

					</div>
				</div>
			</div>
			<div class="col-md-12 column">
				<div class="row clearfix">
					<div class="col-md-3 column">
						<div class="row clearfix"
							style="font-size: 8px; text-align: center; background-color: #FCFCFC; box-shadow: 1px 1px 1px 1px #cccccc;">
							<div class="mapWrapper">
								<div class="col-md-3 column">
									<div style="height: 30px;"></div>
									<a class="myWord"
										href="<%=request.getContextPath()%>/Trip/tripplan?area=searchArea&spot=台中"
										onclick="return clickArea('台中');">台中<span
										class="glyphicon glyphicon-certificate" aria-hidden="true"></span></a>
									<a class="myWord"
										href="<%=request.getContextPath()%>/Trip/tripplan?area=searchArea&spot=彰化"
										onclick="return clickArea('彰化');">彰化<span
										class="glyphicon glyphicon-certificate" aria-hidden="true"></span></a>
									<a class="myWord"
										href="<%=request.getContextPath()%>/Trip/tripplan?area=searchArea&spot=南投"
										onclick="return clickArea('南投');">南投<span
										class="glyphicon glyphicon-certificate" aria-hidden="true"></span></a>
									<a class="myWord"
										href="<%=request.getContextPath()%>/Trip/tripplan?area=searchArea&spot=雲林"
										onclick="return clickArea('雲林');">雲林<span
										class="glyphicon glyphicon-certificate" aria-hidden="true"></span></a>
									<div style="height: 20px;"></div>
									<a class="myWord"
										href="<%=request.getContextPath()%>/Trip/tripplan?area=searchArea&spot=嘉義"
										onclick="return clickArea('嘉義');">嘉義<span
										class="glyphicon glyphicon-certificate" aria-hidden="true"></span></a>
									<a class="myWord"
										href="<%=request.getContextPath()%>/Trip/tripplan?area=searchArea&spot=台南"
										onclick="return clickArea('台南');">台南<span
										class="glyphicon glyphicon-certificate" aria-hidden="true"></span></a>
									<a class="myWord"
										href="<%=request.getContextPath()%>/Trip/tripplan?area=searchArea&spot=高雄"
										onclick="return clickArea('高雄');">高雄<span
										class="glyphicon glyphicon-certificate" aria-hidden="true"></span></a>
									<a class="myWord"
										href="<%=request.getContextPath()%>/Trip/tripplan?area=searchArea&spot=屏東"
										onclick="return clickArea('屏東');">屏東<span
										class="glyphicon glyphicon-certificate" aria-hidden="true"></span></a>
								</div>
								<div class="col-md-6 column">
									<div id="mapDiv">
										<img
											src="<%=request.getContextPath()%>/Front/forIndex/img/taiwanMap/taiwan.png"
											width="120" height="220" usemap="#TestMap" class="twMap"
											hidefocus="true">
									</div>
								</div>
								<div class="col-md-3 column">
									<div style="height: 5px;"></div>
									<a class="myWord"
										href="<%=request.getContextPath()%>/Trip/tripplan?area=searchArea&spot=基隆"
										onclick="return clickArea('基隆');"><span
										class="glyphicon glyphicon-certificate" aria-hidden="true"></span>基隆</a>
									<a class="myWord"
										href="<%=request.getContextPath()%>/Trip/tripplan?area=searchArea&spot=台北"
										onclick="return clickArea('台北');"><span
										class="glyphicon glyphicon-certificate" aria-hidden="true"></span>台北</a>
									<a class="myWord"
										href="<%=request.getContextPath()%>/Trip/tripplan?area=searchArea&spot=新北"
										onclick="return clickArea('新北');"><span
										class="glyphicon glyphicon-certificate" aria-hidden="true"></span>新北</a>
									<a class="myWord"
										href="<%=request.getContextPath()%>/Trip/tripplan?area=searchArea&spot=桃園"
										onclick="return clickArea('桃園');"><span
										class="glyphicon glyphicon-certificate" aria-hidden="true"></span>桃園</a>
									<a class="myWord"
										href="<%=request.getContextPath()%>/Trip/tripplan?area=searchArea&spot=新竹"
										onclick="return clickArea('新竹');"><span
										class="glyphicon glyphicon-certificate" aria-hidden="true"></span>新竹</a>
									<a class="myWord"
										href="<%=request.getContextPath()%>/Trip/tripplan?area=searchArea&spot=苗栗"
										onclick="return clickArea('苗栗');"><span
										class="glyphicon glyphicon-certificate" aria-hidden="true"></span>苗栗</a>
									<div style="height: 30px;"></div>
									<a class="myWord"
										href="<%=request.getContextPath()%>/Trip/tripplan?area=searchArea&spot=宜蘭"
										onclick="return clickArea('宜蘭');"><span
										class="glyphicon glyphicon-certificate" aria-hidden="true"></span>宜蘭</a>
									<a class="myWord"
										href="<%=request.getContextPath()%>/Trip/tripplan?area=searchArea&spot=花蓮"
										onclick="return clickArea('花蓮');"><span
										class="glyphicon glyphicon-certificate" aria-hidden="true"></span>花蓮</a>
									<a class="myWord"
										href="<%=request.getContextPath()%>/Trip/tripplan?area=searchArea&spot=台東"
										onclick="return clickArea('台東');"><span
										class="glyphicon glyphicon-certificate" aria-hidden="true"></span>台東</a>
								</div>
							</div>
							<!-- mapWrapper_off -->
							<map name="TestMap">
								<area id="pingtung" shape="poly"
									coords="47,212,50,211,53,207,53,200,53,195,48,193,47,187,47,182,45,175,47,168,51,166,54,164,52,161,48,157,42,158,38,158,34,160,30,161,28,165,27,171,28,174,29,179,28,183,33,185,37,190,40,195,42,199,43,203,43,208"
									href="<%=request.getContextPath()%>/Trip/tripplan?area=searchArea&spot=屏東"
									onclick="return clickArea('屏東');" />
								<area id="kaohsiung" shape="poly"
									coords="14,153,15,157,16,162,18,166,18,171,19,175,25,177,26,171,26,165,30,160,35,157,42,155,48,155,50,149,52,143,54,137,54,133,58,131,60,126,59,121,54,124,47,129,40,131,38,137,37,141,33,145,29,149,23,152,17,152"
									href="<%=request.getContextPath()%>/Trip/tripplan?area=searchArea&spot=高雄"
									onclick="return clickArea('高雄');" />
								<area id="tainan" shape="poly"
									coords="14,151,18,151,25,150,29,147,32,144,35,142,37,136,34,133,31,131,32,128,31,126,27,122,24,122,20,124,16,127,14,130,11,130,8,133,7,137,8,142,9,146"
									href="<%=request.getContextPath()%>/Trip/tripplan?area=searchArea&spot=台南"
									onclick="return clickArea('台南');" />
								<area id="chiayi" shape="poly"
									coords="33,129,34,133,37,135,40,131,42,128,45,128,48,126,52,123,56,120,58,118,53,118,50,118,49,114,48,111,42,109,38,112,34,111,30,109,26,109,21,111,16,114,14,117,12,121,13,125,14,127"
									href="<%=request.getContextPath()%>/Trip/tripplan?area=searchArea&spot=嘉義"
									onclick="return clickArea('嘉義');" />
								<area id="yunlin" shape="poly"
									coords="12,118,10,113,12,108,16,102,19,99,26,99,31,99,38,100,39,103,39,107,40,111,33,110,28,109,23,109,17,112,14,116"
									href="<%=request.getContextPath()%>/Trip/tripplan?area=searchArea&spot=雲林"
									onclick="return clickArea('雲林');" />
								<area id="changhua" shape="poly"
									coords="16,97,19,96,26,96,30,98,37,99,41,101,41,96,37,94,39,90,40,85,35,81,31,77,28,81,25,85,21,89,19,93"
									href="<%=request.getContextPath()%>/Trip/tripplan?area=searchArea&spot=彰化"
									onclick="return clickArea('彰化');" />
								<area id="taichung" shape="poly"
									coords="41,85,44,84,48,82,50,79,54,79,59,77,63,76,68,73,73,72,78,72,82,70,85,66,81,63,75,61,70,62,65,67,61,68,58,65,55,64,53,68,51,69,48,67,44,64,41,60,37,60,37,63,36,67,32,70,32,75,34,78,38,81"
									href="<%=request.getContextPath()%>/Trip/tripplan?area=searchArea&spot=台中"
									onclick="return clickArea('台中');" />
								<area id="miaoli" shape="poly"
									coords="42,59,44,62,46,64,51,67,53,65,54,62,59,63,61,66,63,67,68,64,73,61,74,57,71,55,66,55,62,52,62,48,59,44,56,42,51,43,48,44,47,47,45,50,44,54,43,56"
									href="<%=request.getContextPath()%>/Trip/tripplan?area=searchArea&spot=苗栗"
									onclick="return clickArea('苗栗');" />
								<area id="hsinchu" shape="poly"
									coords="53,41,57,41,60,43,62,46,63,49,64,51,65,53,68,54,71,54,73,55,76,57,76,60,79,53,80,51,79,46,77,43,74,39,69,35,64,30,59,30,55,34,54,38"
									href="<%=request.getContextPath()%>/Trip/tripplan?area=searchArea&spot=新竹"
									onclick="return clickArea('新竹');" />
								<area id="taoyuan" shape="poly"
									coords="81,49,84,46,87,43,85,39,84,34,80,32,77,29,79,25,82,24,83,22,80,21,78,18,74,17,70,19,66,21,62,24,61,28,65,29,69,32,70,34,73,37,76,41,79,44"
									href="<%=request.getContextPath()%>/Trip/tripplan?area=searchArea&spot=桃園"
									onclick="return clickArea('桃園');" />
								<area id="keelung" shape="poly"
									coords="99,14,101,16,102,17,100,18,98,18,97,14" href="#基隆"
									href="<%=request.getContextPath()%>/Trip/tripplan?area=searchArea&spot=基隆"
									onclick="return clickArea('基隆');" />
								<area id="newpei" shape="poly"
									coords="90,17,93,15,94,16,94,19,95,19,96,21,96,23,95,24,93,24,91,23,89,18,90,16"
									href="#台北"
									href="<%=request.getContextPath()%>/Trip/tripplan?area=searchArea&spot=新北"
									onclick="return clickArea('新北');" />
								<area id="taipei" shape="poly"
									coords="88,43,91,41,93,40,94,36,97,35,100,34,104,32,107,28,110,25,113,24,111,20,108,16,103,17,100,13,95,9,91,6,86,6,84,12,82,15,78,16,81,19,83,22,83,26,80,27,78,29,79,31,83,33,86,37,87,39"
									href="<%=request.getContextPath()%>/Trip/tripplan?area=searchArea&spot=台北"
									onclick="return clickArea('台北');" />
								<area id="ilan" shape="poly"
									coords="105,31,105,34,106,39,106,43,107,46,108,50,108,53,107,57,103,61,103,66,100,67,96,65,93,64,92,66,88,66,83,64,80,61,75,60,79,56,82,52,84,48,88,45,94,42,97,37,102,34"
									href="<%=request.getContextPath()%>/Trip/tripplan?area=searchArea&spot=宜蘭"
									onclick="return clickArea('宜蘭');" />
								<area id="hualien" shape="poly"
									coords="86,67,89,67,92,68,96,66,99,68,100,70,96,75,94,79,93,82,95,85,95,88,93,93,91,96,91,101,91,104,88,110,87,117,86,120,83,124,80,128,77,133,76,138,74,141,68,134,64,131,60,127,61,121,61,116,68,115,73,108,72,102,73,97,75,94,75,89,72,87,75,83,79,81,78,76,82,72"
									href="<%=request.getContextPath()%>/Trip/tripplan?area=searchArea&spot=花蓮"
									onclick="return clickArea('花蓮');" />
								<area id="taitung" shape="poly"
									coords="85,122,85,128,80,130,82,135,79,141,77,144,77,148,73,151,70,157,67,162,62,166,58,167,57,172,56,176,55,180,54,184,51,187,52,191,52,194,48,193,46,189,47,184,47,180,46,176,45,171,47,168,53,166,54,162,53,158,51,153,50,149,52,145,54,140,55,134,56,130,61,130,63,132,66,135,69,139,73,141"
									href="<%=request.getContextPath()%>/Trip/tripplan?area=searchArea&spot=台東"
									onclick="return clickArea('台東');" />
								<area id="nantou" shape="poly"
									coords="72,73,75,73,78,73,76,76,76,78,78,82,74,83,71,86,71,90,74,92,74,96,71,98,70,101,71,104,73,108,71,111,67,113,64,117,59,116,52,118,48,115,47,110,43,108,39,110,40,104,43,101,43,97,40,93,39,89,42,87,46,85,50,83,52,81,57,80,61,79,65,77,69,75"
									href="<%=request.getContextPath()%>/Trip/tripplan?area=searchArea&spot=南投"
									onclick="return clickArea('南投');" />
							</map>

						</div>
						<!-- Map_div_off -->
						<div class="row clearfix" style="margin-top: 10px; text-align: center; border: 1px solid #cccccc;">
							<label><p class="text-info">景點表</p></label>
								<a href="#" id="my"><img src="<%=request.getContextPath()%>/Front/forIndex/img/icons/idea13.jpg"/></a>
							<div id="tabs"
								style="margin-top: 10px; text-align: center; border: 1px solid #cccccc;">
								<ul>
									<c:forEach var="i" begin="1" end="${fn:length(viewName)}">
										<li><a href='#tabs-${i}' id="tab${i}" onclick="tabNumber(${i});checkIt()">${i}</a></li>

									</c:forEach>
								</ul>
								<%
									TreeMap<String, ArrayList<String>> map = (TreeMap) request
											.getAttribute("viewName");
									TreeMap<String, ArrayList<String>> viewAddr = (TreeMap) request
											.getAttribute("viewAddr");
									TreeMap<String, ArrayList<Integer>> viewNo = (TreeMap) request
											.getAttribute("viewNo");
									
									for (int i = 1; i <= map.size(); i++) {
										out.println("<div id='tabs-" + i + "'>");
										out.println("<ul id='sortable"+i+"' class='sortable' id='sortable'  >");
										ArrayList<String> day = map.get("day" + i);
										ArrayList<Integer> spot = viewNo.get("day" + i);
										int count = 0;
										
										for (int j=0;j<day.size();j++) {
											out.println("<li id='li"+spot.get(j)+"' class='ui-state-default'><span class='ui-icon ui-icon-arrowthick-2-n-s'></span><button type='button' class='close' style=\"line-height:10px;\" data-dismiss='modal'name='addButton' aria-hidden='true' onclick='removeView(\""+spot.get(j)+"\")')'>X</button><input type='hidden' name='day"+i+"' id='"
													+day.get(j)+"' value='"+spot.get(j)+"'>"
													+ day.get(j)+ "</li>");
											out.println("<input type='hidden' class='viewName" + i
													+ "' value=" + day.get(j) + ">");
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
							<div style="text-align: center;">
									<input type="button" class="btn btn-primary" value="行程規劃"
										onclick="btnTrip()" style="font-size: 12px;"> <input
										type="hidden" name="tripplan" value="tripplan"> <input
										type="hidden" name="days">
										<input type="hidden" name="tripName" value="${tripName}">
										<input type="hidden" name="tripno" value="${tripno}">
								</div>
						</div>
					</div>
					<!-- col-md-3_off -->
					<div id="showDiv" class="col-md-9 column">
						<div style="margin-left: 20px;">
							<h3 style="font-family:微軟正黑體"><p class="text-danger">讀取中</p></h3>
							<jsp:include page="spotView.jsp" />
						</div>
					</div>
				</div>
			</div>
		</form>
	</div>

	<!-- container_off -->
</body>
</html>
									

