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
	<div>
		<c:forEach var="item" items="${imgList}">
			<img style="float: left; margin-right: 5px;" width="400px"
				height="400px" src="http://60.174.233.153:8080/src/${item.path}.png" />
		</c:forEach>
	</div>
	<script type="text/javascript">
		function post() {
			if ($("textarea[name='talk']").val().trim() == "") {
				mini.alert("陈述不能为空");
				return false;
			}
			return true;
		}
		function SetData(data) {
			var equipmentFrom = new mini.Form("#equipmentFrom");
			$.ajax({
				url : "careRemind/getHuaiyunById",
				data : {
					id : data.id
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
