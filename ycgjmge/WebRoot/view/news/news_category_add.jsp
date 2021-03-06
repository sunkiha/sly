﻿<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../comm.jsp"%>
<!DOCTYPE html>
<html>

<head>
<title></title>
<meta charset="UTF-8" />
<LINK rel=stylesheet href="view/js/ueditor/themes/default/ueditor.css">
<script src="view/miniui/boot.js" type="text/javascript"></script>
<script type="text/javascript" charset="utf-8"
	src="view/js/ueditor/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8"
	src="view/js/ueditor/ueditor.all.js"></script>
<script type="text/javascript" charset="utf-8"
	src="view/js/ueditor/lang/zh-cn/zh-cn.js"></script>
<style type="text/css">
</style>
<!--  <script>
        var UEDITOR_HOME_URL = "/ueditor/"
    </script> -->
</head>

<body>
	<form id="frm" action="news/addNewsCategory" method="post"
		onsubmit="return post()">

		<input type="hidden" name="newsId" class="mini-hidden"
			value="${newsId}" />
		<div style="padding-left: 11px; padding-bottom: 5px;">
			<table align="center" style="table-layout: fixed;">
				<tr>
					<td style="width: 80px;">名称：</td>
					<td style="width: 100px;"><input name="name"
						class="mini-textbox" width="200px" /></td>
				</tr>
				<tr>
					<td style="width: 80px;">所属：</td>
					<td style="width: 100px;"><input name="type" id="type" onenter="onKeyEnter" class="mini-combobox"
				style="width: 150px;" textField="name" valueField="value" value="1"
				valueFromSelect="true" data="typeData"  /> </td>
				</tr>
			</table>
		</div>

		<div style="text-align: center; padding: 10px;">
			<button class="mini-button" onclick="sub" style="width: 120px;">确定</button>
			<!-- 				<button class="mini-button" onclick="sub" style="width:120px;">确定</button> -->
		</div>
	</form>
	<script type="text/javascript">
	  var typeData = [{name:"备孕",value:0 },{name:"怀孕",value:1 }];
		function post() {
			if ($("input[name='name']").val() == "") {
				mini.alert("名称不能为空");
				return false;
			}
			return true;
		}
		function sub() {
			if (!post()) {
				return;
			}
			var frm = new mini.Form("frm");
			var messageId = mini.loading("正在执行...");
			var data = frm.getData();
			$.ajax({
				url : "news/addNewsCategory",
				data : data,
				type : "post",
				success : function(data) {
					mini.hideMessageBox(messageId);
					if (data.code) {
						mini.alert(data.msg);
						//closeW()
					} else {
						mini.alert(data.msg);
					}
				}
			});
		}
		function closeW() {
			if (window.CloseOwnerWindow)
				return window.CloseOwnerWindow("cancel");
			else
				window.close();
		}
		
	</script>
</body>
</html>
