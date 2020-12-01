<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@include file="/WEB-INF/views/layout/commonLib.jsp"%>


	<div class="TopBar undefined">
		<div class="navigation-bar">
			<a class="iam-logo" href="/main"><img src="/images/Ai_Interview 로고.png" alt="iam-logo"
				class="iam-img"></a>
			<div class="nav">
				<a class="main false" href="#">내 면접</a><a class="lecture false"
					href="#">면접 강의</a>
				<a class="service-intro false" href="#">서비스 소개</a><a
					class="help-info false" href="#">도움말</a>
			</div>
		</div>
		<div class="user-tool">
			<a class="payment-btn" href="/plan/buyPlan">이용권 구매</a>
			<div class="profile-btn false">
				<img src="/images/camera_webcam.650627bc.png" alt="profile-icon" class="profile-icon">${S_MEMBER.memAlias }
<!-- 				<span aria-hidden="true" class="fa fa-angle-down fa undefined"></span> -->
			</div>
		</div>
	</div>