<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="comm.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>注册</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" /><link href="../demo.css" rel="stylesheet" type="text/css" />

    <style type="text/css">
    body
    {
        width:100%;height:100%;margin:0;overflow:hidden;
    }
    </style>
    <script src="view/miniui/boot.js" type="text/javascript"></script>
    
</head>
<body >   
<div id="loginWindow" class="mini-window" title="注册" style="width:450px;height:245px;" 
   showModal="true" showCloseButton="false"
    >

    <div id="loginForm" style="padding:15px;padding-top:10px;">
        <table align="center">
            <tr>
                <td style="width:80px;"><label for="username$text">帐号：</label></td>
                <td>
                    <input id="username" name="username" vtype="minLength:2" onvalidation="onUserNameValidation" class="mini-textbox" required="true" style="width:150px;"/>
                </td>    
            </tr>
             <tr>
                <td style="width:80px;"><label for="username$text">邮箱：</label></td>
                <td>
                    <input id="email" name="email" vtype="email"  onvalidation="onUserNameValidation" class="mini-textbox" required="true" style="width:150px;"/>
                </td>    
            </tr>
            <tr>
                <td style="width:80px;"><label for="pwd$text">密码：</label></td>
                <td>
                    <input id="password" name="password" onvalidation="onPwdValidation" vtype="minLength:3" class="mini-password" requiredErrorText="不能为空" required="true" style="width:150px;" />
                </td>
            </tr>  
             <tr>
                <td style="width:80px;"><label for="pwd$text">验证码：</label></td>
                <td>
                    <input id="code" name="ecode" onvalidation="onPwdValidation" class="mini-password" requiredErrorText="不能为空" required="true" style="width:150px;" />
                </td>
                <td><button type="button" id="btn" onclick="settime()"  class="mini-button" style="width:80px;">获取验证码</button></td>
            </tr> 
                  <tr>
                   <td style="width:80px;"><label for="pwd$text">身份类型：</label></td>
                  <td><input id="type" name="type" onenter="onKeyEnter" emptyText="请选择"
				class="mini-combobox" style="width: 150px;" textField="name"
				valueField="value" 
				valueFromSelect="true" data="typeData" /></td>
                  </tr>  
            <tr>
            <td></td>
                <td style="padding-top:5px;"><a onclick="onLoginClick" class="mini-button" >立即注册</a>
                <a onclick=" window.location = 'view/login.jsp'" class="mini-button" style="width:80px;">返回</a></td>
                <td style="padding-top:5px;">
                    
                </td>
            </tr>
        </table>
    </div>

</div>


    

    
    <script type="text/javascript">
	var typeData = [ {
		name : "教师",
		value : "2"
	}, {
		name : "学生",
		value : "3"
	}, {
		name : "财务审核人员",
		value : "4"
	}, {
		name : "财务管理人员",
		value : "5"
	} ];
   
    function settime() {
    	var a=mini.get("email").getValue();
    	var username=mini.get("username").getValue();
    	if(username==''){
    		mini.alert("请填写帐号")
    		return
    	}
    	if(!isEmail(a)){
    		mini.alert("请填写正确的邮箱")
    		return
    	}
    	  var form = new mini.Form("#loginWindow");
    	  var data = form.getData();  
    	  js()
        $.ajax({
            url: "manager/sendMail",
            data:data,
            type: "get",
            success: function (data) {
               if(data.code){
            	   mini.alert(data.msg);
            	   
                   
              
               }else{
            	   countdown=0;
            	   mini.alert(data.msg);
               } 
            }
        });
 
    } 
    var countdown=60; 
    function js(){
    	var obj=document.getElementById("btn");
    	 if (countdown <= 0) { 
         	mini.get("btn").setEnabled(true)
             obj.innerText="获取验证码"; 
             countdown = 60; 
             return;
         } else { 
         	mini.get("btn").setEnabled(false)
             obj.innerText="重新发送(" + countdown + ")"; 
             countdown--; 
         } 
    	 setTimeout(function() { 
         	js() }
             ,1000) 
    }
        mini.parse();
   
          
        var loginWindow = mini.get("loginWindow");
        loginWindow.show();

        function onLoginClick(e) {
            var form = new mini.Form("#loginWindow");

            form.validate();
          
            if (form.isValid() == false) return;
            var type=mini.get("type").getValue();
            if(type==''){
            	mini.alert("请选择身份类型")
            	return
            }
            loginWindow.hide();
            var messageId=mini.loading("稍等...");
            var data = form.getData();      
            $.ajax({
                url: "manager/register",
                data:data,
                type: "post",
                success: function (data) {
                   if(data.code){
                	   mini.alert(data.msg,'',function(){
                		   window.location = "view/login.jsp";
                	   });
                	  
                   }else{
                	   mini.hideMessageBox(messageId);
                	   loginWindow.show();
                	   mini.alert(data.msg);
                   } 
                }
            });
        }
        function onResetClick(e) {
            var form = new mini.Form("#loginWindow");
            form.clear();
        }
        /////////////////////////////////////
        function isEmail(s) {
            if (s.search(/^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/) != -1)
                return true;
            else
                return false;
        }
        function onUserNameValidation(e) {
             if (e.isValid) {
               // if (isEmail(e.value) == false) {
                    //e.errorText = "必须输入邮件地址";
                   // e.isValid = false;
                   // alert()
               // }
            } 
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