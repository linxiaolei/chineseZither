<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="col-md-2">
    <ul class="nav nav-pills nav-stacked" id="nav">
        <li><a href="${pageContext.request.contextPath}/admin/showCourse">课程管理</a></li>
        <li><a href="${pageContext.request.contextPath}/admin/showStudent">学生管理</a></li>
        <li><a href="${pageContext.request.contextPath}/admin/showTeacher">教师管理</a></li>
        <li><a href="${pageContext.request.contextPath}/admin/showProduct">商品管理</a></li>
        <li><a href="${pageContext.request.contextPath}/admin/showOrder">订单管理</a></li>
        <li><a href="${pageContext.request.contextPath}/admin/showWork">工作室管理</a></li>
        <li><a href="${pageContext.request.contextPath}/admin/showMessage">消息查看</a></li>
        <li><a href="${pageContext.request.contextPath}/admin/passwordRest">修改密码</a></li>
        <li><a href="${pageContext.request.contextPath}/logout">退出系统<sapn class="glyphicon glyphicon-log-out pull-right" /></a></li>
        <li class="disabled"><a href="##">Responsive</a></li>
    </ul>
</div>