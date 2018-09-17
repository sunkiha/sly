<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../comm.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>孕产管家后台管理系统</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<link href="../demo.css" rel="stylesheet" type="text/css" />
<meta name="viewport"
	content="width=device-width, initial-scale=1,maximum-scale=1, user-scalable=no" />
<meta name="apple-mobile-web-app-capable" content="yes" />
<meta name="apple-mobile-web-app-status-bar-style" content="black" />
			<style type="text/css">
body {
	margin: 0;
	padding: 0;
	border: 0;
	width: 100%;
	height: 100%;
	overflow: hidden;
}

.header {
	background: url(view/header.gif) repeat-x 0 -1px;
	height: 40px;
}
</style>
	<script src="view/miniui/boot.js" type="text/javascript"></script>
</head>
<body>
	<div class="header">
		<div
			style="float:left;height: 40px; line-height: 40px; padding-left: 15px; font-family: Tahoma; font-size: 16px; font-weight: bold;">
			孕产管家后台管理系统</div>
			 <div style="position:absolute;top:18px;right:10px;">
            ${user.username}&nbsp;<a href="userInfo/loginOutWap">退出</a>
        </div>
	</div>
	<ul id="menu1" class="mini-menubar" style="width: 100%;"
		url="admin/menuWap" onitemclick="onItemClick"
		textField="text" idField="id" parentField="pid">
	</ul>
	<div class="mini-fit" style="padding-top: 5px;">
		<!--Tabs-->
		<div id="mainTabs" class="mini-tabs" activeIndex="0"
			style="width: 100%; height: 100%;">
			<div title="首页" url="view/welcome.jsp"></div>
		</div>
	</div>
	<div style="line-height: 28px; text-align: center; cursor: default">Copyright © 上海满江红医院投资管理有限公司版权所有</div>

	<script type="text/javascript">
		mini.parse();

		function showTab(node) {
			var tabs = mini.get("mainTabs");

			var id = "tab$" + node.id;
			var tab = tabs.getTab(id);
			if (!tab) {
				tab = {};
				tab.name = id;
				tab.title = node.text;
				tab.showCloseButton = true;
				tab.url = mini_JSPath + "../../../" + node.id;
				tabs.addTab(tab);
			}
			tabs.activeTab(tab);
		}
		function onItemClick(e) {
			var item = e.item;
			var isLeaf = e.isLeaf;

			if (isLeaf) {
				showTab(item);
			}
		}
	</script>


</body>
</html>