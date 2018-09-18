﻿<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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

		<!-- <div style="padding-bottom: 5px;">
			<h5>备孕提醒</h5>
			天数： <input id="day" onenter="onKeyEnter" class="mini-combobox"
				style="width: 150px;" textField="name" valueField="value"
				valueFromSelect="true" url="careRemind/getDays" /> <a
				class="mini-button" onclick="search()">查询</a>

		</div> -->
		<div class="mini-toolbar" style="border-bottom: 0; padding: 0px;">
			<table style="width: 100%;">
				<tr>
					<td style="width: 100%;"><a class="mini-button"
						iconCls="icon-add" onclick="add()">增加</a> <!--  <a class="mini-button"
						iconCls="icon-add" onclick="edit()">编辑</a> <a class="mini-button"
						iconCls="icon-remove" onclick="remove()">删除</a>--></td>
					<td style="white-space: nowrap;">
						<!-- <input id="key"
						class="mini-textbox" emptyText="请输入姓名" style="width: 150px;"
						onenter="onKeyEnter" /> <a class="mini-button" onclick="search()">查询</a> -->
					</td>
				</tr>
			</table>
		</div>
	</div>
	<div id="datagrid1" class="mini-datagrid"
		style="width: 100%; height: 100%;" allowResize="true"
		url="pregnancyCheck/getPregnancyCheckList" idField="id" multiSelect="true">
		<div property="columns">
			<!--<div type="indexcolumn"></div>        -->
			<!-- <div type="checkcolumn"></div> -->
			<div field="id" width="20" headerAlign="center">编号</div>
			<div field="name" width="50">名称</div>
			<div field="banner" width="50" headerAlign="center"
				renderer="banner">状态图</div>
			<div field="desc" width="100">描述</div>
			<div field="normalCheck" width="120">体格检查及咨询</div>
			<div field="assay" width="120">化验</div>
			<div field="assistCheck" width="120">辅助检查</div>
			<div field="min" width="20">最小周</div>
			<div field="max" width="20">最大周</div>
			<div field="createDate" width="50" allowSort="true"
				dateFormat="yyyy-MM-dd HH:mm:dd">创建日期</div>
			<div name="action" width="50" headerAlign="center" align="center"
				renderer="operat" cellStyle="padding:0;">操作</div>
		</div>
	</div>


	<script type="text/javascript">
		mini.parse();
		var grid = mini.get("datagrid1");
		grid.load();
		grid.sortBy("id", "asc");
		function operat(e) {
			var grid = e.sender;
			var record = e.record;
			var id = record.id;
			var rowIndex = e.rowIndex;
			var s = '<a class="Delete_Button" href="javascript:mod(\'' + id
					+ '\')">修改</a> '
					+ '<a class="Delete_Button" href="javascript:del(\'' + id
					+ '\')">删除</a> ';
			return s;
		}
		function banner(e) {
			var banner = e.record.banner;
			var s = '<img width="80px" src="http://60.174.233.153:8080/src/'+banner+'.png"/>';
			return s;
		}
		function add() {
			mini.open({
				url : "pregnancyCheck/toAddPregnancyCheck",
				title : "新增",
				width : 900,
				height : 500,
				onload : function() {
					/* var iframe = this.getIFrameEl();
					var data = {
						//action : "new"
					};
					iframe.contentWindow.SetData(data); */
				},
				ondestroy : function(action) {
					grid.reload();
				}
			});
		}
		function mod(id) {
			mini.open({
				url : "pregnancyCheck/toModPregnancyCheck",
				title : "修改",
				width : 900,
				height : 500,
				onload : function() {
					var iframe = this.getIFrameEl();
					var data = {
						id : id
					};
					iframe.contentWindow.SetData(data);
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
						url : "pregnancyCheck/delPregnancyCheck",
						data : {
							id : id
						},
						success : function(json) {
							mini.alert(json)
							grid.reload();
						},
						error : function() {

						}
					});
				}
			})
		}
		function remove() {

			var rows = grid.getSelecteds();
			if (rows.length > 0) {
				if (confirm("确定删除选中记录？")) {
					var ids = [];
					for (var i = 0, l = rows.length; i < l; i++) {
						var r = rows[i];
						ids.push(r.id);
					}
					var id = ids.join(',');
					grid.loading("操作中，请稍后......");
					$.ajax({
								url : "../data/AjaxService.aspx?method=RemoveEmployees&id="
										+ id,
								success : function(text) {
									grid.reload();
								},
								error : function() {
								}
							});
				}
			} else {
				alert("请选中一条记录");
			}
		}
		function search() {
			var day = mini.get("day").getValue();
			grid.load({
				day : day
			});
		}
		function onKeyEnter(e) {
			search();
		}
	</script>
</body>
</html>