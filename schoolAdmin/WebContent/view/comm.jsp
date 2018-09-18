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
	//out.clear();
%>
<base href="${ctx}">
<script>
	function closeW() {
		if (window.CloseOwnerWindow)
			return window.CloseOwnerWindow("cancel");
		else
			window.close();
	}
	function CloseWindow(action) {
		if (action == "close" && form.isChanged()) {
			mini.confirm("数据被修改了，是否先保存？","提示",function(){
				return;
			})
		}
		if (window.CloseOwnerWindow)
			return window.CloseOwnerWindow(action);
		else
			window.close();
	}

	function onCancel(e) {
		CloseWindow("cancel");
	}
	function getImg(imgUrl){
		return "http://121.42.191.124:8080/src/"+imgUrl+".png"
	}
</script>