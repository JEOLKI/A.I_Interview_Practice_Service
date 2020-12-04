<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/layout/commonLib.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>아이엠터뷰</title>

<link href="/css/main.8acfb306.chunk.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-latest.js"></script>


<style type="text/css">/* Chart.js */
@
keyframes chartjs-render-animation {from { opacity:0.99;
	
}

to {
	opacity: 1;
}

}
.chartjs-render-monitor {
	animation: chartjs-render-animation 0.001s;
}

.chartjs-size-monitor, .chartjs-size-monitor-expand,
	.chartjs-size-monitor-shrink {
	position: absolute;
	direction: ltr;
	left: 0;
	top: 0;
	right: 0;
	bottom: 0;
	overflow: hidden;
	pointer-events: none;
	visibility: hidden;
	z-index: -1;
}

.chartjs-size-monitor-expand>div {
	position: absolute;
	width: 1000000px;
	height: 1000000px;
	left: 0;
	top: 0;
}

.chartjs-size-monitor-shrink>div {
	position: absolute;
	width: 200%;
	height: 200%;
	left: 0;
	top: 0;
}
</style>
<script>
$(document).ready(function(){
	$('.NullQuestionBox').on('click',function(){
		$('.NullQuestionBox').before($("<div class='SetQuestionBox true'><div draggable='true' class='SetQuestionBoxView false'><div class='label unchecked'></div><input type='text' class='text' placeholder='면접 질문을 입력해주세요' name='questionList' value=''><button class='complete-btn'>완료</button><button class='search-btn'><img src='/images/search.ed51fb59.svg' alt='' class='search-icon'></button></div></div>"));
	});
	$('.text').on('click',function(){
		$(this).parent().removeClass('unchecked');
// 		$(this)parent().addClass('checked');
		console.log("클릭");
	});
});

function setting(){
	$("#questionFrm").submit();
}

</script>
</head>


<body style="overflow: hidden;" scroll="no">
	<noscript>You need to enable JavaScript to run this app.</noscript>
	<div id="root">
		<div class="Questions">
			<%@include file="/WEB-INF/views/layout/header.jsp" %>
			<div class="body">
				<div class="QuestionSetBar">
					<div class="title">면접 질문 미리보기</div>
					
					<form id="questionFrm" action="${pageContext.request.contextPath }/interview/setting.do" method="get">
										
						<div class="SetQuestionBox  false">
							<div draggable="true" class="SetQuestionBoxView false">
								<div class="label unchecked">
									
								</div>
								
								<input type="text" id="question" class="text" placeholder="면접 질문을 입력해주세요"
									value="" name="questionList">
								<button class="complete-btn">완료</button>
								<button class="search-btn">
									<img src="/images/search.ed51fb59.svg" alt="" class="search-icon">
								</button>
							</div>
						</div>
						
						<div class="SetQuestionBox true">
							<div draggable="true" class="SetQuestionBoxView false">
								<div class="label unchecked">
									
								</div>
								
								<input type="text" class="text" placeholder="면접 질문을 입력해주세요"
									value="" name="questionList">
								<button class="complete-btn">완료</button>
								<button class="search-btn">
									<img src="/images/search.ed51fb59.svg" alt="" class="search-icon">
								</button>
							</div>
						</div>
						
						<div class="NullQuestionBox">
							<div class="NullQuestionBox__text">
								<div class="wrapper">
									<img src="/images/add.b9b0eddd.svg" alt="">
									<span>질문 추가</span>
								</div>
							</div>
						</div>
						<div class="interview-ready-btn Btn none" onclick="setting();">면접 시작</div>
					
					</form>
			
				</div>
			</div>
			<footer class="SimpleFooter">
			<div class="logo-area">
				<img
					src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADcAAAAQCAYAAACycufIAAAABHNCSVQICAgIfAhkiAAAAvJJREFUSEvdVs1O20AQnrGTCiWHhido6Qs03MIatUHFVk8FpF6rkmsvTS+VeipVq16bPgGoTxBuKEbCHLLkVvMGeQQ4JEgE71QTe+naMf/hgm9rz3r3m++bbwbhgT1CuO8Q8Q/DwgeGDVLghHADRCATJBEeAUAIoEIpd7evSkCt9vopYrSCiBVEqmfjieAQALYQ4Rd/47WUfjMbJ4T3FoDe8PuzM/WjULA+IMJzXkeR3ej1dvqTe9yWjul2/aXFxVfPoggXx8w5jpcCNgmEjpTCxsFBp539Vq3WK+Xyo68AMHHRdLJoXynasG1rLwZH+1L6E0lwHPcnAH6J90YviKzviPgyXlPAl88BF+iYbreTUuI1wOnfqU/d7m5LrxhYqVTcQ8TqVcwymLuDGzP+TcrOhnlerLw4AReCM7PJF5+ZKVQty2oiwso5PAVrmkEhvLb+RkTHANhSSgW93m6g47UqpgUuYX1eSj/UZ9wYnJkZx1luAli6VvpSduaEcKuI+Dc57BgA6uaB9wwuHA5HS2EYsC+wgdyMuct0TUTzALCOiB8TcA0p/a08aU6TOSLYNpTyWxvSFMB5G4jAxgFKwRoiNbXOo8iay3Mxjp0muMHgdLZUKoaI+CR2T7XEJXBncGlpUiNhLreI05KOnXgaNcdmUast17XjAtDRYDCaK5WK7RsZSlZijuOx7N7rjNm2ta7XzGRem5g2c9oJheC+pksC2gA0e2twWfOQ0q8I4XLNbSashFL6XIcTzzRladq843jsluPmzgwCYOXarUDfcmHBW7Us2tSbzT4jhNvX+ucGmzdB3Bc4M+FmRi9p4pwBHrnOn6oGlbw5HAxO64YFc/NmG36sdxBBH5GMEQnHU0hOzYVE6anm5GR0WC4XP180oWQvbvqAPv9WEwpfbjgcrWpg+mecwSzAPHlmweXFsPvZNnrXBcf/MJ3yUllmD0ymjkAp1TKnjmxcPF8W1olw9f8cmI66L3A8sFtWxO1hrJ4sc/8Az8CsuRK8Ou8AAAAASUVORK5CYII="
					class="doodlin-logo" alt="doodlin-logo">
			</div>
			<div class="doodlin-message">
				@<b>Doodlin Corp.</b> All Rights Reserved.
			</div>
			<div class="nav-flex">
				<div class="user-agreement">
					<a href="/agreement/user-agree">회원이용약관</a>
				</div>
				<div class="personal-info">
					<a href="/agreement/personal-agree">개인정보처리방침</a>
				</div>
				<div class="about-us">ABOUT US</div>
			</div>
			</footer>
		</div>
	</div>
	<script src="/static/js/2.f1e4c4b1.chunk.js"></script>
	<script src="/static/js/main.a74e6755.chunk.js"></script>
	<div id="ch-plugin">
		<div id="ch-plugin-core">
			<style data-styled="active" data-styled-version="5.1.1"></style>
			<style data-styled="active" data-styled-version="5.1.1"></style>
			<div data-ch-testid="full-screen-push-message" hidden=""
				class="FullScreenPushMessagestyled__Wrapper-nxoc25-9 jNIDNu PushMessagestyled__PCPopupMessage-vqm8p7-1 egLHoW"
				style="z-index: 100000000 !important;">
				<div
					class="FullScreenPushMessagestyled__MainWrapper-nxoc25-8 fCsTtf">
					<div
						class="FullScreenPushMessagestyled__SVGIconWrapper-nxoc25-0 kmAVFX">
						<div name="cancel" size="16" width="24" height="24"
							class="SVGIconstyled__SVGIcon-sc-15isf0b-0 cQJNXd"></div>
					</div>
					<div class="FullScreenPushMessagestyled__Header-nxoc25-3 fzszwe">
						<div size="24" radius="8px"
							class="Avatarstyled__Avatar-yfy5xq-0 jUtegZ"></div>
						<div class="FullScreenPushMessagestyled__Name-nxoc25-2 fqimYT">(알
							수 없음)</div>
						<div
							class="FullScreenPushMessagestyled__HeaderContent-nxoc25-1 dVbCKK">9:00
							AM</div>
					</div>
					<div class="FullScreenPushMessagestyled__Content-nxoc25-7 Eohuv">
						<div class="FullScreenPushMessagestyled__Text-nxoc25-4 kOiAv"></div>
					</div>
				</div>
			</div>
			<div size="300" class="Screenstyled__Screen-sc-3ge3qf-0 gUFjvy"></div>
			<div data-ch-testid="launcher"
				class="Launcherstyled__Wrapper-oef45p-0 ekjiAG">
				<div class="Launcherstyled__TextLauncher-oef45p-1 lbMRR">
					<div
						class="Launcherstyled__TextLauncherContent-oef45p-2 inNMmP textLauncherContent">문제가
						생겼나요?</div>
					<div
						class="Launcherstyled__TextLauncherIcon-oef45p-3 lfSkuP textLauncherIcon">
						<div data-ch-testid="badge" hidden=""
							class="Badgestyled__Badge-sc-1ztqq4-0 Launcherstyled__Badge-oef45p-5 bZpFRQ">0</div>
					</div>
				</div>
			</div>
		</div>
		<div id="ch-plugin-script" style="display: none"
			class="ch-messenger-hidden">
			<iframe id="ch-plugin-script-iframe"
				style="position: relative !important; height: 100% !important; width: 100% !important; border: none !important;"></iframe>
		</div>
	</div>
	<style data-styled="active" data-styled-version="5.1.1"></style>
</body>

</html>