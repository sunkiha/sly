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
	<form id="equipmentFrom" action="circle/modCircle" method="post"
		enctype="multipart/form-data" onsubmit="return post()">

		<input type="hidden" name="id" class="mini-hidden" value="${bean.id}" />
		<input type="hidden" name="banner1" class="mini-hidden"
			value="${bean.banner}" />
		<div style="padding-left: 11px; padding-bottom: 5px;">
			<table align="center" style="table-layout: fixed;">
				<tr>
					<td style="width: 80px;">一级分类：</td>
					<td style="width: 100px;"><input id="circleCategory"
						name="circleCategoryId" class="mini-combobox"
						style="width: 150px;" textField="name" valueField="id"
						valueFromSelect="true" url="circle/getCircleCategoryAll"
						value="${bean.circleCategoryId }" /></td>
				</tr>
				<tr>
					<td style="width: 80px;">名称：</td>
					<td style="width: 100px;"><input name="name"
						class="mini-textbox" style="width: 150px;" value="${bean.name }" /></td>
				</tr>
				<tr>
					<td style="width: 80px;">图片：</td>
					<td style="width: 100px;"><input class="mini-htmlfile"
						name="banner" limitType="*.png;*.jpg" style="width: 150px;"
						value="${bean.banner }" /></td>
				</tr>
			</table>
		</div>

		<div style="text-align: center; padding: 10px;">
			<button type="submit" style="width: 60px;">确定</button>
			<button type="button" onclick="closeW()" style="width: 60px;">取消</button>
		</div>
	</form>
	<script type="text/javascript">
		function post() {
			var circleCategory = mini.get("circleCategory").getValue();
			if (circleCategory == "") {
				mini.alert("分类不能为空");
				return false;
			} else if ($("input[name=name]").val() == "") {
				mini.alert("名称不能为空");
				return false;
			}
			if ('${bean.id}' == "" && $("input[name='banner']").val() == "") {
				mini.alert("图片不能为空");
				return false;
			}
			return true;
		}
	</script>
</body>
</html>
