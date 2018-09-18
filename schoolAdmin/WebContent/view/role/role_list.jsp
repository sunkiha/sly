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
			<a class="mini-button" iconCls="icon-add" plain="true"
				onclick="add()">新增</a> <span style="padding-left: 5px;">名称：</span>
			<input id="name" class="mini-textbox" width="120" value="" />
			<a class="mini-button" iconCls="icon-search" plain="true"
				onclick="search">查找</a>
		</div>
	</div>
	<div id="datagrid" class="mini-datagrid"
		style="width: 100%; height: 94%;" allowResize="true"
		url="role/getRolePage" idField="id" multiSelect="true">
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

	<script type="text/javascript">
		mini.parse();
		var datagrid = mini.get("datagrid");
		datagrid.load();
		datagrid.sortBy("createDate", "desc");
		function operat(e) {
			var record = e.record;
			var uid = record._uid;
			return '<a class="Edit_Button" href="javascript:modParentMenu()">修改</a> <a class="Edit_Button" href="javascript:delParentMenu()">删除</a>';

		}
		function operatChild(e) {
			var record = e.record;
			var uid = record._uid;
			return '<a class="Edit_Button" href="javascript:modChildMenu()">修改</a> <a class="Edit_Button" href="javascript:delChildMenu()">删除</a>';

		}
		var optParentIdMenuId;
		function onSelectionChanged(e) {
			var gird = e.sender;
			var record = gird.getSelected();
			var id = record.id;
			menuChildDgd.load({
				parentId : id
			});
			optParentIdMenuId = id;
			menuChildDgd.sortBy("createDate", "desc");
		}
		function add() {
			mini.open({
				url : "view/role/operat_role.jsp",
				title : "新增",
				width : 300,
				height : 150,
				onload : function() {

				},
				ondestroy : function(action) {
					datagrid.reload();

				}
			});
		}
		function addChildMenu() {
			if (optParentIdMenuId == null) {
				mini.alert("请选择父菜单");
				return;
			}
			mini.open({
				url : "view/menu/operatChildMenu.jsp",
				title : "新增子菜单",
				width : 300,
				height : 150,
				onload : function() {
					var iframe = this.getIFrameEl();
					var data = {
						action : "add",
						parentId : optParentIdMenuId
					};
					iframe.contentWindow.SetData(data);
				},
				ondestroy : function(action) {
					menuChildDgd.reload();

				}
			});
		}
		function modParentMenu() {
			var record = menuParentDgd.getSelected();
			if (record) {
				mini.open({
					url : "view/menu/operatParentMenu.jsp",
					title : "修改父菜单",
					width : 300,
					height : 100,
					onload : function() {
						var iframe = this.getIFrameEl();
						var data = {
							action : "mod",
							id : record.id
						};
						iframe.contentWindow.SetData(data);

					},
					ondestroy : function(action) {
						menuParentDgd.reload();

					}
				});
			}
		}
		function delParentMenu() {
			var record = menuParentDgd.getSelected();
			if (record) {
				mini.confirm("确定要删除吗?", "提示", function(data) {
					if (data == "ok") {
						var messageId = mini.loading("正在执行...");
						$.ajax({
							url : "menu/delMenu",
							data : {
								id : record.id,
								parentId : record.parentId
							},
							success : function(json) {
								mini.hideMessageBox(messageId);
								if (json.code == 1) {
									mini.alert(json.msg);
								} else {
									menuParentDgd.reload();
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
		function modChildMenu() {
			var record = menuChildDgd.getSelected();
			if (record) {
				mini.open({
					url : "view/menu/operatChildMenu.jsp",
					title : "修改子菜单",
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
						menuChildDgd.reload();

					}
				});
			}
		}
		function delChildMenu() {
			var record = menuChildDgd.getSelected();
			if (record) {
				mini.confirm("确定要删除吗?", "提示", function(data) {
					if (data == "ok") {
						var messageId = mini.loading("正在执行...");
						$.ajax({
							url : "menu/delMenu",
							data : {
								id : record.id,
								parentId : record.parentId
							},
							success : function(json) {
								mini.hideMessageBox(messageId);
								if (json.code == 1) {
									mini.alert(json.msg);
								} else {
									menuChildDgd.reload();
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
		function searchParentMenu(e) {
			menuParentDgd.load({
				name : mini.get("parentMenuName").getValue()
			});
		}
		function searchChildMenu(e) {
			menuChildDgd.load({
				name : mini.get("childMenuName").getValue(),
				parentId : optParentIdMenuId
			});
		}
	</script>

</body>
</html>