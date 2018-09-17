<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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
	<form id="equipmentFrom" action="careRemind/addBeiyun" method="post"
		enctype="multipart/form-data" onsubmit="return post()">

		<input type="hidden" name="id" class="mini-hidden" />
		<div style="padding-left: 11px; padding-bottom: 5px;">
			<table align="center" style="table-layout: fixed;">
				<tr>
					<td style="width: 70px;">天数：</td>
					<td style="width: 150px;">
					 <input 
						name="day" class="mini-combobox" style="width: 150px;"
						textField="name" value="1" valueField="value" valueFromSelect="true" url="careRemind/getDays" />
					</td>
				</tr>
				<tr>
					<td style="width: 70px;">状态图片：</td>
					<td style="width: 150px;"><input class="mini-htmlfile"
						name="statusPic" limitType="*.png;*.jpg" /></td>
				</tr>
				<tr>
					<td style="width: 70px;">陈述：</td>
					<td style="width: 150px;">
					<textarea name="talk" rows="20" cols="80">
						</textarea>
					</td>
				</tr>
			</table>
		</div>

		<div style="text-align: center; padding: 10px;">
			<button type="submit" style="width: 120px;">确定</button>
			<!-- 				<button class="mini-button" onclick="sub" style="width:120px;">确定</button> -->
		</div>
	</form>
	<script type="text/javascript">
	function post(){
		   if($("input[name='statusPic']").val()==""){
			   mini.alert("状态图不能为空");
			   return false;
		   }
		   if($("textarea[name='talk']").val().trim()==""){
			   mini.alert("陈述不能为空");
			   return false;
		   }  
		   return true;
	}
	</script>
</body>
</html>
