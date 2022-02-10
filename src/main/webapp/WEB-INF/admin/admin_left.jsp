<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
	<title>admin_left.jsp</title>
	<%@ include file="../../include/bs4.jsp" %>
	<script>
		function logoutCheck(){
			parent.location.href = "${ctp}/memLogOut.mem";
		}
	</script>
	<style>
		body{background-color:#4361c2; color:white;}
		 a:link { color: white; text-decoration: none;}
			a:visited { color: white; text-decoration: none;}
			a:hover { color: #9dc66b; text-decoration: none;}

	</style>
</head>
<body>
<p><br/></p>
<div class="container" style="font-family: 'pretendard';">
	<h4><a href="${ctp}/admin_content.ad" target="admin_content">관리자메뉴</a></h4>
	<hr style="background-color:#9dc66b;"/>
	<p><a href="${ctp}/admin_memList.ad" target="admin_content">회원관리</a></p>
	<p><a href="${ctp}/admin_apply.ad" target="admin_content">견적의뢰</a></p>
	<p><a href="${ctp}/admin_freeApplyList.ad" target="admin_content">샘플의뢰</a></p>
	<hr style="background-color:#9dc66b;"/>
	<p><a href="<%=request.getContextPath()%>/" target="_top">홈으로</a></p>
	<p><a href="javascript:logoutCheck()">로그아웃</a></p>
</div>
<br/>
</body>
</html>