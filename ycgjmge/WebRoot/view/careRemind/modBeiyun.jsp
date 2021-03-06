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
	<form id="equipmentFrom" action="careRemind/modBeiyun" method="post"
		enctype="multipart/form-data" onsubmit="return post()">

		<input type="hidden" name="id" class="mini-hidden" />
		<div style="padding-left: 11px; padding-bottom: 5px;">
			<table align="center" style="table-layout: fixed;">
				<tr>
					<td style="width: 70px;">天数：</td>
					<td style="width: 150px;">
					<input name="day"
						class="mini-combobox" style="width: 150px;" textField="name"
						valueField="value" valueFromSelect="true"
						url="careRemind/getDays" /></td>
				</tr>
				<tr>
					<td style="width: 70px;">状态图片：</td>
					<td style="width: 150px;"><input class="mini-htmlfile"
						name="statusPic" limitType="*.png;*.jpg" /></td>
				</tr>
				<tr>
					<td style="width: 70px;">陈述：</td>
					<td style="width: 150px;"><textarea class="mini-TextArea" name="talk" rows="20"
							cols="80" width="300px" height="180">
						</textarea></td>
				</tr>
			</table>
		</div>

		<div style="text-align: center; padding: 10px;">
			<button type="submit" style="width: 120px;">确定</button>
			<!-- 				<button class="mini-button" onclick="sub" style="width:120px;">确定</button> -->
		</div>
	</form>
	<script type="text/javascript">
		function post() {
			if ($("textarea[name='talk']").val().trim() == "") {
				mini.alert("陈述不能为空");
				return false;
			}
			return true;
		}
	  	function  SetData(data){
	  		var equipmentFrom=new mini.Form("#equipmentFrom");
	  		$.ajax({
				url : "careRemind/getBeiyunById",
				data:{
					id:data.id
				},
				success : function(json) {
					//var json=mini.decode(text);
					equipmentFrom.setData(json);
				},
				error : function() {
					
				}
			});
	  	}
	</script>
</body>
</html>
