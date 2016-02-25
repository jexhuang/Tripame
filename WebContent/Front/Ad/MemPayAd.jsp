<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>購買行程</title>
</head>
<jsp:include page="/Front/select_page.jsp" />
<script>
	function card() {
		document.getElementById("c").style.display = "";
		document.getElementById("a").style.display = "none";
	}
	function atm() {
		document.getElementById("c").style.display = "none";
		document.getElementById("a").style.display = "";
	}
	$(function() {
	    $('#to').datepicker( {
	        changeMonth: true,
	        changeYear: true,
	        showButtonPanel: true,
	        dateFormat: 'yy-mm',
	        onClose: function(dateText, inst) { 
	            var month = $("#ui-datepicker-div .ui-datepicker-month :selected").val();
	            var year = $("#ui-datepicker-div .ui-datepicker-year :selected").val();
	            $(this).datepicker('setDate', new Date(year, month, 1));
	        }
	    });
	});
</script>
<body onload="card()">
	<div class="container">
	<ol class="breadcrumb">
			<li><a href="<%=request.getContextPath()%>/Front/front_index.jsp">首頁</a></li>
			<li><a href="<%=request.getContextPath()%>/Front/Trip/memRoute.jsp">會員專區</a></li>
			<li><a href="<%=request.getContextPath()%>/Front/Ad/ListAdsByMemno.jsp">我的廣告</a></li>
			<li class="active">廣告付款</li>
		</ol>
		<table class="table">
			<caption align="right">退款方式</caption>
			<tr>
				<td>會員姓名:</td>
				<td>${memvo.memname }</td>
			</tr>
			<tr>
				<td>退款方式</td>
				<td><input type="radio" name="pay" value="b" onclick="card()">信用卡
					<input type="radio" name="pay" value="c" onclick="atm()">ATM轉帳<br>
				<br> <span id="c"> 信用卡號:<input type="text" name="no"
						maxlength="15"><br>
					<br> 到期年月:<input type="text" id="to" maxlength="15">
				</span> <span id="a"> 銀行代號:<input type="text" maxlength="15"><br>
					<br> 扣款帳號:<input type="text" name="no" maxlength="15">
				</span></td>
			</tr>
			<tr>
			<td>
					<FORM METHOD="post"
						ACTION="<%=request.getContextPath()%>/Front/Ad/ListAdsByMemno.jsp">
						<input type="button" name="button" class="btn btn-success" value="確認" onclick="if(confirm('確認要購買廣告嗎？')) this.form.submit();">
					</FORM>
				</td>
				<td><a class="btn btn-success"
					href="<%=request.getContextPath()%>/Front/Ad/ListAdsByMemno.jsp"
					role="button">取消</a></td>
				
			</tr>
		</table>
	</div>
</body>
</html>