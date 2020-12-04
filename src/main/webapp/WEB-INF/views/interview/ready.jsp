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
/* The Modal (background) */
#questionSearch {
	display: none; /* Hidden by default */
	position: fixed; /* Stay in place */
	z-index: 100; /* Sit on top */
	left: 0;
	top: 0;
	width: 100%; /* Full width */
	height: 100%; /* Full height */
	overflow: auto; /* Enable scroll if needed */
	background-color: rgb(0, 0, 0); /* Fallback color */
	background-color: rgba(0, 0, 0, 0.4); /* Black w/ opacity */
}

/* Modal Content/Box */
/* #content-box { */
/* 	position:absolute; */
/* 	top: 40px; */
/* 	margin-left: 40%; */
/* 	width: 996px; /* Could be more or less, depending on screen size */ */
/* 	border-radius: 8px solid #888; */
/* 	background-color: #fefefe; */
/* 	text-align: left; */
	
	
/* 	margin: 15% auto; /* 15% from the top and centered */ */
/* 	padding: 20px; */
/* 	height: 15%; */
/* } */
</style>
<script>
$(document).ready(function(){
	$('.search-btn').hide();
	
	count = 1;
	
	$('.NullQuestionBox').on('click',function(){
		if(count < 5 ){
			$('.NullQuestionBox').before($("<div class='SetQuestionBox true'><div draggable='true' class='SetQuestionBoxView false'><div class='label unchecked'></div><input type='text' class='text' placeholder='면접 질문을 입력해주세요' name='questionList' value=''><button type='button' class='search-btn' style='display:none;'><img src='/images/search.ed51fb59.svg' alt='' class='search-icon'></button><div class='delete-btn' style='vertical-align: middle;' ><img src='/images/close-btn.9663b787.svg' alt='' ></div></div></div>"));
			count++;
		}else{
			alert('질문 개수 제한은 5개입니다')			
		}
	});
	
	$(document).on('click','.SetQuestionBox',function(){
		if(!$(this).hasClass('delete-btn')){
			$(this).find('button').show();
			$(this).find('.delete-btn').hide();
			$(this).addClass('checked');
			$(this).children().addClass('checked');
		}
	});
	
	$(document).on('click','.delete-btn',function(){
		$(this).parent().parent().remove();
		count--;
	});
	
	$(document).on('click','.search-btn',function(){
		$('#questionSearch').show();
	});
	
	$('.close-btn').on('click',function(){
		$('#questionSearch').hide();
	});
	
	$(document).mouseup(function(){
		$('.SetQuestionBox button').hide();
		$('.delete-btn').show();
		$('.SetQuestionBox').children().removeClass('checked');
		$('.SetQuestionBox').removeClass('checked');
	});
});


function setting(){
// 	if($(document).val('.text',function())==''){
// 		alert('빈칸인 질문이 있습니다.')
// 	}else{
// 		$("#questionFrm").submit();
// 	}
}

</script>
</head>


<body style="overflow: hidden;" scroll="no">
	<noscript>You need to enable JavaScript to run this app.</noscript>
	<div id="root">
		<div class="Questions">
			<%@include file="/WEB-INF/views/layout/header.jsp"%>
			<div class="body">
				<div class="NewQuestionSearch">
					<div id="questionSearch" class="modal">

							<div class="content-box" style="margin-left: 23%;">
								<div class="close-btn">
									<img src="/images/close-btn.9663b787.svg" alt="" style="height: 60%;width: 60%;">
								</div>
								<div class="input-bar false">
									<span aria-hidden="true" class="fa fa-search fa undefined">
									</span> <input type="text" placeholder="회사명, 직무명 등 키워드로 질문을 검색하세요."
										value="">
								</div>
								<div class="questions-area">
									<div class="recommend-question">
										<div class="label">추천 질문</div>
										<div class="searched-question recommend">
											<button class="refresh-btn">
												<span aria-hidden="true" class="fa fa-refresh fa undefined"></span>
											</button>
											저희 팀 업무가 힘든편인데 잘할 수 있겠나요?
										</div>
									</div>
								</div>
							</div>
					</div>

				</div>
				<div class="QuestionSetBar">
					<div class="title">면접 질문 미리보기</div>

					<form id="questionFrm"
						action="${pageContext.request.contextPath }/interview/setting.do"
						method="get">

						<div class="SetQuestionBox">
							<div draggable="true" class="SetQuestionBoxView">
								<div class="label unchecked"></div>

								<input type="text" id="question" class="text"
									placeholder="면접 질문을 입력해주세요" value="" name="questionList">
								<!-- 								<button type="button" id="complete" class="complete-btn" >완료</button> -->
								<button type="button" class="search-btn">
									<img src="/images/search.ed51fb59.svg" alt=""
										class="search-icon">
								</button>
								<div class="delete-btn">
									<img src="/images/close-btn.9663b787.svg" alt="">
								</div>
							</div>
						</div>

						<div class="NullQuestionBox">
							<div class="NullQuestionBox__text">
								<div class="wrapper">
									<img src="/images/add.b9b0eddd.svg" alt=""> <span>질문
										추가</span>
								</div>
							</div>
						</div>
						<div class="interview-ready-btn Btn none" onclick="setting();">면접
							시작</div>

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
	<script src="/js/2.f1e4c4b1.chunk.js"></script>
	<script src="/js/main.a74e6755.chunk.js"></script>

	
</body>
</html>