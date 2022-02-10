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
		  		location.href="qnaList.qa?page=${pag}&pageSize="+pageSize;
		  	}
		  	
		  	//최근 게시글 검색
		  	function latelyCheck(){
		  		var lately = document.getElementById("lately").value;
		  		if(lately == "") {
		  			alert("검색 일자를 선택하세요");
		  		}
		  		else {
		  			location.href="${ctp}/qnaList.qa?page=${pag}&pageSize=${pageSize}&lately="+lately;
		  		}
		  	}
		  	
		  	// 검색 콤보상자 선택시 커서를 검색 입력창으로 이동
		  	function searchChange() {
		  		searchForm.searchString.focus();
		  	}
		  	
		  	//검색버튼 클릭시 수행할 내용
		  	function searchCheck(){
		  		var searchString = searchForm.searchString.value;
		  		if(searchString == ""){
		  			alert("검색어를 입력하세요");
		  			searchForm.searchString.focus();
		  		}
		  		else{
		  			searchForm.submit();
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
				<h1 style="font-family: 'pretendard';">문의하기</h1><br />
				<h2></h2>
				<hr style="background-color: white; width: 60%; margin: 0px auto;"/>
				<p style="font-family: 'pretendard';">Your Global Translation Partner <br /></p>
				<ul class="actions special">
					<li><a href="#one" class="button scrolly" style="font-family: 'pretendard'; text-decoration-line: none;">Discover</a></li>
				</ul>
			</div>
		</section>
		<section>
			<div class="container"  style="font-family: 'pretendard'; ">
				<table class="table table-borderless" style="width:80%; margin:auto;">
				    <tr><br/>
				    	<td class="text-left p-0" style="background-color:white;">
				    	<%if(level == 0||level==1||level==2){ %>
				       		<a href="${ctp}/qnaInput.qa" class="button primary">글쓰기</a> &nbsp;
				       		<%} %>
				       		<select name="lately" id="lately" onchange="latelyCheck()" style="width:150px; height:41px; float:left;">
					        	<option value="0">최근자료순</option>
					        	<c:forEach var="i" begin="1" end="5">
					        		<option value="${i}" ${lately==i ? 'selected' : ''}>${i}일 전</option>
					        	</c:forEach>
					        </select>
				      	</td>
				      	<td class="text-right p-0" style="background-color:white;">
				      		<select name="pageSize" id="pageSize" onchange="pageCheck()" class="p-0 m-0" style="width:80px; height:41px; float:right;">
					      		<option value="5" ${pageSize==5 ? 'selected' : ''}>5건</option>
					      		<option value="10" ${pageSize==10 ? 'selected' : ''}>10건</option>
					      		<option value="15" ${pageSize==15 ? 'selected' : ''}>15건</option>
					      		<option value="20" ${pageSize==20 ? 'selected' : ''}>20건</option>
					      	</select>
				      	</td>
				    </tr>
				 </table><br/>
				 <!-- 리스트  -->
				 <table class="table table-hover" style="width:80%; margin:auto;">
				 	<tr>
				 		<th style="text-align:center; color:white;">번호</th>
				 		<th style="text-align:center; color:white;">제목</th>
				 		<th style="text-align:center; color:white;">글쓴이</th>
				 		<th style="text-align:center; color:white;">작성날짜</th> 
				 		<th style="text-align:center; color:white;">조회수</th> 
				 	</tr>
				 	<c:forEach var="vo" items="${vos}">
					 	<tr>
					 		<td style="text-align:center; width:10%">${curScrStrarNo}</td>
					 		<td>
					 			<c:if test="${(vo.secret) eq '0'}">
						 			<c:choose>
						 				<c:when test="${vo.mid eq sMid || sLevel==0}">
						 					<a href="${ctp}/qnaContent.qa?idx=${vo.idx}&pag=${pag}&pageSize=${pageSize}&lately=${lately}">${vo.title}</a>
						 					<c:if test="${vo.replyCount != 0}">[${vo.replyCount}]</c:if>
						 				</c:when>
						 				<c:otherwise>
						 					<font color="#4361c2">비밀글은 작성자와 관리자만 볼 수 있습니다.</font>
						 				</c:otherwise>
						 			</c:choose>
						 			<c:if test="${vo.wNdate <= 24}"><span class="badge badge-success">new!</span></c:if>
					 			</c:if>
					 			<c:if test="${(vo.secret) eq '1'}">
						 			<a href="${ctp}/qnaContent.qa?idx=${vo.idx}&pag=${pag}&pageSize=${pageSize}&lately=${lately}">${vo.title}</a>
						 			<c:if test="${vo.replyCount != 0}">[${vo.replyCount}]</c:if>
						 			<c:if test="${vo.wNdate <= 24}"><span class="badge badge-success">new!</span></c:if>
					 			</c:if>
					 		</td>
					 		<td style="width:20%; text-align:center;">${vo.nickName}</td>
					 		<td style="width:20%; text-align:center;">
						 		<c:if test="${vo.wNdate <= 24}">${fn:substring(vo.wDate,11,19)}</c:if> 
			      				<c:if test="${vo.wNdate > 24}">${fn:substring(vo.wDate,0,10)}</c:if> 
					 		</td>
					 		<td style="text-align:center;">${vo.readNum}</td>
					 	</tr>
					 	<c:set var="curScrStrarNo" value="${curScrStrarNo - 1}"/>
				 	</c:forEach>
				 </table>
				 <br/>
<!-- 블록 페이징처리 시작(BS4 스타일적용) -->
				<div class="container">
					<ul class="pagination justify-content-center">
						<c:if test="${totPage == 0}"><p style="text-align:center"><b>자료가 없습니다.</b></p></c:if>
						<c:if test="${totPage != 0}">
						  <c:if test="${pag != 1}">
						    <li class="page-item"><a href="qnaList.qa?pag=1&pageSize=${pageSize}&lately=${lately}" title="첫페이지" class="page-link text-secondary">◁◁</a></li>
						  </c:if>
						  <c:if test="${curBlock > 0}">
						    <li class="page-item"><a href="qnaList.qa?pag=${(curBlock-1)*blockSize + 1}&pageSize=${pageSize}&lately=${lately}" title="이전블록" class="page-link text-secondary">◀</a></li>
						  </c:if>
						  <c:forEach var="i" begin="${(curBlock*blockSize)+1}" end="${(curBlock*blockSize)+blockSize}">
						    <c:if test="${i == pag && i <= totPage}">
						      <li class="page-item active"><a href='qnaList.qa?pag=${i}&pageSize=${pageSize}&lately=${lately}' class="page-link text-light bg-secondary border-secondary">${i}</a></li>
						    </c:if>
						    <c:if test="${i != pag && i <= totPage}">
						      <li class="page-item"><a href='qnaList.qa?pag=${i}&pageSize=${pageSize}&lately=${lately}' class="page-link text-secondary">${i}</a></li>
						    </c:if>
						  </c:forEach>
						  <c:if test="${curBlock < lastBlock}">
						    <li class="page-item"><a href="qnaList.qa?pag=${(curBlock+1)*blockSize + 1}&pageSize=${pageSize}&lately=${lately}" title="다음블록" class="page-link text-secondary">▶</a>
						  </c:if>
						  <c:if test="${pag != totPage}">
						    <li class="page-item"><a href="qnaList.qa?pag=${totPage}&pageSize=${pageSize}&lately=${lately}" title="마지막페이지" class="page-link" style="color:#555">▷▷</a>
						  </c:if>
						</c:if>
					</ul>
				</div>
<!-- 블록 페이징처리 끝 -->
<!-- 검색 처리 시작 -->
				<div class="container text-center">
					<form name="searchForm" method="post" action="${ctp}/qnaSearch.qa">
					<table class="table table-borderless" style="width:50%; padding:0px; margin:0px auto;">
						<tr>
							<td style="width:20%; padding:0px">
								<select name="search" onchange="searchChange()"><!-- 여기온체인지는사실없어도됨.. -->
									<option value="title">제목</option>
									<option value="nickName">작성자</option>
									<option value="content">내용</option>
								</select>
							</td>
							<td style="padding:0px">
								<input type="text" name="searchString" style="width:100%; margin:0 auto;"/>
							</td>
							<td style="padding:0px">
								<input type="button" class="button primary" value="검색" onclick="searchCheck()"/>
							</td>
						</tr>
					</table>
						<input type="hidden" name="pag" value="${pag}"/>
						<input type="hidden" name="pageSize" value="${pageSize}"/>
					</form>
				</div>
<!-- 검색 처리 끝 -->
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