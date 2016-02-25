<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8"/>
<title>Google Maps JavaScript API Example</title>
<script src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=ABQIAAAAG_4i2swR3KOd-nGYrlrt8RTkyS8SRe_kYPTAbwTumvAqao01PRRUcCtCzTBnNH2kRURGR8RhQQoZ3w"
      type="text/javascript"></script>
<script type="text/javascript">
function getaddressInfo(){	
	  //===實作(填入程式碼)
		var xhr=new XMLHttpRequest();
	  //設定好回呼函數 
	  xhr.onreadystatechange=function(){
		  if(xhr.readyState==4){
			  if(xhr.status==200){
				  document.getElementById('address').value=xhr.responseText;
				  }
			  else{
				  alert(xhr.status);
				  }
			  }
		  }
	  //建立好Get連接與送出請求
		var url="<%=request.getContextPath()%>/act/Activity_Servlet?action=address&con="+document.getElementsByName("country")[0].value+"&dis="+document.getElementsByName("district")[0].value;
		xhr.open("Get",url,true);
		xhr.send(null);
	};

var myMap;
var myMarker
function load() {
	if (GBrowserIsCompatible())
	{
		myMap = new GMap2(document.getElementById("my_map"));
		var myLatLng = new GLatLng(25.04763902653048, 121.51715755462646);
		myMap.setCenter(myLatLng, 15);
		myMap.addControl(new GLargeMapControl());
		document.getElementById('inLat').value = myLatLng.lat();
		document.getElementById('inLng').value = myLatLng.lng();		
		
		myMarker = new GMarker( myLatLng );
		myMap.addOverlay( myMarker );
	}
}

function addressGps() {
	var myGeocoder = new GClientGeocoder();
	var address = document.getElementById('address').value;
	myGeocoder.getLatLng(address, function getRequest( point ){
							if(!point){
								alert('這個地址 Google 說不知道！');
							}else{
								//移動地圖中心點
								myMap.panTo( point );
								//設定標註座標
								myMarker.setLatLng(point);
								document.getElementById('inLat').value = point.lat();
								document.getElementById('inLng').value = point.lng();
							}
						});
	
}
</script>
</head>
<body onload="load()" onunload="GUnload()">
<div class="form-group">
	<label class="col-sm-2 control-label"></label>
	<div class="col-sm-10">
		<input id="address" name="actaddress" placeholder="輸入地址" maxlength="50" class="form-control" type="text" value="${ActVO.actaddress }" onclick="getaddressInfo();" onchange="addressGps();" />
		<input id="inLat" name="actlat" type="hidden"/>
		<input id="inLng" name="actlong" type="hidden"/>
	</div>	
</div>
<div class="form-group">
	<label class="col-sm-2 control-label"></label>
	<div class="col-sm-10"><div id="my_map" style="width: 460px; height: 300px"></div>	</div>
</div>
</body>
</html>