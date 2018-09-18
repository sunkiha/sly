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
		<div class="mini-toolbar" style="border-bottom: 0; padding: 0px;">
			<a class="mini-button" iconCls="icon-add" plain="true"
				onclick="add()">新增</a> <span style="padding-left: 5px;">名称：</span> <input
				id="name" class="mini-textbox" width="120" value="" /> 渠道：<input id="platformId"
						class="mini-combobox" textField="name" valueField="id"
						url="product/getPlatformAll" emptyText=""  showNullItem="true" /><a
				class="mini-button" iconCls="icon-search" plain="true"
				onclick="search">查找</a>
		</div>
	</div>
	<div id="datagrid" class="mini-datagrid"
		style="width: 100%; height: 94%;" allowResize="true"
		url="product/getAtlasPage" idField="id" multiSelect="true"
		pageSize="20">
		<div property="columns">
			<!--<div type="indexcolumn"></div>-->
			<!--<div type="checkcolumn"></div>-->
			<div field="id" width="20" headerAlign="center">ID</div>
			<div renderer="img" width="80" headerAlign="center">封面</div>
			<div field="platformName" width="50" headerAlign="center">渠道</div>
			<!-- 	<div renderer="status" width="20" headerAlign="center">状态</div> -->
			<div field="createDate" width="50" allowSort="true"
				dateFormat="yyyy-MM-dd HH:mm:dd">创建日期</div>
			<div field="modDate" width="50" allowSort="true"
				dateFormat="yyyy-MM-dd HH:mm:dd">修改日期</div>
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
			return '<a class="Edit_Button" href="javascript:upload()">上传图集</a> <a class="Edit_Button" href="javascript:mod()">修改</a> <a class="Edit_Button" href="javascript:del()">删除</a>';

		}
		function img(e) {
			var imgUrl = e.record.imgUrl;
			var s = '<img src="' +imgUrl + '"/>';
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
					url : "product/updateVideoAtlas",
					data : {
						status : status,
						videoId : record.videoId
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
		function upload() {
			var record = datagrid.getSelected();
			if (record) {
				mini.open({
					url : "view/product/atlas_img_list.jsp",
					title : "新增",
					width : 800,
					height : 500,
					onload : function() {
						var iframe = this.getIFrameEl();
						var data = {
							//action : "mod",
							atlasId : record.id
						};
						iframe.contentWindow.SetData(data);
					},
					ondestroy : function(action) {
						datagrid.reload();
					}
				});
			}
		}
		function add() {
			mini.open({
				url : "view/product/atlas_add.jsp",
				title : "新增",
				width : 300,
				height : 150,
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
					url : "view/product/atlas_mod.jsp",
					title : "修改",
					width : 300,
					height : 150,
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
				mini.confirm("此操作会将图片一起删除,确定要删除吗?", "提示", function(data) {
					if (data == "ok") {
						var messageId = mini.loading("正在执行...");
						$.ajax({
							url : "product/delAtlas",
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
				name : mini.get("name").getValue(),
				platformId : mini.get("platformId").getValue()
			});
		}
	</script>

</body>
</html>