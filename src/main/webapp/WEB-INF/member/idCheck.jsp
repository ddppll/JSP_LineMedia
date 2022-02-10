<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<%
	String mid = (String)request.getAttribute("mid");
	int res = (int) request.getAttribute("res");
 %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>아이디 중복 체크</title>
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/member_join.css" />
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.14.0/css/all.min.css" rel="stylesheet">
	<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/static/pretendard.css" />
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/member_join.js"></script>
	<script src="${pageContext.request.contextPath}/js/navbar.js"></script>
	<noscript><link rel="stylesheet" href="${pageContext.request.contextPath}/css/noscript.css" /></noscript>
	<script>
		function sendCheck(){
			opener.window.document.myform.mid.value =  "<%=mid%>";
			opener.window.document.myform.pwd.focus();
			window.close();
		}
		function idCheck(){
			var mid = childForm.mid.value;
			
			if(mid==""){
				alert("아이디를 입력하세요");
				childForm.mid.focus();
			}
			else {
				childForm.submit();
			}
		}
	</script>
</head>
<body>
    <div class="container p-3 my-3 border" style="width: 400px; font-family: pretendard;">
        <h3 style="margin: 5px;">아이디 중복 체크</h3>
        <hr>
		<%if(res == 1) { %>
			<h4><font color="red"><%=mid %></font>는 사용 가능한 아이디입니다.</h4>
			<p><input type="button" value="창 닫기" onclick="sendCheck()"/></p>
			<%}else { %>
			<h4><font color="red"><%=mid %></font>는 이미 사용중입니다.</h4>
			<form name="childForm" method="post" action="<%=request.getContextPath()%>/idCheck.mem">
				<input type="text" name="mid"/>
				<input type="button" value="아이디검색" onclick="idCheck()"/>
			</form>
			<%} %>
    </div>
</body>
</html>