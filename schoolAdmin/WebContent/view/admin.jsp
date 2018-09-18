<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="comm.jsp"%>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="utf-8" />
		<title></title>
		<script src="view/miniui/boot.js" type="text/javascript"></script>
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
				background: url(view/images/header.gif) repeat-x 0 -1px;
			}
		</style>
	</head>

	<body>

		<!--Layout-->
		<div id="layout1" class="mini-layout" style="width:100%;height:100%;">
			<div class="header" region="north" height="70" showSplit="false" showHeader="false">
				<h1 style="margin:0;padding:15px;cursor:default;font-family:微软雅黑,黑体,宋体;">管理系统</h1>
				<div style="position:absolute;top:18px;right:10px;">
					<a href="#">${user.username}</a>&nbsp;<a href="#">退出</a>
				</div>

			</div>
			<div title="south" region="south" showSplit="false" showHeader="false" height="30">
				<div style="line-height:28px;text-align:center;cursor:default"> </div>
			</div>
			<div title="center" region="center" style="border:0;" bodyStyle="overflow:hidden;">
				<!--Splitter-->
				<div class="mini-splitter" style="width:100%;height:100%;" borderStyle="border:0;">
					<div size="180" maxSize="250" minSize="100" showCollapseButton="true" style="border:0;">
						<!--OutlookTree-->
						<div id="leftTree" class="mini-outlooktree" url="menu/getMenuPower" onnodeclick="onNodeSelect" 
						textField="name" idField="id" parentField="parentId"
						urlField="url"
						>
						</div>

					</div>
					<div showCollapseButton="false" style="border:0;">
						<!--Tabs-->
						<div id="mainTabs" class="mini-tabs" activeIndex="2" style="width:100%;height:100%;" plain="false" onactivechanged="onTabsActiveChanged">
							<div title="首页" url="view/welcome.jsp">
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<script type="text/javascript">
			mini.parse();
			var tree = mini.get("leftTree");
			function showTab(node) {
				var tabs = mini.get("mainTabs");
				var id = "tab$" + node.id;
				var tab = tabs.getTab(id);
 				if (!tab) {
					tab = {};
					tab._nodeid = node.id+"";
					tab.name = id;
					tab.title = node.name;
					tab.showCloseButton = true;
					tab.url ="${basePath}"+node.url;
					tabs.addTab(tab);
				} 
				tabs.activeTab(tab);
			}

			function onNodeSelect(e) {
				var node = e.node;
				var isLeaf = e.isLeaf;
				if (isLeaf) {
					showTab(node);
				}
			}

			function onClick(e) {
				var text = this.getText();
				alert(text);
			}

			function onQuickClick(e) {
				tree.expandPath("datagrid");
				tree.selectNode("datagrid");
			}

			function onTabsActiveChanged(e) {
				var tabs = e.sender;
				var tab = tabs.getActiveTab();
				if (tab && tab._nodeid) {
					var node = tree.getNode(tab._nodeid);
					if (node && !tree.isSelectedNode(node)) {
						tree.selectNode(node);
					}
				}
			}
		</script>

	</body>

</html>