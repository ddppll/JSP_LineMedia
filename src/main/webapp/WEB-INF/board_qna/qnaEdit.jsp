<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE HTML>
<html>
	<head>
		<title>견적 의뢰</title>
		<%@ include file="/include/bs4.jsp" %>
		<script>
			function fCheck(){
				var title = myform.title.value;
				var content = myform.content.value;
				
				if(title.trim() == ""){
					alert("제목을 입력하세요");
					myform.title.focus();
				}
				else if(content.trim() == ""){
					alert("글 내용을 입력하세요");
					myform.content.focus();
				}
				else{
					myform.submit();
				}
				
			}
		</script>
		<style>
			th{
				background-color : #4fa49a;
				text-align: center;
				color:white;
			}
			a:link { color: black; text-decoration: none;}
			a:visited { color: black; text-decoration: none;}
			a:hover { color: blue; text-decoration: none;}
			input:focus {outline:none;}
		
		</style>
	</head>
	<body class="is-preload">
	
	<%@ include file="/include/nav.jsp" %>
		<section id="header">
			<div class="inner">
				<br/>
				<h1 style="font-family: 'pretendard';">문의하기</h1><br />
				<h2></h2>
				<hr style="background-color: white; width: 60%; margin: 0px auto;"/>
				<p style="font-family: 'pretendard';">Your Global Translation Partner <br /></p>
				<ul class="actions special">
					<li><a href="#one" class="button scrolly" style="font-family: 'pretendard'; text-decoration-line: none;">Discover</a></li>
				</ul>
			</div>
		</section>
		<div class="container"style="font-family: 'pretendard'; margin-top:50px; margin-bottom:50px; ">
			<form name="myform" method="post" action="${ctp}/qnaEditOk.qa">
				<table class="table">
					<tr>
						<th style="text-align: center; color:white;">작성자</th>
						<td>${sNickName}</td> <!-- loginOk에서 세션에 닉네임 담아둔거 있음 -->
					</tr>
					<tr>
						<th style="text-align: center; color:white;">제목</th>
						<td><input type="text" name="title" placeholder="제목을 입력하세요" class="form-control" value="${vo.title}" autofocus required  style="background-color:white; border : none;"/></td>
					</tr>
					<tr>
						<th style="text-align: center; color:white;">이메일</th>
						<td style="background-color:white;"><input type="text" name="email" placeholder="이메일을 입력하세요" value="${email}" class="form-control" style="background-color:white; border : none;"/></td>
					</tr>
					<tr>
						<th style="text-align: center; color:white;">내용</th>
						<td style="background-color:white;"><textarea rows="6" name="content" class="form-control" required  style="background-color:white; border : none;">${vo.content}</textarea></td>
					</tr>
					<tr>
						<td colspan="2" style="text-align : center">
							<input type="checkbox" id="demo-human" name="demo-human"><label for="demo-human">비밀글</label>
							<input type="button" value="수정하기" onclick="fCheck()" class="btn btn-secondary"/>&nbsp;
							<input type="reset" value="재입력"  class="btn btn-secondary"/>&nbsp;
							<input type="button" value="돌아가기" onclick="location.href='${ctp}/qnaList.qa';" class="btn btn-secondary"/>
						</td>
					</tr>
				</table>
				<input type="hidden" name="idx" value="${vo.idx}"/>
			</form>
		</div>
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