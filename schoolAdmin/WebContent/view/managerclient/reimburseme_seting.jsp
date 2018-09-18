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
<div id="loginWindow" class="mini-window" title="" style="width:550px;height:355px;" 
   showModal="true" showCloseButton="false"
    >

    <div id="loginForm" style="padding:15px;padding-top:10px;">
    <form action="managerclient/remSet">
        <table align="center">
            <tr>
                <td style="width:80px;"><label for="username$text">周一</label></td>
                <td>
                    <input id="date1s" name="date1s" class="mini-timespinner" value="${date1s }"  format="H:mm"  style="width:150px;" showTime="true" /> 
                </td>   
                <td>
                到
                </td>
                   <td>
                    <input id="date1e" name="date1e" class="mini-timespinner" value="${date1e }"  format="H:mm"  style="width:150px;" showTime="true" />
                </td> 
             
            </tr>
                 <tr >
                 <td></td>
                <td colspan="3">
                 <input id="1_1" name="z1" type="checkbox" value="1" ${z1_1 }/>窗口1
                &nbsp;<input name="z1" type="checkbox" value="2"  ${z1_2 } />窗口2
                &nbsp; <input name="z1" type="checkbox" value="3" ${z1_3 }/>窗口3
                &nbsp;<input name="z1" type="checkbox" value="4" ${z1_4 }/>窗口4
                &nbsp;<input name="z1" type="checkbox" value="5" ${z1_5 }/>窗口5
                
                </td>
            

            </tr>
            
            
        <tr>
          
                <td style="width:80px;"><label for="username$text">周二</label></td>
                <td>
                    <input id="date2s" name="date2s"  value="${date2s }" class="mini-timespinner"  format="H:mm" style="width:150px;"  showTime="true" /> 
                </td>   
                <td>
                到
                </td>
                   <td>
                    <input id="date2e" name="date2e" value="${date2e }" class="mini-timespinner"  format="H:mm" style="width:150px;" showTime="true" />
                </td> 
            
            </tr>
              <tr >
                 <td></td>
                <td colspan="3">    <input id="1_1" name="z2" type="checkbox" value="1" ${z2_1 }/>窗口1
                &nbsp;<input name="z2" type="checkbox" value="2"  ${z2_2 } />窗口2
                &nbsp; <input name="z2" type="checkbox" value="3" ${z2_3 }/>窗口3
                &nbsp;<input name="z2" type="checkbox" value="4" ${z2_4 }/>窗口4
                &nbsp;<input name="z2" type="checkbox" value="5" ${z2_5 }/>窗口5</td>
            

            </tr>
            
               <tr>
          
                <td style="width:80px;"><label for="username$text">周三</label></td>
                <td>
                    <input id="date2" name="date3s"  value="${date3s }" class="mini-timespinner"  format="H:mm" style="width:150px;"  showTime="true" /> 
                </td>   
                <td>
                到
                </td>
                   <td>
                    <input id="date2" name="date3e" value="${date3e }" class="mini-timespinner"  format="H:mm" style="width:150px;" showTime="true" />
                </td> 
            
            </tr>
              <tr >
                 <td></td>
                <td colspan="3"> <input id="1_1" name="z3" type="checkbox" value="1" ${z3_1 }/>窗口1
                &nbsp;<input name="z3" type="checkbox" value="2"  ${z3_2 } />窗口2
                &nbsp; <input name="z3" type="checkbox" value="3" ${z3_3 }/>窗口3
                &nbsp;<input name="z3" type="checkbox" value="4" ${z3_4 }/>窗口4
                &nbsp;<input name="z3" type="checkbox" value="5" ${z3_5 }/>窗口5</td>
            

            </tr>
            
                <tr>
          
                <td style="width:80px;"><label for="username$text">周四</label></td>
                <td>
                    <input id="date2" name="date4s"  value="${date4s }"  class="mini-timespinner"  format="H:mm" style="width:150px;"  showTime="true" /> 
                </td>   
                <td>
                到
                </td>
                   <td>
                    <input id="date2" name="date4e" value="${date4e }" class="mini-timespinner"  format="H:mm" style="width:150px;" showTime="true" />
                </td> 
            
            </tr>
              <tr >
                 <td></td>
                <td colspan="3"> <input id="1_1" name="z4" type="checkbox" value="1" ${z4_1 }/>窗口1
                &nbsp;<input name="z4" type="checkbox" value="2"  ${z4_2 } />窗口2
                &nbsp; <input name="z4" type="checkbox" value="3" ${z4_3 }/>窗口3
                &nbsp;<input name="z4" type="checkbox" value="4" ${z4_4 }/>窗口4
                &nbsp;<input name="z4" type="checkbox" value="5" ${z4_5 }/>窗口5</td>
            

            </tr>
            
                <tr>
          
                <td style="width:80px;"><label for="username$text">周五</label></td>
                <td>
                    <input id="date2" name="date5s"  value="${date5s }"  class="mini-timespinner"  format="H:mm" style="width:150px;"  showTime="true" /> 
                </td>   
                <td>
                到
                </td>
                   <td>
                    <input id="date2" name="date5e" value="${date5e }" class="mini-timespinner"  format="H:mm" style="width:150px;" showTime="true" />
                </td> 
            
            </tr>
              <tr >
                 <td></td>
                <td colspan="3"><input id="1_1" name="z5" type="checkbox" value="1" ${z5_1 }/>窗口1
                &nbsp;<input name="z5" type="checkbox" value="2"  ${z5_2 } />窗口2
                &nbsp; <input name="z5" type="checkbox" value="3" ${z5_3 }/>窗口3
                &nbsp;<input name="z5" type="checkbox" value="4" ${z5_4 }/>窗口4
                &nbsp;<input name="z5" type="checkbox" value="5" ${z5_5 }/>窗口5</td>
            

            </tr>
            
            
    
            <tr>
                <td></td> <td></td> 
                <td style="padding-top:5px;">
                <input type="submit" value="提交"/>
                  <!--   <a onclick="onLoginClick" class="mini-button" style="width:80px;">确定</a> -->
                </td> <td></td> 
            </tr>
        </table></form>
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

        function onLoginClick(e) {
            var form = new mini.Form("#loginWindow");

            form.validate();
          
            if (form.isValid() == false) return;
        
        	form.loading()
	var data=form.getData()
	//alert(JSON.stringify(data)))
			$.ajax({
				url : "managerclient/remSet",
				type : 'post',
				data : data,
				cache : false,
				success : function(json) {
					if (json.code == 1) {
						mini.alert(json.msg, '', function() {
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