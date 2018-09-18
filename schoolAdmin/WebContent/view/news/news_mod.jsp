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
	<form id="frm" action="news/modNews" method="post"
	 onsubmit="return post()">
		<input type="hidden" name="id" class="mini-hidden" />
		<div style="padding-left: 11px; padding-bottom: 5px;">
			<table align="center" style="table-layout: fixed;">
				<tr>
					<td style="width: 50px;">标题：</td>
					<td style="width: 150px;"><input name="title"
						class="mini-textbox" width="200px" /></td>
				</tr>
	
				<tr>
					<td style="width: 50px;">类型：</td>
					<td style="width: 150px;"><input id="type" name="type" onenter="onKeyEnter"
				class="mini-combobox" style="width: 200px;" textField="name"
				valueField="value" 
				valueFromSelect="true" data="typeData" /> </td>
			
				<tr>
					<td style="width: 50px;">内容：</td>
					<td style="width: 150px;"><textarea id="editor" name="content"
							class="" style="width: 650px; height: 350px;">
						<%-- ${bean.content} --%>
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
	var typeData = [  {
		name : "公告",
		value : "公告"
	}, {
		name : "通知",
		value : "通知"
	}, {
		name : "事件",
		value : "事件"
	} ];
	function post(){
		   if($("input[name='title']").val()==""){
			   mini.alert("标题不能为空");
			   return false;
		   }
		   if($("input[name='summary']").val()==""){
			   mini.alert("摘要不能为空");
			   return false;
		   }
		   if($("input[name='newscategoryId']").val()==""){
			   mini.alert("分类不能为空");
			   return false;
		   }
		   if($("textarea[name='content']").val().trim()==""){
			   mini.alert("内容不能为空");
			   return false;
		   }
		   
		   SaveData()
		   
		   return false;
	}
	
	var form = new mini.Form("frm");
	function SaveData() {
	/* 	var o = form.getData();
		form.validate();
		if (form.isValid() == false)
			return;
	 	fileupload.setPostParam(o);
		fileupload.startUpload();  */
		
		var o = form.getData();
		var content=$("textarea[name='content']").val().trim()
		o.content=content;
		form.validate();
		if (form.isValid() == false)
			return;
		form.loading()
		var json = mini.encode(o);
		$.ajax({
			url : "news/modNews",
			type : 'post',
			data :o,
			cache : false,
			success : function(json) {
				if (json.code == 1) {
					mini.alert(json.msg,'',function(){
						CloseWindow("save");
					});
				} else {
					mini.alert(json.msg)
				}
				form.unmask(); 
				
			},
			error : function(jqXHR, textStatus, errorThrown) {
				form.unmask();
				mini.alert("服务器异常");
				//CloseWindow();
			}
		});
		return false
	}
	
		SetData();
		function SetData(data) {
			var frm = new mini.Form("#frm");
			$.ajax({
				url : "news/getNewsById",
				data : {
					newsId : '${newsId}'
				},
				success : function(json) {
					//var json=mini.decode(text);
					frm.setData(json);
					document.getElementById("editor").innerText = json.content
					ue = UE.getEditor('editor');
				},
				error : function() {

				}
			});
		}
		//实例化编辑器
		//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例

		// getLocalData();
		function isFocus(e) {
			alert(UE.getEditor('editor').isFocus());
			UE.dom.domUtils.preventDefault(e)
		}
		function setblur(e) {
			UE.getEditor('editor').blur();
			UE.dom.domUtils.preventDefault(e)
		}
		function insertHtml() {
			var value = prompt('插入html代码', '');
			UE.getEditor('editor').execCommand('insertHtml', value)
		}
		function createEditor() {
			enableBtn();
			UE.getEditor('editor');
		}
		function getAllHtml() {
			alert(UE.getEditor('editor').getAllHtml())
		}
		function getContent() {
			var arr = [];
			arr.push("使用editor.getContent()方法可以获得编辑器的内容");
			arr.push("内容为：");
			arr.push(UE.getEditor('editor').getContent());
			alert(arr.join("\n"));
		}
		function getPlainTxt() {
			var arr = [];
			arr.push("使用editor.getPlainTxt()方法可以获得编辑器的带格式的纯文本内容");
			arr.push("内容为：");
			arr.push(UE.getEditor('editor').getPlainTxt());
			alert(arr.join('\n'))
		}
		function setContent(isAppendTo) {
			var arr = [];
			arr.push("使用editor.setContent('欢迎使用ueditor')方法可以设置编辑器的内容");
			UE.getEditor('editor').setContent('欢迎使用ueditor', isAppendTo);
			alert(arr.join("\n"));
		}
		function setDisabled() {
			UE.getEditor('editor').setDisabled('fullscreen');
			disableBtn("enable");
		}

		function setEnabled() {
			UE.getEditor('editor').setEnabled();
			enableBtn();
		}

		function getText() {
			//当你点击按钮时编辑区域已经失去了焦点，如果直接用getText将不会得到内容，所以要在选回来，然后取得内容
			var range = UE.getEditor('editor').selection.getRange();
			range.select();
			var txt = UE.getEditor('editor').selection.getText();
			alert(txt)
		}

		function getContentTxt() {
			var arr = [];
			arr.push("使用editor.getContentTxt()方法可以获得编辑器的纯文本内容");
			arr.push("编辑器的纯文本内容为：");
			arr.push(UE.getEditor('editor').getContentTxt());
			alert(arr.join("\n"));
		}
		function hasContent() {
			var arr = [];
			arr.push("使用editor.hasContents()方法判断编辑器里是否有内容");
			arr.push("判断结果为：");
			arr.push(UE.getEditor('editor').hasContents());
			alert(arr.join("\n"));
		}
		function setFocus() {
			UE.getEditor('editor').focus();
		}
		function deleteEditor() {
			disableBtn();
			UE.getEditor('editor').destroy();
		}
		function disableBtn(str) {
			var div = document.getElementById('btns');
			var btns = UE.dom.domUtils.getElementsByTagName(div, "button");
			for (var i = 0, btn; btn = btns[i++];) {
				if (btn.id == str) {
					UE.dom.domUtils.removeAttributes(btn, [ "disabled" ]);
				} else {
					btn.setAttribute("disabled", "true");
				}
			}
		}
		function enableBtn() {
			var div = document.getElementById('btns');
			var btns = UE.dom.domUtils.getElementsByTagName(div, "button");
			for (var i = 0, btn; btn = btns[i++];) {
				UE.dom.domUtils.removeAttributes(btn, [ "disabled" ]);
			}
		}

		function getLocalData() {
			alert(UE.getEditor('editor').execCommand("getlocaldata"));
		}

		function clearLocalData() {
			UE.getEditor('editor').execCommand("clearlocaldata");
			alert("已清空草稿箱")
		}
	</script>
</body>
</html>
