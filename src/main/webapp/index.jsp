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
<script type="text/javascript" src="${APP_PATH}/static/js/jquery-1.12.4.min.js"></script>
<link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
<script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js" type="text/javascript"></script>

</head>
<body>

<!-- 添加弹窗 -->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">员工添加</h4>
      </div>
      <div class="modal-body">
			 <form class="form-horizontal">
			  <div class="form-group">
			    <label class="col-sm-2 control-label">empName</label>
			    <div class="col-sm-10">
			      <input type="test" name="empName" class="form-control" id="empName_add_input" placeholder="empName">
			     <span id="helpBlock2" class="help-block"></span>
			    </div>
			  </div>
			  <div class="form-group">
			    <label class="col-sm-2 control-label">email</label>
			    <div class="col-sm-10">
			      <input type="test" name="email" class="form-control" id="email_add_input" placeholder="email">
			    	<span id="helpBlock2" class="help-block"></span>
			    </div>
			  </div>
			 <div class="form-group">
			    <label class="col-sm-2 control-label">gender</label>
			    <div class="col-sm-10">
			    	<label class="radio-inline">
					  <input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked"> 1
					</label>
					<label class="radio-inline">
					  <input type="radio" name="gender" id="gender2_add_input" value="F"> 2
					</label>
			    </div>
			  </div>
			  
			  <div class="form-group">
			    <label class="col-sm-2 control-label">deptName</label>
			    <div class="col-sm-4">
			    <!--  部门提交-->
			    	<select class="form-control" name="dId"></select>
			    </div>
			  </div>
			</form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
        <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
      </div>
    </div>
  </div>
</div>


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
				<button class="btn btn-primary" id="emp_add_Modal">新增</button>
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
			<div class="col-md-6" id="page_info_area">
				
			</div>
			<!-- 分页条 -->
			<div class="col-md-6" id="page_nav_area">
				
			</div>	
		</div>
	</div>
	
	<script type="text/javascript">
	
	var totalRecord;
	
	//去首页
		$(function(){
			to_page(1);
		});
		
		function to_page(pn){
			$.ajax({
				url:"${APP_PATH}/emps",
				data:"pn="+pn,
				type:"GET",
				success:function(result){
					//console.log(result);
					build_emps_table(result);
					build_page_info(result);
					build_page_nav(result);
				}
					
			});
		}
		
		
		function build_emps_table(result){
			//清空table表格
			$("#emps_table tbody").empty();
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
					.append($("<span></spqn>").addClass("glyphicon glyphicon-trash")).append("删除")
				
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
		
		//解析显示分页信息
		function build_page_info(result){
			$("#page_info_area").empty();
			$("#page_info_area").append("当前"+result.extend.PageInfo.pageNum+"页,总"+
					result.extend.PageInfo.pages+"页,总"+
					result.extend.PageInfo.total+" 条记录");
			totalRecord=result.extend.PageInfo.total;
		}
		
		
		//解析显示分页条
		function build_page_nav(result){
			//page_nav_area
			$("#page_nav_area").empty();
			var ul = $("<ul></ul>").addClass("pagination");
			var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
			var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
			if(result.extend.PageInfo.hasPreviousPage == false){
				firstPageLi.addClass("disabled");
				prePageLi.addClass("disabled");
			}else{
				//为元素添加点击翻页事件
				firstPageLi.click(function(){
					to_page(1);
				})
				prePageLi.click(function(){
					to_page(result.extend.PageInfo.pageNum-1);
				})
			}
			
			
			var nestPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
			var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
			if(result.extend.PageInfo.hasNextPage == false){
				nestPageLi.addClass("disabled");
				lastPageLi.addClass("disabled");
			}else{
				nestPageLi.click(function(){
					to_page(result.extend.PageInfo.pageNum+1);
				})
				lastPageLi.click(function(){
					to_page(result.extend.PageInfo.pages);
				})
			}
			
			
			ul.append(firstPageLi).append(prePageLi);
			$.each(result.extend.PageInfo.navigatepageNums,function(index,item){
				var numLi = $("<li></li>").append($("<a></a>").append(item));
				if(result.extend.PageInfo.pageNum == item){
					numLi.addClass("active");
				}
				numLi.click(function(){
					to_page(item);
					
				});
				ul.append(numLi);
			});
			ul.append(nestPageLi).append(lastPageLi);
			var navEle = $("<nav></nav>").append(ul);
			navEle.appendTo("#page_nav_area");
		}
		
		//清空表单样式及内容
		function reset_form(ele){
			$(ele)[0].reset(); 
			$(ele).find("*").removeClass("has-error has-success");
			$(ele).find(".help-block").text("");
		}
		
		//点击弹出模态框
		$("#emp_add_Modal").click(function(){
			//清除表单数据
			reset_form("#empAddModal form");
			//$()[0].reset();
			
			
			//发送ajax请求，查出部门信息，显示在下来列表中
			getDepts();
			
			//弹出模态框
			$("#empAddModal").modal({
				backdrop:"static"
			});
		});
		
		function getDepts(){
			$("#empAddModal select").empty();
			$.ajax({
				url:"${APP_PATH}/depts",
				type:"GET",
				success:function(result){
					 
					$.each(result.extend.depts,function(){
						var optionEle = $("<option></option>").append(this.deptName).attr("value",this.deptId);
						optionEle.appendTo("#empAddModal select");
					}); 
				}
			});
		}
		
		//校验表单数据
		function validate_add_form(){
			//1.拿到要校验的数据，使用正则表达式
			var empName = $("#empName_add_input").val();
			var regName =/(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/; 	
			if(!regName.test(empName)){
				/*  alert("用户名不规范");*/
				show_validate_msg("#empName_add_input","error","用户名不规范");
/* 				$("#empName_add_input").parent().addClass("has-error");
				$("#empName_add_input").next("span").text("用户名不规范"); */
				return false;
			}else{
				/* $("#empName_add_input").parent().addClass("has-success");
				$("#empName_add_input").next("span").text("用户名可以使用"); */
				show_validate_msg("#empName_add_input","success","用户名可以使用");
			};
			 
			//校验邮箱的值
			var email = $("#email_add_input").val();
			var regEmail = 	/^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
				if(!regEmail.test(email)){
					/* alert("邮箱格式不正确"); */
					//应该清空元素之前的样式
					show_validate_msg("#email_add_input","error","邮箱格式不正确");
					/* $("#email_add_input").parent().addClass("has-error");
					$("#email_add_input").next("span").text("邮箱格式不正确"); */
					return false;
				}else{
					/* $("#email_add_input").parent().addClass("has-success");
					$("#email_add_input").next("span").text("邮箱可以使用"); */
					show_validate_msg("#email_add_input","success","邮箱可以使用");
				}
			return true;
		}
		 
		
		function show_validate_msg(ele,status,msg){
			//清除当前元素校验状态
			$(ele).parent().removeClass("has-success has-error");
			$(ele).next("span").text("");
			if("success"==status){
				$(ele).parent().addClass("has-success");
				$(ele).next("span").text(msg);
				
			}else if("error"==status){
				$(ele).parent().addClass("has-error");
				$(ele).next("span").text(msg);
			}
		}
		
		//校验用户名是否可用
		$("#empName_add_input").change(function(){
			//发送ajax请求校验用户名是否可用
			var empName = this.value;
			
			$.ajax({
				url:"${APP_PATH}/checkuser",
				data:"empName="+empName,
				type:"POST",
				success:function(result){
					if(result.code==100){
						show_validate_msg("#empName_add_input","success","用户名可用");
						$("#emp_save_btn").attr("ajax_va","success");
					}else{
						show_validate_msg("#empName_add_input","error",result.extend.va_msg);
						$("#emp_save_btn").attr("ajax_va","error");
					}
				}
			});
		});
		
		
		$("#emp_save_btn").click(function(){
			
		/* 	alert($("#empAddModal form").serialize()); */
			//对提交的数据进行校验
			if(!validate_add_form()){
			return false;
		};
		//判断用户名校验是否成功
		if($(this).attr("ajax_va")=="error"){
			return false;
		}
		
		$.ajax({
				url:"${APP_PATH}/emp",
				type:"POST",
				data:$("#empAddModal form").serialize(),
				success:function(result){
					/* alert(result.msg); */
					$("#empAddModal").modal('hide');
					
					to_page(totalRecord);
				}
			})	 	
		})
		
	</script>
</body>
</html>