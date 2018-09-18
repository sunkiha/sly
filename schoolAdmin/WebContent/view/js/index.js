$(function(){
	$(function(nav){
		$("#logo ul li").hover(function(){
			$(this).children(".list").slideDown("300");
			},function(){
			$(this).children(".list").slideUp("300");	
				})
		})
	$(function() {
		var sWidth = $("#banner ul li").width();
		var len = $("#banner ul li").length;
		var index = 0;
		var picTimer;
		$("#banner dl dd span").css("opacity",0.4).mouseenter(function() {
			index = $("#banner dl dd span").index(this);
			showPics(index);
		}).eq(0).trigger("mouseenter");
		$(".PreNext").css("opacity",0.2).hover(function() {
			$(this).stop(true,false).animate({"opacity":"0.6"},300);
		},function() {
			$(this).stop(true,false).animate({"opacity":"0.2"},300);
		});
		$(".Pre").click(function() {
			index -= 1;
			if(index == -1) {index = len - 1;}
			showPics(index);
		});
		$(".Next").click(function() {
			index += 1;
			if(index == len) {index = 0;}
			showPics(index);
		});
		$("#banner ul").css("width",sWidth * (len));
		$("#banner").hover(function() {
			clearInterval(picTimer);
		},function() {
			picTimer = setInterval(function() {
				showPics(index);
				index++;
				if(index == len) {index = 0;}
			},3000);
		}).trigger("mouseleave");
		function showPics(index) {
			var nowLeft = -index*sWidth;
			$("#banner ul").stop(true,false).animate({"left":nowLeft},300); 
			$("#banner dl dd span").removeClass("on").eq(index).addClass("on");
			$("#banner dl dd span").stop(true,false).animate({"opacity":"0.3"},300).eq(index).stop(true,false).animate({"opacity":"1"},300); 
		}	
});
	$(function(){
		$("#content1 dl dd").eq(0).addClass("ys1").siblings().addClass("ys2");
		$("#content1 dl dd").mouseover(function(){
			$(this).removeClass("ys2").addClass("ys1").siblings("dd").removeClass("ys1").addClass("ys2");
			var index=$(this).index();
			
			$("#content1 ul").eq(index).show().siblings("ul").hide();
			})
		})
	$(function(){
		$("ul.cp li").hover(function(){
			$(this).css("border","1px solid #f63")
			$(this).children("p.cp_book").slideDown("300");
			},function(){
			$(this).css("border","1px solid #eee")
			$(this).children("p.cp_book").slideUp("300");	
				})
		$("ul.cp li p.cp_book a").hover(function(){
			$(this).css("background","#d03c0b");
			},function(){
			$(this).css("background","#f63");	
				})
		})
	$(function(){
				
			$(".cp_show dl dd").mouseover(function(){
			var index=$(".cp_show dl dd").index(this);	
			$(".cp_show ul li").eq(index).show("fast").siblings().hide("fast");
			$(this).children("img").css("border","1px solid #f63").parent().siblings().children().css("border","1px solid #999")
			})
		
		})
	})