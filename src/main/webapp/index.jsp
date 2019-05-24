<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>员工列表</title>
<%
	pageContext.setAttribute("APP_PATH",request.getContextPath());
%>
<script type="text/javascript" src="${APP_PATH}/static/js/jquery-3.3.1.min.js"></script>
<link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
<script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js" type="text/javascript"></script>

</head>
<body>
	<!--搭建显示页面  -->
	<div class="container">	
	<!--标题  -->
		<div calss="row">
			<div class="col-md-12">
				<h1>SSM-CRUD</h1>
			</div>
		</div>
		<!--按钮  -->
		<div calss="row">
			<div class="col-md-4 col-md-offset-8"> 
				<button class="btn btn-primary">新增</button>
				<button class="btn btn-danger">删除</button>
			</div>
		</div>
		<!--  显示表格数据-->
		<div calss="row">
			<div class="col-md-12">
				<table class="table table-hover" id="emps_table">
					<thead>
					<tr>
						<th>#</th>
						<th>empName</th>
						<th>gender</th>
						<th>email</th>
						<th>deptName</th>
						<th>操作</th>
					</tr>
				</thead>
				<tbody>
					
				</tbody>
					
					
				</table>
			</div>	
		</div>
		
		
		<!-- 分页 -->
		<div calss="row">
			<!-- 分页文字信息 -->
			<div class="col-md-6">
				当前 页，总 页,总  条记录
			</div>
			<!-- 分页条 -->
			<div class="col-md-6">
				
			</div>	
		</div>
	</div>
	
	<script type="text/javascript">
		$(function(){
			$.ajax({
				url:"${APP_PATH}/emps",
				data:"pn=1",
				type:"GET",
				success:function(result){
					//console.log(result);
					build_emps_table(result);
				}
					
			});
		});
		
		function build_emps_table(result){
			var emps= result.extend.PageInfo.list;
			$.each(emps,function(index,item){
				var empIdTd = $("<td></td>").append(item.empId);
				var empNameTd = $("<td></td>").append(item.empName);
				var genderTd = $("<td></td>").append(item.gender=='M'?"男":"女");
				var emailTd = $("<td></td>").append(item.email);
				var deptNameTd = $("<td></td>").append(item.department.deptName);
			
				var editbtn =$("<button></button>").addClass("btn btn-primary btn-sm")
					.append($("<span></spqn>").addClass("glyphicon glyphicon-pencil")).append("编辑")
				
				var delbtn =$("<button></button>").addClass("btn btn-danger btn-sm")
					.append($("<span></spqn>").addClass("glyphicon glyphicon-trash")).append("编辑")
				
				var btnTd = $("<td></td>").append(editbtn).append(" ").append(delbtn);
					$("<tr></tr>").append(empIdTd)
				.append(empNameTd)
				.append(genderTd)
				.append(emailTd)
				.append(deptNameTd)
				.append(btnTd)
				.appendTo("#emps_table tbody");
			});
		}
		
		function build_page_nav(result){
			
		}
	</script>
</body>
</html>