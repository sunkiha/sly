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
			<!-- 天数： <input id="day" onenter="onKeyEnter" class="mini-combobox"
				style="width: 150px;" textField="name" valueField="value"
				valueFromSelect="true" url="careRemind/getDays" /> <a
				class="mini-button" onclick="search()">查询</a> -->

		</div>
		<div class="mini-toolbar" style="border-bottom: 0; padding: 0px;">
			<table style="width: 100%;">
				<tr>
					<td style="width: 100%;"><!-- <a class="mini-button"
						iconCls="icon-add" onclick="add()">增加</a> --> <!--  <a class="mini-button"
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
		url="inspectReport/getInspectReportList" idField="id" multiSelect="true">
		<div property="columns">
			<!--<div type="indexcolumn"></div>        -->
			<!-- <div type="checkcolumn"></div> -->
			<div field="username" width="80" headerAlign="center">用户帐号</div>
			<div field="content" width="120">内容</div>
			<div field="createDate" width="100" allowSort="true"
				dateFormat="yyyy-MM-dd HH:mm:dd">创建日期</div>
				<div field="statusPic" width="80px" headerAlign="center" align="center"
				renderer="path">状态图</div>
			<div name="action" width="80" headerAlign="center" align="center"
				renderer="operat" cellStyle="padding:0;">操作</div>
		</div>
	</div>


	<script type="text/javascript">
		mini.parse();
		var grid = mini.get("datagrid1");
		grid.load();
		grid.sortBy("createDate", "desc");
		function operat(e) {
			var grid = e.sender;
			var record = e.record;
			var id = record.id;
			var rowIndex = e.rowIndex;
			var s = '<a class="Delete_Button" href="javascript:seeReply(\'' + id
					+ '\')">查看回复</a> '
					+ '<a class="Delete_Button" href="javascript:del(\'' + id
					+ '\')">删除</a> ';
			return s;
		}
		function path(e) {
			var path = e.record.path;
			var id = e.record.id;
			var s = '<img style="float:left" height="30px" width="80px" src="http://60.174.233.153:8080/src/'+path+'.png"/><a style="float:left;margin-top:5px;margin-left:40px" href="javascript:seeMoreImg(\'' + id
			+ '\')">更多</a>';
			return s;
		}
		function add() {
			mini.open({
				url : "careRemind/toAddBeiyun",
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
		function seeReply(id) {
			mini.open({
				url : "inspectReport/seeReply?id="+id,
				title : "查看回复",
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
						url : "inspectReport/delInspectReport",
						data : {
							id : id
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
			var day = mini.get("day").getValue();
			grid.load({
				day : day
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