<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
	<title></title>

	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<!-- 引入bootstrap -->
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
	<!-- 引入JQuery  bootstrap.js-->
	<script src="${pageContext.request.contextPath}/js/jquery-3.2.1.min.js"></script>
	<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
</head>
<body>
	<!-- 顶栏 -->
	<jsp:include page="top.jsp"></jsp:include>
	<!-- 中间主体 -->
		<div class="container" id="content">
		<div class="row">
			<jsp:include page="menu.jsp"></jsp:include>
			<div class="col-md-10">
				<div class="panel panel-default">
				    <div class="panel-heading">
						<div class="row">
					    	<h1 style="text-align: center;">修改工作室资料</h1>
						</div>
				    </div>
				    <div class="panel-body">
						<form class="form-horizontal" role="form" action="${pageContext.request.contextPath}/admin/showWork" id="editfrom" method="post">
							  <div class="form-group">
				                <label for="inputPassword3" class="col-sm-2 control-label">上传视频</label>
				                <div class="col-sm-10">
				                  <input type="file"  id="v_video">
				                </div>
				              </div>
							  <div class="form-group">
							    <label for="inputEmail3" class="col-sm-2 control-label">工作室资料id</label>
							    <div class="col-sm-10">
							      <input type="number" class="form-control" id="inputEmail3" name="wId" placeholder="请输入id" readonly value="${workspace.wId}"/>
								 
							    </div>
							  </div>
							  <div class="form-group">
							    <label for="inputPassword3" class="col-sm-2 control-label">工作室简介</label>
							    <div class="col-sm-10">
							      <input type="text" class="form-control" name="wIntro" value="${workspace.wIntro}" placeholder="请输入工作室简介"/>
								
							    </div>
							  </div>
							  <div class="form-group">
							    <label for="inputPassword3" class="col-sm-2 control-label">培训对象</label>
							    <div class="col-sm-10">
							      <input type="text" class="form-control" name="wObject" value="${workspace.wObject}" placeholder="请输入培训对象"/>
								  
							    </div>
							  </div>
							<div class="form-group">
							    <label for="inputPassword3" class="col-sm-2 control-label">授课方式</label>
							    <div class="col-sm-10">
							      <input type="text" class="form-control"  name="wSchema" value="${workspace.wSchema}" placeholder="请输入授课方式"/>
								 
							    </div>
							  </div>
							  
							  <div class="form-group">
							    <label for="inputPassword3" class="col-sm-2 control-label">温馨提示</label>
							    <div class="col-sm-10">
							      <input type="text" class="form-control"  name="wRemind" value="${workspace.wRemind}" placeholder="请输入温馨提示"/>
								 
							    </div>
							  </div>
							  
							  <div class="form-group">
							    <label for="inputPassword3" class="col-sm-2 control-label">琴行地址</label>
							    <div class="col-sm-10">
							      <input type="text" class="form-control"  name="wAddress" value="${workspace.wAddress}" placeholder="请输入琴行地址"/>
								 
							    </div>
							  </div>
							  
							   <div class="form-group">
							    <label for="inputPassword3" class="col-sm-2 control-label">请输入联系方式</label>
							    <div class="col-sm-10">
							      <input type="text" class="form-control"  name="wPhone" value="${workspace.wPhone}" placeholder="请输入联系方式"/>
								 
							    </div>
							  </div>
							  
							  
							   <div class="form-group">
							    <label for="inputPassword3" class="col-sm-2 control-label">公告栏内容</label>
							    <div class="col-sm-10"> 
							      <input type="text" class="form-control"  name="gContent" value="${workspace.gContent}" placeholder="请输入公告栏内容"/>
								 
							    </div>
							  </div>
							 
							   <div class="form-group">
							    <label for="inputPassword3" class="col-sm-2 control-label">公告栏时间</label>
							    <div class="col-sm-10">
							      <input type="text" class="form-control"  name="gTime" value="${workspace.gTime}" placeholder="请输入公告栏时间"/>
								 
							    </div>
							  </div>
							 
							  <div class="form-group">
							    <label for="inputPassword3" class="col-sm-2 control-label">公告栏地址</label>
							    <div class="col-sm-10">
							      <input type="text" class="form-control"  name="gAddress" value="${workspace.gAddress}" placeholder="请输入公告栏地址"/>
								 
							    </div>
							  </div>
							 
							  <div class="form-group">
							    <label for="inputPassword3" class="col-sm-2 control-label">公告栏温馨提示</label>
							    <div class="col-sm-10">
							      <input type="text" class="form-control"  name="gRemind" value="${workspace.gRemind}" placeholder="请输入公告栏温馨提示"/>
								 
							    </div>
							  </div>
							  <div class="form-group" style="text-align: center">
								<button class="btn btn-default" type="submit">提交</button>
								<button class="btn btn-default" type="reset">重置</button>
							  </div>
						</form>
				    </div>
				    
				</div>

			</div>
		</div>
	</div>
	<div class="container" id="footer">
	<div class="row">
		<div class="col-md-12"></div>
	</div>
	</div>
</body>
	<script type="text/javascript">
		$("#nav li:nth-child(6)").addClass("active")
	</script>
</html>