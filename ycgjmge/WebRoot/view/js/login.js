/*$(function(){
	$(function(){
		$(".login ul li input.text").blur(function(){
			if($(this).is(".text")){
				if(this.value==""||this.value.length<6){
					$(this).css("border","1px solid #f00");
				}else{
				;
					$(this).css("border","1px solid #999")	
						}
				
				}			
		})		
	})
		
	$(function(){
		$(".regist ul li .text").blur(function(){
			var $parent=$(this).parent();
			$parent.find(".formtips").remove();
			if($(".regist ul li #name")){
				if(this.value==""||this.value.length<6){
					var errormsg="请输入至少6位的用户名.";
					$parent.append("<span class='red onError ts'>"+errormsg+"</span>");
					}else{
						var okmsg="输入正确.";
						$parent.append("<span class='formtips onSuccess ts'>"+okmsg+"</span>");
						
						}
				
				}
			if($(".regist ul li #email")){
				if(this.value=="" || (this.value!="" && !/.+\.[a-zA-Z]{2,4}$/.test(this.value))){
					var errormsg="请输入正确的Email地址.";
					$parent.append("<span class='formtips onError ts'>"+errormsg+"</span>");
					}else{
						var okmsg="输入正确.";
						$parent.append("<span class='formtips onSuccess ts'>"+okmsg+"</span>");
						}
				}
		}).keyup(function(){
			$(this).triggerHandler("blur");
			
			}).focus(function(){
				$(this).triggerHandler("blur");
				});
		$("#regist").click(function(){
				$("form .required:input").trigger("blur");
				var numError=$("form .onError").length;
				if(numError){
					return false;
					}
					//alert("注册成功，密码已发到你的邮箱，请查收.");
				});
			
		})
		})
*/