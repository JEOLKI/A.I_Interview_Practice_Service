<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="https://kit.fontawesome.com/ef761ed31c.js" crossorigin="anonymous"></script>
<title>AI_INTERVIEW</title>

<%@ include file="/WEB-INF/views/layout/commonLib.jsp" %>

<style>

	.aiInterview-logo{
		width: 175px;
		height: 52px;
		margin-top: 5px;
		margin-left: 6px;		
	}
	
</style>

<script>

	$(document).ready(function() {
		$('#home').on('click',function(){
			document.location = "/login/home.do";
		});
		$('.start-btn').on('click',function(){
			document.location = "/login/home.do";
		});
		
	});

</script>

</head>
<body >



	<div id="root">
		<div class="LandingNew">
		
			<%@ include file="/WEB-INF/views/layout/header.jsp" %>
			<div class="content intro">
				<div class="content-box">
				
					<div class="title">인공지능으로 연습하는 실전 면접</div>
					<div class="sub-message">
						당장 다음 주에 잡힌 면접, 어떻게 해야 할지 막막하신가요?<br>AI_INTERVIEW와 함께 혼자서도, 집에서도 할 수
						있는 면접 트레이닝을 경험해 보세요.
					</div>
					<img src="/images/landing_hero_illust.a57fd7e5.svg"
						alt="landing-img" class="landing-img">
					<button id="home" class="login">무료 체험하기</button>
				</div>
				<img src="/images/arrow.0aa5ca57.png" alt="" class="triangle-icon">
			</div>
			
			<div class="content gray calc">
				<div class="message">
					지금도 많은 취업준비생들이<br>AI_INTERVIEW와 함께 면접을 준비하고 있습니다.
				</div>
				<div class="calc-num wow fadeInUp"
					style="visibility: visible; animation-name: fadeInUp;">
					현재 진행중인 면접 수 <span>${interviewCount }회</span><img
						src="/images/graph_rise.43a766c5.png" alt="" class="up">
				</div>
				<div class="calc-num wow fadeInUp"
					style="visibility: visible; animation-name: fadeInUp;">
					쌓이고 있는 실전 기출질문 <span>${sampQuestCount }개</span><img
						src="/images/stack.a84850fb.png" alt="" class="layer">
				</div>
			</div>
			
			<div class="content main">
				<div class="content-box first">
					<div class="message wow fadeInUp">
						집에서도 손쉽게
						혼자서도 부담없이</div>
					<div class="sub-message wow fadeInUp">
						다른 프로그램이나 앱을 다운로드할 필요 없이<br>크롬 브라우저와 PC 또는 노트북, 카메라(웹캠), 마이크만
						있으면 가능합니다.
					</div>
					<div class="chrome-message wow fadeInUp">
						다른 브라우저를 사용하고 계신가요?<br> <a
							href="https://www.google.com/intl/ko/chrome"
							class="chrome-link green" target="blank">
							크롬브라우저 설치하러 가기
							<img src="/images/arrow_small.png" alt="" class="dash"></a>
					</div>
					<div class="needs-flex">
						<div class="area">
							<div class="box">
								<img src="/images/chrome.90ee9563.png" alt="" class="chrome">
							</div>
							<div class="label">크롬 브라우저</div>
						</div>
						<div class="sep"></div>
						<div class="area">
							<div class="box">
								<img src="/images/PC_laptop.ae8b563b.png" alt="" class="pc">
							</div>
							<div class="label">PC/노트북</div>
						</div>
						<div class="sep"></div>
						<div class="big-area">
							<div class="ab-comment">* 대부분의 노트북에 기본 탑재되어 있습니다 *</div>
							<div class="area">
								<div class="box">
									<img src="/images/camera_webcam.650627bc.png" alt="" class="camera">
								</div>
								<div class="label">카메라(웹캠)</div>
							</div>
							<div class="sep"></div>
							<div class="area">
								<div class="box">
									<img src="/images/stand_mic.f99d71f2.png" alt="" class="mic">
								</div>
								<div class="label">마이크</div>
							</div>
						</div>
					</div>
				</div>
				
				<div class="content-box second">
					<img src="/images/notebook.121a50c8.png" alt="" class="notebook">
					<div class="interface">
						<div class="message w2
						+-ow fadeInUp">
							클릭 몇 번으로<br> <b>나만의 면접</b>을
						</div>
						<div class="sub-message wow fadeInUp">
							실전 기출 질문을 자유롭게 구성하고,<br>인공지능과 면접을 시작해 보세요.<br>질문을 검색하거나
							직접 작성할 수도 있습니다.
						</div>
						<a href="${pageContext.request.contextPath }/login/home.do" class="service-link green wow fadeInUp">
							무료 체험하기
							<img
							src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAcAAAAMCAYAAACulacQAAAABHNCSVQICAgIfAhkiAAAAGhJREFUGFd10LERgCAMheEXWnUHmQQ3ESYTNnESHYIePUwBRKCD7z/gQphWC6UM4uUgFmHRHqAdgJcBffEgYBwEBTtBizmY9Qkig5Rci/zzA3gC4m0LCsiXMHaAcQAV0pbf+E9InlT7FwGRLZg1T12ZAAAAAElFTkSuQmCC"
							alt="" class="dash"></a>
					</div>
				</div>
			</div>
			
			<div class="content loop gray">
			
				<div class="interface">
					<div class="message wow fadeInUp">
						만족할 때까지<br> <b>무제한</b>으로 연습해 보세요.
					</div>
					<div class="sub-message wow fadeInUp">
						AI_INTERVIEW는 면접 생성부터 분석까지의 과정을<br>여러 번 순환할 수 있도록 구성되어 있습니다.<br>스스로
						만족할 만한 결과가 나올 때까지 무제한으로 연습해 보세요.
					</div>
				</div>
				
				<div class="loop-grid">
					<div class="box">
						<img src="/images/arrow.0aa5ca57.svg" alt=""
							class="right dash"><img
							src="/images/make_interview.e6983bb9.svg" alt=""
							class="make-img">면접 생성
					</div>
					<div class="box">
						<img src="/images/arrow.0aa5ca57.svg" alt=""
							class="bottom dash"><img
							src="/images/select_question.b37c0634.svg" alt=""
							class="select-img">질문 선택
					</div>
					<div class="box">
						<img src="/images/arrow.0aa5ca57.svg" alt=""
							class="top dash"><img
							src="/images/report_check.20e45e4d.svg" alt=""
							class="report-img">분석 결과 확인
					</div>
					<div class="box">
						<img src="/images/arrow.0aa5ca57.svg" alt=""
							class="left dash"><img
							src="/images/interviewing_man.09854e86.svg" alt=""
							class="interviewing-img">모의 면접
					</div>
				</div>
			</div>
			
			<div class="content comment">
				<div class="message wow fadeInUp">AI_INTERVIEW,
					사용해보니 어떤가요?</div>
				<div class="comment-section">
					<div class="name green">- 대덕인재개발원 수강생</div>
					<div class="text">최근에 코로나로 인해 면접 스터디를 참여하지 못해 힘들었는데
					온라인으로 면접을 위한 준비를 할 수 있어서 유용했습니다.</div>
				</div>
				<div class="comment-section">
					<div class="name green">- 모 공기업 현직자</div>
					<div class="text">수시로 사용하기에도 좋고 생각날 때 내가 면접을 보거나 내가 물어보고 싶은
						질문에 대해서 직접 적어서 면접을 볼 수 있다는게 좋았습니다.</div>
				</div>
				<div class="comment-section">
					<div class="name green">- 국내 대형 갤러리 레지스트라 현직자</div>
					<div class="text">면접은 자가 피드백이 어려운데 이런 면접 프로그램을 쓰면 내가 어떤 표정을
						짓고 대답했으며 내가 대답한 내용이 직접 받아쓰기가 되니까 "앞으로 어떻게 내가 답변 해야겠다" 라는 생각이 들어서
						좋았어요!</div>
				</div>
			</div>
			
			<div class="content footer" style="background-image:url('/images/bg-paint.180ab6a7.png')">
				<div class="title">그럼, 시작할 준비 되셨나요?</div>
				<div class="start-btn">
					<img src="/images/click_hand.b88a0798.svg" alt=""
						class="circle-icon">AI_INTERVIEW<br>시작하기<img
						src="/images/arrow_right.png"
						alt="" class="arrow-icon">
				</div>
				<div class="top-btn">
					<img
						src="/images/top_button.png"
						alt="" class="top-btn-icon">
				</div>
				<div class="left">
					<div class="link">
						<a>회원이용약관</a>
					</div>
					<div class="link">
						<a><b>개인정보처리방침</b></a>
					</div>
					<div class="link">
						<a>ABOUT US</a>
					</div>
					<div class="aiInterview">
						<b>(주) OURTECH</b><br>대전 중구 중앙로76, 영민빌딩 4층 <br>대표 : 홍정기
						<div class="icons">
						</div>
						사업자등록번호: 199-71-00215 <br> 마케팅ㆍ제휴 문의 : jeolki93@ourtech.co.kr<br>@Ourtech
						Corp All Rights Reserved.
					</div>
				</div>
				<div class="right">
					<img src="/images/Ai_Interview 로고.png" class="aiInterview-logo"
				alt="aiInterview-logo">
				</div>
			</div>
		</div>
	</div>
	
	<jsp:include page="/WEB-INF/views/chat/chatImage.jsp" flush="false"> 
		<jsp:param name="serverIp" value="${serverIp }" />
	</jsp:include>
	
	</body>
</html>
