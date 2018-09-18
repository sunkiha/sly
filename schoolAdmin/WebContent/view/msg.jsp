<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%--导入UI的taglib，该taglib的uri也是Sping的schema --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!-- 去掉影响缓存? -->
<%-- <%@ page session="false" %> --%>
<%
	//request.setAttribute("ctx", "http://localhost:8080/xinlingmanager/");
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	request.setAttribute("ctx", path + "/");
	request.setAttribute("basePath", basePath);
%>
<base href="${ctx}">
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet" href="common/css/bootstrap.min.css" />
<script src="view/miniui/boot.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>
</head>
<body>
	<h1 align="center" style="color: red; font-size: 14px">${msg}</h1>
	<div align="center">
		<button onclick="closeW()" class="mini-button" style="width: 120px;">关闭</button>
	</div>
</body>
<script type="text/javascript">
	function closeW() {
		if (window.CloseOwnerWindow)
			return window.CloseOwnerWindow("cancel");
		else
			window.close();
	}
</script>
</html>
