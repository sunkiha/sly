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

		<div style="padding-bottom: 5px;">
			<!-- 日期： <input id="datepicker" class="mini-datepicker"
				style="width: 150px;" /> -->
			一级分类： <input id="circleCategoryId" name="circleCategoryId"
				onenter="onKeyEnter" class="mini-combobox" 
				textField="name" valueField="id" onvaluechanged="onTypeChanged"
				valueFromSelect="true" url="circle/getCircleCategoryAll" /> 二级分类： <input
				id="circleId" name="circleId" class="mini-combobox"
				 textField="name" valueField="id" /> 主题：<input
				id="title" name="title" class="mini-textbox" /> <a
				class="mini-button" onclick="search()">查询</a>

		</div>
		<div class="mini-toolbar" style="border-bottom: 0; padding: 0px;">
			<table style="width: 100%;">
				<tr>
					<td style="width: 100%;"><a class="mini-button"
						iconCls="icon-add" onclick="add()">增加</a></td>
				</tr>
			</table>
		</div>
	</div>
	<div id="datagrid1" class="mini-datagrid"
		style="width: 100%; height: 100%;" allowResize="true"
		url="topics/getTopics" idField="id" multiSelect="true" pageSize="20">
		<div property="columns">
			<!--<div type="indexcolumn"></div>        -->
			<!-- <div type="checkcolumn"></div> -->
			<div field="title" width="50">主题</div>
			<div field="content" width="50">内容</div>
			<div field="circleName" width="30">二级分类</div>
			<div field="username" width="30">用户</div>
			<div name="action" width="30" headerAlign="center" align="center"
				renderer="operat" cellStyle="padding:0;">操作</div>

		</div>
	</div>


	<script type="text/javascript">
		mini.parse();
		var grid = mini.get("datagrid1");
		grid.load();
		grid.sortBy("t.createDate", "desc");
		var circleCategoryId = mini.get("circleCategoryId");
		var circleId = mini.get("circleId");
		var title = mini.get("title");
		function onTypeChanged() {
			var value = circleCategoryId.getValue();
			circleId.setValue("");
			circleId
					.setUrl("circle/getCircleListByCategoryId?circleCategoryId="
							+ value);
		}
		function operat(e) {
			var grid = e.sender;
			var record = e.record;
			var id = record.id;
			var rowIndex = e.rowIndex;
			var s = '<a class="Delete_Button" href="javascript:mod(\'' + id
					+ '\')">修改</a> '
					+ '<a class="Delete_Button" href="javascript:del(\'' + id
					+ '\')">删除</a>';
			return s;
		}
		function add() {
			mini.open({
				url : "view/topics/add_topics.jsp",
				title : "新增",
				width : "60%",
				height : "50%",
				onload : function() {
					var iframe = this.getIFrameEl();
					var data = {
						action : "add"
					};
					iframe.contentWindow.setData(data);
				},
				ondestroy : function(action) {
					grid.reload();
				}
			});
		}
		function mod(id) {
			mini.open({
				url : "view/topics/add_topics.jsp",
				title : "修改",
				width : "60%",
				height : "50%",
				onload : function() {
					var iframe = this.getIFrameEl();
					var data = {
						id : id,
						action : "mod"
					};
					iframe.contentWindow.setData(data);
				},
				ondestroy : function(action) {
					grid.reload();
				}
			});
		}
		function del(id) {
			mini.confirm("确定要删除吗?", "提示", function(data) {
				if (data == "ok") {
					$.ajax({
						url : "topics/delTopics",
						data : {
							id : id
						},
						success : function(json) {
							grid.reload();
						},
						error : function() {
							mini.alert("服务器异常，请稍后重试！");
						}
					});
				}
			})
		}
		function search() {
			grid.load({
				title : title.getValue(),
				circleCategoryId : circleCategoryId.getValue(),
				circleId : circleId.getValue()
			});
		}
		function onKeyEnter(e) {
			search();
		}
	</script>
</body>
</html>