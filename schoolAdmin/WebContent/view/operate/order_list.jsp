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
			 <span style="padding-left: 5px;">订单号：</span> <input
				id="id" class="mini-textbox" width="120" value="" vtype="int" /> 计费类型：<input id="chargeId"
						class="mini-combobox" textField="name" valueField="id"
						url="product/getChargeAll"  showNullItem="true" 
						 emptyText=""  /> 状态：<input id="status"
						class="mini-combobox" textField="name" valueField="id"
						data="[{'id':0,'name':'待付款'},{'id':1,'name':'已付款'}]"  showNullItem="true" 
						 emptyText=""  /> 开始时间：<input id="startDate" class="mini-datepicker" /> 结束时间：<input id="endDate" class="mini-datepicker"/>   <a
				class="mini-button" iconCls="icon-search" plain="true"
				onclick="search">查找</a>
		</div>
	</div>
	<div id="datagrid" class="mini-datagrid"
		style="width: 100%; height: 94%;" allowResize="true"
		url="operate/getOrderPage" idField="id" multiSelect="true"
		pageSize="20">
		<div property="columns">
			<!--<div type="indexcolumn"></div>-->
			<!--<div type="checkcolumn"></div>-->
			<div field="id" width="20" headerAlign="center">ID</div>
			<div field="phone" width="50" headerAlign="center">手机</div>
			<div field="payModeName" width="50" headerAlign="center">通道</div>
			<div field="chargeName" width="80" headerAlign="center">计费类型</div>
			<div field="videoName" width="80" headerAlign="center">视频</div>
			<div field="price" width="40" headerAlign="center">价格</div>
			<div renderer="status" width="20" headerAlign="center">状态</div>
			<div field="createDate" width="100" allowSort="true"
				dateFormat="yyyy-MM-dd HH:mm:dd">创建日期</div>
			<div field="modDate" width="100" allowSort="true"
				dateFormat="yyyy-MM-dd HH:mm:dd">修改日期</div>
			<!-- <div name="action" width="80" headerAlign="center" align="center"
				renderer="operat" cellStyle="padding:0;">操作</div> -->
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
			return '<a class="Edit_Button" href="javascript:mod()">修改</a> <a class="Edit_Button" href="javascript:del()">删除</a>';

		}
		function status(e) {
			var record = e.record;
			var status = record.status;
			if (status == 0) {
				return '失败';
			} else if (status == 1) {
				return '成功';
			}
		}
		function type(e){
			var record=e.record;
			var os=record.type;
			if(os==0){
				return "android";
			}else if(os==1){
				return "ios"
			}else{
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
								url:record.url
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
			var id=mini.get("id").getValue();
			var chargeId=mini.get("chargeId").getFormValue();
			var startDate=mini.get("startDate").getFormValue();
			var endDate=mini.get("endDate").getValue();
			var status=mini.get("status").getValue();
			datagrid.load({
				id:id,
				chargeId:chargeId,
				startDate:startDate,
				endDate:endDate,
				status:status
			});
		}
	</script>

</body>
</html>