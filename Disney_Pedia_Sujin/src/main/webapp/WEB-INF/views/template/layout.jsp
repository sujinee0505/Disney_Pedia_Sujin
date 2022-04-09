<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><tiles:getAsString name="title" /></title>
<link rel="icon" href="${pageContext.request.contextPath}/resources/images/logo.png">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/sujin.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/yunee.css">
<link href="${pageContext.request.contextPath}/resources/css/rateit.css" rel="stylesheet" type="text/css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script> -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10.10.1/dist/sweetalert2.all.min.js"></script>
<link rel='stylesheet' href='https://cdn.jsdelivr.net/npm/sweetalert2@10.10.1/dist/sweetalert2.min.css'>
</head>
<body>
	<div id="main">
		<div id="main_header">
			<tiles:insertAttribute name="header" />
		</div>
		<div id="main_body">
			<tiles:insertAttribute name="body" />
		</div>
		<div id="main_footer">
			<tiles:insertAttribute name="footer" />
		</div>
	</div>
</body>
</html>






