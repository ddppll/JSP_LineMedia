<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE HTML>
<html>
	<head>
		<title>견적 의뢰</title>
		<%@ include file="/include/bs4.jsp" %>
		<script>
			function pageCheck(){
		  		var pageSize = document.getElementById("pageSize").value;
		  		location.href="applyList.ap?page=${pag}&pageSize="+pageSize;
		  	}
		  	
		  	//최근 게시글 검색
		  	function latelyCheck(){
		  		var lately = document.getElementById("lately").value;
		  		if(lately == "") {
		  			alert("검색 일자를 선택하세요");
		  		}
		  		else {
		  			location.href="${ctp}/applyList.ap?page=${pag}&pageSize=${pageSize}&lately="+lately;
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
		</style>
	</head>
	<body class="is-preload">
	
	<%@ include file="/include/nav.jsp" %>
		<section id="header">
			<div class="inner">
				<br/>
				<h1 style="font-family: 'pretendard';">의뢰 내역</h1><br />
				<h2></h2>
				<hr style="background-color: white; width: 60%; margin: 0px auto;"/>
				<p style="font-family: 'pretendard';">Your Global Translation Partner <br /></p>
				<ul class="actions special">
					<li><a href="#one" class="button scrolly" style="font-family: 'pretendard'; text-decoration-line: none;">Discover</a></li>
				</ul>
			</div>
		</section>
		<section>
			<div class="container"  style="font-family: 'pretendard'; margin-top:50px; margin-bottom:50px; ">
	<table class="table table-bordered">
		<tr>
			<th style="text-align: center; color:white;">글쓴이</th><!-- ajax를 이용한 좋아요 처리 -->
			<td style="background-color:white;">${vo.nickName}</td>
			<th style="text-align: center; color:white;">관심 서비스</th>
			<td style="background-color:white;">${vo.category}</td>
		</tr>
		<tr>
			<th style="text-align: center; color:white;">이메일</th>
			<td>${vo.email}</td>
			<th style="text-align: center; color:white;">출발언어</th>
			<td>${vo.sourceLang}</td>
		</tr>
		<tr>
			<th style="text-align: center; color:white;">연락처</th>
			<c:set var="tel" value="${vo.tel}" />
			<td style="background-color:white;">${fn:replace(tel,'/','-')}</td>
			<th style="text-align: center; color:white;">도착언어</th>
			<td style="background-color:white;">${vo.targetLang}</td>
		</tr>
		<tr>
			<th style="text-align: center; color:white;">업체/담당자명</th>
			<td>${vo.company}</td>
			<th style="text-align: center; color:white;">작성날짜</th>
			<td>${fn:substring(vo.wDate,0,19)}</td>
		</tr>
		<tr>
			<th style="text-align: center; color:white;">제목</th>
			<td colspan="3" style="background-color:white;">${vo.title}</td>
		</tr>
		<tr>
			<th style="text-align: center; color:white;">문의 내용</th>
			<td colspan="3" style="height:200px">${fn:replace(vo.content,newLine,'<br/>')}</td>
		</tr>
		<tr>
			<td colspan="4" class="text-center">
				<c:if test="${sw != 'search'}">
					<a href="${ctp}/${ctp}/applyList.ap?pag=${pag}&pageSize=${pageSize}&lately=${lately}" class="button primary">돌아가기</a>
					<%-- <c:if test="${sMid == vo.mid}">
						<input type="button" value="수정" onclick="location.href='${ctp}/boUpdate.bo?idx=${vo.idx}&pag=${pag}&pageSize=${pageSize}&lately=${lately}';"/>
						<input type="button" value="삭제" onclick="delCheck()"/>
					</c:if> --%>
				</c:if>
				<c:if test="${sw == 'search'}">
					<input type="button" value="돌아가기" onclick="history.back()"/>
				</c:if>
			</td>
		</tr> 
	</table>
	
	<table class="table table-borderless">
		<tr>
			<td style="background-color:white;">
				<c:if test="${nextVO.nextIdx != 0}">
					<span class="badge badge-secondary">다음글</span> &nbsp; <a href="${ctp}/applyContent.ap?idx=${nextVO.nextIdx}&pag=${pag}&pageSize=${pageSize}&lately=${lately}">${nextVO.nextTitle}</a><br/>
				</c:if>
				<c:if test="${preVO.preIdx != 0}">
					<span class="badge badge-secondary">이전글</span> &nbsp; <a href="${ctp}/applyContent.ap?idx=${preVO.preIdx}&pag=${pag}&pageSize=${pageSize}&lately=${lately}">${preVO.preTitle}</a>
				</c:if>
			</td>
		</tr>
	</table>

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