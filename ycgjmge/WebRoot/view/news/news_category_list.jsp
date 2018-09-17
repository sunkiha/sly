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
			类型： <input id="type" onenter="onKeyEnter" class="mini-combobox"
				style="width: 150px;" textField="name" valueField="value"
				valueFromSelect="true" data="typeData" /> <a class="mini-button"
				onclick="search()">查询</a>

		</div>
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
		url="news/getNewsCategoryList" idField="id" multiSelect="true" pageSize="20">
		<div property="columns">
			<!--<div type="indexcolumn"></div>        -->
			<!-- <div type="checkcolumn"></div> -->
			<div field="id" width="40" headerAlign="center">编号</div>
			<div field="name" width="40">标题</div>
			<div field="type" width="30" headerAlign="center" renderer="type">所属</div>
			<div name="action" width="20" headerAlign="center" align="center"
				renderer="operat" cellStyle="padding:0;">操作</div>
		</div>
	</div>


	<script type="text/javascript">
		var typeData = [ {
			name : "全部",
			value : ""
		}, {
			name : "备孕",
			value : 0
		}, {
			name : "怀孕",
			value : 1
		} ];
		mini.parse();
		var grid = mini.get("datagrid1");
		grid.load();
		grid.sortBy("id", "desc");
		function operat(e) {
			var grid = e.sender;
			var record = e.record;
			var id = record.id;
			var banner = record.pic;
			var rowIndex = e.rowIndex;
			var s = "<a href='javascript:void(0)' id="
					+ id
					+ " onclick='mod(this)'>修改</a>\t<a href='javascript:void(0)' id="
					+ id + " onclick='del(this)'>删除</a>";
			return s;
		}
		function type(e) {
			var type = e.record.type;
			var s = "怀孕";
			if (type == 0) {
				s = "备孕";
			}
			return s;
		}
		function add() {
			mini.open({
				url : "news/toAddNewsCategory",
				title : "新增",
				width : 400,
				height : 200,
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
			var id = obj.getAttribute("id")
			mini.open({
				url : "news/toModNewsCategory?id="+id,
				title : "修改",
				width : 300,
				height : 200,
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
		function seeReply(id) {
			mini.open({
				url : "inspectReport/seeReply?id=" + id,
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
		function del(obj) {
			var id = obj.getAttribute("id")
			mini.confirm("确定要删除吗?", "提示", function(data) {
				if (data == "ok") {
					var messageId = mini.loading("正在执行...");
					$.ajax({
						url : "news/delNewsCategory",
						data : {
							id : id
						},
						success : function(json) {
							mini.hideMessageBox(messageId);
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
					$
							.ajax({
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
			var type = mini.get("type").getValue();
			grid.load({
				type : type
			});
		}
		function onKeyEnter(e) {
			search();
		}
		function seeMoreImg(id) {
			mini.open({
				//url : "view/inspectReport/seeMoreImg.jsp",
				url : "inspectReport/seeMoreImg?id=" + id,
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