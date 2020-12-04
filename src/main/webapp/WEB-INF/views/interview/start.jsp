<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="manifest" href="/manifest.json">
<link href="/css/main.8acfb306.chunk.css" rel="stylesheet">
<script type="text/javascript">
	var docV = document.documentElement;
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
	
	$(document).ready(function(){
		
		openFullScreenMode();
		
	});
</script>
</head>
<body>
	<noscript>You need to enable JavaScript to run this app.</noscript>
	<div id="root">
		<div class="Interview">
			<video class="stream-video"></video>
			<div class="FullButton"></div>
			<div class="InterviewCircle">
				<div class="MovingCircle circle false">
					<canvas width="600" height="600"></canvas>
				</div>
				<img src="/images/bg.355cdfd9.png" alt="" class="bg">
				<div class="attention-message shown">이곳을 주목해주세요!</div>
<!-- 				<audio src="/images/interview_guide_audio.5680f6cc.mp3" -->
<!-- 					autoplay=""></audio> -->
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