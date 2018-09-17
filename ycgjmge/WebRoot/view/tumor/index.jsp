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

			标题：
				<input id="username"
				  style="width: 150px;"
				onenter="onKeyEnter" /> <a class="mini-button" onclick="search()">查询</a>

		</div>
		<div class="mini-toolbar" style="border-bottom: 0; padding: 0px;">
			<table style="width: 100%;">
				<tr>
					<td style="width: 100%;">
						<a class="mini-button"
						iconCls="icon-add" onclick="add()">增加</a>  <!--  <a class="mini-button"
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
		url="tumor/getTumorPage" idField="id" multiSelect="true">
		<div property="columns">
			<!--<div type="indexcolumn"></div>        -->
			<!-- <div type="checkcolumn"></div> -->
			<div field="id" width="120" headerAlign="center">编号</div>
			<div field="name" width="120" headerAlign="center">名称</div>
			<div field="createDate" width="100" allowSort="true"
				dateFormat="yyyy-MM-dd HH:mm:dd">创建日期</div>
			<div field="modDate" width="100" allowSort="true"
				dateFormat="yyyy-MM-dd HH:mm:dd">修改日期</div>
			<div name="action" width="80" headerAlign="center" align="center" renderer="operat" cellStyle="padding:0;">操作</div>
		</div>
	</div>


	<script type="text/javascript">
		mini.parse();
		var grid = mini.get("datagrid1");
		grid.load();
		grid.sortBy("modDate", "desc");
		function operat(e) {
			var grid = e.sender;
			var record = e.record;
			var id = record.id;
			var rowIndex = e.rowIndex;
			var s = '<a class="Edit_Button" href="javascript:news(' +id+ ')">文章</a> '
			        +'<a class="Delete_Button" href="javascript:mod(\''
					+ id + '\')">修改</a> '
					+ '<a class="Delete_Button" href="javascript:del(\''
					+ id + '\')">删除</a> ';
			return s;
		}
		function banner(e){
			var banner = e.record.banner;
			var s ='<img width="80px" src="http://60.174.233.153:8080/src/zhongliu/'+banner+'.png"/>';
			return s;
		}
		function news(id){
		            mini.open({
		                url: "tumorMenu2?tumorId="+id,
		                title: "文章管理",
		                width: 1024,
		                height: 600,
		                ondestroy: function (action) {
		                    //if (action == "close") return false;
		                    if (action == "ok") {
		                        var iframe = this.getIFrameEl();
		                        var data = iframe.contentWindow.GetData();
		                        data = mini.clone(data);    //必须
		                        if (data) {
		                        }
		                    }

		                }
		            });
		}
		function add() {
			mini.open({
				url : "tumor/toAdd",
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
				url : "http://60.174.233.153:8080/ZhongLiuInterface/tumor/contentDetail?id="+id,
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
				url : "tumor/toMod",
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
			mini.confirm("确定要删除吗?","提示",function(data){
				   if (data == "ok") {
						$.ajax({
							url : "tumor/deleteById",
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
	/* 	function search() {

			var username = mini.get("username").getValue();
			alert(username)
			grid.load({
				username : username
			});
		} */
		 function search() {
		    var username = document.getElementById("username").value;
		    grid.load({ username:username });
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