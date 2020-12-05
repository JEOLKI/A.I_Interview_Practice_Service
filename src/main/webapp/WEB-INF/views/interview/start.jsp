<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ include file="/WEB-INF/views/layout/commonLib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="manifest" href="/manifest.json">
<link href="/css/main.8acfb306.chunk.css" rel="stylesheet">
<style type="text/css">
</style>
<script type="text/javascript">
	var docV = document.documentElement;
	SetTime = 0;
	startCount = 0;
	
	// 전체화면 설정
	function openFullScreenMode() {
	    if (docV.requestFullscreen)
	        docV.requestFullscreen();
	    else if (docV.webkitRequestFullscreen) // Chrome, Safari (webkit)
	        docV.webkitRequestFullscreen();
	    else if (docV.mozRequestFullScreen) // Firefox
	        docV.mozRequestFullScreen();
	    else if (docV.msRequestFullscreen) // IE or Edge
	        docV.msRequestFullscreen();
	}
	
	// 전체화면 해제
	function closeFullScreenMode() {
	    if (document.exitFullscreen)
	        document.exitFullscreen();
	    else if (document.webkitExitFullscreen) // Chrome, Safari (webkit)
	        document.webkitExitFullscreen();
	    else if (document.mozCancelFullScreen) // Firefox
	        document.mozCancelFullScreen();
	    else if (document.msExitFullscreen) // IE or Edge
	        document.msExitFullscreen();
	}
	
	
	function nextQuestion(){
// 		$.ajax({
// 			ur:"/interview/",
// 			data : {질문 내용, 답변내용, 표정분석데이터, 얼굴위치값, 답변시간},
// 			method : "post"
// 			success : function(data){
// 				// 제대로 값이 들어오면 변수를 바꿔서 다음 질문 출력
// 				timer();
// 				// null 이나 제대로 값이 못들어오는경우(다음 질문 없음)
// 				// 마무리 팝업 출력 후 다음 누르면 끝내기 
// 				// document.location = ""
// 		});
		
	}
	
	// 2분 타이머
	function timer(){
		SetTime++;					// 1초씩 증가
		m = Math.floor(SetTime / 60) + ":" + (SetTime % 60) ;	// 남은 시간 계산
		
		msg = "<font color='red' size='7px' style='z-index:200;'>" + '남은시간' + "</font><br>";
		msg += "<font color='black' size='15px' style='z-index:200;'>" + m + "</font>";
		
		document.all.time.innerHTML = msg;
		
		if (SetTime >= 10) {			// 시간이 종료 되었으면..
			
			clearInterval(tid);		// 타이머 해제
			
			alert("종료");
		}
		
	}
	function TimerStart(){ tid=setInterval('timer()',1000) };
	
	$(document).ready(function(){
		
		openFullScreenMode();
		
		$('.spacebar-area.false').on('click',function(){
			$('.attention-message.shown').text('');
			TimerStart();
		});
		
		// spacebar 시작
		$(document).keydown(function(event) {
			if(event.keyCode == 32){ // space
				$('.attention-message.shown').text('');
				TimerStart();
			}
		});
	});
</script>
</head>
<body style="overflow: hidden;" scroll="no">
	<noscript>You need to enable JavaScript to run this app.</noscript>
	<div id="root">
		<div class="Interview">
			<video class="stream-video"></video>
			<div class="FullButton" style="display: inline-block;"></div>
			<div class="InterviewCircle">
			<font size=""></font>
			<div id="time" style="width: 600px; height: 30px; display: inline-block; text-align: center; margin-top: 250px; position: relative; z-index: 300;"></div>
					<img id="attention" src="/images/interviewwatch.png" alt="" class="bg" style="width: 400px; height: 400px; position: absolute; margin-left:39.5%; top:200; display: none;">
				<div class="MovingCircle circle false">
					<canvas width="600" height="600"></canvas>
				</div>
				<img src="/images/bg.355cdfd9.png" alt="" class="bg">
				<div class="attention-message shown" style="position:relative; display: block; margin-left: auto; margin-right: auto; width: 400px; height: 200px; margin-top: -35%; background-size:100% ; padding-top:200px; background-image: url('/images/interview_circle.png');" >
					이곳을 주목해주세요!
				</div>
				<div style="text-align: center;">
				</div>
				<audio src="/images/interview_guide_audio.5680f6cc.mp3"
					autoplay=""></audio>
			</div>
			<div class="InterviewInterface">
				<div class="question-message shown">
					<div class="message-balloon">
						<div>
							<div class="text-line false">지금부터 면접을 시작하겠습니다. 최대 답변 시간은
								2분이며,</div>
							<div class="text-line false">질문을 잘 듣고 중앙의 원을 보며 차분하게 답변해
								주세요.</div>
						</div>
					</div>
				</div>
				<div class="next-question shown">
					면접 시작<br>
					<div class="spacebar-area false">SPACE BAR</div>
				</div>
			</div>
		</div>
	</div>
	<script src="/js/2.f1e4c4b1.chunk.js"></script>
	<script src="/js/main.a74e6755.chunk.js"></script>
</body>
</html>