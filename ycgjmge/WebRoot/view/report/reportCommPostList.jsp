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
			<!-- 类型： <input id="type" onenter="onKeyEnter" class="mini-combobox"
				style="width: 150px;" textField="name" valueField="value"
				valueFromSelect="true" data="typeData" value="1" /> <a
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
		url="report/getReportCommPostList" idField="id" pageSize="20"
		multiSelect="true">
		<div property="columns">
			<!--<div type="indexcolumn"></div>        -->
			<!-- <div type="checkcolumn"></div> -->
			<div field="reportUserName" width="100" headerAlign="center">举报人</div>
			<div field="username" width="80">帖子发表人</div>
			 <div field="content" width="120">帖子内容</div>
			 <div field="reportNum" width="80">举报次数</div>
			 <div field="status" width="80" renderer="status">状态</div>
			<div field="createDate" width="80" allowSort="true"
				dateFormat="yyyy-MM-dd HH:mm:dd">创建日期</div>
			<div name="action" width="80" headerAlign="center" align="center"
				renderer="operat" cellStyle="padding:0;">操作</div>
		</div>
	</div>


	<script type="text/javascript">
	var typeData = [{name:"评论",value:1 },{name:"帖子",value:0 }];
		mini.parse();
		var grid = mini.get("datagrid1");
		grid.load();
		grid.sortBy("id", "asc");
		function operat(e) {
			var grid = e.sender;
			var record = e.record;
			var communitypostId = record.communitypostId;
			var reportId = record.id;
			var rowIndex = e.rowIndex;
			var s = '<a class="Delete_Button" href="javascript:del(\''+communitypostId+','+reportId
					+ '\')">删除该贴</a> ';
			return s;
		}
		function banner(e) {
			var banner = e.record.banner;
			var s = '<img width="80px" src="http://60.174.233.153:8080/src/'+banner+'.png"/>';
			return s;
		}
		function status(e) {
			var status = e.record.status;
			if(status==1){
			  return "已处理";
			}else{
				return "未处理";
			}
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
		function del(str) {
			var a=str.split(",");
			mini.confirm("确定要删除吗?", "提示", function(data) {
				if (data == "ok") {
					$.ajax({
						url : "report/delCommunitypost",
						data : {
							communitypostId:a[0],
							reportId:a[1]
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