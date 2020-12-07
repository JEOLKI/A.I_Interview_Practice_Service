<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ include file="/WEB-INF/views/layout/commonLib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="/js/capture.js"></script>
<link rel="stylesheet" href="/css/main.css" type="text/css" media="all">

<!-- <link rel="manifest" href="/manifest.json"> -->
<link href="/css/main.8acfb306.chunk.css" rel="stylesheet">
<script type="text/javascript">
	var docV = document.documentElement;
	SetTime = 00;
	startCount = 0; // 시작 카운트
	endCount = ${questionGoList.size()}; // 질문의 개수
	var tid;
    var average;
	
	// 모든 질문을 출력 했을 경우
	if(startCount>=endCount){ 
		clearInterval(tid);		
		alert('면접 종료');					
	}
	
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
	
	// 2분 타이머 설정
	function timer(){
		SetTime++;					// 1초씩 증가
		if(SetTime%60<10){
			m = Math.floor(SetTime / 60) + ":" + "0"+(SetTime % 60) ;
		}else{
			m = Math.floor(SetTime / 60) + ":" +(SetTime % 60) ;
		}
		
		msg = "<font color='red' size='5px' style='z-index:200;'>REC</font><br>";  
		msg += "<font color='red' size='7px' style='z-index:200;'>" + '답변시간' + "</font><br>";
		msg += "<font color='black' size='15px' style='z-index:200;'>" + m + "</font>";
		
		
		document.all.time.innerHTML = msg;
		
		// 시간이 종료 되었으면..
		if (SetTime >= 120) {
			
			startCount++;
			script = "다음 질문을 준비해주세요.";
			
			clearInterval(tid);		// 타이머 해제
			console.log('타이머 멈추기')	;	
			console.log('시작카운트 : '+startCount);
			console.log('종료카운트 : '+endCount);
				
			if(startCount>=endCount){ // 모든 질문을 출력 했을 경우
				clearInterval(tid);		// 타이머 해제
// 				alert('면접 종료');					
			}else{
				$('.message-balloon').empty(); // 메세지 창 지우기
				$('#time').empty(); // 타이머 표시 지우기
				$('.message-balloon').text(script); // 다음질문 준비 표시
				SetTime=0; // 타이머 시간 되돌리기
				$('.attention-message.shown').text('이곳을 주목해주세요!'); // 주목해주세요 표시
			}
			
		}
		
	}
	
	// 타이머 시작 
	function TimerStart(){ 
		tid=setInterval('timer()',1000);
	}
	
	// 웹캠기능
	var index = 0;

	function processImage() {
		var subscriptionKey = "cae766a534074d6b89f02281da4e14cf";
		var uriBase = "https://faceanalysis-jh.cognitiveservices.azure.com/face/v1.0/detect";
		// Request parameters.
		var params = {
			"detectionModel" : "detection_01",
			"returnFaceAttributes": "age,gender,headPose,smile,facialHair,glasses,emotion,hair,makeup,occlusion,accessories,blur,exposure,noise",
			"returnFaceId" : "true"
		};
		
		// Display the image.
		var sourceImageUrl = document.getElementById("inputImage").value;
		document.querySelector("#sourceImage").src = sourceImageUrl;
		// Perform the REST API call.
		$.ajax({
							url : uriBase + "?" + $.param(params),
							// Request headers.
							processData: false,
							beforeSend : function(xhrObj) {
								xhrObj.setRequestHeader("Content-Type",
										"application/octet-stream");
								xhrObj.setRequestHeader(
										"Ocp-Apim-Subscription-Key",
										subscriptionKey);
							},
							type : "POST",
							
							// Request body.
							data : makeblob($('#inputImage').val()),
						})
				.done(
						function(data) {
							// Show formatted JSON on webpage.
							emotion = data[0].faceAttributes.emotion;
							face = data[0].faceRectangle
							var html = '<input type="text" name="imageAnalysisVOList['+index+'].anger" value="'+emotion.anger+'" >'
							html += '<input type="text" name="imageAnalysisVOList['+index+'].contempt" value="'+emotion.contempt+'" >'
							html += '<input type="text" name="imageAnalysisVOList['+index+'].disgust" value="'+emotion.disgust+'" >'
							html += '<input type="text" name="imageAnalysisVOList['+index+'].fear" value="'+emotion.fear+'" >'
							html += '<input type="text" name="imageAnalysisVOList['+index+'].happiness" value="'+emotion.happiness+'" >'
							html += '<input type="text" name="imageAnalysisVOList['+index+'].neutral" value="'+emotion.neutral+'" >'
							html += '<input type="text" name="imageAnalysisVOList['+index+'].sadness" value="'+emotion.sadness+'" >'
							html += '<input type="text" name="imageAnalysisVOList['+index+'].surprise" value="'+emotion.surprise+'" >'
							html += '<input type="text" name="imageAnalysisVOList['+index+'].faceTop" value="'+face.top+'" >'
							html += '<input type="text" name="imageAnalysisVOList['+index+'].faceLeft" value="'+face.left+'" >'
							html += '<input type="text" name="imageAnalysisVOList['+index+'].faceHeight" value="'+face.height+'" >'
							html += '<input type="text" name="imageAnalysisVOList['+index+'].faceWidth" value="'+face.width+'" >'
							
							$("#analysisData").append(html);
							
							 index += 1;
							 
							$("#responseTextArea").val(JSON.stringify(data, null, 2));
						})
				.fail(
						function(jqXHR, textStatus, errorThrown) {
							// Display error message.
							var errorString = (errorThrown === "") ? "Error. "
									: errorThrown + " (" + jqXHR.status
											+ "): ";
							errorString += (jqXHR.responseText === "") ? ""
									: (jQuery.parseJSON(jqXHR.responseText).message) ? jQuery
											.parseJSON(jqXHR.responseText).message
											: jQuery
													.parseJSON(jqXHR.responseText).error.message;
							alert(errorString);
						});
	};


	makeblob = function (dataURL) {
           var BASE64_MARKER = ';base64,';
           if (dataURL.indexOf(BASE64_MARKER) == -1) {
               var parts = dataURL.split(',');
               var contentType = parts[0].split(':')[1];
               var raw = decodeURIComponent(parts[1]);
               return new Blob([raw], { type: contentType });
           }
           var parts = dataURL.split(BASE64_MARKER);
           var contentType = parts[0].split(':')[1];
           var raw = window.atob(parts[1]);
           var rawLength = raw.length;

           var uInt8Array = new Uint8Array(rawLength);

           for (var i = 0; i < rawLength; ++i) {
               uInt8Array[i] = raw.charCodeAt(i);
           }

           return new Blob([uInt8Array], { type: contentType });
       }
	
	$(document).ready(function(){
		
		$("#testgo").on('click', function(){
			$("#analysisData").submit();
			
		})
	});		
	
	
	// jquery
	$(document).ready(function(){
		
		// 풀스크린메서드
		openFullScreenMode(); 
		
		 // 클릭의 경우
		$(document).on('click','.spacebar-area.false',function(){
			if(SetTime == 0){ // 타이머 진행중이 아닐 경우
				console.log($('.quest').eq(startCount).val())  
				script=$('.quest').eq(startCount).val(); // 면접 질문 표시
				
				$('.next-question.shown').html('다음 질문<br><div class="spacebar-area false">SPACE BAR</div>'); //버튼 내용 변경
				$('.message-balloon').empty();
				$('.message-balloon').text(script);
				
// 				$(document).on('click','.spacebar-area.false',function(){
					console.log('타이머 시작')				
					$('.attention-message.shown').text('');
					TimerStart();
// 				});
			}else{ // 타이머 진행 중에서 space
				startCount++;
				script = "다음 질문을 준비해주세요.";
				
				clearInterval(tid);		// 타이머 해제
				console.log('타이머 멈추기')	;	
				console.log('시작카운트 : '+startCount);
				console.log('종료카운트 : '+endCount);
					
				if(startCount>=endCount){ // 모든 질문을 출력 했을 경우
					clearInterval(tid);		// 타이머 해제
					alert('면접 종료');					
				}else{
					$('.message-balloon').empty(); // 메세지 창 지우기
					$('#time').empty(); // 타이머 표시 지우기
					$('.message-balloon').text(script); // 다음질문 준비 표시
					SetTime=0; // 타이머 시간 되돌리기
					$('.attention-message.shown').text('이곳을 주목해주세요!'); // 주목해주세요 표시
				}
			}
		});
		
		// space 경우
		$(document).keydown(function(event) {
			if(event.keyCode == 32){ // space
				if(SetTime == 0){ // 타이머 진행중이 아닐 경우
					console.log($('.quest').eq(startCount).val()) 
					script=$('.quest').eq(startCount).val();
						
					$('.next-question').html("다음 질문<br><div class='spacebar-area false'>SPACE BAR</div>");
					$('.message-balloon').empty();
					$('.message-balloon').text(script);
					
					console.log('타이머 시작')				
					$('.attention-message.shown').text('');
					TimerStart();
				}else{ // 타이머 진행 중에서 space
					startCount++;
					script = "다음 질문을 준비해주세요.";
					
					clearInterval(tid);		// 타이머 해제
					console.log('타이머 멈추기')	;	
					console.log('시작카운트 : '+startCount);
					console.log('종료카운트 : '+endCount);
						
					if(startCount>=endCount){ // 모든 질문을 출력 했을 경우
						clearInterval(tid);		// 타이머 해제
						alert('면접 종료');					
					}else{
						$('.message-balloon').empty(); // 메세지 창 지우기
						$('#time').empty(); // 타이머 표시 지우기
						$('.message-balloon').text(script); // 다음질문 준비 표시
						SetTime=0; // 타이머 시간 되돌리기
						$('.attention-message.shown').text('이곳을 주목해주세요!'); // 주목해주세요 표시
					}
				}
			}
		});
		
		// 보이스 테스트
		$(document).on('click','#voice',function(){
			navigator.mediaDevices.getUserMedia({ audio: true, video: true })                                     
			.then(function(stream) {                                                                              
			  audioContext = new AudioContext();                                                                  
			  analyser = audioContext.createAnalyser();                                                           
			  microphone = audioContext.createMediaStreamSource(stream);                                          
			  javascriptNode = audioContext.createScriptProcessor(256, 1, 1);                                    
			                                                                                                      
			  analyser.smoothingTimeConstant = 0.1;                                                               
			  analyser.fftSize = 1024;                                                                            
			                                                                                                      
			  microphone.connect(analyser);                                                                       
			  analyser.connect(javascriptNode);                                                                   
			  javascriptNode.connect(audioContext.destination);                                                   
			  javascriptNode.onaudioprocess = 
			function() {                                                        
			      var array = new Uint8Array(analyser.frequencyBinCount);                                         
			      analyser.getByteFrequencyData(array);                                                           
			      var values = 0;                                                                                 
			                                                                                                      
			      var length = array.length;                                                                      
			      for (var i = 0; i < length; i++) {                                                              
			        values += (array[i]);                                                                         
			      }                                                                                               
			                                                                                                      

			      average += values / length;                                                                  
			                                                                                                      
			    console.log(Math.round(average));                                                                 
			  }                                                                                                   
			});                                                                                                  
		});
	});
</script>
</head>
<body style="">


	<div class="webcam">
		<div class="contentarea">
			<div class="camera">
				<video id="video" autoplay >Video stream not available.</video>
				<button id="startbutton">Take photo</button> 
			</div>
			<canvas id="canvas"></canvas>
			<div class="output">
				<img id="photo" alt="The screen capture will appear in this box."> 
			</div>
			<div id="imgurl"></div>
			
			<input type="text" name="inputImage" id="inputImage" value="" />
			<button onclick="processImage()">Analyze face</button>
			<div id="wrapper" style="width: 1020px; display: table;">
				<div id="jsonOutput" style="width: 600px; display: table-cell;">
					Response:<br><br>
					<textarea id="responseTextArea" class="UIInput" style="width: 580px; height: 400px;"></textarea>
				</div>
				<div id="imageDiv" style="width: 420px; display: table-cell;">
					Source image:<br>
					<br> <img id="sourceImage" width="400" />
				</div>
			</div>
			<button id="testgo">전송테스트</button>
		</div>
		<form id="analysisData" action="/answer/create.do" method="post">
		
		
		</form>
	</div>
	

	<div id="root">
		<div class="Interview">
			<div class="FullButton" style="display: inline-block;"></div>
			
			<c:forEach var="quest" begin="0" end="${questionGoList.size()-1}">
				<input type="hidden" value='${questionGoList[quest].questContent}' class="quest" >
			</c:forEach>
			
			<div class="InterviewCircle">
			<div id="time" style="width: 600px; height: 80px; display: inline-block; text-align: center; margin-top: 200px; position: relative; z-index: 300;"></div>
					<img id="attention" src="/images/interviewwatch.png" alt="" class="bg" style="width: 400px; height: 400px; position: absolute; margin-left:39.5%; top:100; display: none;">
				<div class="MovingCircle circle false">
					<canvas width="600" height="600"></canvas>
				</div>
				<img src="/images/bg.355cdfd9.png" alt="" class="bg">
				<div class="attention-message shown" style="position:relative; display: block; margin-left: auto; margin-right: auto; width: 400px; height: 200px; margin-top: -35%; background-size:100% ; padding-top:200px; background-image: url('/images/interview_circle.png');" >
					이곳을 주목해주세요!
				</div>
				<div style="text-align: center;">
				</div>
<!-- 				<audio src="/images/interview_guide_audio.5680f6cc.mp3"	autoplay=""></audio> -->
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