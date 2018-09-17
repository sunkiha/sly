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
	<form id="frm" action="communityTopic/modCommunityTopic" method="post"
		enctype="multipart/form-data" onsubmit="return post()">
		<input type="hidden" name="img" class="mini-hidden" /> <input
			type="hidden" name="id" class="mini-hidden" />
		<div style="padding-left: 11px; padding-bottom: 5px;">
			<table align="center" style="table-layout: fixed;">
				<tr>
					<td style="width: 70px;">名称：</td>
					<td style="width: 150px;"><input name="name"
						class="mini-textbox" style="width: 150px;" /></td>
				</tr>
				<tr>
					<td style="width: 70px;">图片：</td>
					<td style="width: 150px;"><input class="mini-htmlfile"
						name="imgTmp" limitType="*.png;*.jpg" /></td>
				</tr>
				<tr>
					<td style="width: 70px;">描述：</td>
					<td style="width: 150px;"><textarea class="mini-textarea"
							name="desc" width="300px" height="80"></textarea></td>
				</tr>
			</table>
		</div>

		<div style="text-align: center; padding: 10px;">
			<button type="submit" style="width: 60px;">确定</button>
			<button type="button" onclick="onCancel()" style="width: 60px;">取消</button>
		</div>
	</form>
	<script type="text/javascript">
		function post() {
			if ($("input[name='name']").val() == "") {
				mini.alert("名称不能为空");
				return false;
			}
			if ($("textarea[name='desc']").val().trim() == "") {
				mini.alert("描述不能为空");
				return false;
			}
			return true;
		}
		function SetData(data) {
			var frm = new mini.Form("#frm");
			$.ajax({
				url : "communityTopic/getCommunityTopicById",
				data : {
					id : data.id
				},
				success : function(json) {
					frm.setData(json);
				},
				error : function() {
					mini.alert("服务器异常");
				}
			});
		}
		function CloseWindow(action) {
			if (action == "close" && form.isChanged()) {
				if (confirm("数据被修改了，是否先保存？")) {
					return false;
				}
			}
			if (window.CloseOwnerWindow)
				return window.CloseOwnerWindow(action);
			else
				window.close();
		}
		function onCancel(e) {
			CloseWindow("cancel");
		}
	</script>
</body>
</html>
