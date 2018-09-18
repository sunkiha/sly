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
			<span style="padding-left: 5px;">手机号：</span> <input id="phone"
				class="mini-textbox" width="120" value="" vtype="int" /> 开始时间：<input
				id="startDate" class="mini-datepicker" /> 结束时间：<input id="endDate"
				class="mini-datepicker" /> <a class="mini-button"
				iconCls="icon-search" plain="true" onclick="search">查找</a>
		</div>
	</div>
	<div id="datagrid" class="mini-datagrid"
		style="width: 100%; height: 94%;" allowResize="true"
		url="operate/getUserInfoPage" idField="id" multiSelect="true"
		pageSize="20">
		<div property="columns">
			<!--<div type="indexcolumn"></div>-->
			<!--<div type="checkcolumn"></div>-->
			<div field="id" width="20" headerAlign="center">ID</div>
			<div field="phone" width="50" headerAlign="center">手机</div>
			<div field="createDate" width="100" allowSort="true"
				dateFormat="yyyy-MM-dd HH:mm:dd">创建日期</div>
			<div field="modDate" width="100" allowSort="true"
				dateFormat="yyyy-MM-dd HH:mm:dd">修改日期</div>
			<div name="action" width="80" headerAlign="center" align="center"
				renderer="operat" cellStyle="padding:0;">操作</div>
		</div>
	</div>
	<div id="pwdWindow" class="mini-window" title="Window"
		style="width: 250px;" showModal="true" allowResize="true"
		allowDrag="true">

		<form id="form1" method="post">
			<input name="id" class="mini-hidden" /> <input name="imgUrl"
				class="mini-hidden" />
			<div style="padding-left: 11px; padding-bottom: 5px;">
				<table style="table-layout: fixed;">
					<tr>
						<td style="width: 70px;">密码：</td>
						<td style="width: 150px;"><input name="pwd"
							class="mini-password" required="true" /></td>
					</tr>
				</table>
			</div>
			<div style="text-align: center; padding: 10px;">
				<a class="mini-button" onclick="onOk"
					style="width: 60px; margin-right: 20px;">确定</a> <a
					class="mini-button" onclick="onHide" style="width: 60px;">取消</a>
			</div>
		</form>
	</div>
	<script type="text/javascript">
		mini.parse();
		var datagrid = mini.get("datagrid");
		datagrid.load();
		datagrid.sortBy("createDate", "desc");
		var pwdWindow = mini.get("pwdWindow");
		var form = new mini.Form("form1");
		var userInfoId;
		function operat(e) {
			var record = e.record;
			var uid = record._uid;
			return '<a class="Edit_Button" href="javascript:mod()">重置密码</a>';

		}
		function update(status) {
			var record = datagrid.getSelected();
			if (record) {
				var messageId = mini.loading("正在执行...");
				$.ajax({
					url : "product/updateVersion",
					data : {
						status : status,
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
		}
		function add() {
			mini.open({
				url : "view/product/operat_version.jsp",
				title : "新增",
				width : 300,
				height : 200,
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
				userInfoId = record.id;
				pwdWindow.show();
			}
		}
		function onHide() {
			pwdWindow.hide();
		}

		function search(e) {
			var phone = mini.get("phone").getValue();
			var startDate = mini.get("startDate").getFormValue();
			var endDate = mini.get("endDate").getValue();
			datagrid.load({
				phone : phone,
				startDate : startDate,
				endDate : endDate
			});
		}
		function onOk() {
			var o = form.getData();
			form.validate();
			if (form.isValid() == false)
				return;
			form.loading()
			var json = mini.encode(o);
			$.ajax({
				url : "operate/modPwd",
				type : 'post',
				data : {
					pwd : o.pwd,
					id:userInfoId
				},
				cache : false,
				success : function(json) {
					form.unmask();
					if (json.code == 1) {
						mini.alert(json.msg, "提示", function() {
							pwdWindow.hide();
						});
					} else {
						pwdWindow.hide();
					}
				},
				error : function(jqXHR, textStatus, errorThrown) {
					form.unmask();
					mini.alert("服务器异常", "提示", function() {
						pwdWindow.hide();
					});
				}
			});
		}
	</script>

</body>
</html>