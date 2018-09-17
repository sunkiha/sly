﻿<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../comm.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<link href="../demo.css" rel="stylesheet" type="text/css" />
<script src="view/miniui/boot.js" type="text/javascript"></script>
</head>
<body>
	<div style="width: 100%;">

		<div style="padding-bottom: 5px;">
			帐号：
				<input id="username"
				  style="width: 150px;"
				onenter="onKeyEnter" /> <a class="mini-button" onclick="search()">查询</a>

		</div>
		<div class="mini-toolbar" style="border-bottom: 0; padding: 0px;">
			<table style="width: 100%;">
				<tr>
					<td style="width: 100%;">
						<!-- <a class="mini-button"
						iconCls="icon-add" onclick="add()">增加</a> --> <!--  <a class="mini-button"
						iconCls="icon-add" onclick="edit()">编辑</a> <a class="mini-button"
						iconCls="icon-remove" onclick="remove()">删除</a>-->
					</td>
					<td style="white-space: nowrap;">
						<!-- <input id="key"
						class="mini-textbox" emptyText="请输入姓名" style="width: 150px;"
						onenter="onKeyEnter" /> <a class="mini-button" onclick="search()">查询</a> -->
					</td>
				</tr>
			</table>
		</div>
	</div>
	<div id="datagrid1" class="mini-datagrid"
		style="width: 100%; height: 100%;" allowResize="true"
		url="userInfo/getUserInfoPage" idField="id" multiSelect="true" pageSize="20">
		<div property="columns">
			<!--<div type="indexcolumn"></div>        -->
			<!-- <div type="checkcolumn"></div> -->
			<div field="username" width="120" headerAlign="center">帐号</div>
			<div field="nickname" width="120" headerAlign="center">昵称</div>
			<div field="status" width="100" renderer="onStatus">状态</div>
			<div name="action" width="30" headerAlign="center" align="center" renderer="operat" cellStyle="padding:0;">操作</div>
		</div>
	</div>


	<script type="text/javascript">
		mini.parse();
		var grid = mini.get("datagrid1");
		grid.load();
		grid.sortBy("createDate", "desc");
		function operat(e) {
			var grid = e.sender;
			var record = e.record;
			var id = record.id;
			var status = record.status;
			var rowIndex = e.rowIndex;
			var s;
			if(status==0){
               s='<a class="Delete_Button" href="javascript:del(\''+ id + '\')">冻结</a> ';
			}else{
			   s='<a class="Delete_Button" href="javascript:resetUser(\''+ id + '\')">解冻</a> ';
			}
			return s;
		}
		function banner(e){
			var banner = e.record.banner;
			var s ='<img width="80px" src="http://60.174.233.153:8080/src/zhongliu/'+banner+'.png"/>';
			return s;
		}
		
		function add() {
			mini.open({
				url : "userInfo/toAdd?toAdd",
				title : "新增",
				width : 900,
				height : 500,
				onload : function() {
					var iframe = this.getIFrameEl();
					var data = {
						//action : "new"
					};
					iframe.contentWindow.SetData(data);
				},
				ondestroy : function(action) {
					grid.reload();
				}
			});
		}
		function detail(id) {
			mini.open({
				url : "http://60.174.233.153:8080/ZhongLiuInterface/homeMenu/contentDetail?homeMenuContentId="+id,
				title : "查看",
				width : 900,
				height : 500,
				onload : function() {
				},
				ondestroy : function(action) {
				}
			});
		}
		function mod(id) {
			mini.open({
				url : "tumorMenu2/toMod",
				title : "修改",
				width : 900,
				height : 500,
				onload : function() {
					var iframe = this.getIFrameEl();
					var data = {
						id : id
					};
					iframe.contentWindow.SetData(data);
				},
				ondestroy : function(action) {
					grid.reload();
				}
			});
		}
		function del(id) {
			mini.confirm("确定要冻结吗?","提示",function(data){
				   if (data == "ok") {
						$.ajax({
							url : "userInfo/deleteById",
							data:{
								id:id
							},
							success : function(json) {
								mini.alert(json)
								grid.reload();
							},
							error : function() {
								
							}
						});
	                }
			})
		}
		function resetUser(id){
		
			mini.confirm("确定要解冻吗?","提示",function(data){
				   if (data == "ok") {
						$.ajax({
							url : "userInfo/jieDongById",
							data:{
								id:id
							},
							success : function(json) {
								mini.alert(json)
								grid.reload();
							},
							error : function() {
								
							}
						});
	                }
			})
		}
		function onStatus(e){
			var status=e.record.status
			return status==0?"正常":"冻结";
		}
	 function search() {
	    var username = document.getElementById("username").value;
	    grid.load({ username:username });
	} 
	</script>
</body>
</html>