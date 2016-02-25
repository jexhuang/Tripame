<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.rec.model.*"%>
<%@ page import="com.mem.model.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="memvo" scope="session" class="com.mem.model.MemVO" />
<jsp:useBean id="recsvc" class="com.rec.model.RecService" />
<html>
<head>
<%
	List<RecVO> list=recsvc.getAll();
int c=0;
for(RecVO recvo:list){
	if(recvo.getMemno().equals(memvo.getMemno())){
		c=1;
	}
}
pageContext.setAttribute("list", list);
pageContext.setAttribute("c", c);
response.setHeader("Cache-Control", "no-store");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);
%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>推薦旅遊點列表</title>
</head>
<jsp:include page="/Front/select_page.jsp" />
<script type="text/javascript">
	function blinklink() {
		if (!document.getElementById('blink').style.color) {
			document.getElementById('blink').style.color = "red"
		}
		if (document.getElementById('blink').style.color == "red") {
			document.getElementById('blink').style.color = "yellow"
		} else {
			document.getElementById('blink').style.color = "red"
		}
		timer = setTimeout("blinklink()", 300)
	}
</script>
<body onload="blinklink()">
	<div class="container">
	<ol class="breadcrumb">
			<li><a href="<%=request.getContextPath()%>/Front/front_index.jsp">首頁</a></li>
			<li><a href="<%=request.getContextPath()%>/Front/Trip/memRoute.jsp">會員專區</a></li>
			<li class="active">我的推薦旅遊點</li>
		</ol>
		<c:if test="${c<1 }">
			<div class="jumbotron" style="background-color: black;">
				<a id="blink" href="<%=request.getContextPath()%>/Front/Rec/AddNewRec.jsp">
				<h1 align="center"  style="font-family:微軟正黑體">新增您的第一個推薦旅遊點吧!</h1>
				</a>			
			</div>
		</c:if>
		<c:if test="${c>0}">
		<table class="table table-bordered">
			<tr>
				<th>照片</th>
				<th>名稱</th>
				<th>狀態</th>
				<th>回覆訊息</th>
				<th></th>
			</tr>
			<%@ include file="pages/page1.file"%>
			<c:forEach var="recvo" items="${list}" begin="<%=pageIndex%>"
				end="<%=pageIndex+rowsPerPage-1%>">
				<c:if test="${recvo.memno==memvo.memno }">
					<tr align='center' valign='middle'>
						<td><img
							src="<%=request.getContextPath()%>/rec/RecPicReader?recno=${recvo.recno}"
							height="160" width="284"></td>
						<td style="line-height: 140px;">${recvo.recname}</td>
						<td style="line-height: 140px;">${recvo.recstatus}</td>
						<td style="line-height: 140px;">${recvo.recmessage}</td>
						<td><br>
							<FORM METHOD="post"
								ACTION="<%=request.getContextPath()%>/rec/RecServlet">
								<input type="submit" value="檢視旅遊點" class="btn btn-info">
								<input type="hidden" name="recno" value="${recvo.recno}">
								<input type="hidden" name="action" value="UpdateOneRecByMemno">
							</FORM> <br>
							<FORM METHOD="post"
								ACTION="<%=request.getContextPath()%>/rec/RecServlet">
								<input type="submit" value="刪除旅遊點" class="btn btn-danger">
								<input type="hidden" name="recno" value="${recvo.recno}">
								<input type="hidden" name="action" value="deleteOneRecByMemno">
							</FORM></td>
					</tr>
				</c:if>
			</c:forEach>
		</table>
		<a class="btn btn-primary" href="<%=request.getContextPath()%>/Front/Rec/AddNewRec.jsp" role="button">
		新增旅遊點
		</a>
		<%@ include file="pages/page2.file"%>
		</c:if>
	</div>
</body>
</html>