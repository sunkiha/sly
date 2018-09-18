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


	<div class="mini-splitter" style="width: 100%; height: 100%;">
		<div size="450" showCollapseButton="true">
			<div class="mini-toolbar"
				style="padding: 2px; border-top: 0; border-left: 0; border-right: 0;">
				<a class="mini-button" iconCls="icon-add" plain="true"
					onclick="addParentMenu()">新增</a> <span style="padding-left: 5px;">名称：</span>
				<input id="parentMenuName" class="mini-textbox" width="120" value="" />
				<a class="mini-button" iconCls="icon-search" plain="true"
					onclick="searchParentMenu">查找</a>
			</div>
			<div class="mini-fit">
				<div id="menuParentDgd" class="mini-datagrid"
					style="width: 100%; height: 100%;" allowResize="true"
					url="menu/getMenuParentPage" idField="id" multiSelect="true"
					onselectionchanged="onSelectionChanged" pageSize="20">
					<div property="columns">
						<!--<div type="indexcolumn"></div>        -->
						<!-- <div type="checkcolumn"></div> -->
						<div field="name" width="50">名称</div>
						<div field="createDate" width="30" allowSort="true"
							dateFormat="yyyy-MM-dd HH:mm:dd">创建日期</div>
						<div field="modDate" width="30" allowSort="true"
							dateFormat="yyyy-MM-dd HH:mm:dd">修改日期期</div>
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
					onclick="addChildMenu()">新增</a> <span style="padding-left: 5px;">名称：</span>
				<input id="childMenuName" class="mini-textbox" width="120" /> <a class="mini-button"
					iconCls="icon-search" plain="true"  onclick="searchChildMenu">查找</a>
			</div>
			<div class="mini-fit">
				<div id="menuChildDgd" class="mini-datagrid"
					style="width: 100%; height: 100%;" allowResize="true"
					url="menu/getMenuPage" idField="id" multiSelect="true"
					pageSize="20">
					<div property="columns">
						<!--<div type="indexcolumn"></div>        -->
						<!-- <div type="checkcolumn"></div> -->
						<div field="name" width="50">名称</div>
						<div field="url" width="50">地址</div>
						<div field="createDate" width="30" allowSort="true"
							dateFormat="yyyy-MM-dd HH:mm:dd">创建日期</div>
						<div field="modDate" width="30" allowSort="true"
							dateFormat="yyyy-MM-dd HH:mm:dd">修改日期期</div>
						<div name="action" width="80" headerAlign="center" align="center"
							renderer="operatChild" cellStyle="padding:0;">操作</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
		mini.parse();
		var menuParentDgd = mini.get("menuParentDgd");
		var menuChildDgd = mini.get("menuChildDgd");
		menuParentDgd.load();
		menuParentDgd.sortBy("createDate", "desc");
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
			optParentIdMenuId=id;
			menuChildDgd.sortBy("createDate", "desc");
		}
		function addParentMenu() {
			mini.open({
				url : "view/menu/operatParentMenu.jsp",
				title : "新增父菜单",
				width : 300,
				height : 100,
				onload : function() {

				},
				ondestroy : function(action) {
					menuParentDgd.reload();

				}
			});
		}
		function addChildMenu() {
			if(optParentIdMenuId==null){
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
						parentId :optParentIdMenuId
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
								if(json.code==1){
									mini.alert(json.msg);
								}else{
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
		function modChildMenu(){
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
		function delChildMenu(){
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
								if(json.code==1){
									mini.alert(json.msg);
								}else{
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
				parentId:optParentIdMenuId
			});
		}
	</script>

</body>
</html>