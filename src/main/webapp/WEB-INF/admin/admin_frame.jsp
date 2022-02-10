<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
	<title>admin_frame.jsp</title>
	<frameset cols="200px,*">
		<frame src="<%=request.getContextPath()%>/admin_left.ad" name="admin_left" frameborder="0"/>
		<frame src="<%=request.getContextPath()%>/admin_content.ad" name="admin_content" frameborder="0"/>
	</frameset>
</head>
<body>

</body>
</html>