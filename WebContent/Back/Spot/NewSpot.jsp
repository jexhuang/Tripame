<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; utf-8">
<title>新增旅遊點</title>
<style type="text/css">
.hide {display: none}
</style>
<jsp:include page="/Back/back_index.jsp"/>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
<script src="<%=request.getContextPath()%>/Back/Spot/js/jquery.twzipcode.min.js"></script>
<script type="text/javascript">
$(function () 
		{
		    $('#contown').twzipcode(
		    {
				countyName: "country",
		        districtName: "district",
				countySel: "${SpotVO.spotcon}",
		        districtSel: "${SpotVO.spottown}"
		    });
		});
function showPic() {
	var reader = new FileReader();
	reader.onload = function(event) 
	{
		document.getElementById("myPic").src = event.target.result;
	};
		reader.readAsDataURL(document.getElementById("pic").files[0]);
}
function insert() {
	document.getElementsByName("spotname")[0].value = "中央大學";
	document.getElementsByName("spotphone")[0].value = "03-4227151";
	document.getElementsByName("spotsite")[0].value = "http://www.ncu.edu.tw/";
	document.getElementsByName("spotstay")[0].value = "180";
	document.getElementsByName("spotcontent")[0].value = "中壢市放風箏的地點，以中央大學校園最適合，全校占地60公頃，校內有座中大湖，池中有各式大小錦魚，可以利用魚食或麵包餵食，大草坪上則可以放風箏。中大校門口筆直的中大路上，道路兩側植栽木棉樹，每年3、4月間木棉花盛開，美不勝收，市公所還規畫行人步道，兩側有茶藝館、客家美食餐廳、鴕鳥餐廳和高爾夫球練習場等，每逢假日都吸引許多遊客前往休憩。地址：桃園市中壢區中大路300號 ";
}
</script>
<style>
textarea {
	resize: none;
}
</style>
</head>
<body>
<div class="container">
	<h2>旅遊點管理</h2>
		<ol class="breadcrumb" style="background-color: rgb(66, 139, 202)">
			<li><a href="<%=request.getContextPath()%>/Back/back_index.jsp"
				style="color: white;">首頁</a></li>
			<li><a href="<%=request.getContextPath()%>/Back/Spot/SearchSpot.jsp"
				style="color: white;">旅遊點管理</a></li>
			<li class="active" style="color: white;">新增旅遊點</li>
		</ol>
	<div class="col-sm-offset-2">		
		<div>
		<c:if test="${errorMsgs!=null }">
		<span>請修正以下錯誤</span>
			<ul>
				<c:forEach var="message" items="${errorMsgs}">
				<li style="color:red;">${message }
				</c:forEach>
			</ul>
		</c:if>			
		</div>
	</div>
						
	<form class="form-horizontal" action="<%=request.getContextPath() %>/spot/Spot_Servlet" method=post enctype="multipart/form-data">
	<table>
		<tr>
			<td width="500px">
				<div class="form-group">
					<label class="col-sm-4 control-label">上傳圖片</label>
					<div class="col-sm-8">			
						<img id="myPic" class="img-thumbnail" style="width: 300px; height: 300px"/> 
						<input type="file" id="pic" name="spotpic" onChange="showPic()" />
					</div>		
				</div>
			</td>
			<td width="500px">
			<br>
				<jsp:include page="SelectClass.jsp"/>	
				<div class="form-group">
					<label class="col-sm-2 control-label">名稱</label>
					<div class="col-sm-10">
						<input type="text" name="spotname" value="${SpotVO.spotname }" class="form-control" maxlength="50">
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label">電話</label>
					<div class="col-sm-10">
						<input type="text" name="spotphone" value="${SpotVO.spotphone }" class="form-control" maxlength="20">
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label">官網</label>
					<div class="col-sm-10">
						<input type="text" name="spotsite" value="${SpotVO.spotsite }" class="form-control" maxlength="150">
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label">停留時間(分鐘)</label>
					<div class="col-sm-5">
						<input type="text" name="spotstay" value="${SpotVO.spotstay }" class="form-control" maxlength="10">
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label">狀態</label>
					<div class="col-sm-2">
						<select name="spotstatus">
						<option ${(SpotVO.spotstatus=="上架")? 'selected':'' }>上架</option>
						<option ${(SpotVO.spotstatus=="下架")? 'selected':'' }>下架</option>
					</select>
				</div>
		</div>
			</td>
		</tr>
		<tr>
			<td class="col-sm-12" colspan="2" width="500px">
				<div class="form-group">		
					<label class="col-sm-2 control-label">地址</label>
					<div class="col-sm-4">
						<div id="contown">
		    				<div data-role="zipcode" data-style="hide"></div> 
		    			</div>	    		
					</div>			  			
				</div>
				<jsp:include page="Lat_Long.jsp"/>
				<div class="form-group">
					<label class="col-sm-2 control-label">簡介</label>
					<div class="col-sm-10">
						<Textarea rows="10" name="spotcontent" class="form-control">${SpotVO.spotcontent }</Textarea>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label"></label>
					<div class="col-sm-5">
						<input type="submit" value="確認" class="btn btn-default">
						<% session.removeAttribute("list"); %>
						<a class="btn btn-default" href="<%=request.getContextPath()%>${param.requestURL}" role="button" >取消</a>
						<input type="button" value="神奇小按鈕" onclick="insert()" class="btn btn-primary" />
					</div>
				</div>
			</td>
		</tr>
	</table>		
		<input type="hidden" name="spotlook" value="0">
		<input type="hidden" name="action" value="insert">
		<input type="hidden" name="requestURL" value="${param.requestURL}">
	</form>	
</div>
</body>
</html>