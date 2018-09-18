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
			统计：
			<!-- <div id="gb" style="float:left;font-size: 6px" class="mini-checkboxlist" repeatItems="3" repeatDirection="horizontal"
				repeatLayout="flow" textField="text" valueField="id"
				data='[{ "id": "o.chargeId", "text": "计费类型" },{ "id": "o.payMode", "text": "渠道" },{ "id": "jp", "text": "状态" }]'>
			</div> -->
			<input id="charge" class="mini-checkbox" text="计费类型" trueValue="o.chargeId" /> <input id="payMode" class="mini-checkbox" text="渠道" trueValue="o.payModeId"  /> <input
			id="status" trueValue="o.status" text="状态"	class="mini-checkbox" />  
			<!-- 计费类型： <input id="chargeId" class="mini-combobox" textField="name"
				valueField="id" url="product/getChargeAll" nullItemText=""
				showNullItem="true" emptyText="" /> 渠道：<input id="payModeId"
				class="mini-combobox" textField="name" valueField="id"
				nullItemText="" showNullItem="true" url="product/getChargeAll"
				emptyText="" /> 日期：<input id="startDate" class="mini-datepicker" /> -->
			<a class="mini-button" iconCls="icon-search" plain="true" style=""
				onclick="search">查找</a>
		</div>
	</div>
	<div id="datagrid" class="mini-datagrid"
		style="width: 100%; height: 94%;" allowResize="true"
		url="operate/getOrderCountPage" idField="id" multiSelect="true"
		pageSize="20">
		<div property="columns">
			<!--<div type="indexcolumn"></div>-->
			<!--<div type="checkcolumn"></div>-->
			<!-- <div field="id" width="20" headerAlign="center">ID</div> -->
			<div field="payModeName" width="50" headerAlign="center">渠道</div>
			<div field="chargeName" width="80" headerAlign="center">计费类型</div>
			<div field="videoName" width="80" headerAlign="center">视频</div>
			<div field="totalPrice" width="40" headerAlign="center">总价格</div>
			<div renderer="status" width="20" headerAlign="center">状态</div>
			<!-- <div name="action" width="80" headerAlign="center" align="center"
				renderer="operat" cellStyle="padding:0;">操作</div> -->
		</div>
	</div>

	<script type="text/javascript">
		mini.parse();
		var datagrid = mini.get("datagrid");
		datagrid.load({
		//group
		});
		datagrid.sortBy("createDate", "desc");
		function operat(e) {
			var record = e.record;
			var uid = record._uid;
			return '<a class="Edit_Button" href="javascript:mod()">修改</a> <a class="Edit_Button" href="javascript:del()">删除</a>';

		}
		function status(e) {
			var record = e.record;
			var status = record.status;
			if (status == 0) {
				return '待付款';
			} else if (status == 1) {
				return '已付款';
			}
		}
		function type(e) {
			var record = e.record;
			var os = record.type;
			if (os == 0) {
				return "android";
			} else if (os == 1) {
				return "ios"
			} else {
				return os;
			}
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
				mini.open({
					url : "view/product/mod_version.jsp",
					title : "修改",
					width : 300,
					height : 200,
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
							url : "product/delVersion",
							data : {
								id : record.id,
								url : record.url
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
			var charge=mini.get("charge").getValue();
			var payMode=mini.get("payMode").getValue();
			var status=mini.get("status").getValue();
			var a=new Array();
			if(charge!="false"){
				a.push(charge)
			}
			if(payMode!="false"){
				a.push(payMode)
			}
			if(status!="false"){
				a.push(status)
			}
		/* 	var id = mini.get("id").getValue();
			var chargeId = mini.get("chargeId").getFormValue();
			var startDate = mini.get("startDate").getFormValue();
			var endDate = mini.get("endDate").getValue(); */
			datagrid.load({
				gp:a.join(",")
			/* 	id : id,
				chargeId : chargeId,
				startDate : startDate,
				endDate : endDate */
			});
		}
	</script>

</body>
</html>