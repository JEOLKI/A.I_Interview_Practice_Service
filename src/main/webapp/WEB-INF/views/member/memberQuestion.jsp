<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
/*
 * DOM element rendering detection
 * https://davidwalsh.name/detect-node-insertion
 */
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

/*
 * DOM element resizing detection
 * https://github.com/marcj/css-element-queries
 */
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
</head>


<body>
	<noscript>You need to enable JavaScript to run this app.</noscript>
	<div id="root">
		<div class="Questions">
			<div class="TopBar undefined">
				<div class="navigation-bar">
					<a class="iam-logo" href="/main"><img
						src="/static/media/black-long.c5df35b3.svg" alt="iam-logo"
						class="iam-img"></a>
					<div class="nav">
						<a class="main false" href="/main">내 면접</a><a
							class="lecture false" href="/lecture">면접 강의</a>
						<a class="service-intro false" href="/service-intro">서비스 소개</a><a
							class="help-info false" href="/help-info">도움말</a>
					</div>
				</div>
				<div class="user-tool">
					<a class="payment-btn" href="/payment">이용권 구매</a>
					<div class="profile-btn false">
						<img
							src="https://aida-users.s3.ap-northeast-2.amazonaws.com/profile/2324.jpg"
							alt="profile-icon" class="profile-icon">dsfaqwef<span
							aria-hidden="true" class="fa fa-angle-down fa undefined"></span>
					</div>
				</div>
			</div>
			<div class="body">
				<div class="QuestionSetBar">
					<div class="title">면접 질문 미리보기</div>
					
					<div class="SetQuestionBox  false">
						<div draggable="true" class="SetQuestionBoxView false">
							<div class="label unchecked">
								
							</div>
							
							<input type="text" class="text" placeholder="면접 질문을 입력해주세요"
								value="">
							<button class="complete-btn">완료</button>
<!-- 							<button class="search-btn"> -->
								
<!-- 							</button> -->
						</div>
					</div>
					
					<div class="SetQuestionBox false">
						<div draggable="true" class="SetQuestionBoxView false">
							<div class="label unchecked">
								
							</div>
							
							<input type="text" class="text" placeholder="면접 질문을 입력해주세요"
								value="">
							<button class="complete-btn">완료</button>
<!-- 							<button class="search-btn"> -->
								
<!-- 							</button> -->
						</div>
					</div>
					
					<div class="NullQuestionBox">
						<div class="NullQuestionBox__text">
							<div class="wrapper">
								<img src="/static/media/add.b9b0eddd.svg" alt=""><span>질문
									추가</span>
							</div>
						</div>
					</div>
					<div class="interview-ready-btn Btn none">면접 시작</div>
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
	<script>!function(e){function r(r){for(var n,f,i=r[0],l=r[1],a=r[2],c=0,s=[];c<i.length;c++)f=i[c],Object.prototype.hasOwnProperty.call(o,f)&&o[f]&&s.push(o[f][0]),o[f]=0;for(n in l)Object.prototype.hasOwnProperty.call(l,n)&&(e[n]=l[n]);for(p&&p(r);s.length;)s.shift()();return u.push.apply(u,a||[]),t()}function t(){for(var e,r=0;r<u.length;r++){for(var t=u[r],n=!0,i=1;i<t.length;i++){var l=t[i];0!==o[l]&&(n=!1)}n&&(u.splice(r--,1),e=f(f.s=t[0]))}return e}var n={},o={1:0},u=[];function f(r){if(n[r])return n[r].exports;var t=n[r]={i:r,l:!1,exports:{}};return e[r].call(t.exports,t,t.exports,f),t.l=!0,t.exports}f.m=e,f.c=n,f.d=function(e,r,t){f.o(e,r)||Object.defineProperty(e,r,{enumerable:!0,get:t})},f.r=function(e){"undefined"!=typeof Symbol&&Symbol.toStringTag&&Object.defineProperty(e,Symbol.toStringTag,{value:"Module"}),Object.defineProperty(e,"__esModule",{value:!0})},f.t=function(e,r){if(1&r&&(e=f(e)),8&r)return e;if(4&r&&"object"==typeof e&&e&&e.__esModule)return e;var t=Object.create(null);if(f.r(t),Object.defineProperty(t,"default",{enumerable:!0,value:e}),2&r&&"string"!=typeof e)for(var n in e)f.d(t,n,function(r){return e[r]}.bind(null,n));return t},f.n=function(e){var r=e&&e.__esModule?function(){return e.default}:function(){return e};return f.d(r,"a",r),r},f.o=function(e,r){return Object.prototype.hasOwnProperty.call(e,r)},f.p="/";var i=this["webpackJsonpiam-front"]=this["webpackJsonpiam-front"]||[],l=i.push.bind(i);i.push=r,i=i.slice();for(var a=0;a<i.length;a++)r(i[a]);var p=l;t()}([])</script>
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