<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>修改文章</title>
</head>
<jsp:include page="/Front/select_page.jsp" />
<body>
	<div class="container">
		<div class="col-sm-offset-2">
			<c:if test="${not empty errorMsgs}">
						請先修正以下錯誤:<br>
				<p class="help-block">
					<c:forEach var="message" items="${errorMsgs}">
							${message}<br>
					</c:forEach>
				</p>
			</c:if>
		</div>
		<form class="form-horizontal" role="form"
			action="<%=request.getContextPath()%>/forums/ForumsServlet" method="post">
			<div class="form-group">
				<label class="col-sm-2 control-label">類別:</label>
				<div class="col-sm-2">
					<select name="forclass" class="form-control">
						<option value="美食" ${(forvo.forclass=='美食')?'selected':''}>美食</option>
						<option value="住宿" ${(forvo.forclass=='住宿')?'selected':''}>住宿</option>
						<option value="景點" ${(forvo.forclass=='景點')?'selected':''}>景點</option>
						<option value="交通" ${(forvo.forclass=='交通')?'selected':''}>交通</option>
						<option value="活動" ${(forvo.forclass=='活動')?'selected':''}>活動</option>
					</select>
				</div>
				<label class="col-sm-1 control-label" for="theme">主題:</label>
				<div class="col-sm-4">
					<input type="text" name="theme" id="theme" class="form-control" value="${forvo.fortheme }" maxlength="50">
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label">內容:</label>
				<div class="col-sm-8">
					<jsp:include page="/Front/Forums/advanced.jsp" />
				</div>
			</div>

			<div class="form-group">
				<div class="col-sm-offset-2 col-sm-5">
					<input type="submit" class="btn btn-primary" value="送出">
					<input type="hidden" name="forno" value="${forvo.forno}">
					 <a
						class="btn btn-warning"
						href="<%=request.getContextPath()%>/forums/ForumsServlet?action=WatchFor&forno=${forvo.forno}"
						role="button">取消</a> <input type="hidden" name="action"
						value="UpdateForumsByMem">
				</div>
			</div>
		</form>
	</div>
</body>
</html>