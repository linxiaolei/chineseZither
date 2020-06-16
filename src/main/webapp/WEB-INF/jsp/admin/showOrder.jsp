<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
	<title>订单信息显示</title>

	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<!-- 引入bootstrap -->
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
	<!-- 引入JQuery  bootstrap.js-->
	<script src="${pageContext.request.contextPath}/js/jquery-3.2.1.min.js"></script>
	<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>

	<%--<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">--%>

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
					    	<h1 class="col-md-5">订单管理</h1>
							<form class="bs-example bs-example-form col-md-5" role="form" style="margin: 20px 0 10px 0;" action="${pageContext.request.contextPath}/admin/selectCourse" id="form1" method="post">
								<div class="input-group">
									<input type="text" class="form-control" placeholder="请输入姓名" name="findByName">
									<span class="input-group-addon btn" onclick="document.getElementById('form1').submit" id="sub">搜索</span>
								</div>
							</form>

						</div>
				    </div>
				    <table class="table table-bordered">
					        <thead>
					            <tr>
									<th>订单号</th>
									<th>商品id</th>
									<th>商品名称</th>
									<th>数量</th>
									<th>时间</th>
									<th>操作</th>
					            </tr>
					        </thead>
					        <tbody>
							<c:forEach  items="${orderList}" var="item">
								<tr>
									<td>${item.orderId}</td>
									<td>${item.productId}</td>
									<td>${item.productIntro}</td>
									<td>${item.productNum}</td>
									<td><fmt:formatDate value="${item.create_time}" dateStyle="medium" /></td>
									<td>
										<a class="btn btn-default btn-xs btn-danger btn-primary" href="${pageContext.request.contextPath}/admin/deleteOrder?id=${item.oId}">删除</a>
										<button class="btn btn-default btn-xs btn-danger btn-primary" onClick="showModel()">发货</button>
										<!--弹出框-->
									</td>
								</tr>
							</c:forEach>
					        </tbody>
				    </table>
				</div>

			</div>
		</div>
	</div>
	<div class="container" id="footer">
		<div class="row">
			<div class="col-md-12"></div>
		</div>
	</div>
	<script type="text/javascript">
		<%--设置菜单中--%>
		$("#nav li:nth-child(5)").addClass("active");
	  function delete_tr(obj){
       	　　var index = $(obj).parents("tr").index(); //这个可获取当前tr的下标
       	　　$(obj).parents("tr").remove();
       	}
        function confirmd() {
            var msg = "您真的确定要删除吗？！";
            if (confirm(msg)==true){
                return true;
            }else{
                return false;
            }
        }
        function showModel(){
        	alert("您已经成功发货");
        }

        
      
        
	</script>
</body>
	
</html>