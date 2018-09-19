﻿<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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
		<div style="padding-left: 11px; padding-bottom: 5px;">
			<table style="table-layout: fixed;">
				<tr>
					<td style="width: 70px;">更行频率(分钟)：</td>
					<td style="width: 150px;"><input name="updateTime"
						class="mini-textbox" required="true" emptyText="" vtype="int" /></td>
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
		form.loading()
		$.ajax({
			url : "product/getVideoPictureUpdateTime",
			type : 'get',
			cache : false,
			success : function(json) {
				form.setData(json);
				form.unmask();
			},
			error : function(jqXHR, textStatus, errorThrown) {
				form.unmask();
				mini.alert("服务器异常");
			}
		});
		function SaveData() {
			var o = form.getData();
			form.validate();
			if (form.isValid() == false)
				return;
			form.loading()
			$.ajax({
				url : "product/updateVideoPictureUpdateTime",
				type : 'post',
				cache : false,
				data : o,
				success : function(json) {
					form.unmask();
					if (json.code == 0) {
						mini.alert(json.msg, "提示", function() {
							CloseWindow();
						})
					} else {
						mini.alert("服务器异常");
					}
				},
				error : function(jqXHR, textStatus, errorThrown) {
					form.unmask();
					mini.alert("服务器异常");
				}
			});
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
			 */}

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
	</script>
</body>
</html>