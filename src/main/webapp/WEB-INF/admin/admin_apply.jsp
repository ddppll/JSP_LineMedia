<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
   		<title>견적 의뢰</title>
		<%@ include file="/include/bs4.jsp" %>
		<script>
			function pageCheck(){
		  		var pageSize = document.getElementById("pageSize").value;
		  		location.href="admin_apply.ad?page=${pag}&pageSize="+pageSize;
		  	}
		  	
		  	//최근 게시글 검색
		  	function latelyCheck(){
		  		var lately = document.getElementById("lately").value;
		  		if(lately == "") {
		  			alert("검색 일자를 선택하세요");
		  		}
		  		else {
		  			location.href="${ctp}/admin_apply.ad?page=${pag}&pageSize=${pageSize}&lately="+lately;
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
		<section>
			<div class="container"  style="font-family: 'pretendard'; ">
				<br/>
				<table class="table table-borderless" style="width:70%; margin:auto;">
				<tr>
					<td colspan="2" style="background-color:white;"><h2 style="text-align:center;">견적 신청 내역</h2></td>
				</tr>
				    <tr>
				    	<td class="text-left p-0" style="background-color:white;">
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
				 <table class="table table-hover" style="width:70%; margin:auto;">
				 	<tr>
				 		<th style="text-align:center; color:white;">번호</th>
				 		<th style="text-align:center; color:white;">제목</th>
				 		<th style="text-align:center; color:white;">글쓴이</th>
				 		<th style="text-align:center; color:white;">작성날짜</th> 
				 	</tr>
				 	<c:forEach var="vo" items="${vos}">
					 	<tr>
					 		<td style="text-align:center; width:10%">${curScrStrarNo}</td>
					 		<td>
					 			<a href="${ctp}/admin_applyContent.ad?idx=${vo.idx}&pag=${pag}&pageSize=${pageSize}&lately=${lately}">${vo.title}</a>
					 		</td>
					 		<td style="width:20%; text-align:center;">${vo.nickName}</td>
					 		<td style="width:20%; text-align:center;">
						 		<c:if test="${vo.wNdate <= 24}">${fn:substring(vo.wDate,11,19)}</c:if> 
			      				<c:if test="${vo.wNdate > 24}">${fn:substring(vo.wDate,0,10)}</c:if> 
					 		</td>
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
						    <li class="page-item"><a href="admin_apply.ad?pag=1&pageSize=${pageSize}&lately=${lately}" title="첫페이지" class="page-link text-secondary">◁◁</a></li>
						  </c:if>
						  <c:if test="${curBlock > 0}">
						    <li class="page-item"><a href="admin_apply.ad?pag=${(curBlock-1)*blockSize + 1}&pageSize=${pageSize}&lately=${lately}" title="이전블록" class="page-link text-secondary">◀</a></li>
						  </c:if>
						  <c:forEach var="i" begin="${(curBlock*blockSize)+1}" end="${(curBlock*blockSize)+blockSize}">
						    <c:if test="${i == pag && i <= totPage}">
						      <li class="page-item active"><a href='admin_apply.ad?pag=${i}&pageSize=${pageSize}&lately=${lately}' class="page-link text-light bg-secondary border-secondary">${i}</a></li>
						    </c:if>
						    <c:if test="${i != pag && i <= totPage}">
						      <li class="page-item"><a href='admin_apply.ad?pag=${i}&pageSize=${pageSize}&lately=${lately}' class="page-link text-secondary">${i}</a></li>
						    </c:if>
						  </c:forEach>
						  <c:if test="${curBlock < lastBlock}">
						    <li class="page-item"><a href="admin_apply.ad?pag=${(curBlock+1)*blockSize + 1}&pageSize=${pageSize}&lately=${lately}" title="다음블록" class="page-link text-secondary">▶</a>
						  </c:if>
						  <c:if test="${pag != totPage}">
						    <li class="page-item"><a href="admin_apply.ad?pag=${totPage}&pageSize=${pageSize}&lately=${lately}" title="마지막페이지" class="page-link" style="color:#555">▷▷</a>
						  </c:if>
						</c:if>
					</ul>
				</div>
<!-- 블록 페이징처리 끝 -->
<!-- 검색 처리 시작 -->
				<div class="container text-center">
					<form name="searchForm" method="post" action="${ctp}/admin_applySearch.ad">
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
</body>
</html>