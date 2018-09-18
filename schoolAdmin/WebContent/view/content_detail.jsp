<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="/view/comm.jsp"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title></title>
		<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
	</head>
		<link rel="stylesheet" href="view/css/mui.min.css">
		<style type="text/css">
		 img{
		  display: block;
		  height: auto;
		  max-width: 100%;
		 }
		</style>
	</head>
	<body>
	<div  class="mui-content" style="background-color: white;">
		<div class="mui-h3" style="text-align: center;padding-top: 15px;margin-bottom: 15px;">${name}${title}</div>
		<h5 style="margin:15px">凤凰肿瘤网 ${modDate}</h5>
		<p></p>
	    <div style="margin:15px">${content}</div>
	    <p>&nbsp;</p>
	 </div>
	</body>
</html>