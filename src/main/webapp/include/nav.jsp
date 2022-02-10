<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	int level = session.getAttribute("sLevel")==null? 99 : (int)session.getAttribute("sLevel");
%>
<script>
	function memberDel(){
		var ans = confirm("정말 탈퇴하시겠습니까?");
		if (ans) {
			ans = confirm("탈퇴 후 1개월간은 같은 아이디로 가입하실 수 없습니다.\n탈퇴하시겠습니까?");
			if(ans) location.href="<%=request.getContextPath()%>/memDelete.mem";
		}
		
	}
</script>
<nav class="navbar navbar-expand-sm py-3 fixed-top">
	<a class="navbar-brand" style="font-family: 'pretendard'; color: white;" href="<%=request.getContextPath()%>/">Line</a>
	<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#collapsibleNavbar">
		<!--<span class="navbar-toggler-icon"></span>-->
		<i class="fas fa-bars"></i>
	</button>
	<div class="collapse navbar-collapse" id="collapsibleNavbar">
		<ul class="navbar-nav ml-auto" style="font-family: 'pretendard';">
			<li class="nav-item">
				<a class="nav-link" href="<%=request.getContextPath()%>/menu1" style="color: white;">영화 · 드라마</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" href="#" style="color: white;">유튜브</a>
			</li>
			<li class="nav-item dropdown">
				<a class="nav-link dropdown-toggle" href="#" id="navbardrop" data-toggle="dropdown" style="color: white;">
				고객센터
				</a>
				<div class="dropdown-menu">
					<a class="dropdown-item" href="<%=request.getContextPath()%>/qnaList.qa">문의하기</a>
				</div>
			</li>
			<% if (level == 99){%>
			<li class="nav-item dropdown">
				<a class="nav-link dropdown-toggle" href="#" id="navbardrop" data-toggle="dropdown" style="color: white;">
				회원메뉴
				</a>
				<div class="dropdown-menu">
					<a class="dropdown-item" href="<%=request.getContextPath()%>/memJoin.mem">회원가입</a>
					<a class="dropdown-item" id="login" href="<%=request.getContextPath()%>/memLogin.mem">로그인</a>
				</div>
			</li>
			<%}else{%>
			<li class="nav-item dropdown">
				<a class="nav-link dropdown-toggle" href="#" id="navbardrop" data-toggle="dropdown" style="color: white;">
				회원메뉴
				</a>
				<div class="dropdown-menu">
					<%if(level == 0){ %>
				    <a class="dropdown-item" href="<%=request.getContextPath()%>/admin_frame.ad">관리자메뉴</a>
		<%           }%>
					<a class="dropdown-item" href="<%=request.getContextPath()%>/memEdit.mem">정보수정</a>
					<%if(level!=0){%>
				    <a class="dropdown-item" href="<%=request.getContextPath()%>/applyList.ap">신청내역</a>
				    <a class="dropdown-item" href="javascript:memberDel()">회원탈퇴</a>
		<%           } %>
					<a class="dropdown-item" id="login" href="<%=request.getContextPath()%>/memLogOut.mem">로그아웃</a>
				</div>
			</li>
			<%} %>
		</ul>
	</div>
</nav>