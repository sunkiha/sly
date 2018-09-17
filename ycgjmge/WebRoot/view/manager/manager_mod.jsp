<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../comm.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>肿瘤后台管理系统</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<link href="../demo.css" rel="stylesheet" type="text/css" />

<style type="text/css">
body {
	width: 100%;
	height: 100%;
	margin: 0;
	overflow: hidden;
}
</style>
<script src="view/miniui/boot.js" type="text/javascript"></script>

</head>
<body>
	<!-- <div id="loginWindow" class="mini-window" title="用户登录" style="width:350px;height:165px;" 
   showModal="true" showCloseButton="false"
    > -->
	<br />
	<div id="frm" style="padding: 15px; padding-top: 10px;">
	<input type="hidden" name="id" class="mini-hidden"/>
		<table align="center">
			<tr>
				<td style="width: 60px;"><label>帐号：</label></td>
				<td><input id="username" name="username" class="mini-textbox"
					style="width: 150px;" /></td>
			</tr>
			<tr>
				<td style="width: 60px;"><label>密码：</label></td>
				<td><input id="password" name="password" class="mini-textbox"
					style="width: 150px;" /></td>
			</tr>
			<tr>
				<td></td>
				<td style="padding-top: 5px;">
					<button onclick="onLoginClick" class="mini-button"
						style="width: 120px;">添加</button>
				</td>
			</tr>
		</table>
	</div>
	<!-- </div> -->
	<script type="text/javascript">
		mini.parse();
		function SetData(data) {
			var frm = new mini.Form("#frm");
			$.ajax({
				url : "manager/getManagerById",
				data : {
					id : data.id
				},
				success : function(json) {
					frm.setData(json);
				},
				error : function() {

				}
			});
		}
		function onLoginClick(e) {
			if ($("input[name='username']").val() == "") {
				mini.alert("用户名不能为空");
				return;
			} else if ($("input[name='username']").val().trim().length < 4) {
				mini.alert("用户长度至少为4位");
				return

			} else if ($("input[name='password']").val() == "") {
				mini.alert("密码不能为空");
				return;
			} else if (!($("input[name='password']").val().trim().length > 5
					&& $("input[name='password']").val().trim().length < 13)) {
				mini.alert("密码必须在6-12位之间");
				return;
			}
			var form = new mini.Form("#frm");
			var messageId = mini.loading("正在执行...");
			var data = form.getData();
 		$.ajax({
				url : "manager/managerMod",
				data : data,
				type : "post",
				success : function(data) {
					mini.hideMessageBox(messageId);
					mini.alert(data, "", function() {
						closeW();
					});
				},
				error : function() {
					mini.hideMessageBox(messageId);
					mini.alert("修改失败,用户名可能存在");
				}
			}); 
		}
		function onResetClick(e) {
			var form = new mini.Form("#loginWindow");
			form.clear();
		}
		/////////////////////////////////////
		function isEmail(s) {
			// if (s.search(/^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/) != -1)
			return true;
			//  else
			//return false;
		}
		function onUserNameValidation(e) {
			/*      if (e.isValid) {
			         if (isEmail(e.value) == false) {
			             e.errorText = "必须输入邮件地址";
			             e.isValid = false;
			         }
			     } */
		}
		function onPwdValidation(e) {
			if (e.isValid) {
				if (e.value.length < 3) {
					e.errorText = "密码不能少于3个字符";
					e.isValid = false;
				}
			}
		}
		function check() {
			if ($("input[name='banner']").val() == "") {
				mini.alert("banner图片不能为空");
				return false;
			}
			return true;
		}
	</script>

</body>
</html>