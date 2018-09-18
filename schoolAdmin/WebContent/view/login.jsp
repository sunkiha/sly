<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="comm.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>登录</title>
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
<div id="loginWindow" class="mini-window" title="用户登录" style="width:350px;height:170px;" 
   showModal="true" showCloseButton="false"
    >

    <div id="loginForm" style="padding:15px;padding-top:10px;">
        <table >
            <tr>
                <td style="width:60px;"><label for="username$text">帐号：</label></td>
                <td>
                    <input id="username" name="username"  onvalidation="onUserNameValidation" class="mini-textbox" required="true" style="width:150px;"/>
                </td>    
            </tr>
            <tr>
                <td style="width:60px;"><label for="pwd$text">密码：</label></td>
                <td>
                    <input id="password" name="password" onvalidation="onPwdValidation" class="mini-password" requiredErrorText="密码不能为空" required="true" style="width:150px;" onenter="onLoginClick"/>
                </td>
            </tr>   
             <tr>
                <td style="width:60px;"></td>
                <td style="text-align: right;">
                       <a href="view/findpwd.jsp" style="font-size: 12px">忘记密码</a>  <a href="view/register.jsp" style="font-size: 12px">注册</a>
                </td>
            </tr>           
            <tr>
                <td></td>
                <td style="padding-top:5px;">
                    <a onclick="onLoginClick" class="mini-button" style="width:60px;">登录</a>
                    <a onclick="onResetClick" class="mini-button" style="width:60px;">重置</a>
                </td>
            </tr>
        </table>
    </div>

</div>


    

    
    <script type="text/javascript">
        mini.parse();

        var loginWindow = mini.get("loginWindow");
        loginWindow.show();

        function onLoginClick(e) {
            var form = new mini.Form("#loginWindow");

            form.validate();
            if (form.isValid() == false) return;

            loginWindow.hide();
            var messageId=mini.loading("正在登录...");
            var data = form.getData();      
            $.ajax({
                url: "manager/login",
                data:data,
                type: "post",
                success: function (data) {
                   if(data.code){
                	   window.location = "view/admin.jsp";
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