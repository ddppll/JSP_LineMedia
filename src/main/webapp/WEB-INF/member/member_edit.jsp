<%@page import="member.MemberVO"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE HTML>
<html>
	<head>
		<title>Photon by HTML5 UP</title>
		<%@ include file="/include/bs4.jsp" %>
		<script>
			//아이디 중복체크
	
				
				// 이름 중복체크
		    function nickCheck2() {
		    	var nickName = myform.nickName.value;
		    	var url = "<%=request.getContextPath()%>/nickCheck.mem?nickName="+nickName;
		    	
		    	if(nickName=="") {
		    		alert("닉네임을 입력하세요!");
		    		myform.nickName.focus();
		    	}
		    	else {
		    		nickCheckOn = 1;
		    		window.open(url,"nWin","width=500px,height=250px");
		    	}
		    }
			  	
		  	
		  	function nickReset() {
		  		nickCheckOn = 0;
		  	}
			  	
		  	//회원가입버튼 클릭 체크
		  	function fCheck() {
	    	var mid = myform.mid.value;
	    	var pwd = myform.pwd.value;
	    	var nickName = myform.nickName.value;
	    	var cellphone2 = myform.cellphone2.value;
	    	var cellphone3 = myform.cellphone3.value;
	    	
	     	if(pwd == "") {
	    		alert("비밀번호를 입력하세요");
	    		myform.pwd.focus();
	    	}
	    	else if(nickName == "") {
	    		alert("닉네임을 입력하세요");
	    		myform.nickName.focus();
	    	}
	    	else if(cellphone2 == ""||cellphone3=="") {
	    		alert("연락처를 입력하세요");
	    		myform.cellphone2.focus();
	    	}
	    	// 기타 추가 체크해야 할 항목들을 모두 체크하세요.
	    	else {
	    		if(nickCheckOn == 1) {
	   				myform.submit();
	    			}
	    		else {
	    			if(nickCheckOn == 0) {
	    				alert("닉네임 중복체크버튼을 눌러주세요!");
	    			}
	    		}
	    	}
	    }
		</script>
	</head>
	<body class="is-preload">
	
	<%@ include file="/include/nav.jsp" %>
		<section id="header">
			<div class="inner">
				<br/>
				<h1 style="font-family: 'pretendard';">회원정보 수정</h1><br />
				<hr style="background-color: white; width: 60%; margin: 0px auto;"/>
				<p style="font-family: 'pretendard';">Your Global Translation Partner <br /></p>
				<ul class="actions special">
					<li><a href="#one" class="button scrolly" style="font-family: 'pretendard'; text-decoration-line: none;">Login</a></li>
				</ul>
			</div>
		</section>
				<section id="one"  class="main style1" style="font-family: 'pretendard'; ">
			<div class="container" style="font-family: 'pretendard';">
				<form name="myform" method="post" action="<%=request.getContextPath()%>/memEditOk.mem">
					<table class="table table-borderless" id="basicTable">
						<tr style="background-color: white;">
							<td colspan="2">
								<b>기본정보</b>&nbsp;
									<font style="color: blue; font-weight: bold;">*</font><font style="font-size : 10pt; color: gray;">표시는 필수입력입니다</font>
							</td>
						</tr>
						<tr style="background-color: white;">
							<td class="category" >아이디<font style="color: blue; font-weight: bold;"> *</font></td>
							<td>
								<input type="text" class="form-control" onkeyup="idReset()" placeholder="영소문자/숫자, 4~16자" name="mid" id="mid" required oninvalid="this.setCustomValidity('아이디를 입력하세요.')" oninput="idCheck()" value="${mid}" readonly />&nbsp; 
							</td>
						</tr>
						<tr style="background-color: white;">
							<td class="category">비밀번호<font style="color: blue; font-weight: bold;"> *</font></td>
							<td>
								<input type="password" class="form-control" placeholder="영어/숫자/특수문자,8~16자" name="pwd" id="pwd" required oninvalid="this.setCustomValidity('비밀번호를 입력하세요.')" oninput="pwdCheck()">
								<div><span id="pwddemo" style="font-size: 10pt; color: red;"></span></div>
							</td>
						</tr>
						<tr style="background-color: white;">
							<td class="category">비밀번호 확인<font style="color: blue; font-weight: bold;"> *</font></td>
							<td>
								<input type="password" class="form-control" placeholder="비밀번호 확인" name="pwdConfirm" id="pwdConfirm" required oninvalid="this.setCustomValidity('비밀번호를 입력하세요.')" oninput="pwdConfirmCheck()">
								<div><span id="pwdConfirmDemo" style="font-size: 10pt; color: red;"></span></div>
							</td>
						</tr>
						<tr style="background-color: white;">
							<td class="category">닉네임<font style="color: blue; font-weight: bold;"> *</font></td>
							<td>
								<input type="text" class="form-control" onkeyup="nickReset()" placeholder="영어/한글, 2~8자" name="nickName" id="nickName" required oninvalid="this.setCustomValidity('닉네임을 입력하세요.')" oninput="nickCheck()" value="${nickName}" style="width:200px;display: inline-block;">&nbsp;
								<button type="button" class="button primary" id="nameTest" style="text-decoration-line: none;" onclick="nickCheck2()">중복확인</button>
								<div><span id="namedemo" style="font-size: 10pt; color: red;"></span></div>
							</td>
						</tr>
						<tr style="background-color: white;">
							<td class="category">연락처<font style="color: blue; font-weight: bold;"> *</font></td>
							<td>
								<c:set var="tel" value="${tel}"/>
								<c:set var="arrTel" value="${fn:split(tel,'/')}"/>
								<select class="form-control" id="cellphone" name="cellphone" >
									<c:forEach var="tel" items="${arrTel}" varStatus="st">
										<c:if test="${st.index==0}">
											<option value="${tel}" selected>${tel}</option>
										</c:if>
									</c:forEach>
									${arrTel[0] == '010' ? '' : '<option value="010">010</option>'}
									${arrTel[0] == '011' ? '' : '<option value="011">011</option>'}
									${arrTel[0] == '016' ? '' : '<option value="016">016</option>'}
									${arrTel[0] == '017' ? '' : '<option value="017">017</option>'}
									${arrTel[0] == '018' ? '' : '<option value="018">018</option>'}
									${arrTel[0] == '019' ? '' : '<option value="019">019</option>'}
								</select> -
								<c:forEach var="tel" items="${arrTel}" varStatus="st">
									<c:if test="${st.index==1}">
										<input type="text" class="form-control" name="cellphone2" id="cellphone2" required oninvalid="this.setCustomValidity('번호를 입력하세요.')" value="${tel}" oninput="cellphoneCheck2()"> -
									</c:if>
									<c:if test="${st.index==2}">
										<input type="text" class="form-control" name="cellphone3" id="cellphone3" required oninvalid="this.setCustomValidity('번호를 입력하세요.')" value="${tel}" oninput="cellphoneCheck3()">
									</c:if>
								</c:forEach>
								<div><span id="cellphonedemo" style="font-size: 10pt; color: red;"></span></div>
							</td>
						</tr>
						<tr style="background-color: white;">
							<td class="category">이메일</td>
							<td>
								<input type="text" class="form-control" placeholder="이메일" name="email" id="email" value="${email}">
								<div><span id="emaildemo" style="font-size: 10pt; color: red;"></span></div>
							</td>
						</tr>
						<tr>
							<td colspan="2" style="text-align: center;">
								<button type="button" class="button primary" id="idtest" style="text-decoration-line: none;"  onclick="fCheck()">수정하기</button>
								<input type="hidden" name="mid" value="${sMid}"/>
							</td>
						</tr>
					</table>
				</form>
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