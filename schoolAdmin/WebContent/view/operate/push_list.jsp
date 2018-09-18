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
				onclick="add()">新增</a> <span style="padding-left: 5px;">内容：</span> <input
				id="content" class="mini-textbox" width="120" value="" /> <a
				class="mini-button" iconCls="icon-search" plain="true"
				onclick="search">查找</a>
		</div>
	</div>
	<div id="datagrid" class="mini-datagrid"
		style="width: 100%; height: 94%;" allowResize="true"
		url="operate/getPushPage" idField="id" multiSelect="true"
		pageSize="20">
		<div property="columns">
			<!--<div type="indexcolumn"></div>-->
			<!--<div type="checkcolumn"></div>-->
			<div field="id" width="20" headerAlign="center">ID</div>
			<div field="content" width="50" headerAlign="center">内容</div>
			<div field="pushDate" width="80" headerAlign="center">时间段</div>
			<div field="s" width="80" headerAlign="center">推送条数</div>
			<div renderer="status" width="20" headerAlign="center">状态</div>
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
			return '<a class="Edit_Button" href="javascript:mod()">修改</a> <a class="Edit_Button" href="javascript:del()">删除</a>';

		}
		function img(e){
			var imgUrl = e.record.imgUrl;
			var s ='<img width="80px" src="'+getImg(imgUrl)+'"/>';
			return s;
		}
		function format(e){
			var format=e.record.format;
			if(!format){
				return "暂无"
			}
			return format;
		}
		function type(e){
			var type = e.record.type;
			if(type==0){
				return "免费"
			}
			if(type==1){
				return "时段"
			}
			if(type==2){
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
					url : "operate/updatePush",
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
				url : "view/operate/push_operat.jsp",
				title : "新增",
				width : 280,
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
					url : "view/operate/push_operat.jsp",
					title : "修改",
					width : 300,
					height : 230,
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
							url : "operate/delPush",
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
				content : mini.get("content").getValue()
			});
		}
		function addVideo(){
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
						videoId:record.id
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