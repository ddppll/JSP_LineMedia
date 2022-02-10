<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE HTML>
<html>
	<head>
		<title>라인 미디어</title>
		<%@ include file="/include/bs4.jsp" %>
		<style>
			.carousel-inner img {
			    width: 100%;
			    height: 100%;
			  }
		</style>
	</head>
	<body class="is-preload">

		<!-- Header -->
		<%@ include file="/include/nav.jsp" %>
			<section id="header" style="background-image: url(images/cinema.jpg); background-size: 1920px 700px; background-attachment: scroll">

				<div class="inner">
					<br/>
					<h1 style="font-family: 'pretendard';">영화·드라마</h1><br />
					<h3 style="font-family: 'pretendard';">두 줄로 가능한 이야기</strong></h3><br/>
					<h2></h2>
					<p><hr style="background-color: white; width: 60%; margin: 0px auto;"/></p>
					<p style="font-family: 'pretendard';">Your Global Translation Partner <br /></p>
					<ul class="actions special">
						<li><a href="#one" class="button scrolly" style="font-family: 'pretendard'; text-decoration-line: none;">Discover</a></li>
					</ul>
				</div>
			</section>

		<!-- One -->
			<section id="one" class="main style1" style="font-family: 'pretendard';">
				<div class="container">
					<div class="row gtr-150">
						<div class="col-6 col-12-medium">
							<header class="major">
								<h2>라인 미디어의<br />
								영화·드라마 전문 번역팀</h2>
							</header>
							<label style="font-size:18px;">라인미디어는 영화 전문 번역팀을 별도로 운영하고 있습니다</label><br/>
							<label style="font-size:18px;">속어·욕설·제스처 등 현지화가 필요한 부분을<br/> 도착 문화권에 맞게 번역하여 정확한 의미를 전달합니다</label><br/>
							<label style="font-size:18px;">화면에 표시될 수 있는 글자 수를 고려하여<br/>가독성과 가시성이 뛰어난 번역 자막을 제공합니다.</label><br/>
							<label style="font-size:18px;">영화를 감상하는 관객 집중도를 위해<br/> 젠더·정치·사회적 이슈를 고려하여 번역합니다.</label><br/><br/>
							<p><a href="<%=request.getContextPath()%>/apply.ap" class="button primary" style="text-decoration-line: none;">의뢰하기</a></p>
						</div>
						<div class="col-6 col-12-medium imp-medium">
						<div id="demo" class="carousel slide" data-ride="carousel">
						  <div class="carousel-inner">
						    <div class="carousel-item active">
						      <img src="images/videoCarousel1.jpg" width="646px" height="444px"/>
						    </div>
						    <div class="carousel-item">
						      <img src="images/videoCarousel2.jpg" width="646px" height="444px"/>
						    </div>
						    <div class="carousel-item">
						      <img src="images/videoCarousel3.jpg" width="646px" height="444px"/>
						    </div>
						  </div>
						</div>
							<!-- <span class="image fit"><img src="images/type.jpg" alt="" /></span> -->
						</div>
					</div>
				</div>
			</section>
			
			<section id="one" class="main style1" style="font-family: 'pretendard';">
				<div class="container">
				<h4 style="text-align:center;">영화·드라마 제작에 추가적으로 필요한 번역 작업을 제공해 드립니다</h4><br/><br/>
					<div class="row gtr-150">
						<div class="col-6 col-12-medium">
							<header class="major">
								<h2>사전 제작 단계(Pre-production)</h2>
							</header>
							<p><b>촬영 이전 작업 문서 번역</b><br/>
							시놉시스, 시나리오, 촬영 계획서 등 해외 시장 진출을 위한<br/>
							사전 제작시 필요한 번역을 제공합니다</p><br/>
						</div>
						<div class="col-6 col-12-medium" style="text-align:right;">
							<header class="major">
								<h2>후반 작업 단계(Post-production)</h2>
							</header>
							<p><b>홍보·마케팅 콘텐츠 번역</b><br/>
							영화제 혹은 필름마켓 출품을 위한 홍보·마케팅<br/>
							관련 콘텐츠 번역 서비스를 제공합니다</p><br/>
						</div>
					</div>
				</div>
			</section>
			<div style=" text-align:center;"><img src="images/video_process.jpg" style="width:90%; height:auto;"/></div>

			<section id="three" class="main style1 special">
				<div class="container" style="font-family: 'pretendard';">
					<header class="major">
						<h2 style="font-family: 'pretendard';">라인미디어의 번역 서비스<br/>먼저 경험해 보시고 결정하세요</h2>
					</header>
					실제 의뢰할 작업의 일부를 무료 테스트를 통해 퀄리티를 직접 확인하세요<br/>
					더 자세한 내용은 문의를 통해 친절하게 안내해드립니다<br/><br/>
					<a href="<%=request.getContextPath()%>/applyFree.ap" class="button primary" style="text-decoration-line: none;">무료 번역 샘플 의뢰</a>
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