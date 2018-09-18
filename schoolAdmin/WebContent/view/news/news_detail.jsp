<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../comm.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>新闻页面</title>
<link rel="stylesheet" href="style.css" type="text/css"/>
<style  type="text/css">
	*{
padding:0;margin:30}
body{
font:14px/24px "宋体";
color:#000}
h2{
font:normal 22px/35px "黑体";
color:#000;
text-align:center;}
.one{
font-size:12px;
text-align:center}
p{
text-indent:2em;}
.blue{
color:#00C}
.gray{
color:#666}
</style>
</head>


<body>
<h2>${news.title }</h2>
<p class="one gray">时间:<em><fmt:formatDate value="${news.createDate}" pattern="yyyy-MM-dd HH:mm:dd" /></em>&nbsp;作者:<em>${news.author }</em>&nbsp;浏览数:<em>${news.clicknum }</em></p>
<hr/>
${news.content }
</body>
</html>