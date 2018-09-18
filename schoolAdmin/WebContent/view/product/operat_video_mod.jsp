<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@
include file="../comm.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />

<style type="text/css">
html, body {
	font-size: 12px;
	padding: 0;
	margin: 0;
	border: 0;
	height: 100%;
	overflow: hidden;
}
</style>
<link href="../demo.css" rel="stylesheet" type="text/css" />
<script src="view/miniui/boot.js" type="text/javascript"></script>
<script src="view/miniui/swfupload.js" type="text/javascript"></script>
</head>
<body>

	<form id="form1" method="post">
		<input name="id" class="mini-hidden" /> <input name="imgUrl"
			class="mini-hidden" />
		<div style="padding-left: 11px; padding-bottom: 5px;">
			<table style="table-layout: fixed;">
				<tr>
					<td style="width: 70px;">渠道：</td>
					<td style="width: 150px;"><input name="platformId"
						class="mini-combobox" textField="name" valueField="id"
						url="product/getPlatformAll" required="true" emptyText="" /></td>
				</tr>
				<tr>
					<td style="width: 70px;">分类：</td>
					<td style="width: 150px;"><input name="categoryId"
						class="mini-combobox" textField="name" valueField="id"
						url="product/getCategoryAll" required="true" emptyText="" /></td>
				</tr>
				<tr>
					<td style="width: 70px;">类型：</td>
					<td style="width: 150px;"><input name="type"
						class="mini-combobox" textField="name" valueField="id"
						required="true"
						data="[{id:0,name:'免费视频'},{id:1,name:'时段视频'},{id:2,name:'单独收费'}]"
						onvaluechanged="typeSelect" emptyText="" /></td>
				</tr>
				<tr id="price" style="display: none">
					<td style="width: 70px;">价格：</td>
					<td style="width: 150px;"><input name="price"
						class="mini-textbox" required="true" emptyText="" vtype="int" /></td>
				</tr>
				<tr>
					<td style="width: 70px;">名称：</td>
					<td style="width: 150px;"><input name="name"
						class="mini-textbox" required="true" emptyText="" /></td>
				</tr>
				<tr>
					<td style="width: 70px;">标题：</td>
					<td style="width: 150px;"><input name="title"
						class="mini-textbox" required="true" emptyText="" /></td>
				</tr>
				<tr>
					<td style="width: 70px;">简介：</td>
					<td style="width: 150px;"><input name="summary"
						class="mini-textArea" required="true" emptyText="" /></td>
				</tr>
				<tr>
					<td style="width: 70px;">关键词：</td>
					<td style="width: 150px;"><input name="tag"
						class="mini-textArea" required="true" emptyText="" /></td>
				</tr>
		<!-- 		<tr>
					<td style="width: 70px;">封面：</td>
					<td style="width: 150px;"><input name="img"
						class="mini-fileupload" limitSize="20MB" limitType="*.png;*.jpg;*.bmp;"
						flashUrl="view/miniui/swfupload.swf"
						uploadUrl="../../product/modVideo"
						onuploadsuccess="onUploadSuccess" onuploaderror="onUploadError"
						onfileselect="onFileSelect" /></td>
				</tr> -->
			</table>
		</div>
		<div style="text-align: center; padding: 10px;">
			<a class="mini-button" onclick="onOk"
				style="width: 60px; margin-right: 20px;">确定</a> <a
				class="mini-button" onclick="onCancel" style="width: 60px;">取消</a>
		</div>
	</form>
	<script type="text/javascript">
		mini.parse();
		var form = new mini.Form("form1");
		function SaveData() {
			var o = form.getData();
			form.validate();
			if (form.isValid() == false)
				return;
			//form.loading()
		/* 	var fileupload = mini.getbyName("img");
			if (fileupload.value) {
				fileupload.setPostParam(o);
				fileupload.startUpload();
			} else { */
				form.loading()
				var json = mini.encode(o);
				$.ajax({
					url : "product/modVideoNoFile",
					type : 'post',
					data : {
						data : json
					},
					cache : false,
					success : function(json) {
						if (json.code == 1) {
							mini.alert(json.msg, "提示", function() {
								CloseWindow();
							});
						} else {
							CloseWindow();
						}
						form.unmask();

					},
					error : function(jqXHR, textStatus, errorThrown) {
						form.unmask();
						mini.alert("服务器异常", "提示", function() {
							CloseWindow();
						});
					}
				});
			}

		//}

		////////////////////
		//标准方法接口定义
		function SetData(data) {
			if (data.action == "mod") {
				//跨页面传递的数据对象，克隆后才可以安全使用
				data = mini.clone(data);
				$.ajax({
					url : "product/getVideoById",
					data : {
						id : data.id
					},
					cache : false,
					success : function(text) {
						var o = mini.decode(text);
						form.setData(o);
						if (text.type == 2) {
							var price = document.getElementById("price");
							price.style.display = "";
						}
					}
				});
			} else if (data.action == "add") {
			}
		}

		function GetData() {
			var o = form.getData();
			return o;
		}
		function onOk(e) {
			SaveData();
		}
		function typeSelect(e) {
			var priceMi = mini.getbyName("price");
			var price = document.getElementById("price");
			if (e.value == 2) {
				priceMi.setValue()
				price.style.display = "";
			} else {
				priceMi.setValue(0)
				price.style.display = "none";
			}
		}
		function onFileSelect(e) {
			//alert("选择文件");
		}
		function onUploadSuccess(e) {
			var data = JSON.parse(e.serverData)
			if (data.code == 1) {
				mini.alert(json.msg, "提示", function() {
					CloseWindow();
				});
			} else {
				CloseWindow();
			}
			this.setText("");
		}
		function onUploadError(e) {
			mini.alert("上传失败", "提示", function() {
				CloseWindow();
			});
		}
	</script>
</body>
</html>
