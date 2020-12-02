<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix ="c" uri ="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<!-- <meta name="viewport" content="width=device-width,initial-scale=1"> -->
<!-- <meta property="og:image" content="/iam.ico"> -->
<!-- <meta name="theme-color" content="#000000"> -->
<!-- <link rel="icon" href="/iam.ico"> -->
<!-- <link rel="manifest" href="/manifest.json"> -->
<!-- <link rel="stylesheet" -->
<!-- 	href="https://cdn.jsdelivr.net/npm/animate.css@3.5.2/animate.min.css"> -->
<!-- <script async="" src="https://www.google-analytics.com/analytics.js"></script> -->
<!-- <script async="" src="https://www.google-analytics.com/analytics.js"></script> -->
<!-- <script async="" src="https://www.google-analytics.com/analytics.js"></script> -->
<!-- <script async="" src="https://www.google-analytics.com/analytics.js"></script> -->
<!-- <script async="" src="https://www.google-analytics.com/analytics.js"></script> -->
<!-- <script type="text/javascript" async="" -->
<!-- 	src="https://cdn.channel.io/plugin/ch-plugin-web.js" charset="UTF-8"></script> -->
<!-- <script type="text/javascript" async="" -->
<!-- 	src="https://testcpay.payple.kr/js/cpay.payple.1.0.1.js" -->
<!-- 	charset="UTF-8"></script> -->
<!-- <script -->
<!-- 	src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script> -->
<!-- <link href="/css/main.8acfb306.chunk.css" rel="stylesheet"> -->
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
.value{
	float: right;
	text-align: right;
}
</style>
</head>
<body>
	<noscript>You need to enable JavaScript to run this app.</noscript>
	<div id="root">
		<div class="PersonalInfo">
			<%@ include file="/WEB-INF/views/layout/header.jsp"%>
			<div class="body">
				<div class="MyProfile" style="height: 530px;">
					<div class="title">내 프로필</div>
					<div class="flex">
						<img
							src="/member/profile.do?memId=${S_MEMBER.memId }"alt="" class="profile">
						<div class="info-area">
							<div class="name">
								<div class='label' style="display: inline;
														    padding: .2em .6em .3em;
														    font-size: 75%;
														    font-weight: 700;
														    line-height: 1;
														    font-size : 15px;
														    color: black;
														    text-align:left;
														    white-space: nowrap;
														    vertical-align: baseline;
														     border-radius: .25em;">별명</div>
								<div class="value">${S_MEMBER.memAlias }</div>
							</div>
							<div class="info">
								<div class="label"style="display: inline;
														    padding: .2em .6em .3em;
														    font-size: 75%;
														    font-weight: 700;
														    line-height: 1;
														    font-size : 15px;
														    color: black;
														    text-align:left;
														    white-space: nowrap;
														    vertical-align: baseline;
														     border-radius: .25em;">경력사항</div>
								<div class="value">${S_MEMBER.memCareer }</div>
							</div>
							<div class="info">
								<div class="label"style="display: inline;
														    padding: .2em .6em .3em;
														    font-size: 75%;
														    font-weight: 700;
														    line-height: 1;
														    font-size : 15px;
														    color: black;
														    text-align:left;
														    white-space: nowrap;
														    vertical-align: baseline;
														     border-radius: .25em;">학력</div>
								<div class="value">${S_MEMBER.memEduc }</div>
							</div>
							<div class="info">
								<div class="label"style="display: inline;
														    padding: .2em .6em .3em;
														    font-size: 75%;
														    font-weight: 700;
														    line-height: 1;
														    font-size : 15px;
														    color: black;
														    text-align:left;
														    white-space: nowrap;
														    vertical-align: baseline;
														     border-radius: .25em;">성별</div>
								<div class="value">
									<c:if test="${S_MEMBER.memGender=='F' }">여성</c:if>
									<c:if test="${S_MEMBER.memGender=='M' }">남성</c:if>
								</div>
							</div>
							<div class="info">
								<div class="label"style="display: inline;
														    padding: .2em .6em .3em;
														    font-size: 75%;
														    font-weight: 700;
														    line-height: 1;
														    font-size : 15px;
														    color: black;
														    text-align:left;
														    white-space: nowrap;
														    vertical-align: baseline;
														     border-radius: .25em;">목표 회사</div>
								<div class="value">${S_MEMBER.memTargetCompany }</div>
							</div>
							<div class="info">
								<div class="label"style="display: inline;
														    padding: .2em .6em .3em;
														    font-size: 75%;
														    font-weight: 700;
														    line-height: 1;
														    font-size : 15px;
														    color: black;
														    text-align:left;
														    white-space: nowrap;
														    vertical-align: baseline;
														     border-radius: .25em;">목표 직무</div>
								<div class="value">${S_MEMBER.memTargetJob }</div>
							</div>
							<div class="info">
								<div class="label"style="display: inline;
														    padding: .2em .6em .3em;
														    font-size: 75%;
														    font-weight: 700;
														    line-height: 1;
														    font-size : 15px;
														    color: black;
														    text-align:left;
														    white-space: nowrap;
														    vertical-align: baseline;
														     border-radius: .25em;">취업 준비 시작시기</div>
								<div class="value">${S_MEMBER.searchJobDate }</div>
							</div>
							<div class="info">
								<div class="label"style="display: inline;
														    padding: .2em .6em .3em;
														    font-size: 75%;
														    font-weight: 700;
														    line-height: 1;
														    font-size : 15px;
														    color: black;
														    text-align:left;
														    white-space: nowrap;
														    vertical-align: baseline;
														     border-radius: .25em;">전공</div>
								<div class="value">${S_MEMBER.memMajor }</div>
							</div>
						</div>
					</div>
					<a class="edit-btn" href="/member/updateview.do">수정</a>
				</div>
				<div class="MyOrder">
					<div class="title">이용권 정보</div>
					<div class="ticket-area">
						<div class="PaymentTicket">
							<img
								src="data:image/png;base64,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"
								alt="" class="bg-img">
							<div class="null-content">
								<div class="sub-message">현재 사용 중인 이용권이 없습니다.</div>
								<a class="payment-link" href="/plan/buyPlan">이용권 구매하기</a>
							</div>
						</div>
					</div>
					<div class="sub-message">무제한 모의면접, 지금 바로 경험해 보세요!</div>
					<a class="edit-btn" href="/plan/totalPayList">결제내역 확인</a>
				</div>
				<div class="withdraw-message">
					아이엠터뷰를 더 이상 이용하지 않는다면<a class="withdraw-btn"
						href="/member/deleteview.do">회원탈퇴 바로가기<span aria-hidden="true"
						class="fa fa-caret-right fa undefined"></span>
					</a>
				</div>
				<%@ include file="/WEB-INF/views/layout/myPageFooter.jsp"%>
			</div>
		</div>
	</div>
	<!-- 	<style data-styled="active" data-styled-version="5.1.1"></style> -->
</body>
</html>