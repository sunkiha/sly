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
		<input name="id" class="mini-hidden" />
		<div style="padding-left: 11px; padding-bottom: 5px;">
			<table style="table-layout: fixed;">
				<tr>
					<td style="width: 70px;">外部地址：</td>
					<td style="width: 150px;"><input name="videoUrl"
						class="mini-textbox"  required="true"/></td>
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
		var videoId;
		function SaveData() {
			var o = form.getData();
			form.validate();
			if (form.isValid() == false)
				return;
			form.loading()
			$.ajax({
				url : "product/addVideoUrl",
				type : 'post',
				data :o,
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
						//form.setChanged(false);
					}
				});
			} else if (data.action == "add") {
			}else{
				videoId=data.videoId;
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
			CloseWindow();
			this.setText("");
		}
		function onUploadError(e) {
			mini.alert("上传失败","提示",function(){
				CloseWindow();
			})
		}
	</script>
</body>
</html>
