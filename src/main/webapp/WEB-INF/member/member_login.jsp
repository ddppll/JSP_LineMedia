<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE HTML>
<html>
	<head>
		<title>로그인</title>
		<%@ include file="/include/bs4.jsp" %>
	</head>
	<body class="is-preload">
	
	<%@ include file="/include/nav.jsp" %>
		<section id="header">
			<div class="inner">
				<br/>
				<h1 style="font-family: 'pretendard';">로그인</h1><br />
				<h2></h2>
				<hr style="background-color: white; width: 60%; margin: 0px auto;"/>
				<p style="font-family: 'pretendard';">Your Global Translation Partner <br /></p>
				<ul class="actions special">
					<li><a href="#one" class="button scrolly" style="font-family: 'pretendard'; text-decoration-line: none;">Login</a></li>
				</ul>
			</div>
		</section>
		<form name="myform" method="post" action="<%=request.getContextPath()%>/memLoginOk.mem" class="was-validated">
		    <div class="container p-3 my-3 border" style="width: 550px; font-family: pretendard;">
		        <h3 style="margin: 5px;">Line Media</h3>
		        <hr>
		        <table class="table table-borderless" style="background-color: white;"> 
		            <tr style="background-color: white;">
		                <td>아이디</td>
		                <td><input type="text" class="form-control" id="mid" value="${mid}" placeholder="아이디를 입력하세요." name="mid" required autofocus style="width:327px" /></td>
		            </tr>
		            <tr>
		                <td>비밀번호</td>
		                <td><input type="password" class="form-control" name="pwd" id="pwd" placeholder="비밀번호를 입력하세요." autofocus></td>
		            </tr>
		        </table>
		    <span class="col mt-3">
		    	<input type="checkbox" id="demo-human" name="demo-human" checked><label for="demo-human">아이디 저장</label>
		    </span>
		    <div style="text-align: center;">
		        <button type="submit" class="button primary">로그인</button>
		        <button type="button" class="button primary" onclick="location.href='<%=request.getContextPath()%>/';">뒤로가기</button>
									
		    </div>
		    </div>
		</form>
		<!-- Footer -->
		<%@ include file="/include/footer.jsp" %>
		<!-- Scripts -->
			<script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
			<script src="${pageContext.request.contextPath}/js/jquery.scrolly.min.js"></script>
			<script src="${pageContext.request.contextPath}/js/browser.min.js"></script>
			<script src="${pageContext.request.contextPath}/js/breakpoints.min.js"></script>
			<script src="${pageContext.request.contextPath}/js/util.js"></script>
			<script src="${pageContext.request.contextPath}/js/main.js"></script>

	</body>
</html>