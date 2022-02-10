<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE HTML>
<html>
	<head>
		<title>Photon by HTML5 UP</title>
		<%@ include file="include/bs4.jsp" %>
	</head>
	<body class="is-preload">

		<!-- Header -->
		<%@ include file="/include/nav.jsp" %>
			<section id="header">

				<div class="inner">
					<br/>
					<h1 style="font-family: 'pretendard';">Line Media</h1><br />
					<h3 style="font-family: 'pretendard';">한 줄로 시작되는 새로운 세상</strong></h3><br/>
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
								<h2>지금 당신이 찾고 있는<br />
								글로벌 번역 파트너, 라인미디어</h2>
							</header>
							<p>라인미디어는 고객사별 A to Z 맞춤 가이드라인으로<br/>
							빠르고 정확한 번역 서비스를 제공합니다</p><br/>
							<p><a href="<%=request.getContextPath()%>/apply.ap" class="button primary" style="text-decoration-line: none;">의뢰하기</a></p>
						</div>
						<div class="col-6 col-12-medium imp-medium">
							<span class="image fit"><img src="images/type.jpg" alt="" /></span>
						</div>
					</div>
				</div>
			</section>

		<!-- Two -->
			<section id="two" class="main style2" style="font-family: 'pretendard';">
				<div class="container">
					<div class="row gtr-150">
						<div class="col-6 col-12-medium">
							<ul class="major-icons">
								<li><span class="icon solid style3 major"><img src="images/mnet.png" width="100px"></span></li>
								<li><span class="icon solid style4 major"><img src="images/dingo.png" width="100px"></span></li>
								<li><span class="icon solid style5 major"><img src="images/mbc.png" width="100px"></span></li>
								<li><span class="icon solid style6 major"><img src="images/dia.png" width="100px"></span></li>
							</ul>
						</div>
						<div class="col-6 col-12-medium">
							<header class="major">
								<h2>다양한 기업들이 라인미디어와 함께<br />
								전세계로 이야기를 전달하고 있습니다</h2>
							</header>
							<p>KBS, MBC, SBS 삼사 방송국 및 샌드박스, 다이아 티비 같은 MCN 기업과도 계약을 체결해 다양한 번역 서비스를 납품하고 있습니다.</p>
							<p>총 5만 건이 넘는 콘텐츠를 작업했으며, 100명이 넘는 번역가와 함께 작업이 이루어집니다. </p>
							<p>라인미디어 자체 플랫폼을 통해 번역 작업이 이루어지며, 캡쳐 및 녹화 불가 기술을 적용해서 클라이언트의 보안 관리에 집중합니다.</p>
							<p>고객사별 가이드라인을 작성해 작품 일관성을 유지합니다.</p>
						</div>
					</div>
				</div>
			</section>

		<!-- Three -->
			<section id="three" class="main style1 special">
				<div class="container" style="font-family: 'pretendard';">
					<header class="major">
						<h2 style="font-family: 'pretendard';">라인미디어의 번역 서비스를 만나보세요</h2>
					</header>
					<p>영화, 드라마, 유튜브 콘텐츠별로 필요에 맞춰 퀄리티 있는 번역을 제공해드리는 맞춤 번역 서비스를 경험해보세요</p><br/>
					<div class="row gtr-150">
						<div class="col-4 col-12-medium">
							<span class="image fit"><img src="images/video.jpg" alt="" /></span>
							<h3>영화</h3>
							<p>극장 상영 / OTT 서비스 / 기내 / DVD·블루레이 출시 영화 번역 서비스를 제공합니다</p>
							<ul class="actions special">
								<li><a href="<%=request.getContextPath()%>/menu1" class="button" style=" text-decoration-line: none;">알아보기</a></li>
							</ul>
						</div>
						<div class="col-4 col-12-medium">
							<span class="image fit"><img src="images/video2.jpg" alt="" /></span>
							<h3>드라마</h3>
							<p>다양한 플랫폼에서 방송되는 드라마 번역 서비스를 <br/>제공합니다.</p>
							<ul class="actions special">
								<li><a href="#" class="button" style=" text-decoration-line: none;">알아보기</a></li>
							</ul>
						</div>
						<div class="col-4 col-12-medium">
							<span class="image fit"><img src="images/youtube.jpg" alt="" /></span>
							<h3>유튜브</h3>
							<p>연예 기획사 및 MCN 소속 아티스트의 유튜브 콘텐츠 번역 서비스를 제공합니다.</p>
							<ul class="actions special">
								<li><a href="#" class="button" style=" text-decoration-line: none;">알아보기</a></li>
							</ul>
						</div>
					</div>
				</div>
			</section>

		<!-- Four -->
			<section id="four" class="main style2 special" style="font-family: 'pretendard';">
				<div class="container">
					<header class="major">
						<h2>라인미디어와 함께 세계를 여행해보세요</h2>
					</header>
					<p>가입을 통해 높은 품질의 번역을 경험해보세요</p>
					<ul class="actions special">
					<% if (level == 99){%>
						<li><a href="<%=request.getContextPath()%>/memJoin.mem" class="button wide primary" style=" text-decoration-line: none;">회원 가입</a></li>
					<%} %>
					</ul>
				</div>
			</section>
		<!-- Footer -->
		<%@ include file="include/footer.jsp" %>

		<!-- Scripts -->
			<script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
			<script src="${pageContext.request.contextPath}/js/jquery.scrolly.min.js"></script>
			<script src="${pageContext.request.contextPath}/js/browser.min.js"></script>
			<script src="${pageContext.request.contextPath}/js/breakpoints.min.js"></script>
			<script src="${pageContext.request.contextPath}/js/util.js"></script>
			<script src="${pageContext.request.contextPath}/js/main.js"></script>
			

	</body>
</html>