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

<!-- 员工修改模态框 -->
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" >员工修改</h4>
      </div>
      <div class="modal-body">
			 <form class="form-horizontal">
			  <div class="form-group">
			    <label class="col-sm-2 control-label">empName</label>
			    <div class="col-sm-10">
			     <p class="form-control-static" id="empName_update_static"></p>
			    </div>
			  </div>
			  <div class="form-group">
			    <label class="col-sm-2 control-label">email</label>
			    <div class="col-sm-10">
			      <input type="test" name="email" class="form-control" id="email_update_input" placeholder="email">
			    	<span id="helpBlock2" class="help-block"></span>
			    </div>
			  </div>
			 <div class="form-group">
			    <label class="col-sm-2 control-label">gender</label>
			    <div class="col-sm-10">
			    	<label class="radio-inline">
					  <input type="radio" name="gender"  value="M" checked="checked"> 男
					</label>
					<label class="radio-inline">
					  <input type="radio" name="gender" value="F"> 女
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
        <button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
      </div>
    </div>
  </div>
</div>




<!-- 员工添加模态框 -->
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
					  <input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked"> 男
					</label>
					<label class="radio-inline">
					  <input type="radio" name="gender" id="gender2_add_input" value="F"> 女
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
				<button class="btn btn-danger" id="emp_delete_all_btn">删除</button>
			</div>
		</div>
		<!--  显示表格数据-->
		<div calss="row">
			<div class="col-md-12">
				<table class="table table-hover" id="emps_table">
					<thead>
					<tr>
						<th>
							<input type="checkbox" id="check_all">
						</th>
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
	
	var totalRecord,currentPage;
	
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
				var checkBoxTd=$("<td><input type='checkbox' class='check_item'/></td>");
				var empIdTd = $("<td></td>").append(item.empId);
				var empNameTd = $("<td></td>").append(item.empName);
				var genderTd = $("<td></td>").append(item.gender=='M'?"男":"女");
				var emailTd = $("<td></td>").append(item.email);
				var deptNameTd = $("<td></td>").append(item.department.deptName);

				var editbtn =$("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
					.append($("<span></spqn>").addClass("glyphicon glyphicon-pencil")).append("编辑")
				//为编辑按钮添加一个自定义属性
				editbtn.attr("edit-id",item.empId);
				
				var delbtn =$("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
					.append($("<span></spqn>").addClass("glyphicon glyphicon-trash")).append("删除")
				delbtn.attr("del-id",item.empId);
				var btnTd = $("<td></td>").append(editbtn).append(" ").append(delbtn);
					$("<tr></tr>")
				.append(checkBoxTd)
					.append(empIdTd) 
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
			currentPage=result.extend.PageInfo.pageNum;
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
			getDepts("#empAddModal select");
			
			//弹出模态框
			$("#empAddModal").modal({
				backdrop:"static"
			});
		});
		
		//查出所有部门信息并显示在下拉列表中
		function getDepts(ele){
			$(ele).empty();
			$.ajax({
				url:"${APP_PATH}/depts",
				type:"GET",
				success:function(result){
					 
					$.each(result.extend.depts,function(){
						var optionEle = $("<option></option>").append(this.deptName).attr("value",this.deptId);
						optionEle.appendTo(ele);
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
	/* 		if(!validate_add_form()){
			return false;
		}; */
		//判断用户名校验是否成功
		if($(this).attr("ajax_va")=="error"){
			return false;
		}
		
		$.ajax({
				url:"${APP_PATH}/emp",
				type:"POST",
				data:$("#empAddModal form").serialize(),
				success:function(result){
				//	alert(result.msg);
					if(result.code==100){
						//员工保存成功
						//	关闭模态框
							$("#empAddModal").modal('hide');
							/*来到最后一页  */
							to_page(totalRecord);
					}else{
						//显示失败信息
						//console.log(result);
						//有那个字段错误信息就显示哪个字段
						if(undefined !=result.extend.errorFields.email){
							show_validate_msg("#email_add_input","error",result.extend.errorFields.email);
						}
						if(undefined !=result.extend.errorFields.empName){
							show_validate_msg("#empName_add_input","error",result.extend.errorFields.empName);
							
						}
					}
				}
			})	 	
		})
		
		$(document).on("click",".edit_btn",function(){
			//1查出部门和员工信息并显示列表
			getDepts("#empUpdateModal select");
			
			getEmp($(this).attr("edit-id"));
			
			//把员工id传递给模态框的更新按钮
			$("#emp_update_btn").attr("edit-id",$(this).attr("edit-id"));
			$("#empUpdateModal").modal({
				backdrop:"static"
			});
		});
		
		
		function getEmp(id){
			$.ajax({
				url:"${APP_PATH}/emp/"+id,
				type:"GET",
				success:function(result){
					var empData=result.extend.emp;
					$("#empName_update_static").text(empData.empName);
					$("#email_update_input").val(empData.email);
					$("#empUpdateModal input[name=gender]").val([empData.gender]);
					$("#empUpdateModal select").val([empData.dId]);
				}
			})
		}
		
		$("#emp_update_btn").click(function(){
			//验证邮箱是否合法
			var email = $("#email_update_input").val();
			var regEmail = 	/^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
				if(!regEmail.test(email)){
					show_validate_msg("#email_update_input","error","邮箱格式不正确");
					return false;
				}else{
					show_validate_msg("#email_update_input","success","邮箱可以使用");
				}
		
				//2、发送ajax请求保存更新的员工数据
				$.ajax({
					url:"${APP_PATH}/emp/"+$(this).attr("edit-id"),
					type:"POST",
					data:$("#empUpdateModal form").serialize()+"&_method=PUT",
					success:function(result){
						//alert(result.msg);
					$("#empUpdateModal").modal("hide");
					to_page(currentPage);
					}
				})
				 
		});
		
		//单个删除
		$(document).on("click",".delete_btn",function(){
			//弹出是否确认删除的对话框
			var empName= $(this).parents("tr").find("td:eq(2)").text();
			var empId=$(this).attr("del-id");
			if(confirm("确认删除【"+empName+"】吗？")){
				$.ajax({
					url:"${APP_PATH}/emp/"+empId,
					type:"DELETE",
					success:function(result){
						to_page(currentPage);
					}
					
				})
			}
			
			//alert($(this).parents("tr").find("td:eq(1)").text());
		});
		
		$("#check_all").click(function(){
			$(".check_item").prop("checked",$(this).prop("checked"));
		});
		
		$(document).on("click",".check_item",function(){
			var flag =$(".check_item:checked").length==$(".check_item").length;
			$("#check_all").prop("checked",flag);
		})
		
		
		$("#emp_delete_all_btn").click(function(){
			
			var empNames = "";
			var del_idstr="";
			$.each($(".check_item:checked"),function(){
				empNames +=$(this).parents("tr").find("td:eq(2)").text()+","
				del_idstr +=$(this).parents("tr").find("td:eq(1)").text()+"-"
			});
			
			empNames=empNames.substring(0,empNames.length-1);
			del_idstr=del_idstr.substring(0,del_idstr.length-1);
			if(confirm("确认删除【"+empNames+"】吗？")){
				
				$.ajax({
					url:"${APP_PATH}/emp/"+del_idstr,
					type:"DELETE",
					success:function(result){
						alert(result.msg);
						
						to_page(currentPage);
					}
				})
			}
		})
	</script>
</body>
</html>