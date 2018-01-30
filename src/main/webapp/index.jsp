<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<%--
        不以/开始的相对路径，找资源，以当前资源的路径为基准，经常容易出问题
        以/开始的相对路径，找资源，以服务器的路径为标准,需要加上项目名
        （http://localhost:3306）
        http://localhost:3306/crud
    --%>
<script src="${APP_PATH}/static/js/jquery-3.2.1.min.js"></script>
<link rel="stylesheet"
	href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css">
<script type="text/javascript"
	src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>

<body>
	<!-- Modal -->
	<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">NEW EMPLOYEE HERE</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal">
						<div class="form-group">
							<label for="inputEmail3" class="col-sm-2 control-label">姓名</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="empName_input"
									placeholder="Jackey Chan" name="empName"><span
									class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label for="inputPassword3" class="col-sm-2 control-label">Email</label>
							<div class="col-sm-10">
								<input type="email" class="form-control" id="email_input"
									placeholder="xxxx@qq.com" name="email">
								<span class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">性别</label>
							<div class="col-sm-10">
								<label class="radio-inline"> <input type="radio"
									id="gender_input_M" checked="checked" value="M" name="gender">男</label>
								<label class="radio-inline"> <input type="radio"
									id="gender_input_F" value="F" name="gender">女</label>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">部门</label>
							<div class="col-sm-4">
								<select class="form-control" id="dept_select" name="dId">


								</select>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" id="emp_save">保存</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				</div>
			</div>
		</div>
	</div>


	<div class="container">
		<div class="row">
			<!-- title -->
			<div class="col-lg-12">
				<h1>SSM-CRUD</h1>
			</div>
		</div>
		<div class="row">
			<!-- button -->
			<div class="col-lg-4 col-lg-offset-8">
				<button class="btn btn-info" id="emp_add_modal">
					<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>新增
				</button>
				<button class="btn btn-danger">
					<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除
				</button>
			</div>
		</div>
		<div class="row">
			<br>
		</div>
		<div class="row">
			<!-- table -->
			<div class="col-lg-12">
				<table class="table table-hover" id="emps_table">
					<thead>
						<tr>
							<th>工号</th>
							<th>姓名</th>
							<th>性别</th>
							<th>Email</th>
							<th>部门</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>

					</tbody>
				</table>
			</div>
		</div>
		<!-- 分页 -->
		<div class="row">
			<div class="col-lg-4" id="infos_area"></div>
			<div class="col-lg-4" id="lead_area"></div>
		</div>
	</div>

	<script type="text/javascript">
	
		var lastPageNum;
	
		$(function() {
			to_page(1);
		});

		function to_page(pn) {
			$.ajax({
				url : "${APP_PATH }/emps",
				data : {
					"pn" : pn
				},
				type : "GET",
				success : function(result) {
					build_emps_table(result);
					build_page_info(result);
					build_page_nav(result);
					lastPageNum = result.extend.pageInfo.pages + 1;
				}
			});
		}

		function build_emps_table(result) {
			$("#emps_table tbody").empty();
			var emps = result.extend.pageInfo.list;
			$.each(emps, function(index, item) {
				//alert(item.empName);
				var empId = $("<td></td>").append(item.empId);
				var empName = $("<td></td>").append(item.empName);
				var gender = $("<td></td>").append(
						item.gender == "M" ? "男" : "女");
				var email = $("<td></td>").append(item.email);
				var deptName = $("<td></td>").append(item.department.deptName);
				var editBtn = $("<button></button>").addClass(
						"btn btn-primary btn-sm").append(
						$("<span></span>").addClass(
								"glyphicon glyphicon-pencil").append("编辑"));
				var delBtn = $("<button></button>").addClass(
						"btn btn-danger btn-sm").append(
						$("<span></span>")
								.addClass("glyphicon glyphicon-trash").append(
										"删除"));
				var Btn = $("<td></td>").append(editBtn).append(" ").append(
						delBtn);
				$("<tr></tr>").append(empId).append(empName).append(gender)
						.append(email).append(deptName).append(Btn).appendTo(
								"#emps_table tbody");
			});
		}

		function build_page_info(result) {
			$("#infos_area").empty();
			var data = result.extend.pageInfo;
			$("#infos_area").append(
					"当前第" + data.pageNum + "页，共" + data.pages + "页，共"
							+ data.total + "条记录。");
		}

		function build_page_nav(result) {
			$("#lead_area").empty();
			var data = result.extend.pageInfo;
			var ul = $("<ul></ul>").addClass("pagination");

			//绑定单击事件，点击按钮后发送ajax请求
			var index = $("<li></li>").append(
					$("<a></a>").append("首页").attr("href", "#"));
			var pre = $("<li></li>").append(
					$("<a></a>").append("&laquo;").attr("href", "#"));

			if (!data.hasPreviousPage) {
				index.addClass("disabled");
				pre.addClass("disabled");
			} else {
				index.click(function() {
					to_page(1);
				});
				pre.click(function() {
					to_page(data.pageNum - 1);
				});
			}
			var next = $("<li></li>").append(
					$("<a></a>").append("&raquo;").attr("href", "#"));
			var end = $("<li></li>").append(
					$("<a></a>").append("尾页").attr("href", "#"));

			if (!data.hasNextPage) {
				next.addClass("disabled");
				end.addClass("disabled");
			} else {
				next.click(function() {
					to_page(data.pageNum + 1);
				});
				end.click(function() {
					to_page(data.pages);
				});
			}

			ul.append(index).append(pre);

			//error
			$.each(data.navigatepageNums, function(index, item) {
				var num = $("<li></li>").append($("<a></a>").append(item));
				if (data.pageNum == item) {
					num.addClass("active");
				}

				num.click(function() {
					to_page(item);
				});

				ul.append(num);
			});

			ul.append(next).append(end);

			var nav = $("<nav></nav>").append(ul);

			$("#lead_area").append(nav);

		}

		//btn click
		$("#emp_add_modal").click(function() {
			//reset_form("#empAndModal form");
			getDepts();
			$("#empAddModal").modal({
				//backdrop : "static",
				keyboard : "true"
			});
		});

		function getDepts() {
			//{"code":100,"msg":"aaa!","extend":{"depts":[{"deptId":1,"deptName":"省网管"},{"deptId":2,"deptName":"省支撑"},{"deptId":3,"deptName":"大众分发组"}]}}
			$.ajax({
				url : "${APP_PATH }/depts",
				type : "GET",
				success : function(result) {
					//console.log(result);
					$("#empAddModal select").empty();
					var data = result.extend.depts;
					$.each(data, function(index, item) {
						var op = $("<option></option>").append(item.deptName)
								.attr("value", item.deptId);
						op.appendTo("#empAddModal select");
					});
				}
			});
		}
		
		//校验用户名
	    $("#empName_input").change(function () {
	    	alert("1");
	        var empName = this.value;
	        $.ajax({
	            url:"${APP_PATH}/checkUser",
	            data:"empName=" + empName,
	            type:"POST",
	            success:function (result) {
	                if (result.code == 100){
	                    $("#empName_add_input").parent().removeClass("has-error");
	                    $("#empName_add_input").parent().addClass("has-success");
	                    $("#empName_add_input").next("span").text("用户名可用");

	                    $("#emp_save_btn").attr("ajax_va", "success");
	                }else {
	                    $("#empName_add_input").parent().removeClass("has-success");
	                    $("#empName_add_input").parent().addClass("has-error");
	                    $("#empName_add_input").next("span").text(result.extend.va_msg);

	                    $("#emp_save_btn").attr("ajax_va", "error");
	                }
	            }
	        });
	    });

		function validate_form(){
			 //1.拿到要校验的数据
	        var empName = $("#empName_input").val();
	        var regName = /(^[a-zA-Z0-9_-]{6,16}$)|([\u2E80-\u9FFF]{2,5})/;
	        
	        if(!regName.test(empName)){
	            $("#empName_input").parent().removeClass("has-success");
	            $("#empName_input").parent().addClass("has-error");
	            if(checkUser(empName)){
	            	$("#empName_input").next("span").text("该用户已存在！");
	            }else{
	            	$("#empName_input").next("span").text("用户名应为6-16位英文和数字的组合或者2-5位中文");
	            }
	            return false;
	        }else {
	            $("#empName_input").parent().removeClass("has-error");
	            $("#empName_input").parent().addClass("has-success");
	            $("#empName_input").next("span").text("");
	        }

	        //2.校验邮箱
	        var email = $("#email_input").val();
	        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
	        if(!regEmail.test(email)){
	            //alert("邮箱格式不正确");
	            $("#email_input").parent().removeClass("has-error");
	            $("#email_input").parent().addClass("has-error");
	            $("#email_input").next("span").text("邮箱格式不正确");
	            return false;
	        }else {
	            $("#email_input").parent().removeClass("has-error");
	            $("#email_input").parent().addClass("has-success");
	            $("#email_input").next("span").text("");
	        }
	        return true;
		}
		
		$("#emp_save").click(function() {
			//console.log($("#empAddModal form").serialize());
			if(!validate_form()){
				return false;
			}
			$.ajax({
				url : "${APP_PATH}/emp",
				data : $("#empAddModal form").serialize(),
				type : "POST",
				success : function(result) {
					alert(result.msg);
					$('#empAddModal').modal('hide');
					to_page(lastPageNum);
				}
			});
		});
	</script>
</body>
</html>
