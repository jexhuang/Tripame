<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib uri="http://ckeditor.com" prefix="ckeditor" %>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page language="Java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
	<title></title>
<style>
#editor1 {
  resize : none;
}
</style>
	<meta content="text/html; charset=utf-8" http-equiv="content-type"/>
	<link type="text/css" rel="stylesheet" href="<%=request.getContextPath() %>/Back/forIndex/ckeditor/_samples/sample.css" />
</head>
<body>
	<textarea id="editor1" name="editor1" cols="105" rows="10">${travelvo.travelcontent}</textarea>
	<ckeditor:replace  replace="editor1" basePath="/YA101G1_Tripame/Back/forIndex/ckeditor/" />
</body>
</html>
