<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
	<title>admin_freeApplyList.jsp</title>
	<%@ include file="/include/bs4.jsp" %>
	<script>
		// 자료 내용 상세보기(팝업창)
		function nWin(idx){
			var url = "${ctp}/admin_freeApplyContent.ad?idx="+idx;
			var winX = 500;
			var winY = 700;
			var x = (window.screen.width)/2 - winX/2;
			var y = (window.screen.height)/2 - winY/2;
			
			window.open(url,"pdsWindow","width="+winX+", height="+winY+",left="+x+",top="+y);
		}
		//파일 삭제 처리
		function pdsDelCheck(idx,fSName){
			var ans = confirm("파일을 삭제하시겠습니까?");
			if(!ans) return false;
			
			var query = {
	    		idx : idx,
	    		fSName : fSName
	    	}
			
			$.ajax({
				type : "post",
				url : "${ctp}/freeApplyDel.ad",
				data : query,
				success : function(data) {
					if(data == 'applyDeleteOk'){
						alert("삭제 되었습니다.");
						location.reload();
					}
					else{
						alert("삭제되지 않았습니다.");
					}
				}
			});
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
						<td colspan="2" style="background-color:white;"><h2 style="text-align:center;">샘플 의뢰 목록</h2></td>
					</tr>
				 </table>
			<table class="table table-hover">
				<tr class="table-dark text-dark">
					<th style="background-color : #4fa49a; color:white; text-align: center;">번호</th>
					<th style="background-color : #4fa49a; color:white; text-align: center;">파일명</th>
					<th style="background-color : #4fa49a; color:white; text-align: center;">업체/담당자</th>
					<th style="background-color : #4fa49a; color:white; text-align: center;">올린이</th>
					<th style="background-color : #4fa49a; color:white; text-align: center;">올린날짜</th>
					<th style="background-color : #4fa49a; color:white; text-align: center;">비고</th>
				</tr>
				<c:forEach var="vo" items="${vos}">
				<tr style="text-align: center;">
					<td>${curScrStrarNo}</td>
					<td><!-- 개별파일다운로드 -->
						<c:set var="fNames" value="${fn:split(vo.fName,'/')}"/>
						<c:set var="fSNames" value="${fn:split(vo.fSName,'/')}"/><!-- 실제서버에저장된파일명추출 -->
						<c:forEach var="fName" items="${fNames}" varStatus="st">
							<a href="${ctp}/data/pds/${fSNames[st.index]}" download="${fName}" onclick="downCheck(${vo.idx})">${fName}</a>
							<c:if test="${vo.wNdate <= 24}"><span class="badge badge-success">new!</span></c:if><br/>
						</c:forEach>
						<%-- (<fmt:formatNumber value="${vo.fSize / 1024}" pattern="#,##0"/>KByte)${vo.fSize } --%>
					</td>
					<td>${vo.company}</td>
					<td>${vo.mid}</td>
					<td>
						<c:if test="${vo.wNdate <= 24}">${fn:substring(vo.fDate,11,19)}</c:if> 
		      			<c:if test="${vo.wNdate > 24}">${fn:substring(vo.fDate,0,10)}</c:if>
					</td>
					<td>
						<a href="javascript:nWin(${vo.idx})" class="button primary">미리보기</a>
						<a href="javascript:pdsDelCheck('${vo.idx}','${vo.fSName}')" class="button primary">삭제</a>
					</td>
	    		</tr>
	    		<c:set var="curScrStrarNo" value="${curScrStrarNo-1}"/>
				</c:forEach>
			</table>
<!-- 블록 페이징처리 시작(BS4 스타일적용) -->
			<div class="container">
				<ul class="pagination justify-content-center">
					<c:if test="${totPage == 0}"><p style="text-align:center"><b>자료가 없습니다.</b></p></c:if>
					<c:if test="${totPage != 0}">
					  <c:if test="${pag != 1}">
					    <li class="page-item"><a href="admin_freeApplyList.ad?pag=1&part=${part}" title="첫페이지" class="page-link text-secondary">◁◁</a></li>
					  </c:if>
					  <c:if test="${curBlock > 0}">
					    <li class="page-item"><a href="admin_freeApplyList.ad?pag=${(curBlock-1)*blockSize + 1}&part=${part}" title="이전블록" class="page-link text-secondary">◀</a></li>
					  </c:if>
					  <c:forEach var="i" begin="${(curBlock*blockSize)+1}" end="${(curBlock*blockSize)+blockSize}">
					    <c:if test="${i == pag && i <= totPage}">
					      <li class="page-item active"><a href='admin_freeApplyList.ad?pag=${i}&part=${part}' class="page-link text-light bg-secondary border-secondary">${i}</a></li>
					    </c:if>
					    <c:if test="${i != pag && i <= totPage}">
					      <li class="page-item"><a href='admin_freeApplyList.ad?pag=${i}&part=${part}' class="page-link text-secondary">${i}</a></li>
					    </c:if>
					  </c:forEach>
					  <c:if test="${curBlock < lastBlock}">
					    <li class="page-item"><a href="admin_freeApplyList.ad?pag=${(curBlock+1)*blockSize + 1}&part=${part}" title="다음블록" class="page-link text-secondary">▶</a>
					  </c:if>
					  <c:if test="${pag != totPage}">
					    <li class="page-item"><a href="admin_freeApplyList.ad?pag=${totPage}&part=${part}" title="마지막페이지" class="page-link" style="color:#555">▷▷</a>
					  </c:if>
					</c:if>
				</ul>
			</div>
<!-- 블록 페이징처리 끝 -->
		</div>
	</section>
</body>
</html>