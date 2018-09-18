<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/view/comm.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
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


    <div id="loginForm" style="padding:15px;padding-top:10px;">
        <table>
            <tr>
                <td style="width:90px;"><label for="username$text">申请人：</label></td>
                <td>
               ${uc.uname }
                </td>    
            </tr>
             <tr>
                <td style="width:90px;"><label for="username$text">预约时间：</label></td>
                <td>
                ${uc.openDate }
                </td>    
            </tr>
              <tr>
                   <td style="width:90px;"><label for="pwd$text">描述：</label></td>
                  <td>${uc.desc }</td>
                  </tr>
                  <tr>
                   <td style="width:90px;"><label for="pwd$text">当前状态：</label></td>
                        <c:if test="${uc.status==0}">
                  <td>待审核</td>
                  </c:if>
                    <c:if test="${uc.status==1}">
                  <td>审核通过</td>
                  </c:if>
                    <c:if test="${uc.status==2}">
                  <td>审核未通过</td>
                  </c:if>
                  </tr>  
                    <c:if test="${uc.status==2}">
                     <tr>
                   <td style="width:90px;"><label for="pwd$text">原因：</label></td>
                  <td>${uc.reason }</td>
                  </tr>  
                  </c:if>
                  
                    <c:if test="${uc.status==1}">
                     <tr>
                   <td style="width:90px;"><label for="pwd$text">预计到账天数：</label></td>
                  <td>${uc.pday }天</td>
                  </tr>  
                  </c:if>
                     <tr>
                   <td style="width:90px;"><label for="pwd$text">凭证：</label></td>
              <td><img  src="${uc.authFile }"/></td>
            
                <td>
                </td>
                <td >
                </td>
            </tr>
                     <tr>
            
                <td>
                </td>
                <td >
                </td>
            </tr>
          <!--   <tr >
            
                <td><a onclick="onOkClick" class="mini-button" style="width:80px;">审核通过</a></td>
                <td >
                    <a onclick="onNoClick" class="mini-button" style="width:80px;">审核不通过</a>
                </td>
            </tr> -->
        </table>
    </div>




    

    
    <script type="text/javascript">
	var typeData = [ {
		name : "男",
		value : "男"
	}, {
		name : "女",
		value : "女"
	} ];
     var countdown=6; 
    function settime() {
    	var a=mini.get("email").getValue();
    	if(!isEmail(a)){
    		mini.alert("请填写正确的邮箱")
    		return
    	}
    	var obj=document.getElementById("btn");
        if (countdown == 0) { 
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
        settime(obj) }
        ,1000) 
    } 
        mini.parse();
   
          
        var loginWindow = mini.get("loginWindow");
        loginWindow.show();

        function onOkClick(e) {
         
            var messageId=mini.loading("稍等...");
            $.ajax({
                url: "managerclient/personUpdate",
                data:{
                	id:'${magerclient.id}',
                	status:'2'
                },
                type: "post",
                success: function (data) {
                   if(data.code){
                	   closeW()
                   }else{
                	   mini.hideMessageBox(messageId);
                	   loginWindow.show();
                	   mini.alert(data.msg);
                   } 
                }
            });
        }
        function onNoClick(e) {
            
            var messageId=mini.loading("稍等...");
            $.ajax({
                url: "managerclient/personUpdate",
                data:{
                	id:'${magerclient.id}',
                	status:'3'
                },
                type: "post",
                success: function (data) {
                   if(data.code){
                	   closeW()
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