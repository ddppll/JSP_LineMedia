<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE HTML>
<html>
	<head>
		<title>견적 의뢰</title>
		<%@ include file="/include/bs4.jsp" %>
		<script>
			function fCheck(){
				var company = myform.company.value;
		    	var title = myform.title.value;
		    	var email = myform.email.value;
		    	var cellphone2 = myform.cellphone2.value;
		    	var cellphone3 = myform.cellphone3.value;
		    	var content = myform.content.value;
		    	
		    	if(company == "") {
		    		alert("업체/담당자명을 입력하세요");
		    		myform.company.focus();
		    	}
		    	else if(title == "") {
		    		alert("제목을 입력하세요");
		    		myform.title.focus();
		    	}
		    	else if(email == "") {
		    		alert("이메일을 입력하세요");
		    		myform.title.focus();
		    	}
		    	else if(content == "") {
		    		alert("문의 내용을 입력하세요");
		    		myform.content.focus();
		    	}
		    	else if(cellphone2 == ""||cellphone3=="") {
		    		alert("연락처를 입력하세요");
		    		myform.cellphone2.focus();
		    	}
		    	else{
		    		myform.submit();
		    	}
		    }
		</script>
	</head>
	<body class="is-preload">
	
	<%@ include file="/include/nav.jsp" %>
		<section id="header">
			<div class="inner">
				<br/>
				<h1 style="font-family: 'pretendard';">견적 의뢰</h1><br />
				<h2></h2>
				<hr style="background-color: white; width: 60%; margin: 0px auto;"/>
				<p style="font-family: 'pretendard';">Your Global Translation Partner <br /></p>
				<ul class="actions special">
					<li><a href="#one" class="button scrolly" style="font-family: 'pretendard'; text-decoration-line: none;">Discover</a></li>
				</ul>
			</div>
		</section>
		<section id="one" class="main style1" style="font-family: 'pretendard';">
				<div class="container">
					<div class="row gtr-150">
						<div class="col-6 col-12-medium">
							<header class="major">
								<h2 style="text-align:left;">콘텐츠의 글로벌 진출,<br />
								라인미디어와 시작하세요</h2>
							</header>
							<p style="text-align:left;">번역 가격 책정 외 궁금한 점이 있다면 언제든지 연락주세요.<br/>
							최상의 콘텐츠 번역 파트너가 되어드립니다.</p>
							<span style="margin-bottom:4px"><img src="images/apply.jpg" style="width:400px"/></span><br/>
							<br/><p style="text-align:left;"><font size="5px" bold>번역 품질을 먼저 확인해보고 싶다면?</font><br/>
							원하시는 콘텐츠의 일부분을 무상으로 번역해 드립니다</p>
							<p>실제 의뢰할 작업의 일부를 무료 테스트를 통해 퀄리티를 직접 확인하세요.<br/>
							샘플 번역을 통해 타 업체와 구분되는 품질을 체험할 수 있습니다.</p>
							<p><a href="<%=request.getContextPath()%>/applyFree.ap" class="button primary" style="text-decoration-line: none;">무료 번역 샘플 의뢰</a></p>
						</div>
						<div class="col-6 col-12-medium imp-medium">
							<form name="myform" method="post" action="${ctp}/applyInput.ap">
							업체명/담당자명<font style="color: red; font-weight: bold;"> *</font><br/>
							<input type="text" class="form-control" name="company" id="company" required oninvalid="this.setCustomValidity('업체/담당자를 입력하세요.')"/><br/>
							연락처<font style="color: red; font-weight: bold;"> *</font><br/>
							<select class="form-control" id="cellphone" name="cellphone" >
								<option value="010">010</option>
								<option value="011">011</option>
								<option value="016">016</option>
								<option value="017">017</option>
								<option value="018">018</option>
								<option value="019">019</option>
							</select> -
							<input type="text" class="form-control" name="cellphone2" id="cellphone2" required oninvalid="this.setCustomValidity('번호를 입력하세요.')"> -
							<input type="text" class="form-control" name="cellphone3" id="cellphone3" required oninvalid="this.setCustomValidity('번호를 입력하세요.')"><br/><br/>
							이메일<font style="color: red; font-weight: bold;"> *</font><br/>
							<input type="text" class="form-control" name="email" id="email" required oninvalid="this.setCustomValidity('이메일을 입력하세요.')" style="width:100%;"/><br/>
							제목<font style="color: red; font-weight: bold;"> *</font><br/>
							<input type="text" class="form-control" name="title" id="title" required oninvalid="this.setCustomValidity('제목을 입력하세요.')"/><br/>
							관심 번역 서비스<font style="color: red; font-weight: bold;"> *</font><br/>
							<select class="form-control" id="category" name="category" >
								<option value="영화">영화</option>
								<option value="드라마">드라마</option>
								<option value="유튜브">유튜브</option>
								<option value="기타">기타</option>
							</select><br/>
							출발 언어 선택<font style="color: red; font-weight: bold;"> *</font><br/>
							<select class="form-control" id="sourceLang" name="sourceLang" >
								<option value="한국어">한국어</option>
								<option value="영어">영어</option>
								<option value="일본어">일본어</option>
								<option value="기타">기타</option>
							</select><br/>
							도착 언어 선택<font style="color: red; font-weight: bold;"> *</font><br/>
							<select class="form-control" id="targetLang" name="targetLang" >
								<option value="한국어">한국어</option>
								<option value="영어">영어</option>
								<option value="일본어">일본어</option>
								<option value="기타">기타</option>
							</select><br/>
							문의 내용<font style="color: red; font-weight: bold;"> *</font><br/>
							<textarea rows="6" name="content" class="form-control" required ></textarea><br/>
							<p style="text-align:right"><a href="javascript:fCheck()" class="button primary" style="text-decoration-line: none;">의뢰하기</a></p>
							</form>
						</div>
					</div>
				</div>
			</section>
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