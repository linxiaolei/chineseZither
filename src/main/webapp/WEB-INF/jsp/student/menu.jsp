<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="col-md-2">
    <ul class="nav nav-pills nav-stacked" id="nav">
        <li><a href="${pageContext.request.contextPath}/student/showCourse">所有课程</a></li>
        <li><a href="${pageContext.request.contextPath}/student/selectedCourse">已选课程</a></li>
        <li><a href="${pageContext.request.contextPath}/student/passwordRest">修改密码</a></li>
        <li><a href="${pageContext.request.contextPath}/logout">退出系统<sapn class="glyphicon glyphicon-log-out pull-right" /></a></li>
        <li class="disabled"><a href="##">Responsive</a></li>
    </ul>
</div>