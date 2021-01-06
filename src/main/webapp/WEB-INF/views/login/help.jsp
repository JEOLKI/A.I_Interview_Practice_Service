<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ include file="/WEB-INF/views/layout/commonLib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script>
$(document).ready(function(){
	$('.question__header').on('click',function(){
		if($(this).siblings('.question__content').attr('class')=='question__content close'){
			$(this).siblings('.question__content').removeClass('close');
			$(this).siblings('.question__content').addClass('open');
		}else{
			$(this).siblings('.question__content').removeClass('open');
			$(this).siblings('.question__content').addClass('close');
		}
	})
	$('.content__Inquire-btn').on("click", function(){
		if("${S_MEMBER.memId}"==null || "${S_MEMBER.memId}" =="" ){
			alert("로그인후 이용해주세요")
		}
		$("#image").trigger("click");
	})
	
})
</script>
<style>
.fa{
	font: normal normal normal 14px/1 FontAwesome;
}
</style>
</head>
<body>
	<div id="root">
		<div class="HelpInfo">
			<%@ include file="/WEB-INF/views/layout/header.jsp" %>
			<main>
			<section class="hero">
			<div class="hero__content">
				<div class="content__title">도움말 센터</div>
				<div class="content__sub-title">서비스에 대해 궁금한 점이 있으신가요?</div>
			</div>
			</section>
			<section class="FAQ">
			<div class="FAQ__content">
				<div class="content__title">자주 찾는 질문</div>
				<div class="content__question">
					<ul>
						<li><div class="question__header">
								<div class="header__title">면접이 시작되지 않아요.</div>
								<span aria-hidden="true" class="fa fa-angle-down fa angle-down"></span>
							</div>
							<div class="question__content close">
								<p>다음 사항을 확인해 보세요.</p>
								<p class="content__sub-title">1. 크롬 브라우저 사용</p>
								<p>
									AI_INTERVIEW의 여러 분석 시스템과 STT(Speech to Text) 등은 <u>크롬 브라우저</u>에 최적화되어
									있습니다.<br>따라서 다른 브라우저 사용 시 분석이 불가하거나 결과의 정확도가 저하될 수 있습니다.
								</p>
								<div class="content__wrapper">
									<a href="https://www.google.com/intl/ko/chrome"
										class="chrome-link" target="blank">크롬 브라우저 설치하러 가기 (클릭)</a>
								</div>
								<p class="content__sub-title">2. 카메라(웹캠) 및 마이크 연결</p>
								<p>면접자의 표정과 시선, 답변 내용 등을 분석하기 위해서 이용기기(PC 또는 노트북)와 연결된 카메라와
									마이크가 필요합니다.</p>
								<div class="content__box">
									<div class="box__title">**카메라와 마이크 연결 시에도 되지 않는 경우**</div>
									<span class="box__description">크롬 우측 상단에서 <span>[
											설정 &gt; 개인정보 및 보안 &gt; 사이트 설정 ]</span> 에서 <span>www.aiinterview.com</span>을
										눌러 <span>카메라</span>와 <span>마이크</span> 권한을 <span>"허용"</span>으로
										바꾸어 주세요.
									</span>
								</div>
								<div class="question__ask">
									<div class="ask__title">답변이 문제 해결에 도움이 되었나요?</div>
									<div class="ask__answer">
										<span>네!</span><span>아니요</span>
									</div>
								</div>
							</div></li>
						<li><div class="question__header">
								<div class="header__title">목표 회사나 직무를 바꾸려면 어떻게 해야
									하나요?</div>
								<span aria-hidden="true" class="fa fa-angle-down fa angle-down"></span>
							</div>
							<div class="question__content close">
								<p>
									우측 상단의 <span>[ 내 프로필 &gt; 프로필 수정 ]</span> 에서 <span>목표 회사
										/ 직무</span> 항목을 수정하시면 됩니다.
								</p>
								<div class="question__ask">
									<div class="ask__title">답변이 문제 해결에 도움이 되었나요?</div>
									<div class="ask__answer">
										<span>네!</span><span>아니요</span>
									</div>
								</div>
							</div></li>
						<li><div class="question__header">
								<div class="header__title">모바일이나 ipad / 태블릿에서 이용할 수
									있나요?</div>
								<span aria-hidden="true" class="fa fa-angle-down fa angle-down"></span>
							</div>
							<div class="question__content close">
								<p>
									AI_INTERVIEW는 <span>모바일</span>과 <span>태블릿 기기</span>를 지원하지 않습니다. ;( <br>
									<span>PC</span> 또는 <span>노트북</span>으로 이용해 주세요!
								</p>
								<div class="question__ask">
									<div class="ask__title">답변이 문제 해결에 도움이 되었나요?</div>
									<div class="ask__answer">
										<span>네!</span><span>아니요</span>
									</div>
								</div>
							</div></li>
						<li><div class="question__header">
								<div class="header__title">결제를 취소하고 싶어요. 환불할 수 있나요?</div>
								<span aria-hidden="true" class="fa fa-angle-down fa angle-down"></span>
							</div>
							<div class="question__content close">
								<p>
									이용권 구매일 기준 <span>7일</span> 이내에 언제든지 청약철회할 수 있습니다.<br>단, 이용
									내역이 있는 경우 <span>이용 금액 차감 후</span> 환불됩니다.
								</p>
								<br>
								<p>
									<span>[ 내 프로필 &gt; 이용권 정보 &gt; 결제내역 확인 &gt; 이용권 환불 ]</span> 에서
									환불을 진행할 수 있습니다.<br>환불 사유도 꼭 작성해 주세요! 앞으로의 서비스 개선에 더욱 박차를
									가할 수 있습니다. :-)
								</p>
								<div class="question__ask">
									<div class="ask__title">답변이 문제 해결에 도움이 되었나요?</div>
									<div class="ask__answer">
										<span>네!</span><span>아니요</span>
									</div>
								</div>
							</div></li>
					</ul>
				</div>
			</div>
			</section>
			<section class="Inquire">
			<div class="Inquire__content">
				<div class="content__title">아직 궁금한 점이 해결되지 않으셨나요?</div>
				<div class="content__sub-title">
					궁금한 점이나 건의사항, 오류 등 어떤 것이든 좋습니다.<br>AI_INTERVIEW 팀에게 직접 문의해 보세요!
				</div>
				<div class="wrapper wow fadeInUp">
					<div class="content__Inquire-btn">문의하기</div>
				</div>
			</div>
			</section>
			<footer class="Footer --undefined">
			<div class="footer-body">
				<div class="info">
					<span>(주) OurBox</span><br>대전광역시 중구 대흥동, 영민빌딩 4층 | 대표 : 4팀<br>사업자등록번호:
					123-12-123456 | 마케팅ㆍ제휴 문의 : ourbox@ourbox.com<br>통신판매업신고번호:
					2020-대전중구-03334호 | 연락처 : 010-0000-0000<br>
					<br>@Ourbox Corp. All Rights Reserved.
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
				<div class="logo-area">
				</div>
			</div>
			</footer></main>
		</div>
	</div>
	
	<%@ include file="/WEB-INF/views/chat/chatImage.jsp" %>
	
</body>
</html>