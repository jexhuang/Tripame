<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.spot.model.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="">
<meta name="author" content="">

<style>
h3, h5 {
	font-family: '微軟正黑體';
}

h3 {
	color: #4F8CCA;
	text-shadow: 3px 3px 3px #cccccc;
}

.resultDiv {
	width: 250px;
	height: 220px;
	padding: 4.5px;
	margin-left: 15px;
	margin-bottom: 15px;
	float: left;;
	box-shadow: 2px 2px 5px 2px #cccccc;
	border-radius: 10px;
}

a img:hover {
	opacity: 0.85;
}

#photoFrame {
	border: 2px solid #cccccc;
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
</style>
<script>
$(function() {
	viewClick=false;
});
function removeView(spotno){
    	var name = "#li"+spotno;
        $(name).remove();
        
};

function writeHTML(obj,spotno,spotname){
	obj.innerHTML=obj.innerHTML+"<li id='li"+spotno+"' class=\"ui-state-default\"><span class=\"ui-icon ui-icon-arrowthick-2-n-s\"></span>"
								+spotname+"<button type='button' class='close' style=\"line-height:10px;\" data-dismiss='modal'name='addButton' aria-hidden='true' onclick='removeView(\""+spotno+"\")')'>X</button><input type='hidden' name='day"+tabStatus+"' id='"
								+spotno+"' value='"+spotno+"'></li>";
	viewClick=true;
}

function detail(spotno,spotname){
	var name = "sortable"+tabStatus;
	var obj = document.getElementById(name);
	if('${tripno}'!=""){
		viewArray[count]=spotno;
		writeHTML(obj,spotno,spotname);
	}else{
		if(diff==0){
			alert("請選擇開始與結束日期");
			return;
		}
		if (clickEndDate==false){
				alert("請選擇開始與結束日期");
		}else{
			viewArray[count]=spotno;
			writeHTML(obj,spotno,spotname);
		}
	}
}
</script>

</head>
<body>
	<%
		int count = 0;
	%>
	<c:forEach var="spotVO" items="${spotList}">
		<div class="resultDiv">
			<button type="button" class="close" data-dismiss="modal"
				name="addButton" aria-hidden="true"
				onclick="detail(${spotVO.spotno},'${spotVO.spotname}')">+</button>

			<p align="center">
				<b>${spotVO.spotname}</b>
			</p>
			<div id="photoFrame">
				<a href="#<%=count%>" role="button" class="btn" data-toggle="modal"><img
					src="<%=request.getContextPath()%>/spot/SpotList_Img?spotno=${spotVO.spotno}"
					width="215" title='詳細資訊' height="160"></a>
			</div>
			<!-- Modal -->
			<div class="modal fade" id="<%=count%>" tabindex="1" role="dialog"
				aria-labelledby="myModalLabel" aria-hidden="true">
				<div class="modal-dialog" style="width: 1024px">
					<div class="modal-content" style="height: 820px;">
						<div class="modal-header">
							<button type="button" id="close" class="close"
								data-dismiss="modal" aria-hidden="true">×</button>
							<h4 class="modal-title" id="myModalLabel">
								<h3>
									<b>${spotVO.spotname}</b>
								</h3>
							</h4>
						</div>
						<div class="modal-body" style="height: 630px;">
							<div style="float: left; margin-right: 20px;">
								<div>
									<img
										src="<%=request.getContextPath()%>/spot/SpotList_Img?spotno=${spotVO.spotno}"
										width="500" height="300">
								</div>
								<div>
									<br>
									<h5>
										<p>
											<b>地址：</b>${spotVO.spotaddress}</p>
										<br>
										<p>
											<b>電話：</b>${spotVO.spotphone}</p>
										<br>
										<p>
											<b>官網：</b><a href="${spotVO.spotsite}" target="_blank">${spotVO.spotsite}</a>
										</p>
										<br>
										<p>
											<b>${spotVO.spotclass}分類:</b>${spotVO.spotsort}</p>
										<br>
										<p>
											<b>經緯度：</b>(N:${spotVO.spotlat}, E:${spotVO.spotlong})
										</p>
									</h5>
									<br>
								</div>

							</div>
							<div>
								<p>
									<b><h3>簡介</h3></b>
								</p>
								${spotVO.spotcontent}
							</div>
							<br>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default"
								data-dismiss="modal">取消</button>
							<button type="button" class="btn btn-primary"
								data-dismiss="modal" onclick="detail(${spotVO.spotno},'${spotVO.spotname}')">我要去</button>
						</div>
					</div>

				</div>
			</div>
			<!-- 彈跳視窗_end -->
		</div>
		<%
			count++;
		%>
	</c:forEach>
</body>
</html>