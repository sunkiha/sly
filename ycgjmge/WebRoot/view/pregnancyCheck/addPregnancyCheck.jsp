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
	<form id="frm" action="pregnancyCheck/addPregnancyCheck" method="post"
		enctype="multipart/form-data" onsubmit="return post()">

		<input type="hidden" name="id" class="mini-hidden" />
		<div style="padding-left: 11px; padding-bottom: 5px;">
			<table align="center" style="table-layout: fixed;">
				<tr>
					<td style="width: 70px;">名称：</td>
					<td style="width: 150px;"><input name="name"
						class="mini-textbox" style="width: 150px;" /></td>
				</tr>
				<tr>
					<td style="width: 70px;">banner图片：</td>
					<td style="width: 150px;"><input class="mini-htmlfile"
						name="banner" limitType="*.png;*.jpg" /></td>
				</tr>
				<tr>
					<td style="width: 70px;">最小周：</td>
					<td style="width: 150px;"><input class="mini-textbox"
							name="min" width="300px" />
						</td>
				</tr>
				<tr>
					<td style="width: 70px;">最大周：</td>
					<td style="width: 150px;"><input class="mini-textbox"
							name="max" width="300px" />
						</td>
				</tr>
				<tr>
					<td style="width: 70px;">描述：</td>
					<td style="width: 150px;"><textarea class="mini-TextArea"
							name="desc" width="300px" height="50">
						</textarea></td>
				</tr>
				<tr>
					<td style="width: 70px;">体格检查及咨询：</td>
					<td style="width: 150px;"><textarea class="mini-TextArea"
							name="normalCheck" width="300px" height="200">
						</textarea></td>
				</tr>
				<tr>
					<td style="width: 70px;">化验：</td>
					<td style="width: 150px;"><textarea class="mini-TextArea"
							name="assay" width="300px" height="200">
						</textarea></td>
				</tr>
				<tr>
					<td style="width: 70px;">辅助检查：</td>
					<td style="width: 150px;"><textarea class="mini-TextArea"
							name="assistCheck" width="300px" height="200">
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
		 	if ($("input[name='name']").val() == "") {
				mini.alert("名称不能为空");
				return false;
			}
			if ($("input[name='banner']").val() == "") {
				mini.alert("banner图不能为空");
				return false;
			}
			if ($("input[name='min']").val() == "") {
				mini.alert("最小周不能为空");
				return false;
			}
			if ($("input[name='max']").val() == "") {
				mini.alert("最大周不能为空");
				return false;
			} 
			if ($("input[name='max']").val()<=$("input[name='min']").val()) {
				mini.alert("最大周不能小于最小周");
				return false;
			}
			if ($("textarea[name='desc']").val().trim() == "") {
				mini.alert("描述不能为空");
				return false;
			}
			if ($("textarea[name='normalCheck']").val().trim() == "") {
				mini.alert("体格检查及咨询不能为空");
				return false;
			}
			if ($("textarea[name='assay']").val().trim() == "") {
				mini.alert("化验不能为空");
				return false;
			}
			if ($("textarea[name='assistCheck']").val().trim() == "") {
				mini.alert("辅助检查不能为空");
				return false;
			}
			return true;
		}
	</script>
</body>
</html>
