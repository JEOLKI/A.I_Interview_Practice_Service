<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<title>AIinterview</title>

<%@ include file="/WEB-INF/views/layout/commonLib.jsp" %>

<style>

</style>

<script>

</script>

</head>
<body>

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
					<img src="/images/landing_hero_illust.a57fd7e5.png"
						alt="landing-img" class="landing-img">
					<button id="experience" class="login">무료 체험하기</button>
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
							<img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAcAAAAMCAYAAACulacQAAAABHNCSVQICAgIfAhkiAAAAGhJREFUGFd10LERgCAMheEXWnUHmQQ3ESYTNnESHYIePUwBRKCD7z/gQphWC6UM4uUgFmHRHqAdgJcBffEgYBwEBTtBizmY9Qkig5Rci/zzA3gC4m0LCsiXMHaAcQAV0pbf+E9InlT7FwGRLZg1T12ZAAAAAElFTkSuQmCC"
							alt="" class="dash"></a>
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
						<div class="message wow fadeInUp">
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
<!-- 				<div class="content-box analyze">
					<div class="message wow fadeInUp">
						<b>면접 영상을 녹화</b>하고 다양한 분석을 제공합니다.
					</div>
					<div class="AnalyzeSlid">
						<div class="body">
							<div class="before">
								<span aria-hidden="true" class="fa fa-angle-left fa undefined"></span>
							</div>
							<div class="SlideView view false">
								<div class="AnalyzeView First">
									<div class="title">답변내용 자동 입력 및 기업 인재상 분석</div>
									<div class="txt">
										<div class="label">답변내용</div>
										저의 가장 큰 장점은 책임감입니다. 저는 전공 프로젝트 때 팀장을 맡았습니다. 이 때, 팀원들이 잘 참여할 수
										있도록 동기부여를 하였습니다. 또한, 계획부터 최종단계까지 잘 수행할 수 있도록 최선을 다하였습니다. 그 결과,
										좋은 평가를 받게 되었 고 특허출원까지 하게 되었습니다.
									</div>
									<div class="img">
										<div class="label">답변에 드러난 인재상</div>
										<img src="/static/media/slide_talent.d8311c57.svg" alt="">
									</div>
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
			</div>
			<div class="content loop gray">
				<div class="interface">
					<div class="message wow fadeInUp"
						style="visibility: hidden; animation-name: none;">
						만족할 때까지<br> <b>무제한</b>으로 연습해 보세요.
					</div>
					<div class="sub-message wow fadeInUp"
						style="visibility: hidden; animation-name: none;">
						아이엠터뷰는 면접 생성부터 분석까지의 과정을<br>여러 번 순환할 수 있도록 구성되어 있습니다.<br>스스로
						만족할 만한 결과가 나올 때까지 무제한으로 연습해 보세요.
					</div>
				</div>
				<div class="loop-grid">
					<div class="box">
						<img src="/static/media/arrow.0aa5ca57.svg" alt=""
							class="right dash"><img
							src="/static/media/make_interview.e6983bb9.svg" alt=""
							class="make-img">면접 생성
					</div>
					<div class="box">
						<img src="/static/media/arrow.0aa5ca57.svg" alt=""
							class="bottom dash"><img
							src="/static/media/select_question.b37c0634.svg" alt=""
							class="select-img">질문 선택
					</div>
					<div class="box">
						<img src="/static/media/arrow.0aa5ca57.svg" alt=""
							class="top dash"><img
							src="/static/media/report_check.20e45e4d.svg" alt=""
							class="report-img">분석 결과 확인
					</div>
					<div class="box">
						<img src="/static/media/arrow.0aa5ca57.svg" alt=""
							class="left dash"><img
							src="/static/media/interviewing_man.09854e86.svg" alt=""
							class="interviewing-img">모의 면접
					</div>
				</div>
			</div>
			<div class="content comment">
				<div class="message wow fadeInUp"
					style="visibility: hidden; animation-name: none;">아이엠터뷰,
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
			<div class="content footer">
				<div class="title">그럼, 시작할 준비 되셨나요?</div>
				<div class="start-btn">
					<img src="/static/media/click_hand.b88a0798.svg" alt=""
						class="circle-icon">아이엠터뷰<br>시작하기<img
						src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAHCAYAAAAS9422AAAABHNCSVQICAgIfAhkiAAAAG5JREFUKFNjZKAAWFu7uf7//1/62LHdC3AZw0iB+WCtVlZuWYyM/7WOHt2dg80sii0gZAlVLMBnCdUswGUJo4qKJzul8YCsX0zsb/r///81jx/fnQkSZ7S2dvtBTQtAZv3/z8D4/z9D8PHju7YAACf+LAjYS+o0AAAAAElFTkSuQmCC"
						alt="" class="arrow-icon">
				</div>
				<div class="top-btn">
					<img
						src="data:image/png;base64,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"
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
					<div class="doodlin">
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
						사업자등록번호: 513-86-01891<br>마케팅ㆍ제휴 문의 : bryan95@doodlin.co.kr<br>@Doodlin
						Corp All Rights Reserved.
					</div>
				</div>
				<div class="right">
					<img
						src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAG0AAAA8CAYAAABsKjQEAAAABHNCSVQICAgIfAhkiAAAA5RJREFUeF7tnMFtFTEQhuc/IG6BDoAKIFcukAqIRAEkdyRIBZAKgDsSKYBLKiBB4kzSAQ0ggbgz6F/ZT47jTfzkJZ7dN3uJtLHX8/7Pnhl714aqqmzOdQrg6dx/Lhza/BA6tPkxE4e2EGinInIyw99SMnlPRO4l/1hsTDsE8HYJ0FSVne+JQ5sRTYc2I1jRVIfm0MwoUMoePaaZwVM2xKEZB1Qyz6E5NFsKeCJii0eVNQ6tSiZbhRyaLR5V1ji0KplsFXJotnhUWePQqmSyVcih2eJRZY1Dq5LJViGHZotHlTUOrUomW4Ucmi0eVdY4tCqZbBVyaLZ4VFmjqu9F5FFS+AzA66rKhgst+tWMYd2bTHNoTfL1qezQ+uje1KpDa5KvT2WH1kf3plYdWpN8fSo7tD66N7Xq0Jrk61PZofXRfa1WVXUrLhIA+OrQ1pKvT2FVfSwi30LrtxxaHw5rtbpR0AoLxlGsX2Hj5AcAoxsoVZWb6l+IyK6I3C0oPWxSTPatFzctqupnEXkuIn8AbCXlaccDAPy7ukK7X8KNndzGRY+0K6ClGh0B2M+BhMXmV9cMiVZofPwJgB2HFhTIoB2G2/dDUH+YCHUBXAHYuYiciciPUCduC54CGh95AIBvJIbLR1rYvgsAhd58lOzJHtxQJthvusbcPSWdYSpodI/bAIZO4dBGoAVx+K7te4B5DGBXVQmScYzXpXgS6sW93K3Q2CnuhLZWbtKhXQEtAyAcjarK3s4TEc4BpC9Q00RhKmg8SYJuN8bOYUOnQ7seGk9yeEMiAVo8dmr0+IoJ3SOhMTMluHh0xnbIVD17zGNaEvRXx1ZkI42fJlDAS9eU0MKUIXXTBHggIg6tBE1VU7FifLrJmLYazaq6GvFh5EXXvLnztEL2SFE+JR/+7AM4yuIJszqKxt7/X2JaeiqeqrKddCpSTIY2aXKdnkLElY70CMEhc0xcZjraeJsuNF054TyN8708e6To+ddenON9HFkRuRA3w8hnOzGj3HhopfDEe8cisldYSsrBlern0EpluNrxsgZayGYJ/V3yoM11jwU1mblxJYRwildwlRTx2UiRyaHl05DSXHHR7nEMxk3fD+/DbovIXwA/W9t3aK0Kdqjv0DqI3tqkQ2tVsEN9h9ZB9NYmS9C4YBrfG7U+31p9LgIvcteMNaGntGexZxhPKZK1Zzk0a0Qq7FkMtKUc517BTBaxE/Qfcqp1bNxNolkAAAAASUVORK5CYII="
						class="doodlin-logo" alt="doodlin-logo">
				</div>
			</div>
		</div>
	</div>
	<script src="/static/js/2.f1e4c4b1.chunk.js"></script>
	<script src="/static/js/main.a74e6755.chunk.js"></script>
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
	</div> -->

	</body>
</html>
