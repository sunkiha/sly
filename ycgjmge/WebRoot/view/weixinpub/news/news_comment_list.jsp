<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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
			所属： <input id="type" name="type" onenter="onKeyEnter"
				class="mini-combobox" style="width: 30%;" textField="name"
				valueField="value" onvaluechanged="onTypeChanged"
				valueFromSelect="true" data="typeData" /> 分类： <input
				id="category" name="category" class="mini-combobox"
				style="width: 30%;" textField="name" valueField="id" />
				状态： <input
				id="status" name="status" class="mini-combobox"
				style="width: 100px;" textField="name" valueField="value" data="statusR"/> 评论内容：<input
				id="title" name="title" style="width:150px"/> <a class="mini-button"
				onclick="search()">查询</a>

		</div>
		<div class="mini-toolbar" style="border-bottom: 0; padding: 0px;">
			<table style="width: 100%;">
				<tr>
					<td style="width: 100%;"><!-- <a class="mini-button"
						iconCls="icon-add" onclick="add()">增加</a> --> <!--  <a class="mini-button"
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
	<!-- <div id="datagrid1" class="mini-datagrid"
		style="width: 100%; height: 100%;" allowResize="true"
		 idField="id" multiSelect="true" pageSize="20" url="news/getNewsCommentByNewsId">
		<div property="columns">
			<div type="indexcolumn"></div>       
			<div type="checkcolumn"></div>
			<div field="nickname" width="50">评论人</div>
			<div field="title" width="100">新闻标题</div>
			<div field="content" width="80">评论内容</div>
			<div field="createDate" width="50" allowSort="true"
				dateFormat="yyyy-MM-dd HH:mm:dd">评论日期</div>
			<div name="action" width="30"  
				renderer="status" >审核状态</div>
			<div name="action" width="30" headerAlign="center" align="center"
				renderer="operat" cellStyle="padding:0;">操作</div>

		</div>
	</div> -->

	<div id="datagrid1" class="mini-datagrid"
		style="width: 100%; height: 100%;" allowResize="true"
		url="newsComment/getNewsCommentByNewsId" idField="id" multiSelect="true" pageSize="20">
		<div property="columns">
			<!--<div type="indexcolumn"></div>        -->
			<!-- <div type="checkcolumn"></div> -->
			<div field="nickname" width="20">评论人</div>
			<div field="title" width="50">新闻标题</div>
			<div field="content" width="40">评论内容</div>
			<div field="createDate" width="40" allowSort="true"
				dateFormat="yyyy-MM-dd HH:mm:dd">评论日期</div>
			<div field=status width="20" renderer="statusRender">审核状态</div>
			<div name="action" width="40" headerAlign="center" align="center"
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
		var statusR = [ {
			name : "全部",
			value : ""
		}, {
			name : "待审核",
			value : 0
		}, {
			name : "通过",
			value : 1
		}];
		var newsId="";
		mini.parse();
		//mini.get("datepicker").setValue(new Date())
		var grid = mini.get("datagrid1");
		
		var type = mini.get("type");
		var category = mini.get("category");
		function onTypeChanged() {
			var value = type.getValue();
			category.setValue("");
			category.setUrl("news/getNewsCategory?type=" + value);
		}
		function statusRender(e) {
			var record = e.record;
			var status = record.status;
			if(status==0){
				return "待审核";
			}else if(status==1){
				return "通过"
			}
			
		}
		function operat(e) {
			var grid = e.sender;
			var record = e.record;
			var id = record.id;
			var rowIndex = e.rowIndex;
			if(record.status==0){
				return '<a class="Delete_Button" href="javascript:checkCommentPass(\'' + id
				+ '\')">通过</a> '
			}else{
				return '<a class="Delete_Button" style="color:grey" href="javascript:void(0)">通过</a> ';
			}
		}
		function statusPic(e) {
			var statusPic = e.record.statusPic;
			var s = '<img width="80px" src="http://60.174.233.153:8080/src/'+statusPic+'.png"/>';
			return s;
		}
		function checkCommentPass(id) {
			mini.confirm("确定要通过吗?", "提示", function(data) {
				if (data == "ok") {
					$.ajax({
						url : "newsComment/checkCommentPass",
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
		function add() {
			mini.open({
				url : "news/toAddNews",
				title : "新增",
				width : 800,
				height : 650,
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
		
		function SetData(data) {
			//grid.setUrl("news/getNewsCommentByNewsId");
			//grid.sortBy("c.createDate", "desc");
			//grid.reload();
			newsId=data.newsId;
			grid.load({
				newsId:newsId
			});
			
			grid.sortBy("c.createDate", "desc");
		}
		function search() {
			//var datepicker = mini.get("datepicker").getFormValue();
			var title = document.getElementById("title").value;
			var status=mini.get("status").getValue();
			grid.load({
				title : title,
				status:status,
				newsId:newsId,
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