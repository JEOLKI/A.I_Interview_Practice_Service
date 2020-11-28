<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>AI_Interview</title>
<meta name="naver-site-verification"
	content="94f5ba87b40698d4bc6a88a5e19c99a7d3e1e4c0">
<meta name="google-site-verification"
	content="rSYfvWZS1ZnErY0j3In-SemXmy4eYuQXYZcmyXHGY54">
<meta name="keywords"
	content="면접, ai면접, 공무원면접, 스피치학원, 면접예상질문, 기업분석, 면접1분자기소개예시, 면접질문, 면접자기소개예시, 스피치, 회사면접질문, 1분자기소개, 모의면접, 면접자기소개, 발음연습, 취업, 화상면접, 실무면접, 자기소개, 인공지능, AI, 취업정보사이트, 취업사이트, PT면접, 비대면, 맞춤, 대기업, 공기업, 공무원">
<meta property="title" content="iamterview">
<meta property="og:title" content="iamterview">
<meta name="description" content="집에서 혼자 하더라도 실전 면접 연습은 iamterview에서!">
<meta property="og:description"
	content="집에서 혼자 하더라도 실전 면접 연습은 iamterview에서!">
<meta property="og:image" content="/iam.ico">
<meta name="theme-color" content="#000000">
<link rel="icon" href="/iam.ico">
<link rel="manifest" href="/manifest.json">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/animate.css@3.5.2/animate.min.css">
<script async="" src="https://www.google-analytics.com/analytics.js"></script>
<script async="" src="https://www.google-analytics.com/analytics.js"></script>
<script async="" src="https://www.google-analytics.com/analytics.js"></script>
<script async="" src="https://www.google-analytics.com/analytics.js"></script>
<script async="" src="https://www.google-analytics.com/analytics.js"></script>
<script async="" src="https://www.google-analytics.com/analytics.js"></script>
<script async="" src="https://www.google-analytics.com/analytics.js"></script>
<script async="" src="https://www.google-analytics.com/analytics.js"></script>
<script async="" src="https://www.google-analytics.com/analytics.js"></script>
<script async="" src="https://www.google-analytics.com/analytics.js"></script>
<script async="" src="https://www.google-analytics.com/analytics.js"></script>
<script async="" src="https://www.google-analytics.com/analytics.js"></script>
<script async="" src="https://www.google-analytics.com/analytics.js"></script>
<script async="" src="https://www.google-analytics.com/analytics.js"></script>
<script async="" src="https://www.google-analytics.com/analytics.js"></script>
<script async="" src="https://www.google-analytics.com/analytics.js"></script>
<script async="" src="https://www.google-analytics.com/analytics.js"></script>
<script type="text/javascript" async=""
	src="https://cdn.channel.io/plugin/ch-plugin-web.js" charset="UTF-8"></script>
<script type="text/javascript" async=""
	src="https://testcpay.payple.kr/js/cpay.payple.1.0.1.js"
	charset="UTF-8"></script>
<script
	src="https://connect.facebook.net/signals/config/943528292826757?v=2.9.29&amp;r=stable"
	async=""></script>
<script async="" src="https://connect.facebook.net/en_US/fbevents.js"></script>
<script
	src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script>
$(document).ready(function() {
	$("#payBtn").on("click", function() {
		var IMP = window.IMP; // 생략가능
		IMP.init('imp67005883'); 	//가맹점 식별코드
		IMP.request_pay({
		    pg : 'html5_inicis',
		    pay_method : 'card',
		    merchant_uid : 'merchant_' + new Date().getTime(),
		    name : '주문명:결제테스트',
		    amount : 100,
		    buyer_email : 'm5derntimes@gmail.com',
		    buyer_name : '구매자이름',
		    buyer_tel : '010-1234-5678',
		    buyer_addr : '서울특별시 강남구 삼성동',
		    buyer_postcode : '123-456',
		}, function(rsp) {
		    if ( rsp.success ) {
		    	 var msg = '결제가 완료되었습니다.';
                 msg += '\n고유ID : ' + rsp.imp_uid;
                 msg += '\n상점 거래ID : ' + rsp.merchant_uid;
                 msg += '\결제 금액 : ' + rsp.paid_amount;
                 msg += '카드 승인번호 : ' + rsp.apply_num;
                 
                 alert(msg);
                 
		    	//[1] 서버단에서 결제정보 조회를 위해 jQuery ajax로 imp_uid 전달하기
		    	$.ajax({
		    		url: "/plan/payComplete", //cross-domain error가 발생하지 않도록 동일한 도메인으로 전송
		    		type: 'POST',
		    		dataType: 'json',
		    		data: {//기타 필요한 데이터가 있으면 추가 전달
			    			imp_uid : rsp.imp_uid,
			    			merchant_uid : rsp.merchant_uid},
			    	success : function(data){
		    		
			    	}
		    	 });
		    	 //결제 완료 페이지
		    	location.href="${cp }/myProfile/myProfile";
		    } else {
		        var msg = '결제에 실패하였습니다.';
		        msg += '에러내용 : ' + rsp.error_msg;

		        alert(msg);
		    }
		});
	});
});

</script>

<link href="/css/main.8acfb306.chunk.css" rel="stylesheet">
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
		<div class="PaymentDetail sprint">
		<%@ include file="/WEB-INF/views/layout/myPageHeader.jsp" %>
			<div class="head-section sprint"></div>
			<div class="head-repeat-line"></div>
			<div class="body">
				<div class="PaymentForm sprint">
					<div class="white-message">구매 이용권</div>
					<div class="PaymentTicket">
						<img
							src="data:image/png;base64,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"
							alt="" class="bg-img">
						<div class="date">
							<div class="title">스프린트</div>
							<span>1</span>일 이용권
						</div>
						<div class="price-section">
							₩ 5,900 / 1일
							<div class="price">₩ 5,900</div>
							무제한 면접 연습, 분석 제공<br> VAT 포함
						</div>
					</div>
					<div class="flex">
						<div class="pay-info">
							<div class="message">
								총 결제금액 <span>(부가가치세 포함)</span>
							</div>
							<div class="price">
								<span>5,900</span>원
							</div>
							<div class="detail-info">
								<div class="original price">
									<div class="name">이용권 금액</div>
									5,900 원
								</div>
							</div>
						</div>
					</div>
					<br>
					<br>
					<button class="payment-btn" id="payBtn">구매하기</button>
				</div>
				<div class="lower">
					<div class="notice">
						<div class="title">이용권 유의사항</div>
						<div class="notice-list">
							- 해당 이용권은 PC에서 무제한으로 면접을 수행할 수 있는 이용권입니다.<br>- 녹화 및 분석된 면접
							영상은 인터넷이 연결된 환경에서 얼마든지 볼 수 있습니다.<br>- 구입하신 이용권은 마이 페이지에서 확인할
							수 있습니다.<br>- 본 이용권의 금액은 부가세 10%가 포함되어 있는 금액입니다.<br>- 본
							이용권은 이용 시작일(구매일) 기준 7일 이내 청약철회 가능한 이용권입니다.<br>&ensp;단, 이용
							내역이 있는 경우 이용 금액 공제 후 환불합니다.<br>- 이용 시작일(구매일) 기준 7일 경과 후에는
							*이용 금액 공제 후 해지 가능합니다.<br>*이용 금액은 이미 경과된 시간(실제 사용 여부 불문)에
							상응하는 금액을 말합니다.<br>- 미성년자가 법정대리인 동의 없이 구매를 한 경우, 미성년자 또는
							법정대리인이 이를 취소할 수 있습니다.<br>
						</div>
					</div>
				</div>
			</div>
			<footer class="SemiFooter --undefined">
			<%@ include file="/WEB-INF/views/layout/myPageFooter.jsp" %>
			</footer>
		</div>
	</div>
	<script>!function(e){function r(r){for(var n,f,i=r[0],l=r[1],a=r[2],c=0,s=[];c<i.length;c++)f=i[c],Object.prototype.hasOwnProperty.call(o,f)&&o[f]&&s.push(o[f][0]),o[f]=0;for(n in l)Object.prototype.hasOwnProperty.call(l,n)&&(e[n]=l[n]);for(p&&p(r);s.length;)s.shift()();return u.push.apply(u,a||[]),t()}function t(){for(var e,r=0;r<u.length;r++){for(var t=u[r],n=!0,i=1;i<t.length;i++){var l=t[i];0!==o[l]&&(n=!1)}n&&(u.splice(r--,1),e=f(f.s=t[0]))}return e}var n={},o={1:0},u=[];function f(r){if(n[r])return n[r].exports;var t=n[r]={i:r,l:!1,exports:{}};return e[r].call(t.exports,t,t.exports,f),t.l=!0,t.exports}f.m=e,f.c=n,f.d=function(e,r,t){f.o(e,r)||Object.defineProperty(e,r,{enumerable:!0,get:t})},f.r=function(e){"undefined"!=typeof Symbol&&Symbol.toStringTag&&Object.defineProperty(e,Symbol.toStringTag,{value:"Module"}),Object.defineProperty(e,"__esModule",{value:!0})},f.t=function(e,r){if(1&r&&(e=f(e)),8&r)return e;if(4&r&&"object"==typeof e&&e&&e.__esModule)return e;var t=Object.create(null);if(f.r(t),Object.defineProperty(t,"default",{enumerable:!0,value:e}),2&r&&"string"!=typeof e)for(var n in e)f.d(t,n,function(r){return e[r]}.bind(null,n));return t},f.n=function(e){var r=e&&e.__esModule?function(){return e.default}:function(){return e};return f.d(r,"a",r),r},f.o=function(e,r){return Object.prototype.hasOwnProperty.call(e,r)},f.p="/";var i=this["webpackJsonpiam-front"]=this["webpackJsonpiam-front"]||[],l=i.push.bind(i);i.push=r,i=i.slice();for(var a=0;a<i.length;a++)r(i[a]);var p=l;t()}([])</script>
<!-- 	<script src="/static/js/2.f1e4c4b1.chunk.js"></script>
	<script src="/static/js/main.a74e6755.chunk.js"></script> -->
	<div id="ch-plugin">
		<div id="ch-plugin-core">
			<style data-styled="active" data-styled-version="5.1.1"></style>
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
			<!-- <div data-ch-testid="launcher"
				class="Launcherstyled__Wrapper-oef45p-0 kaiysd">
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
			</div> -->
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