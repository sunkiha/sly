<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/view/comm.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>

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
	<!-- <div id="loginWindow" class="mini-window" title="个人资料"
		style="width: 450px; height: 245px;" showModal="true"
		showCloseButton="false">

		<div id="loginForm" style="padding: 15px; padding-top: 10px;">
		
				<table align="center">
					<tr>
						<td style="width: 80px;"><label for="uname$text">姓名：</label></td>
						<td><input id="uname" name="uname" vtype="minLength:2"
							onvalidation="onUserNameValidation" class="mini-textbox"
							required="true" style="width: 150px;" /></td>
					</tr>
					<tr>
						<td style="width: 80px;"><label for="username$text">年龄：</label></td>
						<td><input id="age" name="age" vtype="int"
							onvalidation="onUserNameValidation" class="mini-textbox"
							required="true" style="width: 150px;" /></td>
					</tr>

					<tr>
						<td style="width: 80px;"><label for="pwd$text">性别：</label></td>
						<td><input id="sex" name="sex" onenter="onKeyEnter"
							emptyText="请选择" class="mini-combobox" style="width: 150px;"
							textField="name" valueField="value" valueFromSelect="true"
							data="typeData" /></td>
					</tr>
					<tr>
						<td></td>
						<td style="padding-top: 5px;"><a onclick="onLoginClick"
							class="mini-button" style="width: 80px;">确定</a></td>
					</tr>
				</table>
		
		</div>

	</div>





	<script type="text/javascript">
		var typeData = [ {
			name : "男",
			value : "男"
		}, {
			name : "女",
			value : "女"
		} ];
		mini.parse()

		var loginWindow = mini.get("loginWindow");
		loginWindow.show();
		SetData();
		function SetData(data) {
			var frm = new mini.Form("#loginWindow");
			$.ajax({
				url : "manager/getManagerById",
				data : {

				},
				success : function(json) {
					//var json=mini.decode(text);
					frm.setData(json.manager);

				},
				error : function() {

				}
			});
		}

		//var form = new mini.Form("form1");
		function onLoginClick(e) {alert()
			var form = new mini.Form("#loginWindow");
			// alert()
			form.validate();
			alert()
			if (form.isValid() == false)
				return;
			var type = mini.get("sex").getValue();
			if (type == '') {
				mini.alert("请选择身份类型")
				return

			}
			loginWindow.hide();
			var messageId = mini.loading("正在登录...");
			var data = form.getData();
			$.ajax({
				url : "manager/login",
				data : data,
				type : "post",
				success : function(data) {
					if (data.code) {
						window.location = "view/login.jsp";
					} else {
						mini.hideMessageBox(messageId);
						loginWindow.show();
						mini.alert(data.msg);
					}
				}
			});
		}
	</script>
 -->
 <div id="loginWindow" class="mini-window"  title="个人资料"
		style="width: 350px; height: 200px;" 
   showModal="true" showCloseButton="false"
    >

    <div id="loginForm" style="padding:15px;padding-top:10px;">
        <table align="center">
           <tr>
						<td style="width: 80px;"><label for="uname$text">姓名：</label></td>
						<td><input id="uname" name="uname" vtype="minLength:2"
							onvalidation="onUserNameValidation" class="mini-textbox"
							required="true" style="width: 150px;" /></td>
					</tr>
					<tr>
						<td style="width: 80px;"><label for="username$text">年龄：</label></td>
						<td><input id="age" name="age" vtype="int"
							onvalidation="onUserNameValidation" class="mini-textbox"
							required="true" style="width: 150px;" /></td>
					</tr>

					<tr>
						<td style="width: 80px;"><label for="pwd$text">性别：</label></td>
						<td><input id="sex" name="sex" onenter="onKeyEnter"
							emptyText="请选择" class="mini-combobox" style="width: 150px;"
							textField="name" valueField="value" valueFromSelect="true"
							data="typeData" /></td>
					</tr>
        	<tr>
						<td></td>
						<td style="padding-top: 5px;"><a onclick="onLoginClick"
							class="mini-button" style="width: 80px;">确定</a></td>
					</tr>
        </table>
    </div>

</div>


    

    
    <script type="text/javascript">
	var typeData = [ {
		name : "男",
		value : "男"
	}, {
		name : "女",
		value : "女"
	} ];
        mini.parse();

        var loginWindow = mini.get("loginWindow");
        loginWindow.show();
    	SetData();
		function SetData(data) {
			var frm = new mini.Form("#loginWindow");
			$.ajax({
				url : "manager/getManagerById",
				data : {

				},
				success : function(json) {
					//var json=mini.decode(text);
					frm.setData(json.manager);

				},
				error : function() {

				}
			});
		}
        function onLoginClick(e) {
            var form = new mini.Form("#loginWindow");

            form.validate();
            if (form.isValid() == false) return;
        	var type = mini.get("sex").getValue();
			if (type == '') {
				mini.alert("请选择性别")
				return

			}
       
        	var o = form.getData();
 
    		form.loading()
    		$.ajax({
    			url : "manager/myPersonPerfect",
    			type : 'post',
    			data :o,
    			cache : false,
    			success : function(json) {
    				if (json.code == 1) {
    					mini.alert(json.msg,'',function(){
    						//CloseWindow("save");
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
    </script>
</body>
</html>