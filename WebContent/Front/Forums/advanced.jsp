<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!--
Copyright (c) 2003-2011, CKSource - Frederico Knabben. All rights reserved.
For licensing, see LICENSE.html or http://ckeditor.com/license
-->
<%@ taglib uri="http://ckeditor.com" prefix="ckeditor"%>
<%@page import="com.ckeditor.CKEditorConfig"%>
<%@page import="com.ckeditor.EventHandler"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page language="Java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title></title>
<meta content="text/html; charset=utf-8" http-equiv="content-type" />
<link type="text/css" rel="stylesheet"
	href="<%=request.getContextPath()%>/Back/forIndex/ckeditor/_samples/sample.css" />
</head>
<body>
	<%
		String value = "<p>This is some <strong>sample text</strong>. You are using <a href=\"http://ckeditor.com/\">CKEditor</a>.</p>";
		CKEditorConfig settings = new CKEditorConfig();
		settings.addConfigValue("skin", "office2003");
		EventHandler eventHandler = new EventHandler();
		eventHandler.addEventHandler("instanceReady",
				"function (ev) { alert(\"Loaded: \" + ev.editor.name); }");
	%>

	<textarea cols="50" rows="10" cols="150" id="editor2" name="editor2">${forvo.forcontent}${repvo.repcontent}</textarea>
	<%
		settings.removeConfigValue("skin");
		settings.addConfigValue("uiColor", "#ADE82E");
		settings.addConfigValue(
				"toolbar",
				"[['Format'],['Bold','Italic','Underline','Strike','-','Subscript','Superscript']]");
	%>
	<ckeditor:replace basePath="/YA101G1_Tripame/Back/forIndex/ckeditor/"
		config="<%=settings%>" replace="editor2" />

</body>
</html>
