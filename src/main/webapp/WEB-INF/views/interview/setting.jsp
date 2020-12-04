<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/layout/commonLib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link href="/css/main.8acfb306.chunk.css" rel="stylesheet">


<!-- 화면 출력 및 얼굴 분석 관련 -->
<link rel="stylesheet" href="main.css" type="text/css" media="all">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="/js/capture.js"></script>
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
.pids-wrapper{                                                                                        
  width: 100%;                                                                                        
}                                                                                                     
.pid{                                                                                                 
  width: calc(10% - 10px);                                                                            
  height: 10px;                                                                                       
  display: inline-block;                                                                              
  margin: 5px;   
}                  
</style>
<script type="text/javascript" >
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

	function check(){
		$('.InterviewTutorial.PopUp').hide();
	}

	/* 아래부터 볼륨 조절 코드 */
	function colorPids(vol) {                                                                             
		  let all_pids = $('.none');                                                                       
		  let amout_of_pids = Math.round(vol);                                                         
		  let elem_range = all_pids.slice(0, amout_of_pids)                                               
		  for (var i = 0; i < all_pids.length; i++) {                                                     
		    all_pids[i].style.backgroundColor="#8C8C8C";                                                  
		  }                                                                                               
		  for (var i = 0; i < elem_range.length; i++) {                                                   
	                                                                                                      
		    // console.log(elem_range[i]);                                                                
		    elem_range[i].style.backgroundColor="#FFFFFF";                                                
		  }                                                                                               
		}                                                                                                 
		                                                                                                  
		                                                                                                  
	navigator.mediaDevices.getUserMedia({ audio: true, video: true })                                     
	.then(function(stream) {                                                                              
	  audioContext = new AudioContext();                                                                  
	  analyser = audioContext.createAnalyser();                                                           
	  microphone = audioContext.createMediaStreamSource(stream);                                          
	  javascriptNode = audioContext.createScriptProcessor(2048, 1, 1);                                    
	                                                                                                      
	  analyser.smoothingTimeConstant = 0.8;                                                               
	  analyser.fftSize = 1024;                                                                            
	                                                                                                      
	  microphone.connect(analyser);                                                                       
	  analyser.connect(javascriptNode);                                                                   
	  javascriptNode.connect(audioContext.destination);                                                   
	  javascriptNode.onaudioprocess = function() {                                                        
	      var array = new Uint8Array(analyser.frequencyBinCount);                                         
	      analyser.getByteFrequencyData(array);                                                           
	      var values = 0;                                                                                 
	                                                                                                      
	      var length = array.length;                                                                      
	      for (var i = 0; i < length; i++) {                                                              
	        values += (array[i]);                                                                         
	      }                                                                                               
	                                                                                                      
	      var average = values / length;                                                                  
	                                                                                                      
	    console.log(Math.round(average));                                                                 
	    colorPids(average);                                                                               
	  }                                                                                                   
	  })                                                                                                  
	  .catch(function(err) {                                                                              
	    /* handle the error */                                                                            
	}); 
	
$(document).ready(function(){
	$('.body').show();
	openFullScreenMode();
});
	
</script>
</head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<noscript>You need to enable JavaScript to run this app.</noscript>
	<div id="root">
		<div class="InterviewTest false">
			<div class="InterviewTutorial PopUp">
				<div class="tutorial-box">
				
					<div class="title">
						모의면접을 시작하기 전에<br>아래 유의사항을 확인해 주세요!
					</div>
					<div class="flex">
						<div class="box">
							<div class="num">1</div>
							<img
								src="data:image/png;base64,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"
								alt="" class="labtop">
							<div class="separate"></div>
							원활한 영상 촬영을 위해 카메라와<br>눈높이를 맞추고, 얼굴이 화면의 정중앙에 오도록 조절해 주세요.
						</div>
						<div class="box">
							<div class="num">2</div>
							<img
								src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAMoAAAAzCAYAAADW+Jd5AAAABHNCSVQICAgIfAhkiAAABRRJREFUeF7tnTuoXUUUhr8pTKd2WvgCIaAJNml8tOID6/gIgRSJWPuoLMQHiJWPXs2VQECM/fUBlpqksDIqaJNoQOyMpeCW/zDrMtnuI8e99x2Ys/+By7n7nJk1M//Md9fMnJm5iV7ouu4eYAc4DNzY/9zPVmCLFbgGfA+cSCn9VNYzlQ9d1+0Cj2+xEK6aFdhUgd2U0hMReQ+UrusuA3duasXxrMACFLiSUrpL9VyBYk+ygCZ3FccqsPIsKc9JfhhrxemswAIUOChQzgP3L6CyrqIVGKvAeYHyB3DTWAtON1mBR4FLG1rRSuQXG8Z1tPkUuCZQuvns2dIIBQzKCNFqJzEotRV3fk0qYFCabDYXurYCBqW24s6vSQUMSpPN5kLXVsCg1Fbc+TWpgEFpstlc6NoKGJTaiju/JhUwKE02mwtdWwGDUltx59ekAgZlvmb7E3ge+Kww+RTwRj4A9yTwdS87bUl5CXiseP9ctnMHoH14/fA58CrwS/5ANl4HHszPt62pkvJ5cb7qLsuSQZmvvWMrykPAA4A6vDqznvV7gCIAbs/ZfpNfTxewlEB9WgCgqAGR9uYFGAJH4UvgEBCgxOdRQ0GrH4cRChiUEaINJNHx0Ufy+1fzq46V3pt//xE4mT1K+Ze97z1+7e3kVsd+t8hPAAq+EqB3gLczBIoboEQ55qnhwq0YlPk6gKAQHBoGPTtgNjxFCUofsA/ysEo21PkVLuahW8SVNynPDwmcTwB5KoFlUOZr0z1LBmU+UdVZX8jm1Jl194CgiGFWgFIOgZRGP4r7YR6yqeNrbiJPoc/ey8M2DdOOFkO5dSVfN0exh5nQ1gZlgngDSdXJ5Qk0b5B3UYiOPjSZ1+fyBIJEx7I1fIszJ7Kh4VrMcf4vKP05ioZrDiMVMCgjhesl09xCkJQT9feB1/KhOA2VApSY7MuEoNCzPJC8UQyhZEchVskuADpgpwWD/mqYVtu+A27uTebtQeZp25UVgzKPmDG3iCFUWI1hkE4lChp1/HXLtDHHGSpRpIk4scKluP28PUeZp02vs2JQ5hFVwyzdO6BXzUH0V1/He/WdSniAocl85B6rX/2jvjH8ChsBhTzQ09nLyAspxEpYgCJPVQbZFqwOIxQwKCNEW5NEYMT8JKKos6pzqpP+FyinMlRDK2bhRQIE5SFgYg4kiJRHXFy4bjIfc535arwgSwZlfxpbnXi/L+yokcf+qNOgVYPSYKO5yPUVMCj1NXeODSpgUBpsNBe5vgIGpb7mzrFBBQxKg43mItdXwKDU19w5NqiAQWmw0Vzk+goYlPqaO8cGFQhQ9E3v0BmKBqvkIluBWRVYsRGgaNtDudFu1pxszAo0qkAcbbhagqK6rDud12g9XWwrMFqB2IAqA/8CRW9qk52GYdpEp8sKHKzAUhTQcWsdhRAkccvNWlCWIorraQU2VWDQo2ya2PGswFIUMChLaWnXc5ICK1B+y4d+fp9kyomtwHYqcAuwK1B2gbPAV9tZT9fKCkxS4GHgGYGiY6R/ATuTzDmxFdhOBbQC3AmUA/n89d3bWU/XygpMUuAKcECXrtF13THgOPDcJJNObAW2SwF9n7KTUjq3AiXDckJjMe/52q6Wdm1GK6D/MPBRSuljWdgDJcOiu6LOAG8BP+cbCL0aNlprJ2xIAa1u3QdoCvIKcEyeJMp/HSgZlhuAl/OF0UeAWxuqrItqBcYqoK9Jvs0XpL+ZUvq7NPQPsrGClYE5JzAAAAAASUVORK5CYII="
								alt="" class="spacebar">
							<div class="separate"></div>
							답변을 마치고 다음 질문으로 넘어가시려면 스페이스바를 눌러주세요.
						</div>
						<div class="box">
							<div class="num">3</div>
							<img
								src="data:image/png;base64,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"
								alt="" class="twomin">
							<div class="separate"></div>
							결과 분석까지 약 2분의 시간이 소요되며,<br>면접을 도중에 중단하실 경우 면접 과정은 저장되지 않습니다.
						</div>
					</div>
					<button onclick="check();">확인했어요</button>
					<div class="again-area">
						<div class="CustomCheck false undefined"></div>
						다시 보고 싶지 않아요.
					</div>
				</div>
			</div>
			<div class="FullButton"></div>
			<div class="back-btn">
				<a href="/interview/ready.do"  onclick="back();"><img
					src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAARCAYAAADUryzEAAAABHNCSVQICAgIfAhkiAAAAPJJREFUOE+dk71RA1EMhL+dIYcWqADnJNABVGCowDBuwhl0AHRABxC4ADsnICS0c2bE7I0ODu7vHS/WftqnlcTIi4grYCfpuatUQ/qIeATmwF7SUTEgIlx8B7j7HriRZFjrtRyk+AWYpfhM0qbP6S/AVLGh34CIcEd3tv0t4M67sSFXgP+KKwcRsQKWwAHwAbwBn2OdM9pLA9bAaYHgb0kVbf2Fe2CRFY7rqQC48YyaQ3TmDzVE0nUB5CeFHKYhdnMI2MntWBJdi+Q4XxPiBTofgnTeQsZaBOk9ptxKQ06Ad0nHRbfQLEqIz9jnfDEZUJLCF5WiXRKgXvFqAAAAAElFTkSuQmCC"
					alt="go-back" class="go-back">돌아가기</a>
			</div>
			<div class="body">
			
<!-- 				화면 출력 -->
<!-- 				<div class="contentarea"> -->
<!-- 					<h1>MDN - WebRTC: Still photo capture demo</h1> -->
<!-- 					<p>This example demonstrates how to set up a media stream using -->
<!-- 						your built-in webcam, fetch an image from that stream, and create -->
<!-- 						a PNG using that image.</p> -->
<!-- 					<div class="camera"> -->
<!-- 						<video id="video" autoplay>Video stream not available.</video> -->
<!-- 						<button id="startbutton">Take photo</button> -->
<!-- 					</div> -->
<!-- 					<canvas id="canvas"> </canvas> -->
<!-- 					<div class="output"> -->
<!-- 						<img id="photo" alt="The screen capture will appear in this box."> -->
<!-- 					</div> -->
<!-- 					<p> -->
<!-- 						Visit our article <a -->
<!-- 							href="https://developer.mozilla.org/en-US/docs/Web/API/WebRTC_API/Taking_still_photos"> -->
<!-- 							Taking still photos with WebRTC</a> to learn more about the -->
<!-- 						technologies used here. -->
<!-- 					</p> -->

<!-- 					<div id="imgurl"></div> -->
<!-- 				</div> -->
<!-- 				화면출력 -->
				
				<div class="center">
					<a onclick="closeFullScreenMode();"  > 
						<img alt=""	src="/images/fullSize_cancel.png" style="height: 70px;width: 70px">
					</a>
					<div class="top-message">카메라와 마이크 상태를 점검해 주세요.</div>
					<br>
					<div class="bottom-message">
						모든 면접은 녹화되며, 분석이 끝난 후 확인할 수 있습니다.<br>보다 정확한 평가를 위해 얼굴이 중앙의 영역
						안으로 오도록 조절해 주세요.
					</div>
				</div>
				<div class="right">
					<div class="test">
						<div class="InterviewTestMic">
							<div class="VolumeMeter">
								<div class="none"></div>
								<div class="none"></div>
								<div class="none"></div>
								<div class="none"></div>
								<div class="none"></div>
								<div class="none"></div>
								<div class="none"></div>
								<div class="none"></div>
								<div class="none"></div>
								<div class="none"></div>
								<div class="none"></div>
								<div class="none"></div>
								<div class="none"></div>
								<div class="none"></div>
								<div class="none"></div>
								<div class="none"></div>
								<div class="none"></div>
								<div class="none"></div>
								<div class="none"></div>
								<div class="none"></div>
								<div class="none"></div>
								<div class="none"></div>
								<div class="none"></div>
								<div class="none"></div>
								<div class="none"></div>
								<div class="none"></div>
								<div class="none"></div>
								<div class="none"></div>
								<div class="none"></div>
								<div class="none"></div>
								<div class="none"></div>
								<div class="none"></div>
								<div class="none"></div>
								<div class="none"></div>
								<div class="none"></div>
								<div class="none"></div>
								<div class="none"></div>
								<div class="none"></div>
								<div class="none"></div>
							</div>
							<img
								src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABQAAAAeCAYAAAAsEj5rAAAABHNCSVQICAgIfAhkiAAAActJREFUSEvtlq1uVVEQhb+laIKgDgkkJJDWgAUUkFBFBYIEUVPDEwBFERBAeAIEkgcA1SatgyYIQhNMW9UKTF0dVYvMYXbpOffce/ctCalgu7N/vrNmZs/MFiOG7SfAbeAi8AP4LunhqDMatmj7G3ClZ30fuC9ppe9sL3AErDD2JU1XAW2/Bh6NMivX1iSFO1pjQKHtz8C1CuCepLM1wB3gXAUQSQOC+hRWA4G5bnD+A8H23/kwAdPloh4HaHsTOA/My7bziryNPD0m8A/jJAEPGhOllZYo2z+BU0AxeaLUs30HWE63LYUPS1Q3JF3NGviyIvU+Spq3/R54APxWbPsDcDcmJE0FqKJA7AELaW4RtCXpcgBDckDD7HVJ18dAd4EXkt51St2SpFdNLh9RGZ+NKTm/mOpPpwu+Snqca9EenqWQxl0xf1gcOlV6HXg+rMyn3+4lLMx/GopbwPxrt49sAF+A6CMxbgCzwJn8bsEGgAmNqJW/Dwt2RPQT8GZsPSyENGsGuJCKAhIR3Uo/NyaObQHdDbZXgVtAbw/5t8AjaioSpdmyKynK1uFo9ZSsa5dqaRn91iuiC4ysuTkBcLvcv3Jm6NtmAmhr6y80wfzbDYp1UQAAAABJRU5ErkJggg=="
								alt="mic-volume">
							<div class="label">마이크 테스트</div>
							<button class="text-btn false">확인하기</button>
						</div>
						<div class="InterviewTestAudio">
							<audio src="/static/media/sample_audio.0c1b6446.mp3"></audio>
							<div class="VolumeMeter">
								<div class="none"></div>
								<div class="none"></div>
								<div class="none"></div>
								<div class="none"></div>
								<div class="none"></div>
								<div class="none"></div>
								<div class="none"></div>
								<div class="none"></div>
								<div class="none"></div>
								<div class="none"></div>
								<div class="none"></div>
								<div class="none"></div>
								<div class="none"></div>
								<div class="none"></div>
								<div class="none"></div>
								<div class="none"></div>
								<div class="none"></div>
								<div class="none"></div>
								<div class="none"></div>
								<div class="none"></div>
								<div class="none"></div>
								<div class="none"></div>
								<div class="none"></div>
								<div class="none"></div>
								<div class="none"></div>
								<div class="none"></div>
								<div class="none"></div>
								<div class="none"></div>
								<div class="none"></div>
								<div class="none"></div>
								<div class="none"></div>
								<div class="none"></div>
								<div class="none"></div>
								<div class="none"></div>
								<div class="none"></div>
								<div class="none"></div>
								<div class="none"></div>
								<div class="none"></div>
								<div class="none"></div>
							</div>
							<img
								src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABwAAAAeCAYAAAA/xX6fAAAABHNCSVQICAgIfAhkiAAAAkxJREFUSEvVlr9rVFEQhb9TaaeVNoIWgpaK/4EKdjYWioKNggFrjRaKWIg/ClsFBRvtIwgKWpo0gpamy5ZJZSpNNTKPucvs2/t237JrwIU0m7f3u2fmzJkndvmjXebx/wLN7BxwH9iQdKWrcgtTaGYrwPkAbQHPJT1ug3sDzewO4H/fJJ1tHxQKHXAi/e9dW20vYMAeAHuAgaQjXSUzs2vAPeBwPDMCnQpswfyMMaCZfQV+A88kffKHzOx7UvtU0rJ/PxFYgY0Bo5QfQ80O8EbSUkB/AseAbeCiX6YT2AHrUvgCuATsy2WMy7iZvBVfvPdV4ARYFRhqfCyKaVzpTUmvzewtcBnYkbRXZrYJHJghcYY9jMNOASulR+m8dUnH4zJ/QuVLB9oMsBGFZraR3NgYw8yeALfjzOuhshhodV6gj8CjqNC2pP2hqFStGYkUCoO5gKl3xaV3PV3SSDRGSarnBwb0Vzi0lPUzcKY4c6HAjp6V3haFPjY3mtCY0zTF8i70h6STY66UlsysKF6fF1iSZOAKPEmSQZq5a5novQNd7tHWaByKSKpNTJ5DH/bTaQZ9m5SQL+V0J78ajsmE1M/hmx+rbosIgQsx4FuSDrZCvPndtPCuQWvbIgeAL9+rUd4cAo2D+6ynNnQE2AroVeBhwHJ5hzE3FVjZbTWF3ic8xuL5DBsqnroPc+NSenRu/FB7K4befz4CmwkYN/fdtlZ7Oaq9GZRRyRfvVdI+2yTGy9PEt/uHrlfFhQFL72rq/4nCPlWYuYd9D5303F8BlG7c1Ln34AAAAABJRU5ErkJggg=="
								alt="">
							<div class="label">스피커 테스트</div>
							<button class="text-btn false">확인하기</button>
						</div>
					</div>
					<div class="txt"></div>
					<div class="interview-start-btn">면접 시작</div>
				</div>
			</div>
			<div class="bg-video camera">
				<div class="bg-layer"></div>
				<video id="video" class="user-camera-video false" autoplay></video>
<!-- 				<canvas id="canvas"> </canvas> -->
			</div>
		</div>
	</div>
	<style data-styled="active" data-styled-version="5.1.1"></style>
</body>
</html>