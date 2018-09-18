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

	<form id="form1" method="post" 
		>
		<input name="id" class="mini-hidden" />
		<input name="imgUrl" class="mini-hidden" />
		<div style="padding-left: 11px; padding-bottom: 5px;">
			<table style="table-layout: fixed;">
				<tr>
					<td style="width: 70px;">封面：</td>
					<td style="width: 150px;">
					<input
						id="img" class="mini-fileupload"  limitSize="20MB"
						limitType="*.png;*.jpg;*.bmp;" flashUrl="view/miniui/swfupload.swf"
						uploadUrl="../../operate/addBanner" onuploadsuccess="onUploadSuccess" onuploaderror="onUploadError" required="true"
						onfileselect="onFileSelect" />
					</td>
				</tr>
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
		var fileupload = mini.get("img");
		function SaveData() {
			var o = form.getData();
			form.validate();
			if (form.isValid() == false)
				return;
		 	fileupload.setPostParam(o);
			fileupload.startUpload(); 
		}

		////////////////////
		//标准方法接口定义
		function SetData(data) {
/* 			if (data.action == "mod") {
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
					}
				});
			} 
 */		}

		function GetData() {
			var o = form.getData();
			return o;
		}
		function onOk(e) {
			SaveData();
		}

		function onFileSelect(e) {
			//alert("选择文件");
		}
		function onUploadSuccess(e) {
			// form.unmask();
			var data=JSON.parse(e.serverData)
			mini.alert(data.msg,"",function(){
				CloseWindow();
				this.setText("");
			})
		}
		function onUploadError(e) {
			mini.alert("上传失败","提示",function(){
				CloseWindow();
			})
		}
	</script>
</body>
</html>
