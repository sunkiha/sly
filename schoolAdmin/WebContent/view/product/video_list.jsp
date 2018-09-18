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
				onclick="add()">新增</a> <a class="mini-button" iconCls="icon-add" plain="true"
				onclick="updateTime()">封面更新频率</a> <span style="padding-left: 5px;">名称：</span> <input
				id="name" class="mini-textbox" width="120" value="" /> 分类：<input id="categoryId"
						class="mini-combobox" textField="name" valueField="id"
						url="product/getCategoryAll" required="true" emptyText=""  showNullItem="true"  /> 渠道：<input id="platformId"
						class="mini-combobox" textField="name" valueField="id"
						url="product/getPlatformAll" emptyText=""  showNullItem="true" /><a
				class="mini-button" iconCls="icon-search" plain="true"
				onclick="search">查找</a>
		</div>
	</div>
	<div id="datagrid" class="mini-datagrid"
		style="width: 100%; height: 94%;" allowResize="true"
		url="product/getVideoPage" idField="id" multiSelect="true"
		pageSize="20">
		<div property="columns">
			<!--<div type="indexcolumn"></div>-->
			<!--<div type="checkcolumn"></div>-->
			<div field="id" width="20" headerAlign="center">ID</div>
			<div field="name" width="30" headerAlign="center">名称</div>
			<div field="title" width="30" headerAlign="center">标题</div>
			<div field="summary" width="30" headerAlign="center">简介</div>
			<div field="tag" width="30" headerAlign="center">关键字</div>
			<div renderer="type" width="20" headerAlign="center">类型</div>
			<div field="categoryName" width="20" headerAlign="center">分类</div>
			<div renderer="status" width="20" headerAlign="center">状态</div>
			<div field="price" width="20" headerAlign="center">价格</div>
			<!-- <div width="40" headerAlign="center" renderer="img">封面</div> -->
			<div field="videoUrl" width="30" headerAlign="center">地址</div>
			<div field="createDate" width="30" allowSort="true"
				dateFormat="yyyy-MM-dd HH:mm:dd">创建日期</div>
			<div field="modDate" width="30" allowSort="true"
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
			return '<a class="Edit_Button" href="javascript:addImg()">上传封面</a> <a class="Edit_Button" href="javascript:addVideo()">上传视频</a> <a class="Edit_Button" href="javascript:addVideoUrl()">外部地址</a> <a class="Edit_Button" href="javascript:mod()">修改</a> <a class="Edit_Button" href="javascript:del()">删除</a>';

		}
		function img(e) {
			var imgUrl = e.record.imgUrl;
			var s = '<img src="' +imgUrl+ '"/>';
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
			if (status == 0) {
			/*  	var imgUrl = record.imgUrl;
				if (!imgUrl){
					mini.alert("未上传图片不能启用")
					return;
				}  */
		 		var videoUrl = record.videoUrl;
				if (!videoUrl) {
					mini.alert("未上传视频不能启用")
					return;
				} 
			}
			if (record) {
				var messageId = mini.loading("正在执行...");
				$.ajax({
					url : "product/updateVideo",
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
				url : "view/product/operat_video.jsp",
				title : "新增",
				width : 300,
				height : 350,
				onload : function() {

				},
				ondestroy : function(action) {
					datagrid.reload();

				}
			});
		}
		function updateTime(){
			
			mini.open({
				url : "view/product/video_picture_update_time.jsp",
				title : "新增",
				width : 300,
				height : 140,
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
					url : "view/product/operat_video_mod.jsp",
					title : "修改",
					width : 300,
					height : 360,
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
							url : "product/delVideo",
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
				categoryId : mini.get("categoryId").getValue(),
				platformId : mini.get("platformId").getValue()
			});
		}
		function addVideo() {
			var record = datagrid.getSelected();
			mini.open({
				url : "view/product/add_video.jsp",
				title : "上传视频",
				width : 300,
				height : 130,
				onload : function() {
					var iframe = this.getIFrameEl();
					var data = {
						//action : "mod",
						videoId : record.id
					};
					iframe.contentWindow.SetData(data);
				},
				ondestroy : function(action) {
					datagrid.reload();

				}
			});
		}
		function addImg() {
			var record = datagrid.getSelected();
			mini.open({
				url : "view/product/video_img_list.jsp",
				title : "上传封面",
				width : 800,
				height : 500,
				onload : function() {
					var iframe = this.getIFrameEl();
					var data = {
						//action : "mod",
						videoId : record.id
					};
					iframe.contentWindow.SetData(data);
				},
				ondestroy : function(action) {
					datagrid.reload();

				}
			});
		}
		function addVideoUrl() {
			var record = datagrid.getSelected();
			mini.open({
				url : "view/product/add_video_url.jsp",
				title : "外部视频",
				width : 300,
				height : 130,
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
	</script>

</body>
</html>