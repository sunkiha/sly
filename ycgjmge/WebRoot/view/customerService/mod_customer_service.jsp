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
	<form id="equipmentFrom" action="customerService/modCustomerService" method="post"
		enctype="multipart/form-data" onsubmit="return post()">

		<input type="hidden" name="id" class="mini-hidden" value="${bean.id}"/>
		<div style="padding-left: 11px; padding-bottom: 5px;">
			<table align="center" style="table-layout: fixed;">
				<tr>
					<td style="width: 80px;">昵称：</td>
					<td style="width: 100px;"><input name="nickname"
						class="mini-textbox" style="width: 150px;" value="${bean.nickname}" /></td>
				</tr>
				<tr>
					<td style="width: 80px;">QQ：</td>
					<td style="width: 100px;"><input name="qq"
						class="mini-textbox" style="width: 150px;" value="${bean.qq}"/></td>
				</tr>
				<tr>
					<td style="width: 80px;">头像：</td>
					<td style="width: 100px;"><input class="mini-htmlfile"
						name="img" limitType="*.png;*.jpg" style="width: 150px;" /></td>
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
			   if($("input[name='nickname']").val()==""){
				   mini.alert("昵称不能为空");
				   return false;
			   }else if($("input[name=qq]").val()==""){
				   mini.alert("qq不能为空");
				   return false;
			   }else if(isNaN($("input[name=qq]").val())){
				   mini.alert("qq必须为数字");
				   return false;
			   }
			   if('${bean.id}'==""&&$("input[name='img']").val()==""){
				   mini.alert("图片不能为空");
				   return false;
			   }
			   return true;
		}
	</script>
</body>
</html>
