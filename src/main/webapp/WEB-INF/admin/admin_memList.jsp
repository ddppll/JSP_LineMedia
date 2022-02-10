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
		  		location.href="admin_memList.ad?page=${pag}&pageSize="+pageSize;
		  	}
		  	
			// 개별회원 검색
			function midSearch(){
				var mid = adminForm.mid.value;
				if(mid==""){
					alert("아이디를 입력하세요");
					adminForm.mid.focus();
				}
				else{
					location.href = "${ctp}/admin_memList.ad?mid="+mid;
				}
			}
			
			// 탈퇴처리
			function admin_memDel(idx){
				var ans = confirm("정말로 탈퇴처리 하시겠습니까?");
				if(ans) location.href="${ctp}/admin_memDel.ad?idx="+idx;
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
				<form name="adminForm">
				<br/>
				<table class="table table-borderless" style="width:90%; margin:auto;">
					<tr>
						<td colspan="2" style="background-color:white;"><h2 style="text-align:center;">회원 목록</h2></td>
					</tr>
				    <tr>
				    	<td>
					  		<input type="text" name="mid" value="${mid}" placeholder="검색할 아이디 입력" style="width:20%; float:left;"/>
					  		<input type="button" class="button primary" value="검색" onclick="midSearch()" style="float:left;"/>
					  		<input type="button" class="button primary" value="전체" onclick="location.href='${ctp}/admin_memList.ad';" style="float:left; width:10%;"/>
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
				 <table class="table table-hover" style="width:90%; margin:auto;">
				 	<tr>
				 		<th style="text-align:center; color:white;">번호</th>
				 		<th style="text-align:center; color:white;">아이디</th>
				 		<th style="text-align:center; color:white;">닉네임</th>
				 		<th style="text-align:center; color:white;">연락처</th> 
				 		<th style="text-align:center; color:white;">이메일</th> 
				 		<th style="text-align:center; color:white;">최종접속일</th> 
				 		<th style="text-align:center; color:white;">탈퇴신청</th> 
				 	</tr>
				 	<c:forEach var="vo" items="${vos}">
				 	<tr>
				 		<td><span class="badge badge-dark">${curScrStrarNo}</span></td>
				 		<td>${vo.mid}</td>
				 		<td>
				 			<c:if test="${vo.level == 0}"><span class="badge badge-info">${vo.nickName}</span></c:if>
				 			<c:if test="${vo.level !=0}">${vo.nickName}</c:if> 
				 		</td>
				 		<td>
				 			<c:set var="tel" value="${vo.tel}"/>
							<c:set var="arrTel" value="${fn:split(tel,'/')}"/>
							${arrTel[0]} - ${arrTel[1]} - ${arrTel[2]}
				 		</td>
				 		<td>
				 			<c:if test="${empty vo.email}"><font color="red">입력안함</font></c:if>
				 			<c:if test="${not empty vo.email}">${vo.email}</c:if>
				 		</td>
				 		<td>${vo.lastDate}</td>
				 		<td>
				 			<c:if test="${vo.userDel == 'NO'}"><span class="badge badge-success">활동중</span></c:if>
				 			<c:if test="${vo.userDel == 'OK'}"><a href="javascript:admin_memDel(${vo.idx})"><span class="badge badge-warning">탈퇴신청</span></a></c:if>
				 		</td>
				 	</tr>
				 	<c:set var="curScrStrarNo" value="${curScrStrarNo - 1}"/>
				 	</c:forEach>
				 </table>
			</form>
				 <br/>
<!-- 블록 페이징처리 시작(BS4 스타일적용) -->
				<div class="container">
					<ul class="pagination justify-content-center">
						<c:if test="${totPage == 0}"><p style="text-align:center"><b>자료가 없습니다.</b></p></c:if>
						<c:if test="${totPage != 0}">
						  <c:if test="${pag != 1}">
						    <li class="page-item"><a href="admin_memList.ad?pag=1&pageSize=${pageSize}&lately=${lately}" title="첫페이지" class="page-link text-secondary">◁◁</a></li>
						  </c:if>
						  <c:if test="${curBlock > 0}">
						    <li class="page-item"><a href="admin_memList.ad?pag=${(curBlock-1)*blockSize + 1}&pageSize=${pageSize}&lately=${lately}" title="이전블록" class="page-link text-secondary">◀</a></li>
						  </c:if>
						  <c:forEach var="i" begin="${(curBlock*blockSize)+1}" end="${(curBlock*blockSize)+blockSize}">
						    <c:if test="${i == pag && i <= totPage}">
						      <li class="page-item active"><a href='admin_memList.ad?pag=${i}&pageSize=${pageSize}&lately=${lately}' class="page-link text-light bg-secondary border-secondary">${i}</a></li>
						    </c:if>
						    <c:if test="${i != pag && i <= totPage}">
						      <li class="page-item"><a href='admin_memList.ad?pag=${i}&pageSize=${pageSize}&lately=${lately}' class="page-link text-secondary">${i}</a></li>
						    </c:if>
						  </c:forEach>
						  <c:if test="${curBlock < lastBlock}">
						    <li class="page-item"><a href="admin_memList.ad?pag=${(curBlock+1)*blockSize + 1}&pageSize=${pageSize}&lately=${lately}" title="다음블록" class="page-link text-secondary">▶</a>
						  </c:if>
						  <c:if test="${pag != totPage}">
						    <li class="page-item"><a href="admin_memList.ad?pag=${totPage}&pageSize=${pageSize}&lately=${lately}" title="마지막페이지" class="page-link" style="color:#555">▷▷</a>
						  </c:if>
						</c:if>
					</ul>
				</div>
<!-- 블록 페이징처리 끝 -->
			</div>
		</section>
</body>
</html>