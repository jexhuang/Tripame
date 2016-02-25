<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>發表文章</title>
</head>
<jsp:include page="/Front/select_page.jsp" />
<body>
	<div class="container">
		<form class="form-horizontal" role="form"
			action="<%=request.getContextPath()%>/forums/ForumsServlet" method="post">
			<div class="form-group">
				<label class="col-sm-2 control-label">內容:</label>
				<div class="col-sm-8">
					<jsp:include page="/Front/Forums/advanced.jsp" />
				</div>
			</div>
			<div class="form-group">
				<div class="col-sm-offset-2 col-sm-5">
					<input type="submit" class="btn btn-primary" value="送出">
					<input type="hidden" name="forno" value="${forno}">
					 <a
						class="btn btn-warning"
						href="<%=request.getContextPath()%>/forums/ForumsServlet?action=WatchFor&forno=${forno}"
						role="button">取消</a>
					 <input type="hidden" name="action" value="Add_New_ForumsRep">
				</div>
			</div>
		</form>
	</div>
</body>
</html>