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
	<!-- <div
		style="width: 700px; border: solid 1px #9da0aa; font-size: 12px; font-family: Verdana; color: #201F35; overflow: hidden;">
		<div class="mini-toolbar"
			style="border: 0; border-bottom: solid 1px #9da0aa; padding: 5px;">
			<table style="width: 50%;">
				<tr>
					<td style="width: auto;"><a class="mini-button"
						iconCls="icon-add" plain="true" onclick="onOk">保存</a></td>
				</tr>
			</table>
		</div>
		<div handlerSize="2" showHandleButton="false"
			style="width: 100%; height: 90%;" borderStyle="border:0">
			<ul id="tree1" class="mini-tree" style="width: 100%; height: 100%;"
				showTreeIcon="true" textField="text" idField="id" parentField="pid"
				resultAsTree="false" showCheckBox="true" checkRecursive="true"
				expandOnLoad="true" allowSelect="false" enableHotTrack="false"
				autoCheckParent="true"
				>
			</ul>
		</div>
	</div> -->
	<div class="mini-splitter" style="width: 100%; height: 100%;">
		<div size="650" showCollapseButton="true">
			<div class="mini-toolbar" style="border-bottom: 0; padding: 0px;">
				<a class="mini-button" iconCls="icon-add" plain="true"
					onclick="add()">新增</a> <span style="padding-left: 5px;">名称：</span>
				<input id="name" class="mini-textbox" width="120" value="" /> <a
					class="mini-button" iconCls="icon-search" plain="true"
					onclick="search">查找</a>
			</div>
			<div class="mini-fit">
				<div id="datagrid" class="mini-datagrid"
					style="width: 100%; height: 94%;" allowResize="true"
					url="role/getRolePage" idField="id" multiSelect="true"
					pageSize="20" onselectionchanged="onSelectionChanged">
					<div property="columns">
						<!--<div type="indexcolumn"></div>-->
						<!--<div type="checkcolumn"></div>-->
						<div field="id" width="20" headerAlign="center">ID</div>
						<div field="name" width="120" headerAlign="center">名称</div>
						<div field="describe" width="120" headerAlign="center">描述</div>
						<div field="createDate" width="100" allowSort="true"
							dateFormat="yyyy-MM-dd HH:mm:dd">创建日期</div>
						<div field="modDate" width="100" allowSort="true"
							dateFormat="yyyy-MM-dd HH:mm:dd">修改日期</div>
						<div name="action" width="80" headerAlign="center" align="center"
							renderer="operat" cellStyle="padding:0;">操作</div>
					</div>
				</div>
			</div>
		</div>
		<div showCollapseButton="true">
			<div class="mini-toolbar"
				style="padding: 2px; border-top: 0; border-left: 0; border-right: 0;">
				<a class="mini-button" iconCls="icon-add" plain="true"
					onclick="onOk">保存权限</a>
			</div>
			<div class="mini-fit">
				<ul id="tree1" class="mini-tree" style="width: 100%; height: 100%;"
					showTreeIcon="false" textField="name" idField="id"
					parentField="parentId" resultAsTree="false" showCheckBox="true"
					checkRecursive="true" expandOnLoad="true" allowSelect="false"
					enableHotTrack="false" autoCheckParent="true">
				</ul>
			</div>
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
		function add() {
			mini.open({
				url : "view/sys/operat_role.jsp",
				title : "新增",
				width : 300,
				height : 150,
				onload : function() {
					var iframe = this.getIFrameEl();
					var data = {
						action : "add"
					};
					iframe.contentWindow.SetData(data);
				},
				ondestroy : function(action) {
					datagrid.reload();

				}
			});
		}
		function mod() {
			var record = datagrid.getSelected();
			mini.open({
				url : "view/sys/operat_role.jsp",
				title : "修改",
				width : 300,
				height : 150,
				onload : function() {
					var iframe = this.getIFrameEl();
					var data = {
						action : "mod",
						id : record.id
					};
					iframe.contentWindow.SetData(data);
				},
				ondestroy : function(action) {
					datagrid.reload();
				}
			});
		}
		function del() {
			var record = datagrid.getSelected();
			if (record) {
				mini.confirm("确定要删除吗?", "提示", function(data) {
					if (data == "ok") {
						var messageId = mini.loading("正在执行...");
						$.ajax({
							url : "sys/delRole",
							data : {
								id : record.id
							},
							success : function(json) {
								mini.hideMessageBox(messageId);
								if (json.code == 1) {
									mini.alert(json.msg);
								} else {
									datagrid.reload();
								}
							},
							error : function() {
								mini.hideMessageBox(messageId);
								mini.alert("服务器异常");
							}
						});
					}
				})
			}
		}
		var roleId;
		function onSelectionChanged(e) {
			var gird = e.sender;
			var record = gird.getSelected();
			var id = record.id;
			roleId = id;
			tree.load("sys/getMenu?roleId=" + id);
			//tree.load("view/sys/listTree.txt");
		}
		var tree = mini.get("tree1");

		function GetCheckedNodes() {
			var nodes = tree.getCheckedNodes();
			return nodes;
		}
		function GetData() {
			var nodes = tree.getCheckedNodes();
			var ids = [], texts = [];
			for (var i = 0, l = nodes.length; i < l; i++) {
				var node = nodes[i];
				ids.push(node.id);
				texts.push(node.text);
			}
			var data = {};
			data.id = ids.join(",");
			data.text = texts.join(",");
			return data;
		}
		function search() {
			var name = mini.get("name").getValue();
			datagrid.load({
				name : name
			});
		}
		function onKeyEnter(e) {
			search();
		}
		function onOk() {
			var nodes = tree.getCheckedNodes();
			var ids = [], texts = [];
			for (var i = 0, l = nodes.length; i < l; i++) {
				var node = nodes[i];
				ids.push(node.id);
			}
			var messageId = mini.loading("正在执行...");
			$.ajax({
				url : "sys/addModPower",
				data : {
					ids : ids.join(","),
					roleId : roleId
				},
				success : function(json) {
					mini.hideMessageBox(messageId);
					mini.alert(json.msg);
				},
				error : function() {
					mini.hideMessageBox(messageId);
					mini.alert("服务器异常");
				}
			});
		}
	</script>

</body>
</html>