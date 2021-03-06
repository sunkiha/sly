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
			<!-- 日期： <input id="datepicker" class="mini-datepicker"
				style="width: 150px;" /> -->
			所属： <input id="type" name="type" onenter="onKeyEnter"
				class="mini-combobox" style="width:20%;" textField="name"
				valueField="value" onvaluechanged="onTypeChanged"
				valueFromSelect="true" data="typeData" /> 分类： <input
				id="category" name="category" class="mini-combobox"
				style="width:20%;" textField="name" valueField="id" /> 标题：<input
				id="title" name="title" style="width:20%;"/> <a class="mini-button"
				onclick="search()">查询</a>

		</div>
		<div class="mini-toolbar" style="border-bottom: 0; padding: 0px;">
			<table style="width: 100%;">
				<tr>
					<td style="width: 100%;"><a class="mini-button"
						iconCls="icon-add" onclick="add()">增加</a> <!--  <a class="mini-button"
						iconCls="icon-add" onclick="edit()">编辑</a> <a class="mini-button"
						iconCls="icon-remove" onclick="remove()">删除</a>--></td>
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
		url="news/getNewsCond" idField="id" multiSelect="true" pageSize="20">
		<div property="columns">
			<!--<div type="indexcolumn"></div>        -->
			<!-- <div type="checkcolumn"></div> -->
			<div field="title" width="30">标题</div>
			<div field="name" width="15">分类</div>
			<!-- <div field="createDate" width="20" allowSort="true"
				dateFormat="yyyy-MM-dd">创建日期</div> -->
			<div name="action" width="50" headerAlign="center" align="center"
				renderer="operat" cellStyle="padding:0;">操作</div>

		</div>
	</div>


	<script type="text/javascript">
		var typeData = [ {
			name : "全部",
			value : ""
		}, {
			name : "备孕",
			value : 0
		}, {
			name : "怀孕",
			value : 1
		} ];
	
		mini.parse();
		//mini.get("datepicker").setValue(new Date())
		var grid = mini.get("datagrid1");
		grid.load();
		grid.sortBy("createDate", "desc");
		var type = mini.get("type");
		var category = mini.get("category");
		function onTypeChanged() {
			var value = type.getValue();
			category.setValue("");
			category.setUrl("news/getNewsCategory?type=" + value);
		}
		function operat(e) {
			var grid = e.sender;
			var record = e.record;
			var id = record.id;
			var rowIndex = e.rowIndex;
			//alert(record.homenews)
			var hn="";
			if(record.homenews==0){
				hn='<a class="Delete_Button" href="javascript:putHome(\'' + id
				+ '\')">加入首页banner</a> ';
			}else{
				hn='<a class="Delete_Button" style="color:grey" disabled="disabled" href="javascript:void(0)">加入首页banner</a> ';
			}
			var s = '<a class="Delete_Button" href="javascript:detail(\'' + id
					+ '\')">详情</a> '
					+ '<a class="Delete_Button" href="javascript:del(\'' + id
					+ '\')">删除</a> '
					+ '<a class="Delete_Button" href="javascript:searchNewsComment(\'' + id
					+ '\')">查看评论</a> '
					+ hn
					+ '<a class="Delete_Button" href="javascript:pushNews(\'' + id
					+ '\')">推送新闻</a> ';
			return s;
		}
		function statusPic(e) {
			var statusPic = e.record.statusPic;
			var s = '<img width="80px" src="http://60.174.233.153:8080/src/'+statusPic+'.png"/>';
			return s;
		}
		function detail(id) {
			mini.open({
				url : "http://60.174.233.153:8080/yunyu/wx/news/newsId/" + id,
				title : "详情",
				width :"70%",
				height : "80%",
				onload : function() {
					/* var iframe = this.getIFrameEl();
					var data = {
						//action : "new"
					};
					iframe.contentWindow.SetData(data); */
				},
				ondestroy : function(action) {
					grid.reload();
				}
			});
		}
		function add() {
			mini.open({
				url : "view/weixinpub/news/news_add.jsp",
				title : "新增",
				width : "80%",
				height : "80%",
				onload : function() {
					/* var iframe = this.getIFrameEl();
					var data = {
						//action : "new"
					};
					iframe.contentWindow.SetData(data); */
				},
				ondestroy : function(action) {
					grid.reload();
				}
			});
		}
		function mod(id) {
			mini.open({
				url : "news/toModNews?newsId=" + id,
				title : "修改",
				width : 800,
				height : 650,
				onload : function() {
					/* var iframe = this.getIFrameEl();
					var data = {
						id : id
					};
					iframe.contentWindow.SetData(data); */
				},
				ondestroy : function(action) {
					grid.reload();
				}
			});
		}
		function del(id) {
			mini.confirm("确定要删除吗?", "提示", function(data) {
				if (data == "ok") {
					$.ajax({
						url : "news/deleteNews",
						data : {
							id : id
						},
						success : function(json) {
							mini.alert(json)
							grid.reload();
						},
						error : function() {
							mini.alert("服务器异常，请稍后重试！");
						}
					});
				}
			})
		}
		function pushNews(id) {
			mini.confirm("确定要推送该条新闻吗?", "提示", function(data) {
				if (data == "ok") {
					$.ajax({
						url : "news/pushNews",
						data : {
							id : id
						},
						success : function(json) {
							mini.alert("推送成功")
							grid.reload();
						},
						error : function() {
							mini.alert("服务器异常，请稍后重试！");
						}
					});
				}
			})
		}
		function remove() {

			var rows = grid.getSelecteds();
			if (rows.length > 0) {
				if (confirm("确定删除选中记录？")) {
					var ids = [];
					for (var i = 0, l = rows.length; i < l; i++) {
						var r = rows[i];
						ids.push(r.id);
					}
					var id = ids.join(',');
					grid.loading("操作中，请稍后......");
					$
							.ajax({
								url : "../data/AjaxService.aspx?method=RemoveEmployees&id="
										+ id,
								success : function(text) {
									grid.reload();
								},
								error : function() {
								}
							});
				}
			} else {
				alert("请选中一条记录");
			}
		}
		//查看评论
		function searchNewsComment(id) {
			mini.open({
				url : "view/weixinpub/newsComment/news_comment_list2.jsp",
				title : "查看评论",
				width : "80%",
				height : "70%",
				onload : function() {
					var iframe = this.getIFrameEl();
					
					var data = {
						newsId:id
					};
					
					iframe.contentWindow.SetData(data);
				},
				ondestroy : function(action) {
					grid.reload();
				}
			});
		}
		function putHome(id){
			mini.open({
				url : "news/toAddHomeNews?newsId="+id,
				title : "新增",
				width :"80%",
				height :"20%",
				onload : function() {
					/* var iframe = this.getIFrameEl();
					var data = {
						//action : "new"
					};
					iframe.contentWindow.SetData(data); */
				},
				ondestroy : function(action) {
				}
			});
		}
		
		function search() {
			//var datepicker = mini.get("datepicker").getFormValue();
			var title = document.getElementById("title").value;
			grid.load({
				title : title,
				type : type.getValue(),
				category : category.getValue()
			});
		}
		function onKeyEnter(e) {
			search();
		}
		/////////////////////////////////////////////////
		function onBirthdayRenderer(e) {
			var value = e.value;
			if (value)
				return mini.formatDate(value, 'yyyy-MM-dd');
			return "";
		}
		function onMarriedRenderer(e) {
			if (e.value == 1)
				return "是";
			else
				return "否";
		}
		var Genders = [ {
			id : 1,
			text : '男'
		}, {
			id : 2,
			text : '女'
		} ];
		function onGenderRenderer(e) {
			for (var i = 0, l = Genders.length; i < l; i++) {
				var g = Genders[i];
				if (g.id == e.value)
					return g.text;
			}
			return "";
		}
	</script>
</body>
</html>