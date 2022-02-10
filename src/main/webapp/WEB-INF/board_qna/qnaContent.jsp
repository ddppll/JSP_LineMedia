<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE HTML>
<html>
	<head>
		<title>문의하기</title>
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
		  	
		  	//게시글 삭제 - 관리자와 글쓴이만 삭제 가능
		  	function delCheck(){
				var ans = confirm("게시글을 삭제하시겠습니까?");
				if(ans) location.href="${ctp}/qnaDelete.qa?idx=${vo.idx}&pag=${pag}&pageSize=${pageSize}&lately=${lately}";
			}
		  	
			// 댓글 입력처리
			function replyCheck(){
				var content = replyForm.content.value;
				if(content.trim() == ""){
					alert("댓글을 입력하세요");
					replyForm.content.focus();
				}
				else{
					replyForm.submit();
				}
			}
			// 댓글 삭제
			function replyDelCheck(replyIdx){
				var query = {replyIdx : replyIdx};
				var ans = confirm("댓글을 삭제하시겠습니까?");
				if(!ans) return false;
				
				$.ajax({
					type : "get",/* post나 get이나 상관 ㄴ */
					url : "${ctp}/qnaReplyDelete.qa",
					data : query,
					success : function(){
						alert("삭제처리 되었습니다.");
						location.reload();
					}
				});
		}
			// 댓글 수정처리(ajax처리)
			function replyUpdateCheck(replyIdx){
				var content = $("#content").val();
				query={
					replyIdx : replyIdx,
					content : content
				}
				$.ajax({
					type : "post",
					url : "${ctp}/qnaReplyEditOk.qa",
					data : query,
					success : function(){
						alert("댓글이 수정되었습니다.");
						location.href="${ctp}/qnaContent.qa?idx=${vo.idx}&pag=${pag}&pageSize=${pageSize}&lately=${lately}";
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
			<div class="container"  style="font-family: 'pretendard'; margin-top:50px; margin-bottom:50px; ">
	<table class="table table-bordered">
		<tr>
			<th style="text-align: center; color:white;">글쓴이</th><!-- ajax를 이용한 좋아요 처리 -->
			<td style="background-color:white;">${vo.nickName}</td>
		</tr>
		<tr>
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
		
		</tr>
	</table>

<!-- 댓글 출력/입력 처리 부분 -->
<!-- 댓글 출력 -->
				<table class="table table-hover table-borderless">
					<!-- <tr>
						<th>작성자</th>
						<th>내용</th>
						<th>작성일자</th>
					</tr> -->
					<c:forEach var="replyVO" items="${replyVOS}"> 
						<tr style="background-color:white;">
							<td class="text-center" ><font color="#4361c2" style="font-weight:bold;">${replyVO.nickName}</font><br/>
								<c:if test="${sMid == replyVO.mid}"><!-- 보드idx : 원본글idx / replyVO.idx : 댓글 idx -->
									<font size="2"><a href="${ctp}/qnaContent.qa?replyIdx=${replyVO.idx}&idx=${vo.idx}&pag=${pag}&pageSize=${pageSize}&lately=${lately}">수정</a>/<a href="javascript:replyDelCheck(${replyVO.idx})">삭제</a></font>
								</c:if>
							</td>
							<td>${fn:replace(replyVO.content,newLine,'<br/>')}</td>
							<td class="text-center">${replyVO.wDate}</td>
						</tr>
					</c:forEach>
				</table>
<!-- 댓글 입력 -->
				<form name="replyForm" method="post" action="${ctp}/qnaReplyInput.qa">
					<table class="table">
				<%if(level == 0){ %>
						<tr>
							<td style="width:90%">
								댓글 : 
								<textarea rows="4" name="content" id="content" class="form-control">${replyContent}</textarea>
							</td>
							<td style="width:10%">
								<br/><p>작성자 : <br/>${sNickName}</p>
								<p>
									<c:if test="${empty replyContent}"><input type="button" value="등록" onclick="replyCheck()"/></c:if>
									<c:if test="${!empty replyContent}"><input type="button" value="수정" onclick="replyUpdateCheck(${replyIdx})"/></c:if>
								</p>
							</td>
						</tr><%} %>
						<tr>
							<td colspan="4" class="text-center">
								<c:if test="${sw != 'search'}">
									<a href="${ctp}/${ctp}/qnaList.qa?pag=${pag}&pageSize=${pageSize}&lately=${lately}" class="button primary">돌아가기</a>
									<c:if test="${sMid == vo.mid}">
										<input type="button" class="button primary" value="수정" onclick="location.href='${ctp}/qnaEdit.qa?idx=${vo.idx}&pag=${pag}&pageSize=${pageSize}&lately=${lately}';"/>
										<input type="button" class="button primary" value="삭제" onclick="delCheck()"/>
									</c:if> 
								</c:if>
								<%if(level == 0){ %>
										<input type="button" class="button primary" value="삭제" onclick="delCheck()"/>
								<%} %>				
								<c:if test="${sw == 'search'}">
									<input type="button" value="돌아가기" onclick="history.back()"/>
								</c:if>
							</td>
						</tr> 
					</table>
					<input type="hidden" name="qnaIdx" value="${vo.idx}"/>
					<input type="hidden" name="mid" value="${sMid}"/>
					<input type="hidden" name="nickName" value="${sNickName}"/>
					<input type="hidden" name="hostIp" value="${pageContext.request.remoteAddr}"/>
					<input type="hidden" name="pag" value="${pag}"/>
					<input type="hidden" name="pageSize" value="${pageSize}"/>
					<input type="hidden" name="lately" value="${lately}"/>
				</form>


<!-- 이전/다음글 처리 -->
				<table class="table table-borderless">
					<tr>
						<td style="background-color:white;">
							<c:if test="${nextVO.nextIdx != 0}">
								<span class="badge badge-secondary">다음글</span> &nbsp; <a href="${ctp}/qnaContent.qa?idx=${nextVO.nextIdx}&pag=${pag}&pageSize=${pageSize}&lately=${lately}">${nextVO.nextTitle}</a><br/>
							</c:if>
							<c:if test="${preVO.preIdx != 0}">
								<span class="badge badge-secondary">이전글</span> &nbsp; <a href="${ctp}/qnaContent.qa?idx=${preVO.preIdx}&pag=${pag}&pageSize=${pageSize}&lately=${lately}">${preVO.preTitle}</a>
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