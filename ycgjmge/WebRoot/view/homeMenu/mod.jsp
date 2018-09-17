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
	<form id="equipmentFrom" action="homeMenu/mod" method="post"
		enctype="multipart/form-data" onsubmit="return post()">
		<input  name="id" class="mini-hidden" />
		<input  name="banner" class="mini-hidden" />
		<div style="padding-left: 11px; padding-bottom: 5px;">
			<table align="center" style="table-layout: fixed;">
				<tr>
					<td style="width: 70px;">标题：</td>
					<td style="width: 150px;"><input name="title" class="mini-textbox"/></td>
				</tr>
					<tr>
					<td style="width: 70px;">摘要：</td>
					<td style="width: 150px;">
					    <textarea  name="summary" class="mini-textArea" style="width: 300px; height: 100px;">
						</textarea>
					</td>
				</tr>
				<tr>
					<td style="width: 70px;">banner图片：</td>
					<td style="width: 150px;"><input class="mini-htmlfile"
						name="bannertmp" limitType="*.png;*.jpg" /></td>
				</tr>
				<tr>
					<td style="width: 70px;">内容：</td>
					<td style="width: 150px;">
					    <textarea id="editor" name="content" class="" style="width: 800px; height: 300px;">
						<%-- ${bean.content} --%>
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
  	function  SetData(data){
  		var equipmentFrom=new mini.Form("#equipmentFrom");
  		$.ajax({
			url : "homeMenu/getHomeMenuById",
			data:{
				id:data.id
			},
			success : function(json) {
				//var json=mini.decode(text);
				equipmentFrom.setData(json);
				document.getElementById("editor").innerText=json.content
				ue = UE.getEditor('editor');
			},
			error : function() {
				
			}
		});
  	}
  	function post(){
		   if($("input[name='title']").val()==""){
			   mini.alert("标题不能为空");
			   return false;
		   }
		   if($("textarea[name='summary']").val()==""){
			   mini.alert("摘要不能为空");
			   return false;
		   }
		   if($("textarea[name='content']").val()==""){
			   mini.alert("内容不能为空");
			   return false;
		   }
		   return true;
	}
		//实例化编辑器
		//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
		//var ue = UE.getEditor('editor');
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
<!-- 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>员工面板</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="view/miniui/boot.js" type="text/javascript"></script>
    <style type="text/css">
    html, body
    {
        font-size:12px;
        padding:0;
        margin:0;
        border:0;
        height:100%;
        overflow:hidden;
    }
    </style>
</head>
<body>    
     
    <form id="form1" method="post">
        <input name="id" class="mini-hidden" />
        <div style="padding-left:11px;padding-bottom:5px;">
            <table style="table-layout:fixed;">
                <tr>
                    <td style="width:70px;">员工帐号：</td>
                    <td style="width:150px;">    
                        <input name="loginname" class="mini-textbox" required="true"  emptyText="请输入帐号"/>
                    </td>
                    <td style="width:70px;">所属部门：</td>
                    <td style="width:150px;">    
                        <input name="dept_id" class="mini-combobox" valueField="id" textField="name" 
                            url="../data/AjaxService.aspx?method=GetDepartments"
                            onvaluechanged="onDeptChanged" required="true"
                             emptyText="请选择部门"
                            />
                    </td>
                </tr>
                <tr>
                    <td >薪资待遇：</td>
                    <td >    
                        <input name="salary" class="mini-textbox" required="true"/>
                    </td>
                    <td >职位：</td>
                    <td >    
                        <input name="position" class="mini-combobox" valueField="id" textField="name"/>
                    </td>
                </tr>
               
                <tr>
                    <td >学历：</td>
                    <td >    
                        <input name="educational" class="mini-combobox" valueField="id" textField="name" url="../data/AjaxService.aspx?method=GetEducationals" />
                    </td>
                    <td >毕业院校：</td>
                    <td >    
                        <input name="school" class="mini-textbox" />
                    </td>
                </tr>           
            </table>
        </div>
        <fieldset style="border:solid 1px #aaa;padding:3px;">
            <legend >基本信息</legend>
            <div style="padding:5px;">
        <table>
            <tr>
                <td style="width:70px;">姓名</td>
                <td style="width:150px;">    
                    <input name="name" class="mini-textbox" required="true"/>
                </td>
                <td style="width:70px;">性别：</td>
                <td >                        
                    <select name="gender" class="mini-radiobuttonlist">
                        <option value="1">男</option>
                        <option value="2">女</option>
                    </select>
                </td>
                
            </tr>
            <tr>
                <td >年龄：</td>
                <td >    
                    <input name="age" class="mini-spinner" value="25" minValue="1" maxValue="200" />
                </td>
                <td >出生日期：</td>
                <td >    
                    <input name="birthday" class="mini-datepicker" required="true" emptyText="请选择日期"/>
                </td>
            </tr>
            <tr>
                <td ></td>
                <td >    
                    <input name="married" class="mini-checkbox" text="已婚？" trueValue="1" falseValue="0" />
                </td>
                <td ></td>
                <td >    
                    
                </td>
            </tr>     
            <tr>
                <td >国家：</td>
                <td >    
                    <input name="country" class="mini-combobox" url="../data/countrys.txt" />
                </td>
                <td >城市：</td>
                <td >    
                    <input name="city" class="mini-combobox"  />
                </td>
            </tr>
            <tr>
                <td >备注：</td>
                <td colspan="3">    
                    <input name="remarks" class="mini-textarea" style="width:350px;" />
                </td>
            </tr>          
        </table>            
            </div>
        </fieldset>
        <div style="text-align:center;padding:10px;">               
            <a class="mini-button" onclick="onOk" style="width:60px;margin-right:20px;">确定</a>       
            <a class="mini-button" onclick="onCancel" style="width:60px;">取消</a>       
        </div>        
    </form>
    <script type="text/javascript">
        mini.parse();

        var form = new mini.Form("form1");

        function SaveData() {
            var o = form.getData();            

            form.validate();
            if (form.isValid() == false) return;

            var json = mini.encode([o]);
            $.ajax({
                url: "../data/AjaxService.aspx?method=SaveEmployees",
		type: 'post',
                data: { data: json },
                cache: false,
                success: function (text) {
                    CloseWindow("save");
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    alert(jqXHR.responseText);
                    CloseWindow();
                }
            });
        }

        ////////////////////
        //标准方法接口定义
        function SetData(data) {
            if (data.action == "edit") {
                //跨页面传递的数据对象，克隆后才可以安全使用
                data = mini.clone(data);

                $.ajax({
                    url: "../data/AjaxService.aspx?method=GetEmployee&id=" + data.id,
                    cache: false,
                    success: function (text) {
                        var o = mini.decode(text);
                        form.setData(o);
                        form.setChanged(false);

                        onDeptChanged();
                        mini.getbyName("position").setValue(o.position);
                    }
                });
            }
        }

        function GetData() {
            var o = form.getData();
            return o;
        }
        function CloseWindow(action) {            
            if (action == "close" && form.isChanged()) {
                if (confirm("数据被修改了，是否先保存？")) {
                    return false;
                }
            }
            if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
            else window.close();            
        }
        function onOk(e) {
            SaveData();
        }
        function onCancel(e) {
            CloseWindow("cancel");
        }
        //////////////////////////////////
        function onDeptChanged(e) {
            var deptCombo = mini.getbyName("dept_id");
            var positionCombo = mini.getbyName("position");
            var dept_id = deptCombo.getValue();

            positionCombo.load("../data/AjaxService.aspx?method=GetPositionsByDepartmenId&id=" + dept_id);
            positionCombo.setValue("");
        }
    </script>
</body>
</html>
 -->