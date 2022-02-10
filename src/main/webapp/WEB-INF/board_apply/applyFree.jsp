<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE HTML>
<html>
	<head>
		<title>견적 의뢰</title>
		<%@ include file="/include/bs4.jsp" %>
		<script>
		var cnt = 1;
		 // 자료 전송을 위한 폼체크
	    function fCheck() {
	    	var freeTestFile = myform.freeTestFile.value;
	    	var maxSize = 1024 * 1024 * 200; 	// 200MB까지 허용
	    	var company = myform.company.value;
	    	var email = myform.email.value;
	    	var cellphone2 = myform.cellphone2.value;
	    	var cellphone3 = myform.cellphone3.value;
	    	
	    	if(freeTestFile.trim() == "") {
	    		alert("업로드할 파일을 선택하세요");
	    		return false;
	    	}
	    	else if(company.trim() == "") {
	    		alert("업체/담당자명을 입력하세요");
	    		myform.company.focus();
	    		return false;
	    	}
	    	else if(email.trim() == "") {
	    		alert("이메일을 입력하세요");
	    		myform.email.focus();
	    		return false;
	    	}
	    	else if(cellphone2 == ""||cellphone3=="") {
	    		alert("연락처를 입력하세요");
	    		myform.cellphone2.focus();
	    	}
	    	var fileSize = 0;
	    	for(var i=1; i<=cnt; i++) {
	    		freeTestFile = "freeTestFile" + i;
	    		if(document.getElementById(freeTestFile) != null) {
		    		if(document.getElementById(freeTestFile).value != "" && document.getElementById(freeTestFile).value != null) {
		    			tempFname = document.getElementById(freeTestFile).value;
		    			var ext = tempFname.substring(tempFname.lastIndexOf(".")+1);
		    			var uExt = ext.toUpperCase();
		    			
		    			if(uExt != "AVI" && uExt != "MP4" && uExt != "WMV" && uExt != "MKV" && uExt != "JPG" && uExt != "JPEG" && uExt != "TXT") {
		    				alert("업로드 가능한 파일은 '.avi, .mp4, .wmv, .mkv, .jpg, .jpeg, .txt' 입니다.");
		    				return false;
		    			}
		    			else if(tempFname.indexOf(" ") != -1) {
		    				alert("업로드할 파일명에는 공백이 없어야 합니다.")
		    				return false;
		    			}
		    			
						    fileSize += document.getElementById(freeTestFile).files[0].size;
						    alert("fileSize : "+fileSize);
		    		}
	    		}
	    	}
	    	if(fileSize > maxSize) {
	    		alert("업로드하는 파일의 최대용량은 200MByte 이내입니다.");
	    		return false;
	    	}
	    	else {
	    		myform.fileSize.value = fileSize;
	    		myform.submit();
	    	}
	    }
		</script>
	</head>
	<body class="is-preload">
	
	<%@ include file="/include/nav.jsp" %>
		<section id="header">
			<div class="inner">
				<br/>
				<h1 style="font-family: 'pretendard';">견적 의뢰</h1><br />
				<h2></h2>
				<hr style="background-color: white; width: 60%; margin: 0px auto;"/>
				<p style="font-family: 'pretendard';">Your Global Translation Partner <br /></p>
				<ul class="actions special">
					<li><a href="#one" class="button scrolly" style="font-family: 'pretendard'; text-decoration-line: none;">Discover</a></li>
				</ul>
			</div>
		</section>
		<section id="one" class="main style1" style="font-family: 'pretendard';">
				<div class="container">
					<div class="row gtr-150">
						<div class="col-6 col-12-medium">
							<form name="myform" method="post" action="${ctp}/applyFreeInput.pds" enctype="multipart/form-data">
							<p><h4>구매 전, 번역 퀄리티를 먼저 확인하세요</h4></p><br/>
							<p>서비스 퀄리티에 대해 확신을 드리기 위해 의뢰 작업물의 일부를<br/>
							무상으로 번역해 드리고 있습니다. 무료 번역의 분량 및 소요 시간은<br/>
							원문의 형태와 난이도에 따라 결정됩니다.</p>
							업체명/담당자명<font style="color: red; font-weight: bold;"> *</font><br/>
							<input type="text" class="form-control" name="company" id="company" required oninvalid="this.setCustomValidity('업체/담당자를 입력하세요.')"/><br/>
							연락처<font style="color: red; font-weight: bold;"> *</font><br/>
							<select class="form-control" id="cellphone" name="cellphone" >
								<option value="010">010</option>
								<option value="011">011</option>
								<option value="016">016</option>
								<option value="017">017</option>
								<option value="018">018</option>
								<option value="019">019</option>
							</select> -
							<input type="text" class="form-control" name="cellphone2" id="cellphone2" required oninvalid="this.setCustomValidity('번호를 입력하세요.')"> -
							<input type="text" class="form-control" name="cellphone3" id="cellphone3" required oninvalid="this.setCustomValidity('번호를 입력하세요.')"><br/><br/>
							이메일<font style="color: red; font-weight: bold;"> *</font><br/>
							<input type="text" class="form-control" name="email" id="email" required oninvalid="this.setCustomValidity('이메일을 입력하세요.')" style="width:100%;"/><br/>
							파일 첨부<font style="color: red; font-weight: bold;"> *</font>&nbsp;<font size="2px">(.avi, .mp4, .wmv, .mkv, .jpg, .jpeg, .txt)</font><br/>
							<input type="file" name="freeTestFile" id="freeTestFile" class="form-control-file border" accept=".avi, .mp4, .wmv, .mkv, .jpg, .jpeg, .txt">
							<!-- 히든으로 넘기는 부분  -->
							<input type="hidden" name="mid" value="${sMid}"/>
							<input type="hidden" name="fileSize"/>
							<br/>
							<p><a href="javascript:fCheck()" class="button primary" style="text-decoration-line: none;">신청하기</a></p>
							</form>
						</div>
						<div class="col-6 col-12-medium imp-medium">
							<header class="major">
								<h2>직접 확인하세요!<br />
								사전 무료 샘플 번역 서비스</h2>
							</header>
							<p>확실한 실력을 직접 경험하세요<br/>
							세계로 나아가는 당신을 확실하게 서포트합니다</p><br/>
							<span class="image fit"><img src="images/applyFree.jpg" alt="" /></span>
						</div>
					</div>
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