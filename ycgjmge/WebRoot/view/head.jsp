<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
  <div id="head">
    <div id="header">
      <p class="right">
      <c:if test="${sessionScope.USR==null}">
       <a href="userInfo/loginP">请登录</a><a href="userInfo/registP">会员注册</a>
      </c:if>
     <c:if test="${sessionScope.USR!=null}">
       <a href="userInfo/loginP">${sessionScope.USR.username}</a>
      </c:if>
      
      <a href="order/buyCarP">我的购物车</a></p> 
      <p class="left"><input type="text" id="text" /><input type="button" id="search" value="搜一搜" /></p>  
    </div>
  </div>  
  <div id="logo">
  <div class="logo">  
  <ul class="right">
   <li>  
      <a href="index/index"><p>Home Page</p><p>首  页</p></a>
   </li>
   <li>
      <a href="#"><p>Cake Directory</p><p>蛋糕名录</p></a>
      <div class="list">
       <c:forEach var="item" items="${goodsCategoryList }">
        <a href="#">${item.name }</a>
       </c:forEach>
      </div>
    </li>
    <li>
      <a href="#"><p>Baking Class</p><p>烘培教室</p></a>
      <div class="list">
        <a href="#">烘培教室一</a>
        <a href="#">烘培教室二</a>
        <a href="#">烘培教室三</a>
        <a href="#">烘培教室四</a>
      </div>
    </li>
   <li>
      <a href="#"><p>Member Center</p><p>会员中心</p></a>
   </li>
   
   <li>
      <a href="#"><p>About Us</p><p>关于我们</p></a>
      <div class="list">
        <a href="#">公司简介</a>
        <a href="#">联系方式</a>
      </div>
    </li>      
  </ul>
  <a href="index.html" class="left"><img src="images/logo.png" /></a>
  </div>
  </div> 