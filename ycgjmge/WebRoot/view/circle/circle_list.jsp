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

		<div style="padding-bottom: 5px;">
			名称：<input
				id="name" name="name" />
				 类型： <input id="circleCategory" onenter="onKeyEnter" class="mini-combobox"
				 textField="name" valueField="id"
				valueFromSelect="true"  url="circle/getCircleCategoryAll"  />  <a
				class="mini-button" onclick="search()">查询</a> 

		</div>
		<div class="mini-toolbar" style="border-bottom: 0; padding: 0px;">
			<table style="width: 100%;">
				<tr>
					<td style="width: 100%;"> <a class="mini-button"
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
		url="circle/getCircleList" idField="id" multiSelect="true"  pageSize="20">
		<div property="columns">
			<!--<div type="indexcolumn"></div>        -->
			<!-- <div type="checkcolumn"></div> -->
			<div field="name" width="40" headerAlign="center">名称</div>
			<div field="circleCategoryName" width="30">分类</div>
			<div field="createDate" width="50" allowSort="true"
				dateFormat="yyyy-MM-dd HH:mm:dd">创建日期</div>
				<div field="pic" width="40"  headerAlign="center"
				renderer="path">banner图</div>
			<div name="action" width="40" headerAlign="center" align="center"
				renderer="operat" cellStyle="padding:0;">操作</div>
		</div>
	</div>


	<script type="text/javascript">
	    var typeData = [{name:"全部",value:"" },{name:"备孕",value:0 },{name:"怀孕",value:1 }];
		mini.parse();
		var grid = mini.get("datagrid1");
		grid.load();
		grid.sortBy("c.createdate", "desc");
		function operat(e) {
			var grid = e.sender;
			var record = e.record;
			var id = record.id;
			var banner = record.banner;
			var rowIndex = e.rowIndex;
			var s ="<a href='javascript:void(0)' banner="+banner+"  id="+id+" onclick='mod(this)'>修改</a>"
			+" <a href='javascript:void(0)' banner="+banner+"  id="+id+" onclick='del(this)'>删除</a>";
			return s;
		}
		function path(e) {
			var path = e.record.pic;
			var s = '<img style="float:left" height="50px" width="70px" src="http://60.174.233.153:8080/src/'+path+'.png"/>';
			return s;
		}
		function add() {
			mini.open({
				url : "circle/toAddCircle",
				title : "新增",
				width : 300,
				height : 190,
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
		function mod(obj) {
			var id=obj.getAttribute("id")
			mini.open({
				url : "circle/toModCircle?id="+id,
				title : "修改",
				width : 300,
				height : 190,
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
		function del(obj) {
			var id=obj.getAttribute("id")
			var banner=obj.getAttribute("banner")
			mini.confirm("确定要删除吗?", "提示", function(data) {
				if (data == "ok") {
					$.ajax({
						url : "circle/delCircle",
						data : {
							id : id,
							banner:banner
						},
						success : function(json) {
							grid.reload();
						},
						error : function() {
						 mini.alert("服务器异常");
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
			var circleCategory = mini.get("circleCategory").getValue();
			var name=document.getElementById("name").value;
			grid.load({
				circleCategoryId : circleCategory,
				name:name
			});
		}
		function onKeyEnter(e) {
			search();
		}
		function seeMoreImg(id) {
			mini.open({
				//url : "view/inspectReport/seeMoreImg.jsp",
				url : "inspectReport/seeMoreImg?id="+id,
				title : "报告单",
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
	</script>
</body>
</html>