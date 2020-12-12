<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="https://kit.fontawesome.com/ef761ed31c.js" crossorigin="anonymous"></script>
<title>AI_INTERVIEW</title>

<%@ include file="/WEB-INF/views/layout/commonLib.jsp" %>

<style>
.logo{
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
	
});

// 사진 넘
// 	$(".AnalyzeView").hide();
// 	$('.AnalyzeView.First').show();
	
// 	var currentConve = $(".AnalyzeView.First").attr("value"); 	//1이겠지

// 	$('.before').on('click', function(){
// 		$(".AnalyzeView").hide();
// 		if(currentConve == 0){
// 			currentConve = 5;
// 			if($(".AnalyzeView").attr("value")==currentConve){
// 				$(this).show();
// 			}
// 		} else{
// 			currentConve -= 1;
// 			if($(".AnalyzeView").attr("value")==currentConve){
// 				$(this).show();
// 			}
// 		}
// 	});
		
// 	$('.after').on('click', function(){
// 		$(".AnalyzeView").hide();
// 		if(currentConve == 6){
// 			currentConve = 1;
// 			if($(".AnalyzeView").attr("value")==currentConve){
// 				$(this).show();
// 			}
// 		}else{
// 			currentConve += 1;
// 			if($(".AnalyzeView").attr("value")==currentConve){
// 				$(this).show();
// 			}
// 		}
// 	})


</script>

</head>
<body >
<%@ include file="/WEB-INF/views/chat/chatImage.jsp" %>
	<div id="root">
		<div class="LandingNew">
		
			<%@ include file="/WEB-INF/views/layout/header.jsp" %>
			<div class="content intro">
				<div class="content-box">
				
					<div class="title">인공지능으로 연습하는 실전 면접</div>
					<div class="sub-message">
						당장 다음 주에 잡힌 면접, 어떻게 해야 할지 막막하신가요?<br>아이엠터뷰와 함께 혼자서도, 집에서도 할 수
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
					지금도 많은 취업준비생들이<br>아이엠터뷰와 함께 면접을 준비하고 있습니다.
				</div>
				<div class="calc-num wow fadeInUp"
					style="visibility: visible; animation-name: fadeInUp;">
					현재 진행중인 면접 수 <span>15,734회</span><img
						src="/images/graph_rise.43a766c5.png" alt="" class="up">
				</div>
				<div class="calc-num wow fadeInUp"
					style="visibility: visible; animation-name: fadeInUp;">
					쌓이고 있는 실전 기출질문 <span>2,134개</span><img
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
						<a href="${pageContext.request.contextPath }/login/main" class="service-link green wow fadeInUp">
							무료 체험하기
							<img
							src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAcAAAAMCAYAAACulacQAAAABHNCSVQICAgIfAhkiAAAAGhJREFUGFd10LERgCAMheEXWnUHmQQ3ESYTNnESHYIePUwBRKCD7z/gQphWC6UM4uUgFmHRHqAdgJcBffEgYBwEBTtBizmY9Qkig5Rci/zzA3gC4m0LCsiXMHaAcQAV0pbf+E9InlT7FwGRLZg1T12ZAAAAAElFTkSuQmCC"
							alt="" class="dash"></a>
					</div>
				</div>
				
				
				<!-- 완성 X ..... 
				<div class="content-box analyze">
					<div class="message wow fadeInUp">
						<b>면접 영상을 녹화</b>하고 다양한 분석을 제공합니다.
					</div>
					<div class="AnalyzeSlid">
						<div class="body">
							<div class="before">
								<span aria-hidden="true" class="fa fa-angle-left fa undefined"></span>
							</div>
							<div class="SlideView view false">


								
								<div class="AnalyzeView First" value="1">
									<div class="title">답변내용 자동 입력 및 기업 인재상 분석</div>
									<div class="txt">
										<div class="label">답변내용</div>
										저의 가장 큰 장점은 책임감입니다. 저는 전공 프로젝트 때 팀장을 맡았습니다. 이 때, 팀원들이 잘 참여할 수
										있도록 동기부여를 하였습니다. 또한, 계획부터 최종단계까지 잘 수행할 수 있도록 최선을 다하였습니다. 그 결과,
										좋은 평가를 받게 되었 고 특허출원까지 하게 되었습니다.
									</div>
									<div class="img">
										<div class="label">답변에 드러난 인재상</div>
										<img src="/images/slide_talent.d8311c57.svg" alt="">
									</div>
								</div>

								<div class="AnalyzeView Second" value="2">
									<div class="title">말 빠르기 분석</div>
									<img src="/images/slide_speech-tempo.ba3b5210.svg" alt=""
										class="tempo-img">
									<div class="txt">
										답변하신 내용은 <span>1분 23초 ~ 1분 36초 </span>안에 이야기하시면 적당한 속도입니다. 다시
										한 번 연습해 보세요!
									</div>
								</div>

								<div class="AnalyzeView Third" value="3">
									<div class="title">음성크기(데시벨) 분석</div>
									<img src="/images/slide_dB.3a7e7b51.svg" alt=""
										class="volume-img">
								</div>

								<div class="AnalyzeView Fourth" value="4">
									<div class="title">표정 비율 분석</div>
									<img src="/images/slide_face.a29615db.svg" alt=""
										class="face-img">
								</div>

								<div class="AnalyzeView Fifth" vlaue="5">
									<div class="title">시선 분포 분석</div>
									<img src="/images/slide_gaze.89a97b76.svg" alt=""
										class="sight-img">
								</div>


							</div>
							<div class="after">
								<span aria-hidden="true" class="fa fa-angle-right fa undefined"></span>
							</div>
						</div>
						<div class="SwipePot undefined">
							<div class="pot set"></div>
							<div class="pot false"></div>
							<div class="pot false"></div>
							<div class="pot false"></div>
							<div class="pot false"></div>
						</div>
					</div>
				</div>
				
				-->

			</div>
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			<div class="content loop gray">
			
				<div class="interface">
					<div class="message wow fadeInUp">
						만족할 때까지<br> <b>무제한</b>으로 연습해 보세요.
					</div>
					<div class="sub-message wow fadeInUp">
						아이엠터뷰는 면접 생성부터 분석까지의 과정을<br>여러 번 순환할 수 있도록 구성되어 있습니다.<br>스스로
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
					<div class="name green">- S기업 해외영업 현직자</div>
					<div class="text">함께 취업을 준비하는 그룹 스터디원들과 같이 쓴다면 더 빠르게 취업에
						성공하거나, 면접 때 더 유창하게 말할 수 있을 것 같습니다.</div>
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
						<a href="/agreement/user-agree">회원이용약관</a>
					</div>
					<div class="link">
						<a href="/agreement/personal-agree"><b>개인정보처리방침</b></a>
					</div>
					<div class="link">
						<a target="blank" href="/">ABOUT US</a>
					</div>
					<div class="aiInterview">
						<b>(주) 두들린</b><br>서울시 마포구 마포대로 122, 프론트원 16층<br>대표 : 이태규
						<div class="icons">
							<a
								href="https://www.facebook.com/%EC%9D%B8%EA%B3%B5%EC%A7%80%EB%8A%A5-%EB%AA%A8%EC%9D%98%EB%A9%B4%EC%A0%91-iamterview-103464748013569"
								target="blank"><img
								src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACgAAAAoCAYAAACM/rhtAAAABHNCSVQICAgIfAhkiAAAArNJREFUWEfNmaFvVEEQh78xJBBQxUCCBUmTKpBgQRFAgkXjrkjgXyCgWoMosrVFtorkGhRVJCdQKEhJMEt+x+5l3+u9677dvXed5Nzu7PdmdmZn5oxMcc6tAbeBW8BF4BJww6ubACfAH+AbcGRmP3OOsj6bnHOCuAesRzCpKgQ9Bj6bmeCTJAkwArvvLZWkvGOR4PZTQc8EdM7dAZ5UAGvzCnTbzGTVTlkI6Jx7ADwsMVfC3l0z2+taNxfQu/QxcDfhgBpLDoBP8+5mF+CzAeHCBx6Y2Xb7a08BOufkUrl2FbJnZrvxwQ1AHxDPV0EWnfkuDpwZoL93bypGqxL5L+Bvzw9WdG+G+xgD1nCtoJSWrregvgD6pcrM1VPAStYT3KMOgr6AMysGwBrWk45rlQClZmrFAPgq422NWS4A7eD6Dnz1i3QXf6f616+bmNlr81XJ256b28tlufjFEczHQp3aPhKgCgC9tSXSBvwBNPJZpvIdAb7w5VOmjum2ZQGOBfgSuJlBJ6iQTi77wjWo0Z07jnSqaO17B7X9WIC5AbIB6JciWxkJW3onAnyfcsKcNX0AP2SewRCARQFT4mLduyveMlf9ExcMpQZJNZ5Eb3FWwxRcnBsksdeWFcXTIDn3aebcJ2pVIbWfuqLAiO7OqFaxsIw7+L9YEG2FPmQZgI1ySyMNuVkzlhypDaiZzkhlf62SvzZgs+T3bi6xogpWBVuQkuQ8s56UtdtOTa2UF1cp89vOQFQhYEo+bnHjHkGqv1D7OKQcmpnKsoYsGh6pDRgK8hDYSR4eDezuU26NTZg6wHxakCO7romidatogBlZUilIRYV+uck8qBOYRsD7KbPqMy0Yf74fkQhS0/0w0U8NJA3Rj1LBgtJegC1YJWblTXWEsrAsG/8NIUtpxqLubpz7N8Q/S9IHorr0FfkAAAAASUVORK5CYII="
								alt=""></a><a href="https://blog.naver.com/iamterview"
								target="blank"><img
								src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACgAAAAoCAYAAACM/rhtAAAABHNCSVQICAgIfAhkiAAAArdJREFUWEfVma9vFUEQxz9jSCA4FIIEBYpAggIJCQocPxIMWDTugQT+BYJrDaIE1SqSIltF0gZFFckTKFQTSDBLvsfuy3Z7d2/33fbdY5Iz7d7OZ2d25mbmGQuKc+4ccBW4DJwGzgAX/HZT4BfwG/gG7JvZz0VUWclLzjlB3AKuRTC5Wwh6D/hsZoLPkizACOy2t1TW5h2LBLedCzoX0Dl3A3hYASzlFei6mcmqndIL6Jy7C9wbYq6MdzfNbKtrXSugd+kD4GaGghpLdoAPbXezC/DJEuHCAXfMbD097TFA55xcKteOIVtmthkrPgLoA+LpGGSRzrdx4MwA/b17fQLRWnpeRfeLcB9jwDFdmx5i5uoGcIWsF0BnVgyAq2S9ANlYMQC+LPi2Xgf0xHIIfAT+RH9sW/cF0JMjUzN7Zb4qeZPzhl/Tplj/+grsVgTUVhMBqgDQtzZXugD1vnLYj56DlFhQ22wI8Jkvn2oAysXvvauHulg8ewJ8DlzKpfP3L72D8evfgU8d60oteCDAkgARSJ+LA6gAVXGnBykFnArwXYH1cgHlapX6V5K9SwGpBagIVm9yas5hFwKs4WIpVlN0pzJg4+IaQRIsI8CLPZClFmyCpEaaCYrl4sc9ri4FbNJMjUQdKz7f08eUAjaJWulg6KcuVaxOMI1geb4UcFKrWEgVy9X3gbMD0sy/YkEbjNyHdMXUkXJLIw25WTOWVRDNdCYq+/+Pkt+7eVWsOLOeuNK2U1Mr5cUxpb3tDEQjB0x/4x5BqnlXLlum7JrZWqqwb3ikNmBZkOplNrKHR0t29zG3xlbMHWA+OoEcqWhdGzTAjCypFKSiQs/QZC4wjYC3c2bVcy0Ym9uPSASp6X6Y6OcGkobo+7lgYdMiwARWVZDypjpCWViWjX+GkKU0Yzlo2scFf4b4C7quDqJICg9JAAAAAElFTkSuQmCC"
								alt=""></a>
						</div>
						사업자등록번호: 513-86-01891<br>마케팅ㆍ제휴 문의 : bryan95@aiInterview.co.kr<br>@Doodlin
						Corp All Rights Reserved.
					</div>
				</div>
				<div class="right">
					로고자리
				</div>
			</div>
		</div>
	</div>
	</body>
</html>
