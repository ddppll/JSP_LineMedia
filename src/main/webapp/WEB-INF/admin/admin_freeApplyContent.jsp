<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE HTML>
<html>
	<head>
		<title>admin_freeApplyContent.jsp</title>
		<%@ include file="/include/bs4.jsp" %>
	</head>
	<div class="modal-dialog">
  	<div class="modal-content">

     <!-- Modal Header -->

     <!-- Modal body -->
     <div class="modal-body">
       <hr/>
       		🔹 아이디 : ${vo.mid}<br/>
       <hr/>
       		🔹 파일명 : ${vo.fName}<br/>
       		🔹 올린날짜 : ${fn:substring(vo.fDate,0,19)}<br/>
       		<%-- 🔹 파일크기 : <fmt:formatNumber value="${vo.fSize/1024}"/>KByte<br/> --%>
       		🔹 이메일 : ${vo.email}<br/>
       		🔹 연락처 : 
       		<c:set var="tel" value="${vo.tel}"/>
			<c:set var="arrTel" value="${fn:split(tel,'/')}"/>
			${arrTel[0]} - ${arrTel[1]} - ${arrTel[2]}
       		<hr/>
      	<c:set var="fSName" value="${vo.fSName}"/>
      	<c:set var="fSNames" value="${fn:split(fSName,'/')}"/>
      	<c:forEach var="fSName" items="${fSNames}" varStatus="st">
      	${st.count}. ${fSName}<br/><br/>
      	<c:set var="fSNameLen" value="${fn:length(fSName)}"/>
      	<c:set var="ext" value="${fn:substring(fSName,fSNameLen-3,fSNameLen)}"/>
      	<c:set var="extUpper" value="${fn:toUpperCase(ext)}"/>
      	<c:if test="${extUpper=='JPG' || extUpper=='GIF' || extUpper=='PNG'}">
      		<img src="${ctp}/data/pds/${fSName}" width="350px"/><br/>
      	</c:if>
      	<c:if test="${extUpper=='AVI' || extUpper=='MP4' || extUpper=='WMV'|| extUpper=='MKV'}">
      		<video controls style="width:320px;">
			    <source src="${ctp}/data/pds/${fSName}" type="video/mp4">
			</video>
      	</c:if>
      	<hr/>
      	</c:forEach>
     </div>

     <!-- Modal footer -->
     <div class="modal-footer">
       <button type="button" class="button primary" data-dismiss="modal" onclick="window.close()">Close</button>
     </div>

    </div>
  </div>
</body>
</html>