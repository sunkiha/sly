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
	<form id="frm">
		<input type="hidden" name="id" class="mini-hidden" />
		<div style="padding-left: 11px; padding-bottom: 5px;">
			<table align="center" style="table-layout: fixed;">
				<tr>
					<td style="width: 80px;">一级分类：</td>
					<td style="width: 100px;"><input id="circleCategoryId"
						name="circleCategoryId" class="mini-combobox"
						style="width: 150px;" textField="name" valueField="id"
						onvaluechanged="onTypeChanged" valueFromSelect="true"
						url="circle/getCircleCategoryAll" required="true" /></td>
				</tr>
				<tr>
					<td style="width: 80px;">二级分类：</td>
					<td style="width: 100px;"><input id="circleId" name="circleId"
						class="mini-combobox" style="width: 150px;" textField="name"
						valueField="id" required="true" /></td>
				</tr>
				<tr>
					<td style="width: 80px;">主题：</td>
					<td style="width: 100px;"><input name="title"
						class="mini-textarea" style="width: 150px; height: 50px"
						required="true" /></td>
				</tr>
				<tr>
					<td style="width: 80px;">内容：</td>
					<td style="width: 100px;"><input name="content"
						class="mini-textarea" style="width: 150px; height: 100px"
						required="true" /></td>
				</tr>
			</table>
		</div>

		<div style="text-align: center; padding: 10px;">
			<a class="mini-button" onclick="sub"
				style="width: 60px; margin-right: 20px;">确定</a> <a
				class="mini-button" onclick="onCancel" style="width: 60px;">取消</a>
		</div>
	</form>
	<script type="text/javascript">
		mini.parse();
		var form = new mini.Form("frm");
		var circleCategoryId = mini.get("circleCategoryId");
		var circleId = mini.get("circleId");
		function onTypeChanged() {
			var value = circleCategoryId.getValue();
			circleId.setValue("");
			circleId
					.setUrl("circle/getCircleListByCategoryId?circleCategoryId="
							+ value);
		}
		function setData(data) {
			var action = data.action;
			if (action == "mod") {
				$.ajax({
					url : "topics/getTopicsById",
					data : {
						id : data.id
					},
					success : function(json) {
						form.setData(json);
						onTypeChanged()
						circleId.setValue(json.circleId);
					},
					error : function() {
						mini.alert("服务器异常");
					}
				});
			}

		}

		function sub() {
			var data = form.getData();
			form.validate();
			if (form.isValid() == false)
				return;
			$.ajax({
				url : "topics/addTopics",
				type : 'post',
				data : data,
				cache : false,
				success : function(text) {
					CloseWindow("save");
				},
				error : function(jqXHR, textStatus, errorThrown) {
					//alert(jqXHR.responseText);
					mini.alert("服务器异常");
					CloseWindow();
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
