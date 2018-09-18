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
				onclick="add()">新增报销</a><!--  <span style="padding-left: 5px;">帐号：</span> <input
				id="name" class="mini-textbox" width="120" value="" /> <a
				class="mini-button" iconCls="icon-search" plain="true"
				onclick="search">查找</a> -->
		</div>
	</div>
	<div id="datagrid" class="mini-datagrid"
		style="width: 100%; height: 94%;" allowResize="true"
		url="userClient/getMyReim" idField="id" multiSelect="true" pageSize="20">
		<div property="columns">
			<!--<div type="indexcolumn"></div>-->
			<!--<div type="checkcolumn"></div>-->
			<div field="id" width="20" headerAlign="center">ID</div>
			<div field="openDate" width="120" 	dateFormat="yyyy-MM-dd HH:mm:dd" headerAlign="center">预约时间</div>
			<div field="money" width="120" headerAlign="center">报销金额</div>
				<div field="desc" width="120" headerAlign="center">描述</div>
			<div renderer="status" width="120" headerAlign="center">状态</div>
		
			<div field="createDate" width="100" allowSort="true"
				dateFormat="yyyy-MM-dd HH:mm:dd">申请日期</div>
		<div renderer="authFile" width="120" headerAlign="center">凭证</div>
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
			return '<a class="Edit_Button" href="javascript:mod()">查看</a>';

		}
		function authFile(e) {
			var record = e.record;
			var imgUrl = record.authFile;
			var s = '<img  src="' +imgUrl + '"/>';
			return s;

		}
		function status(e) {
			var record = e.record;
			var status = record.status;
			if (status == 0) {
				return '待审核';
			} else if (status == 1) {
				return '已通过';
			} else if (status == 2) {
				return '未通过';
			}
		}
		function update(status) {
			var record = datagrid.getSelected();
			if (record) {
				var messageId = mini.loading("正在执行...");
				$.ajax({
					url : "sys/updateManager",
					data : {
						status : status,
						id:record.id
					},
					success : function(json) {
						mini.hideMessageBox(messageId);
						if (json.code == 1) {
							mini.alert(json.msg);
						} else {
							datagrid.reload();
						}
					},
					error : function() {
						mini.hideMessageBox(messageId);
						mini.alert("服务器异常");
					}
				});
			}
		}
		function add() {
			mini.open({
				url : "view/userclient/my_reimburseme_add.jsp",
				title : "新增报销",
				width : 400,
				height : 230,
				onload : function() {

				},
				ondestroy : function(action) {
					datagrid.reload();

				}
			});
		}
		function mod() {
			var record = datagrid.getSelected();
	
			if (record) {
				mini.open({
					url : "userClient/toReimDetail?id="+record.id,
					title : "查看",
					width : 350,
					height : 390,
					onload : function() {
						var iframe = this.getIFrameEl();
						var data = {
							action : "mod",
							id : record.id
						};
						iframe.contentWindow.SetData(data);

					},
					ondestroy : function(action) {
						datagrid.reload();

					}
				});
			}
		}
		function del() {
			var record = datagrid.getSelected();
			if (record) {
				mini.confirm("确定要删除吗?", "提示", function(data) {
					if (data == "ok") {
						var messageId = mini.loading("正在执行...");
						$.ajax({
							url : "sys/delManager",
							data : {
								id : record.id
							},
							success : function(json) {
								mini.hideMessageBox(messageId);
								if (json.code == 1) {
									mini.alert(json.msg);
								} else {
									datagrid.reload();
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
		function search(e) {
			datagrid.load({
				name : mini.get("name").getValue()
			});
		}
	</script>

</body>
</html>