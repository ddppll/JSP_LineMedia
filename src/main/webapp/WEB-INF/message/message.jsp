<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
	String msg = (String)request.getAttribute("msg");
	String url = (String)request.getAttribute("url");
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>message.jsp</title>
</head>
<body>
	<script>
		var msg = "<%=msg%>";
		var url = "<%=url%>";
		var val = "${val}";
		
		if (msg == "memberJoinOk") msg = "회원 가입되었습니다.";
		else if (msg == "memberJoinNo") msg = "회원 가입에 실패했습니다.";
		else if (msg == "memberLoginOk") msg = val+"님 로그인 되었습니다.";
		else if (msg == "memberLoginPwdNo") msg = "비밀번호를 확인하세요.";
		else if (msg == "memberLoginNo") msg = "존재하지 않는 회원입니다.";
		else if (msg == "memberLogoutOk") msg = val+"님 로그아웃 되었습니다.";
		else if (msg == "applyInputOk") msg = "견적 의뢰가 등록되었습니다.";
		else if (msg == "applyInputNo") msg = "견적 의뢰가 등록되지 않았습니다.";
		else if (msg == "memberEditOk") msg = "회원 정보가 수정되었습니다.";
		else if (msg == "memberEditNo") msg = "회원 정보가 수정되지 않았습니다.";
		else if (msg == "qnaInputOk") msg = "문의글이 등록되었습니다.";
		else if (msg == "qnaInputNo") msg = "문의글이 등록되지 않았습니다.";
		else if (msg == "qnaDeleteOk") msg = "문의글이 삭제되었습니다.";
		else if (msg == "qnaDeleteNo") msg = "문의글이 삭제되지 않았습니다.";
		else if (msg == "qnaReplyInputOk") msg = "댓글이 입력되었습니다.";
		else if (msg == "applyDeleteOk") msg = "견적 문의가 삭제되었습니다.";
		else if (msg == "applyDeleteNo") msg = "견적 문의가 삭제되지 않았습니다.";
		else if (msg == "memberDeleteOk") msg = "회원 탈퇴되었습니다.";
		else if (msg == "memberDBDeleteOk") msg = "탈퇴 신청 회원 정보를 삭제했습니다.";
		else if (msg == "pdsInputOk") msg = "무료 샘플 번역 서비스가 신청되었습니다.";
		else if (msg == "pdsInputNo") msg = "무료 샘플 번역 서비스가 신청되지 않았습니다.";
		else if (msg == "qnaEditOk") msg = "문의글이 수정되었습니다.";
		else if (msg == "qnaEditNo") msg = "문의글이 수정되지 않았습니다.";
		
	
		alert(msg);
		if(url !="") location.href=url;
	</script>
</body>
</html>