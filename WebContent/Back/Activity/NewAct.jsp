<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.activity.model.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>新增活動</title>
<jsp:include page="/Back/back_index.jsp"/>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.11.2/themes/smoothness/jquery-ui.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
<script src="<%=request.getContextPath()%>/Back/Spot/js/jquery.twzipcode.min.js"></script>

<!-- <script src="http://code.jquery.com/jquery-1.10.2.js"></script> -->
<script src="http://code.jquery.com/ui/1.11.2/jquery-ui.js"></script>
<script type="text/javascript">
$(function () 
		{
		    $('#contown').twzipcode(
		    {
				countyName: "country",
		        districtName: "district",
				countySel: "${ActVO.actcon}",
		        districtSel: "${ActVO.acttown}"
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

$(function() {
    $( "#from" ).datepicker({
      defaultDate: "+1w",
      changeMonth: true,
      numberOfMonths: 1,
      dateFormat: 'yy-mm-dd',
      onClose: function( selectedDate ) {
        $( "#to" ).datepicker( "option", "minDate", selectedDate );
      }
    });
    $( "#to" ).datepicker({
      defaultDate: "+1w",
      changeMonth: true,
      numberOfMonths: 1,
      dateFormat: 'yy-mm-dd',
      onClose: function( selectedDate ) {
        $( "#from" ).datepicker( "option", "maxDate", selectedDate );
      }
    });
  });
function insert() {
	document.getElementsByName("actname")[0].value = "資策會JAVA班結訓";
	document.getElementsByName("actphone")[0].value = "03-4257387";
	document.getElementsByName("actsite")[0].value = "http://chungli2.iiiedu.org.tw/chungli/";
	document.getElementsByName("actorg")[0].value = "資策會中壢中心";
	document.getElementsByName("acthours")[0].value = "0912";
	document.getElementsByName("actprice")[0].value = "0";
	document.getElementsByName("actstay")[0].value = "180";
	document.getElementsByName("actcontent")[0].value = "YA101結訓的同學，在老師熱忱指導與解題、如沐春風的指導下，個個都擁有不凡身手，期待蒞臨的廠商貴賓能夠一個不留的，把YA101的同學都錄取吧!地址：桃園市中壢區中大路300號";
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
	<h2>活動管理</h2>
		<ol class="breadcrumb" style="background-color: rgb(66, 139, 202)">
			<li><a href="<%=request.getContextPath()%>/Back/back_index.jsp"
				style="color: white;">首頁</a></li>
			<li><a href="<%=request.getContextPath()%>/Back/Activity/SearchAct.jsp"
				style="color: white;">活動管理</a></li>
			<li class="active" style="color: white;">新增活動</li>
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
	<form class="form-horizontal" action="<%=request.getContextPath() %>/act/Activity_Servlet" method=post enctype="multipart/form-data">
	<table>
		<tr>
			<td width=500px>
				<div class="form-group">
					<label class="col-sm-4 control-label">上傳圖片</label>
					<div class="col-sm-8">			
						<img id="myPic" class="img-thumbnail" style="width: 300px; height: 300px"/> 
						<input type="file" id="pic" name="actpic" onChange="showPic()" />
					</div>		
				</div>
			</td>
			<td width=500px>
			<br>
				<div class="form-group">
					<label class="col-sm-3 control-label">名稱</label>
					<div class="col-sm-9">
						<input type="text" name="actname" value="${ActVO.actname }" class="form-control" maxlength="20">
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-3 control-label">電話</label>
					<div class="col-sm-9">
						<input type="text" name="actphone" value="${ActVO.actphone }" class="form-control" maxlength="20">
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-3 control-label">官網</label>
					<div class="col-sm-9">
						<input type="text" name="actsite" value="${ActVO.actsite }" class="form-control" maxlength="100">
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-3 control-label">主辦單位</label>
					<div class="col-sm-9">
						<input type="text" name="actorg" class="form-control" value="${ActVO.actorg }" maxlength="20">
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-3 control-label">開業時間</label>
					<div class="col-sm-9">
						<input type="text" name="acthours" class="form-control" value="${ActVO.acthours }" maxlength="10">
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-3 control-label">價格</label>
					<div class="col-sm-9">
						<input type="text" name="actprice" class="form-control" value="${ActVO.actprice }" maxlength="10">
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-3 control-label">停留時間(分鐘)</label>
					<div class="col-sm-5">
						<input type="text" name="actstay" value="${ActVO.actstay }" class="form-control" maxlength="10">
					</div>
					<label class="col-sm-2 control-label">狀態</label>
					<div class="col-sm-2">
						<select name="actstatus">
							<option ${(ActVO.actstatus=="上架")? 'selected':'' }>上架</option>
							<option ${(ActVO.actstatus=="下架")? 'selected':'' }>下架</option>
						</select>
					</div>
				</div>	
			</td>
		</tr>
		<tr>
			<td colspan=2 width=500px>
				<div class="form-group">
					<label class="col-sm-2 control-label">活動日期</label>
					<div class="col-sm-2">
						<input type="text" id="from" name="actbegin" class="form-control" value="${ActVO.actbegin }">				
					</div>
					<div class="col-sm-2">
						<input type="text" id="to" name="actend" class="form-control" value="${ActVO.actend }">
					</div>
				</div>
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
						<Textarea rows="10" name="actcontent" class="form-control">${ActVO.actcontent }</Textarea>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-2 control-label"></label>
					<div class="col-sm-5">
						<input type="submit" value="確認" class="btn btn-default">
						<a class="btn btn-default" href="<%=request.getContextPath()%>${param.requestURL}" role="button" >取消</a>
						<input type="button" value="神奇小按鈕" onclick="insert()" class="btn btn-primary" />
					</div>
				</div>
			</td>
		</tr>
	</table>	
	<input type="hidden" name="action" value="insert">
	<%session.removeAttribute("list"); %>
	<input type="hidden" name="requestURL" value="${param.requestURL}">
	</form>	
</div>
</body>
</html>