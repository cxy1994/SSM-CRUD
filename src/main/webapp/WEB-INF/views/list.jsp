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
<script type="text/javascript" src="${APP_PATH}/static/js/jquery-3.2.1.min.js"></script>
<link rel="stylesheet"
	href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css">
<script type="text/javascript"
	src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>

<body>
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
				<button class="btn btn-info">
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
				<table class="table table-hover">
					<tr>
						<th>工号</th>
						<th>员工姓名</th>
						<th>Email</th>
						<th>性别</th>
						<th>部门</th>
						<th>操作</th>
					</tr>
					<c:forEach items="${pageInfo.list}" var="emp">
						<tr>
							<th>${emp.empId}</th>
							<th>${emp.empName}</th>
							<th>${emp.email}</th>
							<th>${emp.gender=="M"?"男":"女"}</th>
							<th>${emp.department.deptName}</th>
							<th>
								<button class="btn btn-primary btn-sm">
									<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>编辑
								</button>
								<button class="btn btn-danger btn-sm">
									<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除
								</button></th>
						</tr>
					</c:forEach>
				</table>
			</div>
		</div>
		<!-- 分页 -->
		<div class="row">
			<div class="col-lg-4">当前第${pageInfo.pageNum}页，共${
				pageInfo.pages}页，共${pageInfo.total }条记录。</div>
			<div class="col-lg-4">
				<nav aria-label="Page navigation">
				<ul class="pagination">

					<c:if test="${ pageInfo.hasPreviousPage}">
						<li><a href="${APP_PATH }/emps?pn=1">首页</a></li>
						<li><a href="${APP_PATH }/emps?pn=${pageInfo.pageNum-1}"
							aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
						</a>
						</li>
					</c:if>

					<c:forEach items="${pageInfo.navigatepageNums }" var="page_Num">
						<c:if test="${page_Num==pageInfo.pageNum }">
							<li class="active"><a href="#">${page_Num }</a></li>
						</c:if>
						<c:if test="${page_Num!=pageInfo.pageNum }">
							<li><a href="${APP_PATH }/emps?pn=${page_Num}">${page_Num}</a>
							</li>
						</c:if>
					</c:forEach>
					<c:if test="${ pageInfo.hasNextPage}">
						<li><a href="${APP_PATH }/emps?pn=${pageInfo.pageNum+1}"
							aria-label="Next"> <span aria-hidden="true">&raquo;</span> </a>
						</li>
						<li><a href="${APP_PATH }/emps?pn=${pageInfo.pages}">尾页</a></li>
					</c:if>
				</ul>
				</nav>
			</div>
		</div>
	</div>
</body>
</html>
