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
	<form id="equipmentFrom" action="careRemind/addHuaiyun" method="post"
		enctype="multipart/form-data" onsubmit="return post()">

		<input type="hidden" name="id" class="mini-hidden" />
		<div style="padding-left: 11px; padding-bottom: 5px;">
			<table align="center" style="table-layout: fixed;">
				<tr>
					<td style="width: 70px;">周数：</td>
					<td style="width: 150px;">
					 <input 
						name="week" class="mini-combobox" style="width: 150px;"
						textField="name" value="0" valueField="value" valueFromSelect="true" url="careRemind/getWeeks" />
					<!-- 	<select name="week">
							<option value="0">第0周</option>
							<option value='1'>第1周</option>
							<option value='2'>第2周</option>
							<option value='3'>第3周</option>
							<option value='4'>第4周</option>
							<option value='5'>第5周</option>
							<option value='6'>第6周</option>
							<option value='7'>第7周</option>
							<option value='8'>第8周</option>
							<option value='9'>第9周</option>
							<option value='10'>第10周</option>
							<option value='11'>第11周</option>
							<option value='12'>第12周</option>
							<option value='13'>第13周</option>
							<option value='14'>第14周</option>
							<option value='15'>第15周</option>
							<option value='16'>第16周</option>
							<option value='17'>第17周</option>
							<option value='18'>第18周</option>
							<option value='19'>第19周</option>
							<option value='20'>第20周</option>
							<option value='21'>第21周</option>
							<option value='22'>第22周</option>
							<option value='23'>第23周</option>
							<option value='24'>第24周</option>
							<option value='25'>第25周</option>
							<option value='26'>第26周</option>
							<option value='27'>第27周</option>
							<option value='28'>第28周</option>
							<option value='29'>第29周</option>
							<option value='30'>第30周</option>
							<option value='31'>第31周</option>
							<option value='32'>第32周</option>
							<option value='33'>第33周</option>
							<option value='34'>第34周</option>
							<option value='35'>第35周</option>
							<option value='36'>第36周</option>
							<option value='37'>第37周</option>
							<option value='38'>第38周</option>
							<option value='39'>第39周</option>
							<option value='40'>第40周</option>
							<option value='41'>第41周</option>
							<option value='42'>第42周</option>
							<option value='43'>第43周</option>
							<option value='44'>第44周</option>
							<option value='45'>第45周</option>
							<option value='46'>第46周</option>
							<option value='47'>第47周</option>
							<option value='48'>第48周</option>
							<option value='49'>第49周</option>
							<option value='50'>第50周</option>
					</select> -->
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
