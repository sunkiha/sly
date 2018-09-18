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
				onclick="add()">新增</a>
			<!-- <span style="padding-left: 5px;">名称：</span> <input
				id="name" class="mini-textbox" width="120" value="" /> <a
				class="mini-button" iconCls="icon-search" plain="true"
				onclick="search">查找</a> -->
		</div>
	</div>
	<div id="datagrid" class="mini-datagrid"
		style="width: 100%; height: 94%;" allowResize="true" idField="id"
		multiSelect="true" pageSize="20">
		<div property="columns">
			<!--<div type="indexcolumn"></div>-->
			<!--<div type="checkcolumn"></div>-->
			<div field="id" width="20" headerAlign="center">ID</div>
			<div renderer="img" width="80" headerAlign="center">图片</div>
			<div field="createDate" width="50" allowSort="true"
				dateFormat="yyyy-MM-dd HH:mm:dd">创建日期</div>
			<div name="action" width="80" headerAlign="center" align="center"
				renderer="operat" cellStyle="padding:0;">操作</div>
		</div>
	</div>

	<script type="text/javascript">
		var videoId;
		mini.parse();
		var datagrid = mini.get("datagrid");
		function operat(e) {
			var record = e.record;
			var uid = record._uid;
			return '<a class="Edit_Button" href="javascript:del()">删除</a>';

		}
		function img(e) {
			var imgUrl = e.record.url;
			var s = '<img  src="' +imgUrl+ '"/>';
			return s;
		}
		function format(e) {
			var format = e.record.format;
			if (!format) {
				return "暂无"
			}
			return format;
		}
		function type(e) {
			var type = e.record.type;
			if (type == 0) {
				return "免费"
			}
			if (type == 1) {
				return "时段"
			}
			if (type == 2) {
				return "单独"
			}
		}
		function status(e) {
			var record = e.record;
			var status = record.status;
			if (status == 0) {
				return '<a class="Edit_Button" href="javascript:update(1)">关闭</a>';
			} else if (status == 1) {
				return '<a class="Edit_Button" href="javascript:update(0)">启用</a>';
			}
		}
		function update(status) {
			var record = datagrid.getSelected();
			if (record) {
				var messageId = mini.loading("正在执行...");
				$.ajax({
					url : "operate/updateBanner",
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
				url : "view/product/video_img_add.jsp",
				title : "新增",
				width : 600,
				height :600,
				onload : function() {
					var iframe = this.getIFrameEl();
					var data = {
						videoId : videoId
					};
					iframe.contentWindow.SetData(data);
				},
				ondestroy : function(action) {
					datagrid.reload();
					if (action == "ok") {
					}
				}
			});
		}
		function mod() {
			var record = datagrid.getSelected();
			if (record) {
				mini.open({
					url : "view/product/operat_atlas.jsp",
					title : "新增",
					width : 300,
					height : 130,
					onload : function() {
						var iframe = this.getIFrameEl();
						var data = {
							videoId :record.videoId,
							id : record.id,
							action:"mod"
						};
						iframe.contentWindow.SetData(data);
					},
					ondestroy : function(action) {
						datagrid.reload();
						if (action == "ok") {
						}
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
							url : "product/delVideoImg",
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
		function SetData(data) {
			videoId = data.videoId;
			datagrid.setUrl('product/getVideoImgPage');
			datagrid.load({
				videoId : videoId
			});
			datagrid.sortBy("createDate", "desc");
		}
	</script>

</body>
</html>