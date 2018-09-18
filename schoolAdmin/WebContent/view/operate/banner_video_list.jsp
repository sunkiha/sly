<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../comm.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<link href="../demo.css" rel="stylesheet" type="text/css" />
<script src="view/miniui/boot.js" type="text/javascript"></script>
</head>
<body>

	<div style="width: 100%;">
		<div class="mini-toolbar" style="border-bottom: 0; padding: 0px;">
			<span style="padding-left: 5px;">名称：</span> <input id="name"
				class="mini-textbox" width="120" value="" /> <a class="mini-button"
				iconCls="icon-search" plain="true" onclick="search">查找</a>
		</div>
	</div>
	<div id="datagrid" class="mini-datagrid"
		style="width: 100%; height: 94%;" allowResize="true"
		url="product/getVideoPage" idField="id" multiSelect="true"
		pageSize="20" onrowdblclick="onRowDblClick">
		<div property="columns">
			<div field="id" width="20" headerAlign="center">ID</div>
			<div field="name" width="30" headerAlign="center">名称</div>
			<div field="title" width="30" headerAlign="center">标题</div>
			<div field="summary" width="30" headerAlign="center">简介</div>
			<div field="tag" width="30" headerAlign="center">关键字</div>
			<div renderer="type" width="20" headerAlign="center">类型</div>
			<div field="categoryName" width="20" headerAlign="center">分类</div>
			<div renderer="status" width="20" headerAlign="center">状态</div>
			<div field="price" width="20" headerAlign="center">价格</div>
			<div width="40" headerAlign="center" renderer="img">封面</div>
			<div field="videoUrl" width="30" headerAlign="center">地址</div>
			<div field="createDate" width="30" allowSort="true"
				dateFormat="yyyy-MM-dd HH:mm:dd">创建日期</div>
			<div field="modDate" width="30" allowSort="true"
				dateFormat="yyyy-MM-dd HH:mm:dd">修改日期</div>
		</div>
	</div>

	<script type="text/javascript">
		mini.parse();
		var datagrid = mini.get("datagrid");
		datagrid.load();
		datagrid.sortBy("createDate", "desc");
		function operat(e) {
			var record = e.record;
			var uid = record._uid;
			return '<a class="Edit_Button" href="javascript:mod()">修改</a> <a class="Edit_Button" href="javascript:del()">删除</a>';

		}
		function img(e) {
			var imgUrl = e.record.imgUrl;
			var s = '<img width="80px" src="'+imgUrl+ '"/>';
			return s;
		}
		function format(e) {
			var format = e.record.format;
			if (!format) {
				return "暂无"
			}
			return format;
		}
		function type(e) {
			var type = e.record.type;
			if (type == 0) {
				return "免费"
			}
			if (type == 1) {
				return "时段"
			}
			if (type == 2) {
				return "单独"
			}
		}

		function search(e) {
			datagrid.load({
				name : mini.get("name").getValue()
			});
		}
		function onRowDblClick(e) {
			window.CloseOwnerWindow("ok");
		}
		function GetData() {
			var row = datagrid.getSelected();
			return row;
		}
	</script>

</body>
</html>