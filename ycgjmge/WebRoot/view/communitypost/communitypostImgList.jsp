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
	<div id="datagrid1" class="mini-datagrid"  pageSize="20s"
		style="width: 100%; height: 100%;" allowResize="true"
		url="communitypost/getCommunitypostImgList?cpId=${cpId}" idField="id" multiSelect="true">
		<div property="columns">
			<!--<div type="indexcolumn"></div>        -->
			<!-- <div type="checkcolumn"></div> -->
			<div field="path" width="120" headerAlign="center"
				renderer="path">状态图</div>
			<div field="createDate" width="100" allowSort="true"
				dateFormat="yyyy-MM-dd HH:mm:dd">创建日期</div>
			<div name="action" width="80" headerAlign="center" align="center"
				renderer="operat" cellStyle="padding:0;">操作</div>
		</div>
	</div>


	<script type="text/javascript">
		mini.parse();
		var grid = mini.get("datagrid1");
		grid.load();
		grid.sortBy("cpi.createDate", "desc");
		function operat(e) {
			var grid = e.sender;
			var record = e.record;
			var id = record.id;
			var path = record.path;
			var rowIndex = e.rowIndex;
			var s ='<a class="Delete_Button" href="javascript:del(\'' + id+','+path
					+ '\')">删除</a> ';
			return s;
		}
		function path(e) {
			var path = e.record.path;
			var id = e.record.id;
			var s = '<img style="float:left" width="100px" src="http://60.174.233.153:8080/src/'+path+'.png"/>';
			return s;
		}
		function add() {
			mini.open({
				url : "careRemind/toAddBeiyun",
				title : "新增",
				width : 900,
				height : 500,
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
		function seeReply(id) {
			mini.open({
				url : "communitypost/toCommunitypostComment?cpId="+id,
				title : "查看回复",
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
			var a=id.split(",");
			mini.confirm("确定要删除吗?", "提示", function(data) {
				if (data == "ok") {
					$.ajax({
						url : "communitypost/deleteCommunitypostImg",
						data : {
							id :a[0],
							path:a[1]
						},
						success : function(json) {
							mini.alert(json);
							grid.reload();
						},
						error : function() {
						 mini.alert("服务器异常");
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
					$.ajax({
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
		function search() {
			var day = mini.get("day").getValue();
			grid.load({
				day : day
			});
		}
		function onKeyEnter(e) {
			search();
		}
		function seeMoreImg(id) {
			mini.open({
				//url : "view/inspectReport/seeMoreImg.jsp",
				url : "inspectReport/seeMoreImg?id="+id,
				title : "报告单",
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
	</script>
</body>
</html>