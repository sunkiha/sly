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
<!-- 	<div style="width: 100%;">
		<div style="padding-bottom: 5px;"></div>
		<div class="mini-toolbar" style="border-bottom: 0; padding: 0px;">
			<table style="width: 100%;">
				<tr>
					<td style="width: 100%;"><a class="mini-button"
						onclick="reply()">回复</a></td>
				</tr>
			</table>
		</div>
	</div> -->
	<div id="datagrid1" class="mini-datagrid"
		style="width: 100%; height: 100%;" allowResize="true" pageSize="20"
		url="communitypost/getCommunitypostCommentList?cpId=${cpId}" idField="id"
		multiSelect="true">
		<div property="columns">
			<!--<div type="indexcolumn"></div>        -->
			<!-- <div type="checkcolumn"></div> -->
			<div field="username" width="120" headerAlign="center">用户</div>
			<!-- <div field="statusPic" width="120" headerAlign="center"
				renderer="statusPic">状态图</div> -->
			<div field="content" width="120">内容</div>
			<div field="createDate" width="100" allowSort="true"
				dateFormat="yyyy-MM-dd HH:mm:dd">创建日期</div>
			 	<div name="action" width="80" headerAlign="center" align="center"
				renderer="operat" cellStyle="padding:0;">操作</div>
		</div>
	</div>
	<div id="replyWindow" class="mini-window" title="回复报告单"
		style="width: 650px;" showModal="true" allowResize="true"
		allowDrag="true">
		<div id="replyFrom">

			<input type="hidden" name="id" class="mini-hidden" value="${id}" />
			<div style="padding-left: 11px; padding-bottom: 5px;">
				<table align="center" style="table-layout: fixed;">
					<tr>
						<td style="width: 70px;">内容：</td>
						<td style="width: 150px;"><input class="mini-textbox"
								name="content" width="400px"  height="200px"
								 required="true"/>
						</td>
					</tr>
				</table>
			</div>

			<div style="text-align: center; padding: 10px;">
				<button onclick="doctorReply()" style="width: 120px;">确定</button>
				<!-- 				<button class="mini-button" onclick="sub" style="width:120px;">确定</button> -->
			</div>
		</div>
	</div>

	<script type="text/javascript">
		var replyWindow;
		mini.parse();
		var grid = mini.get("datagrid1");
		grid.load();
		grid.sortBy("createDate", "desc");
		function operat(e) {
			var grid = e.sender;
			var record = e.record;
			var id = record.id;
			var rowIndex = e.rowIndex;
			var s = '<a class="Delete_Button" href="javascript:del(\'' + id
					+ '\')">删除</a> ';
			return s;
		}
		function statusPic(e) {
			var statusPic = e.record.statusPic;
			var s = '<img width="80px" src="http://60.174.233.153:8080/src/'+statusPic+'.png"/>';
			return s;
		}
		function reply() {
			replyWindow = mini.get("replyWindow");
			replyWindow.show();
		}
		function doctorReply() {
			var form = new mini.Form("#replyFrom");
			form.validate();
			if (form.isValid()) {
				var o = form.getData();
				grid.loading("保存中，请稍后......");
				//var json = mini.encode(o);
				$.ajax({
					url : "inspectReport/doctorReply",
					data :o,
					type: "post",
					success : function(res) {
						if(res.code==0){
							grid.reload();
							replyWindow.hide();
						}else{
							mini.alert("服务器出错");
						}
					},
					error : function(jqXHR, textStatus, errorThrown) {
						mini.alert(jqXHR.responseText);
					}
				});
				
			}
		}
		function del(id) {
			mini.confirm("确定要删除吗?", "提示", function(data) {
				if (data == "ok") {
					$.ajax({
						url : "communitypost/deleteCommunitypostComment",
						data : {
							id : id
						},
						success : function(json) {
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
			var week = mini.get("week").getValue();
			grid.load({
				week : week
			});
		}
		function onKeyEnter(e) {
			search();
		}
		/////////////////////////////////////////////////
		function onBirthdayRenderer(e) {
			var value = e.value;
			if (value)
				return mini.formatDate(value, 'yyyy-MM-dd');
			return "";
		}
		function onMarriedRenderer(e) {
			if (e.value == 1)
				return "是";
			else
				return "否";
		}
		var Genders = [ {
			id : 1,
			text : '男'
		}, {
			id : 2,
			text : '女'
		} ];
		function onGenderRenderer(e) {
			for (var i = 0, l = Genders.length; i < l; i++) {
				var g = Genders[i];
				if (g.id == e.value)
					return g.text;
			}
			return "";
		}
	</script>
</body>
</html>