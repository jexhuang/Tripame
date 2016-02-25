<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.activity.model.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>修改活動</title>
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
			<li class="active" style="color: white;">修改活動</li>
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
						<img id="myPic" class="img-thumbnail" src="<%=request.getContextPath() %>/act/ActList_Img?actno=${ActVO.actno}" style="width: 300px; height: 300px"/> 
						<input type="file" id="pic" name="actpic" onChange="showPic()" />
					</div>		
				</div>
			</td>
			<td width=500px>
				<div class="form-group">
					<label class="col-sm-3 control-label">活動編號</label>
					<div class="col-sm-9">
						<span>${ActVO.actno }</span>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-3 control-label">名稱</label>
					<div class="col-sm-9">
						<input type="text" name="actname" value="${ActVO.actname }" class="form-control">
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-3 control-label">電話</label>
					<div class="col-sm-9">
						<input type="text" name="actphone" value="${ActVO.actphone }" class="form-control">
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-3 control-label">官網</label>
					<div class="col-sm-9">
						<input type="text" name="actsite" value="${ActVO.actsite }" class="form-control">
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-3 control-label">主辦單位</label>
					<div class="col-sm-9">
						<input type="text" name="actorg" class="form-control" value="${ActVO.actorg }">
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-3 control-label">開業時間</label>
					<div class="col-sm-9">
						<input type="text" name="acthours" class="form-control" value="${ActVO.acthours }">
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-3 control-label">價格</label>
					<div class="col-sm-9">
						<input type="text" name="actprice" class="form-control" value="${ActVO.actprice }">
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-3 control-label">停留時間(分鐘)</label>
					<div class="col-sm-5">
						<input type="text" name="actstay" value="${ActVO.actstay }" class="form-control">
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
					<input type="text" name="actbegin" id="from" class="form-control" value="${ActVO.actbegin }">				
				</div>
				<div class="col-sm-2">
					<input type="text" name="actend" id="to" class="form-control" value="${ActVO.actend }">
				</div>
			</div>
				<div class="form-group">		
					<label class="col-sm-2 control-label">地址</label>
					<div class="col-sm-4">
						<div id="contown"><div data-role="zipcode" data-style="hide"></div> 
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
					<div>
						<input type="submit" value="確認" class="btn btn-default">
						<a class="btn btn-default" href="<%=request.getContextPath()%>${param.requestURL}" role="button" >取消</a>
					</div>
				</div>
			</td>
		</tr>
	</table>	
	<input type="hidden" name="action" value="update">
	<input type="hidden" name="isupdate" value="yes">
	<input type="hidden" name="actno" value="${ActVO.actno }">
	<input type="hidden" name="requestURL" value="${param.requestURL}">
	</form>	
</div>
</body>
</html>