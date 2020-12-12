<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ include file="/WEB-INF/views/layout/commonLib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="/js/capture.js"></script>
<script src="/js/microsoft.cognitiveservices.speech.sdk.bundle.js"></script>
<link rel="stylesheet" href="/css/main.css" type="text/css" media="all">
<link href="/css/main.8acfb306.chunk.css" rel="stylesheet">
<script type="text/javascript">
	var docV = document.documentElement;
	SetTime = 0; // 타이머 초기값(경과시간)
	startCount = 0; // 시작 카운트
	endCount = ${questionGoList.size()}; // 질문의 개수
	var decibelIndex = 0; // 데시벨 인덱스
	var frequencyIndex = 0; // 주파수 인덱스
	
	var tid;
	var aid;
    var average;
    script = ""; // 면접 질문 받는 변수
    questSq = 0;
    
  // 아래쪽 음성스크립트 추출 부분
    var phraseDiv;
    var startRecognizeOnceAsyncButton;
    var stopRecognizeOnceAsyncButton;
    var subscriptionKey, serviceRegion;
    var authorizationToken;
    var SpeechSDK;
    var recognizer;
    answer = ""; // 대답을 모두 담는 변수
    
    document.addEventListener("DOMContentLoaded", function () {
 	startRecognizeOnceAsyncButton = document.getElementById("startRecognizeOnceAsyncButton");
 	stopRecognizeOnceAsyncButton = document.getElementById("stopRecognizeOnceAsyncButton");
 	subscriptionKey = document.getElementById("subscriptionKey");
 	serviceRegion = document.getElementById("serviceRegion");
 	phraseDiv = document.getElementById("phraseDiv");
 	
 	// 녹음 버튼 클릭 시 
	startRecognizeOnceAsyncButton.addEventListener("click", function () {
	startRecognizeOnceAsyncButton.disabled = true;
    phraseDiv.innerHTML = "";

    var speechConfig;
    if (authorizationToken) {
      speechConfig = SpeechSDK.SpeechConfig.fromAuthorizationToken(authorizationToken, serviceRegion.value);
    } else {
      if (subscriptionKey.value === "" || subscriptionKey.value === "subscription") {
        alert("Please enter your Microsoft Cognitive Services Speech subscription key!");
        return;
      }
      speechConfig = SpeechSDK.SpeechConfig.fromSubscription(subscriptionKey.value, serviceRegion.value);
    }

    speechConfig.speechRecognitionLanguage = "ko-KR";
    var audioConfig  = SpeechSDK.AudioConfig.fromDefaultMicrophoneInput();
    recognizer = new SpeechSDK.SpeechRecognizer(speechConfig, audioConfig);

    	
    recognizer.recognizing = (s, e) => {
  	
  	console.log(`RECOGNIZING: Text=${e.result.text}`);
    };
        
   	recognizer.recognized = (s, e) => { // 음성에서 스크립트 추출
//    		editText = e.result.text.replace(/undefined/g,'');
// 		console.log(`RECOGNIZED: `+editText);
		console.log(`RECOGNIZED: Text=${e.result.text}`);
	    phraseDiv.innerHTML += editText;
	    answer+=editText;
 	   if (e.result.reason == ResultReason.RecognizedSpeech) {
    	}
    	else if (e.result.reason == ResultReason.NoMatch) {
    	   console.log("NOMATCH: Speech could not be recognized.");
   	    }
   	};
    	
    recognizer.canceled = (s, e) => { // 중간취소
    	console.log(`CANCELED: Reason=${e.reason}`);

  	    if (e.reason == CancellationReason.Error) {
  	        console.log("CANCELED: ErrorCode=${e.errorCode}");
  	        console.log("CANCELED: ErrorDetails='${e.errorDetails}'");
  	        console.log("CANCELED: Did you update the subscription info?");
  	    }

  	    recognizer.stopContinuousRecognitionAsync();
  	};
   	recognizer.startContinuousRecognitionAsync();
  	
  	recognizer.sessionStopped = (s, e) => { // 세션 끊어짐
  	    console.log("\n    Session stopped event.");
  	    recognizer.stopContinuousRecognitionAsync();
  	};
 });
 	
	// 음성 스탑버튼 클릭 시 
  	stopRecognizeOnceAsyncButton.addEventListener("click", function () {
		startRecognizeOnceAsyncButton.disabled = false;
		 
	   	recognizer.stopContinuousRecognitionAsync();
   	
  	});
	
	// 음성 추출 관한 내용
  	if (!!window.SpeechSDK) {
  	    SpeechSDK = window.SpeechSDK;
  	    startRecognizeOnceAsyncButton.disabled = false;
  	    if (typeof RequestAuthorizationToken === "function") {
  	        RequestAuthorizationToken();
  	    }
  	  }
  	});
    
    // 음성추출 권한 받아오기
    var authorizationEndpoint = "token.php";

    function RequestAuthorizationToken() {
      if (authorizationEndpoint) {
        var a = new XMLHttpRequest();
        a.open("GET", authorizationEndpoint);
        a.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        a.send("");
        a.onload = function() {
            var token = JSON.parse(atob(this.responseText.split(".")[1]));
            serviceRegion.value = token.region;
            authorizationToken = this.responseText;
            subscriptionKey.disabled = true;
            subscriptionKey.value = "using authorization token (hit F5 to refresh)";
            console.log("Got an authorization token: " + token);
        }
      }
    }
	
	// 전체화면 설정
	function openFullScreenMode() {
	    if (docV.requestFullscreen){
	        docV.requestFullscreen();
	    }
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
			download();
			
			startCount++;
			script = "다음 질문을 준비해주세요.";
			
			clearInterval(tid);		// 타이머 해제
			console.log('타이머 멈추기')	;	
			console.log('시작카운트 : '+startCount);
			console.log('종료카운트 : '+endCount);
				
			if(startCount>=endCount){ // 모든 질문을 출력 했을 경우
				download(); // 녹화 중지
				clearInterval(tid);		// 타이머 해제
				$('#voiceStop').trigger('click'); // 음성분석(데시벨,주파수) 종료
				clearInterval(aid);		// 10초마다 이미지 분석 종료
				
				script = "분석중입니다. 잠시만 기다려주세요"
				$('.message-balloon').text(script); // 모든질문 진행 후 분석하는 안내말 표시
				$('#time').hide();// 타이머 지우기
				$('.attention-message.shown').css("background-image", "");// 원 지우기
				$('.attention-message.shown').css("background-image", "url(/images/loading.16070af3.gif)"); // 원넣기
				$('.attention-message.shown').css("background-repeat", "no-repeat"); // 하나만 출력
				$('.attention-message.shown').css("margin-top", "200px"); // 마진
				$('.attention-message.shown').css("width", "600px"); // 로딩중 설정
				
				window.location.replace("/interview/end.do?interviewSq=${interviewSq}"); // 면접 종료시 이동하는 페이지
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
	
	// 분석을 매 10초마다 시작하는 메서드
	function analyzeStart(){
		aid=setInterval('processImage()',10000);
	}
	
	// 이미지 분석자료 보내기위한 변수
	var index = 0;

	// 이미지 분석
	function processImage() {
		$('.spacebar-area').attr('disabled', true); // 버튼 비활성화 설정
		var subscriptionKey = "cae766a534074d6b89f02281da4e14cf";
		var uriBase = "https://faceanalysis-jh.cognitiveservices.azure.com/face/v1.0/detect";
		// Request parameters.
		var params = {
			"detectionModel" : "detection_01",
			"returnFaceAttributes": "age,gender,headPose,smile,facialHair,glasses,emotion,hair,makeup,occlusion,accessories,blur,exposure,noise",
			"returnFaceId" : "true"
		};
		
		$('#startbutton').trigger('click'); // 영상 캡쳐
		
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
				if(data[0]=== undefined){ // 분석할 사진에 문제가 있을경우
					console.log('영상을 분석할 수 없습니다.')
				}else{
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
				}
				 
				$("#responseTextArea").val(JSON.stringify(data, null, 2));
				$('.spacebar-area').attr('disabled', false); // 버튼 비활성화 해제
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

	// 질문 끝날 때 answerVO 넘기는 ajax
	
	function createAnswer(){
		var form = $('#analysisData')[0]; // form안에 있는 input들의 모음
		var fd = new FormData(form); 
		
		ansContent = answer; // 해당 질문내용
		ansTime = SetTime; // 경과시간 입력
		ansSpeed = (ansContent.length)/ansTime*60; // 말빠르기
		
		fd.append('name', 'answerVideo'); // name지정
		fd.append("mtfRequest", blob); // 영상 데이터
		fd.append("ansContent", ansContent); // 대답 내용
		fd.append("ansTime", ansTime); // 대답시간(초)
		fd.append("ansSpeed", ansSpeed); // 대답 속도(대답내용 문자열수/대답시간)
		fd.append("questSq", questSq); // 대답의 시퀀스 
		
		// 확인용 console.log
		console.log(ansContent);
		console.log(ansTime);
		console.log(ansSpeed);
		console.log(startCount);
		console.log(questSq);
			
		$.ajax(
			{url:"/answer/create.do",
			data : fd,
			type : "post",
			enctype:'multipart/form-data',
			contentType: false,
			processData: false,
			success : function(data){
				decibel = 0;
				console.log("성공");
				console.log(data);
				
			},
			error : function(data){
				console.log(data.status);
			}
		});
	}
	
	
	// blob 데이터 넘기기
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
	
	
	// 여기부터 녹화
	const constraints = { "video": { width: { max: 320 } }, "audio" : true };
	var theStream;
	var theRecorder;
	var recordedChunks = [];
	
	function startFunction() {
	  navigator.mediaDevices.getUserMedia(constraints)
	      .then(gotMedia)
	      .catch(e => { console.error('getUserMedia() failed: ' + e); });
	}
	
	function gotMedia(stream) {
	  theStream = stream;
	  var video = document.querySelector('video');
	  video.srcObject = stream;
	  try {
	    recorder = new MediaRecorder(stream, {mimeType : "video/webm"});
	  } catch (e) {
	    console.error('Exception while creating MediaRecorder: ' + e);
	    return;
	  }
	  
	  theRecorder = recorder;
	  recorder.ondataavailable = 
	      (event) => { recordedChunks.push(event.data); };
	  recorder.start(100);
	}
	
	// 녹화 종료하는메서드
	function download() {
	  theStream.getTracks().forEach(track => { track.stop(); });
	  blob = new Blob(recordedChunks, {type: "video/webm"}); // blob객체로 변환
	  var url =  URL.createObjectURL(blob);
	  
	  $('#file').attr('src',url);
	  setTimeout(function() { URL.revokeObjectURL(url); }, 100); 
	}
	
	// jquery
	$(document).ready(function(){
		$("#testgo").on('click', function(){
			$("#analysisData").submit();
		})
		
		// 풀스크린메서드
		openFullScreenMode();
		
		 // 클릭의 경우
		$(document).on('click','.spacebar-area.false',function(){
			if(SetTime == 0){ // 타이머 진행중이 아닐 경우
				
				startFunction(); // 녹화 시작
				script=$('.quest').eq(startCount).val(); // 면접 시작 지문 출력
				questSq=$('.quest').eq(startCount).data('sq');
				$('#startRecognizeOnceAsyncButton').trigger('click'); // 음성 스크립트 분석 시작 
				
				TimerStart(); // 타이머 시작
				analyzeStart(); // 10초마다 이미지 분석
				$('#voice').trigger('click'); // 음성분석(데시벨,주파수) 측정
				
				$('.next-question.shown').html('다음 질문<br><div class="spacebar-area false">SPACE BAR</div>'); //버튼 내용 변경
				$('.message-balloon').empty();
				$('.message-balloon').text(script);
				
				console.log('타이머 시작')				
				$('.attention-message.shown').text('');
			}else if(SetTime >= 15 ){ // 타이머 진행 중에서 space
				console.log('타이머 멈추기')	;
				console.log('시작카운트 : '+startCount);
				console.log('종료카운트 : '+endCount);
				
				startCount++; // 답변 진행되면서 횟수 증가	
				$('#stopRecognizeOnceAsyncButton').trigger('click'); // 음성 스크립트 분석 종료
				
				
				clearInterval(tid);		// 타이머 해제
				clearInterval(aid);		// 10초마다 이미지 분석 종료
				
				download(); // 녹화 중지
				createAnswer(); // 마친 질문의 답변을 ajax로 보내는 메서드
				
				
				script = "다음 질문을 준비해주세요.";
				if(startCount>=endCount){ // 모든 질문을 출력 했을 경우
					download(); // 녹화 중지
					clearInterval(tid);		// 타이머 해제
					$('#voiceStop').trigger('click'); // 음성분석(데시벨,주파수) 종료
					clearInterval(aid);		// 10초마다 이미지 분석 종료
					
					script = "분석중입니다. 잠시만 기다려주세요"
					$('.message-balloon').text(script); // 모든질문 진행 후 분석하는 안내말 표시
					$('#time').hide();// 타이머 지우기
					$('.attention-message.shown').css("background-image", "");// 원 지우기
					$('.attention-message.shown').css("background-image", "url(/images/loading.16070af3.gif)"); // 원넣기
					$('.attention-message.shown').css("background-repeat", "no-repeat"); // 원넣기
					$('.attention-message.shown').css("margin-top", "200px"); // 마진
					$('.attention-message.shown').css("width", "600px"); // 로딩중 설정
					
					window.location.replace("/interview/end.do?interviewSq=${interviewSq}"); // 면접 종료시 이동하는 페이지
				}else{
					SetTime=0; // 타이머 시간 되돌리기
					answer=""; // 답변 내용 초기화
					$('.message-balloon').empty(); // 메세지 창 지우기
					$('#time').empty(); // 타이머 표시 지우기
					$('.message-balloon').text(script); // 다음질문 준비 표시
					$('.attention-message.shown').text('이곳을 주목해주세요!'); // 주목해주세요 표시
				}
			}
		});
		
		// space 경우
		$(document).keydown(function(event) {
			if(event.keyCode == 32){ // space
				if(SetTime == 0){ // 타이머 진행중이 아닐 경우
					script=$('.quest').eq(startCount).val(); // 면접 시작 지문 출력
					questSq=$('.quest').eq(startCount).data('sq');
					
					startFunction(); // 녹화 시작
					$('#startRecognizeOnceAsyncButton').trigger('click'); // 음성 스크립트 분석 시작 
					TimerStart(); // 타이머 시작
					analyzeStart(); // 10초마다 이미지 분석
					$('#voice').trigger('click'); // 음성분석(데시벨,주파수) 측정
						
					$('.next-question').html("다음 질문<br><div class='spacebar-area false'>SPACE BAR</div>"); // 다음 질문 출력
					$('.message-balloon').empty();
					$('.message-balloon').text(script);
					
					console.log('타이머 시작')				
					$('.attention-message.shown').text('');
				}else if(SetTime >= 15 ){ // 타이머 진행 중에서 space(질문 종료)15초 이후 
					console.log('타이머 멈추기')	;	
					console.log('시작카운트 : '+startCount);
					console.log('종료카운트 : '+endCount);
					console.log('최종 답변 스크립트 : ' + script);
					
					startCount++; // 답변 진행되면서 횟수 증가
					$('#stopRecognizeOnceAsyncButton').trigger('click'); // 음성 스크립트 분석 종료
					
					clearInterval(tid);		// 타이머 해제
					$('#voiceStop').trigger('click'); // 음성분석(데시벨,주파수) 종료
					clearInterval(aid);		// 10초마다 이미지 분석 종료
					
					
					download(); // 녹화 중지
					createAnswer(); // 마친 질문의 답변을 ajax로 보내는 메서드
					
					script = "다음 질문을 준비해주세요.";
					if(startCount>=endCount){ // 모든 질문을 출력 했을 경우
						download(); // 녹화 중지
						clearInterval(tid);		// 타이머 해제
						$('#voiceStop').trigger('click'); // 음성분석(데시벨,주파수) 종료
						clearInterval(aid);		// 10초마다 이미지 분석 종료
						
						script = "분석중입니다. 잠시만 기다려주세요"
						$('.message-balloon').text(script); // 모든질문 진행 후 분석하는 안내말 표시
						$('#time').hide();// 타이머 지우기
						$('.attention-message.shown').css("background-image", "");// 원 지우기
						$('.attention-message.shown').css("background-image", "url(/images/loading.16070af3.gif)"); // 원넣기
						$('.attention-message.shown').css("background-repeat", "no-repeat"); // 원넣기
						$('.attention-message.shown').css("margin-top", "200px"); // 마진
						$('.attention-message.shown').css("width", "600px"); // 로딩중 설정

						window.location.replace("/interview/end.do?interviewSq=${interviewSq}"); // 면접 종료시 이동하는 페이지
					}else{
						SetTime=0; // 타이머 시간 되돌리기
						answer=""; // 답변 내용 초기화
						$('.message-balloon').empty(); // 메세지 창 지우기
						$('#time').empty(); // 타이머 표시 지우기
						$('.message-balloon').text(script); // 다음질문 준비 표시
						$('.attention-message.shown').text('이곳을 주목해주세요!'); // 주목해주세요 표시
					}
				}
			}
		});
		
		// 음성 테스트
		$(document).on('click','#voice',function(){
			decibelSum = 0; // 데시벨 초기값
			frequencySum = 0; // 주파수초기값
			navigator.mediaDevices.getUserMedia({ audio: true, video: false })                                     
			.then(function(stream) {                                                                              
			  audioContext = new AudioContext();                                                                  
			  analyser = audioContext.createAnalyser();                                                           
			  microphone = audioContext.createMediaStreamSource(stream);                                          
			  javascriptNode = audioContext.createScriptProcessor(16384, 1, 1);                                    
			                                                                                                      
			  analyser.smoothingTimeConstant = 0.9;                                                               
			  analyser.fftSize = 32;                                                                            
			                                                                                                      
			  microphone.connect(analyser);                                                                       
			  analyser.connect(javascriptNode);                                                                   
			  javascriptNode.connect(audioContext.destination);    
			  
			  // 주파수 변수 선언
			  var getAverageVolume  =  function( array){
			      var length = array.length;
			      var values = 0;
			      var i = 0;
			     for (; i < length; i++) {
			        values += array[i];
			     }
			    return values / length;
			  }
			  
			  javascriptNode.onaudioprocess = function() {     
				  // 데시벨 변수 선언
			      var array = new Uint8Array(analyser.frequencyBinCount);                                         
			      analyser.getByteFrequencyData(array);                                                       
			      var values = 0;                                                                                 
			                                                                                                      
			      var length = array.length;                                                                      
			      for (var i = 0; i < length; i++) {                                                              
			    	  values += (array[i]);   
			      }          
			      average = values / length;    
					
			      decibelSum+=Math.round(20*Math.log10(Math.round(average+1)));
				  console.log('데시벨:'+Math.round(20*Math.log10(Math.round(average+1))));
				  
				  var decibelHtml = '<input type="text" name="voiceAnalysisVOLIst['+decibelIndex+'].voiceDecibel" value="'+Math.round(20*Math.log10(Math.round(average+1)))+'" >'
				  decibelIndex+=1;
				  $("#analysisData").append(decibelHtml);
				  
				  // 주파수 부분
				  var tempArray = new window.Uint8Array(analyser.frequencyBinCount);
				    analyser.getByteFrequencyData(tempArray);
				    var latestFrequency = (getAverageVolume(tempArray));
				    frequencySum+=latestFrequency;
				    console.log('주파수:' + Math.round(latestFrequency));
				    
				  var frequencyHtml = '<input type="text" name="voiceAnalysisVOLIst['+frequencyIndex+'].voiceRange" value="'+Math.round(latestFrequency)+'" >'
					frequencyIndex+=1;
					$("#analysisData").append(frequencyHtml);
			};
				  
		  // 음성 측정 멈추기
		  $('#voiceStop').on('click',function(){
				  console.log('음성 측정 종료')
					  javascriptNode.onaudioprocess = null;
			});
		});                                                                                                  
	});
});
</script>
</head>
<body style="overflow:"> <!-- 나중에 overflow hidden 해야함 -->
	<!-- 음성 script위한 부분 -->
	<div id="content" style="display:">
		<input type="button" id="voice" value="음성분석">
		<input type="button" id="voiceStop" value="음성분석종료">
		<table width="100%">
			<tr>
				<td align="right"><a
					href="https://docs.microsoft.com/azure/cognitive-services/speech-service/get-started"
					target="_blank">Subscription</a>:</td>
				<td><input id="subscriptionKey" type="text" size="40"
					value="8e1d8a815cd34bd4b7fee2b71344ef49"></td>
			</tr>
			<tr>
				<td align="right">Region</td>
				<td><input id="serviceRegion" type="text" size="40"
					value="koreacentral"></td>
			</tr>
			<tr>
				<td></td>
				<td>
					<button id="startRecognizeOnceAsyncButton">Startrecognition</button>
					<button id="stopRecognizeOnceAsyncButton">Stoprecognition</button>
				</td>
			</tr>
			<tr>
				<td align="right" valign="top">Results</td>
				<td><textarea id="phraseDiv"
						style="display: inline-block; width: 500px; height: 200px"></textarea></td>
			</tr>
		</table>
	</div>
	<!-- 여기까지 음성 스크립트 -->

	<!-- 웹캠부분 -->
	<div class="webcam" style="display: ">
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
	<!-- 여기까지 웹캠부분 -->

	<div id="root">
		<div class="Interview">
			<div class="FullButton" style="display: inline-block;"></div>
			
			<c:forEach var="quest" begin="0" end="${questionGoList.size()-1}">
				<input type="hidden" value='${questionGoList[quest].questContent}' data-sq='${questionGoList[quest].questSq}' class="quest" >
			</c:forEach>
			
			<div class="InterviewCircle" style="background-size: 500px 600px; z-index: 100">
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
					<div class="message-balloon"style="width: 650px;">
						<div>
							<div class="text-line false" >지금부터 면접을 시작하겠습니다. 최대 답변 시간은
								2분이며,</div>
							<div class="text-line false">질문을 잘 듣고 중앙의 원을 보며 차분하게 답변해
								주세요.</div>
							<div class="text-line false" style="color: red; font-weight: bold;">질문 시작 후 15초 이내에는 다음 질문으로 넘어갈 수 없습니다.</div>
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