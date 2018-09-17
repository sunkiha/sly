<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../comm.jsp"%>
<!DOCTYPE html>
<html>

<head>
<title></title>
<meta charset="UTF-8" />
<script src="view/miniui/boot.js" type="text/javascript"></script>
<script src="view/js/jquery-1.10.2.js" type="text/javascript"></script>
<style type="text/css">
</style>
</head>

<body>

	<div style="padding: 10px;" align="center">
		<form id="upload" action="userInfo/add" method="post"
			onsubmit="return validate()">
			<div style="padding-left: 11px; padding-bottom: 5px;">
				<table style="table-layout: fixed;">
					<tr>
						<td style="width: 70px;">帐号：</td>
						<td style="width: 150px;"><input name="username"
							class="mini-textbox" value="" /></td>
					</tr>
					<tr>
						<td style="width: 70px;">密码：</td>
						<td style="width: 150px;"><input name="password"
							class="mini-password" value="" /></td>
					</tr>
					<tr>
						<td style="width: 70px;">电话：</td>
						<td style="width: 150px;"><input name="phone"
							class="mini-textbox" value="" /></td>
					</tr>
					<tr>
						<td style="width: 70px;">QQ：</td>
						<td style="width: 150px;"><input name="qq"
							class="mini-textbox" value="" /></td>
					</tr>
				</table>
			</div>
			<button type="submit" style="width: 120px;">确定</button>
		</form>
	</div>
	<script type="text/javascript">
		function validate() {
			   if($("input[name='username']").val()==""){
				   alert("帐号不能为空");
				   return false;
			   }
			   if($("input[name=password]").val()==""){
				   alert("密码不能为空");
				   return false;
			   }
			   var phone=$("input[name=phone]").val()
			   if (!/^0?1[3|4|5|8][0-9]\d{8}$/.test(phone)) {
				   alert("请输入正确的手机号码")
					return false;
				}
		   var qq=$("input[name=qq]").val()
			   if(qq==""||isNaN(qq)){
				   alert("QQ不能为空且必须为数字");
				   return false;
			   }
			   return true;
		}
	</script>
</body>
</html>
