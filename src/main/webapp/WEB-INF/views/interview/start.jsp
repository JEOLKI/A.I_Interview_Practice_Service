<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/layout/commonLib.jsp" %>
<script src="/js/capture.js"></script>
<script src="/js/microsoft.cognitiveservices.speech.sdk.bundle.js"></script>
<script type="text/javascript">
	var docV = document.documentElement;
	SetTime = 0; // 타이머 초기값(경과시간)
	startCount = 0; // 시작 카운트
	endCount = ${questionGoList.size()}; // 질문의 개수
	endTTS = false; // TTS종료 확인
	voiceCount = 0;
	keyCount = 0; // 중복 space 막기위함
	
	var tid;
	var aid;
    var average;
    script = ""; // 면접 질문 받는 변수
    questSq = 0;
    
  // 아래쪽 음성STT 추출 부분
    var phraseDiv;
    var startRecognizeOnceAsyncButton;
    var stopRecognizeOnceAsyncButton;
    var subscriptionKeySTT, serviceRegion;
    var authorizationToken;
    var SpeechSDK;
    var recognizer;
    answer = ""; // 대답을 모두 담는 변수
    
    document.addEventListener("DOMContentLoaded", function () {
 	startRecognizeOnceAsyncButton = document.getElementById("startRecognizeOnceAsyncButton");
 	stopRecognizeOnceAsyncButton = document.getElementById("stopRecognizeOnceAsyncButton");
 	subscriptionKeySTT = document.getElementById("subscriptionKeySTT");
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
      if (subscriptionKeySTT.value === "" || subscriptionKeySTT.value === "subscription") {
        alert("Please enter your Microsoft Cognitive Services Speech subscription key!");
        return;
      }
      speechConfig = SpeechSDK.SpeechConfig.fromSubscription(subscriptionKeySTT.value, serviceRegion.value);
    }

    speechConfig.speechRecognitionLanguage = "ko-KR";
    var audioConfig  = SpeechSDK.AudioConfig.fromDefaultMicrophoneInput();
    recognizer = new SpeechSDK.SpeechRecognizer(speechConfig, audioConfig);

    	
    recognizer.recognizing = (s, e) => {
    };
        
   	recognizer.recognized = (s, e) => { // 음성에서 스크립트 추출
   		editText = e.result.text.replace(/undefined/g,'');
   		//console.log('음성인식 : '+ editText);
   	
		//console.log(`RECOGNIZED: Text=${e.result.text}`);
	    phraseDiv.innerHTML += editText;
	    answer+=editText;
	    
 	   if (e.result.reason == ResultReason.RecognizedSpeech) {
    	}
    	else if (e.result.reason == ResultReason.NoMatch) {
    	   //console.log("NOMATCH: Speech could not be recognized.");
   	    }
   	};
    	
    recognizer.canceled = (s, e) => { // 중간취소
    	//console.log(`CANCELED: Reason=${e.reason}`);

  	    if (e.reason == CancellationReason.Error) {
  	        //console.log("CANCELED: ErrorCode=${e.errorCode}");
  	        //console.log("CANCELED: ErrorDetails='${e.errorDetails}'");
  	        //console.log("CANCELED: Did you update the subscription info?");
  	    }

  	    recognizer.stopContinuousRecognitionAsync();
  	};
   	recognizer.startContinuousRecognitionAsync();
  	
  	recognizer.sessionStopped = (s, e) => { // 세션 끊어짐
  	    //console.log("\n    Session stopped event.");
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
    var authorizationEndpoint = "tokenSTT.php";

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
            subscriptionKeySTT.disabled = true;
            subscriptionKeySTT.value = "using authorization token (hit F5 to refresh)";
            //console.log("Got an authorization token: " + token);
        }
      }
    }
	
// 	// 전체화면 설정
// 	function openFullScreenMode() {
// 	    if (docV.requestFullscreen){
// 	        docV.requestFullscreen();
// 	    }
// 	    else if (docV.webkitRequestFullscreen) // Chrome, Safari (webkit)
// 	        docV.webkitRequestFullscreen();
// 	    else if (docV.mozRequestFullScreen) // Firefox
// 	        docV.mozRequestFullScreen();
// 	    else if (docV.msRequestFullscreen) // IE or Edge
// 	        docV.msRequestFullscreen();
// 	}
	
// 	// 전체화면 해제
// 	function closeFullScreenMode() {
// 	    if (document.exitFullscreen)
// 	        document.exitFullscreen();
// 	    else if (document.webkitExitFullscreen) // Chrome, Safari (webkit)
// 	        document.webkitExitFullscreen();
// 	    else if (document.mozCancelFullScreen) // Firefox
// 	        document.mozCancelFullScreen();
// 	    else if (document.msExitFullscreen) // IE or Edge
// 	        document.msExitFullscreen();
// 	}
	
	// 2분 타이머 설정
	function timer(){
		SetTime++;					// 1초씩 증가
		if(SetTime%60<10){
			m = Math.floor(SetTime / 60) + ":" + "0"+(SetTime % 60) ;
		}else{
			m = Math.floor(SetTime / 60) + ":" +(SetTime % 60) ;
		}
		
		msg = "<br><br><br><font color='red' size='5px' style='z-index:200;'>REC</font><br>";  
		msg += "<font color='red' size='7px' style='z-index:200;'>" + '답변시간' + "</font><br>";
		msg += "<font color='black' size='15px' style='z-index:200;'>" + m + "</font>";
		
		document.all.time.innerHTML = msg;
		
		// 시간이 종료 되었으면..
		if (SetTime >= 120) {
			startCount++; // 답변 진행되면서 횟수 증가
			$('.next-question').html("다음 질문<br><div class='spacebar-area false'>SPACE BAR</div>"); // 다음 질문 출력
			$('#stopRecognizeOnceAsyncButton').trigger('click'); // 음성 스크립트 분석 종료
			
			clearInterval(tid);		// 타이머 해제
			$('#voiceStop').trigger('click'); // 음성분석(데시벨,주파수) 종료
			$('#pauseButton').trigger('click'); // 면접 질문 TTS 종료
			clearInterval(aid);		// 10초마다 이미지 분석 종료
			
			download(); // 녹화 중지
			createAnswer(); // 마친 질문의 답변을 ajax로 보내는 메서드
			$("#analysisData").empty(); // 비우기
			
		}else if(SetTime == 15){
			$('.next-question').html("답변 종료<br><div class='spacebar-area false'>SPACE BAR</div>"); // 답변 종료
		}
	}
	
	// 타이머 시작 
	function TimerStart(){ 
		tid=setInterval('timer()',1000);
	}
	
	// 분석을 매 10초마다 시작하는 메서드
	function analyzeStart(){
		aid=setInterval('processImage()',7000);
	}
	
	// 이미지 분석자료 보내기위한 변수
	var index = 0;

	// 이미지 분석
	function processImage() {
		$('.spacebar-area').attr('disabled', true); // 버튼 비활성화 설정
		var subscriptionKeyImg = "da4a2410258b4c45b4d2e3cdcac5eedb";
		var uriBase = "https://faceanalysis-jh.cognitiveservices.azure.com/face/v1.0/detect";
		// Request parameters.
		var params = {
			"detectionModel" : "detection_01",
			"returnFaceAttributes": "age,gender,headPose,smile,facialHair,glasses,emotion,hair,makeup,occlusion,accessories,blur,exposure,noise",
			"returnFaceId" : "true"
		};
		
		$('#startbutton').trigger('click'); // 영상 캡쳐
		
		var sourceImageUrl = document.getElementById("inputImage").value;
		document.querySelector("#sourceImage").src = sourceImageUrl;
		$.ajax({
				url : uriBase + "?" + $.param(params),
				processData: false,
				beforeSend : function(xhrObj) {
					xhrObj.setRequestHeader("Content-Type",
							"application/octet-stream");
					xhrObj.setRequestHeader(
							"Ocp-Apim-Subscription-Key",
							subscriptionKeyImg);
				},
				type : "POST",
				
				data : makeblob($('#inputImage').val()),
			})
	.done(
			function(data) {
				if(data[0]=== undefined || data[0] === null){ // 분석할 사진에 문제가 있을경우
					console.log('영상을 분석할 수 없습니다.')
				}else{
					emotion = data[0].faceAttributes.emotion;
					face = data[0].faceRectangle
					var html = '<input type="text" name="imageAnalysisVOList['+index+'].anger" value="'+emotion.anger+'" hidden >'
					html += '<input type="text" name="imageAnalysisVOList['+index+'].contempt" value="'+emotion.contempt+'" hidden>'
					html += '<input type="text" name="imageAnalysisVOList['+index+'].disgust" value="'+emotion.disgust+'" hidden>'
					html += '<input type="text" name="imageAnalysisVOList['+index+'].fear" value="'+emotion.fear+'" hidden>'
					html += '<input type="text" name="imageAnalysisVOList['+index+'].happiness" value="'+emotion.happiness+'" hidden>'
					html += '<input type="text" name="imageAnalysisVOList['+index+'].neutral" value="'+emotion.neutral+'" hidden>'
					html += '<input type="text" name="imageAnalysisVOList['+index+'].sadness" value="'+emotion.sadness+'" hidden>'
					html += '<input type="text" name="imageAnalysisVOList['+index+'].surprise" value="'+emotion.surprise+'" hidden>'
					html += '<input type="text" name="imageAnalysisVOList['+index+'].faceTop" value="'+face.top+'" hidden>'
					html += '<input type="text" name="imageAnalysisVOList['+index+'].faceLeft" value="'+face.left+'" hidden>'
					html += '<input type="text" name="imageAnalysisVOList['+index+'].faceHeight" value="'+face.height+'"hidden >'
					html += '<input type="text" name="imageAnalysisVOList['+index+'].faceWidth" value="'+face.width+'"hidden >'
					
					$("#analysisData").append(html);
					
					index += 1;
				}
				 
				$("#responseTextArea").val(JSON.stringify(data, null, 2));
				$('.spacebar-area').attr('disabled', false); // 버튼 비활성화 해제
				
			})
	.fail(
			function(jqXHR, textStatus, errorThrown) {
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
		keyCount = 1;
		$('.next-question').html(""); // 버튼 지우기
		script = "분석중입니다. 잠시만 기다려주세요"
		$('.message-balloon').text(script); // 모든질문 진행 후 분석하는 안내말 표시
		$('#time').empty();// 타이머 지우기
		$('.attention-message.shown').css("background-image", "");// 원 지우기
		$('.attention-message.shown').css("background-image", "url(/images/loading.16070af3.gif)"); // 원넣기
		$('.attention-message.shown').css("background-repeat", "no-repeat"); // 원넣기
		$('.attention-message.shown').css("margin-top", "230px"); // 마진
		$('.attention-message.shown').css("width", "600px"); // 로딩중 설정
		
		var form = $('#analysisData')[0]; // form안에 있는 input들의 모음
		var fd = new FormData(form); 
		ansContent = answer; // 해당 질문내용
		ansTime = SetTime; // 경과시간 입력
		if(ansContent == ""){
			ansSpeed = 0;
		}else{
			ansSpeed = (ansContent.length)/ansTime*60; // 말빠르기
		}
		
		fd.append('name', 'answerVideo'); // name지정
		fd.append("mtfRequest", blob); // 영상 데이터
		fd.append("ansContent", ansContent); // 대답 내용
		fd.append("ansTime", ansTime); // 대답시간(초)
		fd.append("ansSpeed", ansSpeed); // 대답 속도(대답내용 문자열수/대답시간)
		fd.append("questSq", questSq); // 대답의 시퀀스 
		
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
				
				if(startCount>=endCount){ // 모든 질문을 출력 했을 경우

					window.location.replace("/interview/end.do?interviewSq=${interviewSq}"); // 면접 종료시 이동하는 페이지
				}else{
					$('.next-question').html("다음 질문<br><div class='spacebar-area false'>SPACE BAR</div>"); // 다음 질문 출력
					$('.attention-message.shown').css("background-image", "");// 로딩 지우기
					$('.attention-message.shown').css("background-image", "url(/images/interview_circle.png)"); // 포커스원 넣기
					$('.attention-message.shown').css("background-repeat", "no-repeat"); // 원넣기
					$('.attention-message.shown').css("width", "400px"); // 로딩중 설정
					
					$("#analysisData").empty(); // 비우기
					script = "다음 질문을 준비해주세요.";
					SetTime=0; // 타이머 시간 되돌리기
					answer=""; // 답변 내용 초기화
					$('.message-balloon').empty(); // 메세지 창 지우기
					$('#time').empty(); // 타이머 표시 지우기
					$('.message-balloon').text(script); // 다음질문 준비 표시
					$('.attention-message.shown').html('<div id="attention">이곳을 주목해주세요!</div>'); // 주목해주세요 표시
					keyCount = 0;
				}
			},
			error : function(data){
				console.log(data.status);
				console.log(data);
				alert('오류가 발생 했습니다')
			}
		});
		blob = null; // blob 데이터 초기화
		recordedChunks=[]; // blob 데이터 초기화
		ansContent = "";
		return true;
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
	  
	  setTimeout(function() { URL.revokeObjectURL(url); }, 100); 
	}
	
	function interview(){
		if(SetTime == 0){ // 타이머 진행중이 아닐 경우
			$('#sampleVoice').get(0).pause(); // 안내 음성 중지
			script=$('.quest').eq(startCount).val(); // 면접 시작 지문 출력
			questSq=$('.quest').eq(startCount).data('sq'); // 질문 카운트에 맞는 시퀀스 가져오기
			
			$('.message-balloon').empty();
			$('.message-balloon').text(script); // 면접 질문 출력
			$('#synthesisText').val(script); // 면접 질문 옮기기
			$('.attention-message.shown').text('') // 주목 하는곳 비우기
			
			if(SetTime%60<10){ // 타이머 표시
				m = Math.floor(SetTime / 60) + ":" + "0"+(SetTime % 60) ;
				
			}else{
				m = Math.floor(SetTime / 60) + ":" +(SetTime % 60) ;
			}
			msg = "<br><br><br><font color='red' size='5px' style='z-index:200;'>REC</font><br>";  
			msg += "<font color='red' size='7px' style='z-index:200;'>" + '답변시간' + "</font><br>";
			msg += "<font color='black' size='15px' style='z-index:200;'>" + m + "</font>";
			
			document.all.time.innerHTML = msg;
			
			
			$('#startSynthesisAsyncButton').trigger('click'); // 면접 질문 TTS 시작
		}else if(SetTime >= 15 ){ // 타이머 진행 중에서 space(질문 종료)15초 이후 
			startCount++; // 답변 진행되면서 횟수 증가
			$('.next-question').html("다음 질문<br><div class='spacebar-area false'>SPACE BAR</div>"); // 다음 질문 출력
			$('#stopRecognizeOnceAsyncButton').trigger('click'); // 음성 스크립트 분석 종료
			
			clearInterval(tid);		// 타이머 해제
			$('#voiceStop').trigger('click'); // 음성분석(데시벨,주파수) 종료
			$('#pauseButton').trigger('click'); // 면접 질문 TTS 종료
			clearInterval(aid);		// 10초마다 이미지 분석 종료
			
			
			download(); // 녹화 중지
			createAnswer(); // 마친 질문의 답변을 ajax로 보내는 메서드
			$("#analysisData").empty(); // 비우기
			
			script = "다음 질문을 준비해주세요.";
		}
	}
	
	// jquery
	$(document).ready(function(){
		 // 클릭의 경우
		$(document).on('click','.spacebar-area.false',function(){
			interview();
		});
		
		// space 경우
		$(document).keyup(function(event) {
			if(event.keyCode == 32){ // space
				if(keyCount == 0){
					interview();
				}
			}
		});
		
		// 음성 테스트
		$(document).on('click','#voice',function(){
			var voiceIndex = 0; // 데시벨 인덱스
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
				  
				  // 주파수 부분
				  var tempArray = new window.Uint8Array(analyser.frequencyBinCount);
				    analyser.getByteFrequencyData(tempArray);
				    var latestFrequency = (getAverageVolume(tempArray));
				    frequencySum+=latestFrequency;
				    
				  var voiceHtml = '<input type="text" name="voiceAnalysisVOLIst['+voiceIndex+'].voiceDecibel" value="'+Math.round(20*Math.log10(Math.round(average+1)))+'" hidden>'
				  voiceHtml += '<input type="text" name="voiceAnalysisVOLIst['+voiceIndex+'].voiceRange" value="'+Math.round(latestFrequency)+'" hidden>';
				  voiceIndex+=1;
				  
				  $("#analysisData").append(voiceHtml);
			};
				  
		  // 음성 측정 멈추기
		  $('#voiceStop').on('click',function(){
				  //console.log('음성 측정 종료')
					  javascriptNode.onaudioprocess = null;
			});
		});                                                                                                  
	});
});

/* 아래부터 TTS */
  var authorizationEndpoint = "tokenTTS.php";

  function RequestAuthorizationToken() {
    if (authorizationEndpoint) {
      var a = new XMLHttpRequest();
      a.open("GET", authorizationEndpoint);
      a.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
      a.send("");
      a.onload = function() {
          var token = JSON.parse(atob(this.responseText.split(".")[1]));
          regionOptions.value = token.region;
          authorizationToken = this.responseText;
          subscriptionKeyTTS.disabled = true;
          subscriptionKeyTTS.value = "using authorization token (hit F5 to refresh)";
          //console.log("Got an authorization token: " + token);
      }
    }
  }
  // TTS 최초 진입 시 설정
  function Initialize(onComplete) {
    if (!!window.SpeechSDK) {
      onComplete(window.SpeechSDK);
    }
  }
  // TTS 버튼 설정
  var resultsDiv, eventsDiv;
  var highlightDiv;
  var startSynthesisAsyncButton, pauseButton, resumeButton;
  var updateVoiceListButton;
  var subscriptionKeyTTS, regionOptions;
  var authorizationToken;
  var voiceOptions, isSsml;
  var SpeechSDK;
  var synthesisText;
  var synthesizer;
  var player;
  var wordBoundaryList = [];

  // 음성 TTS
  document.addEventListener("DOMContentLoaded", function () {
    startSynthesisAsyncButton = document.getElementById("startSynthesisAsyncButton");
    updateVoiceListButton = document.getElementById("updateVoiceListButton");
    pauseButton = document.getElementById("pauseButton");
    resumeButton = document.getElementById("resumeButton");
    subscriptionKeyTTS = document.getElementById("subscriptionKeyTTS");
    regionOptions = document.getElementById("regionOptions");
    resultsDiv = document.getElementById("resultsDiv");
    eventsDiv = document.getElementById("eventsDiv");
    voiceOptions = document.getElementById("voiceOptions");
    isSsml = document.getElementById("isSSML");
    highlightDiv = document.getElementById("highlightDiv");

    setInterval(function () {
      if (player !== undefined) {
        const currentTime = player.currentTime;
        var wordBoundary;
        for (const e of wordBoundaryList) {
          if (currentTime * 1000 > e.audioOffset / 10000) {
            wordBoundary = e;
          } else {
            break;
          }
        }
        if (wordBoundary !== undefined) {
          highlightDiv.innerHTML = synthesisText.value.substr(0, wordBoundary.textOffset) +
                  "<span class='highlight'>" + wordBoundary.text + "</span>" +
                  synthesisText.value.substr(wordBoundary.textOffset + wordBoundary.wordLength);
        } else {
          highlightDiv.innerHTML = synthesisText.value;
        }
      }
    }, 50);

    // 일시정지
    pauseButton.addEventListener("click", function () {
      player.pause();
      pauseButton.disabled = true;
      resumeButton.disabled = false;
    });

    // 다시 복귀
    resumeButton.addEventListener("click", function () {
      player.resume();
      pauseButton.disabled = false;
      resumeButton.disabled = true;
    });

    // 시작버튼
    startSynthesisAsyncButton.addEventListener("click", function () {
	$('.next-question.shown').html(''); //버튼 내용 변경
      resultsDiv.innerHTML = "";
      eventsDiv.innerHTML = "";
      wordBoundaryList = [];
      synthesisText = document.getElementById("synthesisText");

      var speechConfig;
      if (authorizationToken) {
        speechConfig = SpeechSDK.SpeechConfig.fromAuthorizationToken(authorizationToken, regionOptions.value);
      } else {
        if (subscriptionKeyTTS.value === "" || subscriptionKeyTTS.value === "subscription") {
          alert("Please enter your Microsoft Cognitive Services Speech subscription key!");
          return;
        }
        speechConfig = SpeechSDK.SpeechConfig.fromSubscription(subscriptionKeyTTS.value, regionOptions.value);
      }

      speechConfig.speechSynthesisVoiceName = voiceOptions.value;

      player = new SpeechSDK.SpeakerAudioDestination();
      player.onAudioEnd = function (_) {
        window.console.log("playback finished");
        eventsDiv.innerHTML += "playback finished" + "\r\n";
        startSynthesisAsyncButton.disabled = false;
        pauseButton.disabled = true;
        resumeButton.disabled = true;
        wordBoundaryList = [];
        
		TimerStart(); // 타이머 시작
        startFunction(); // 녹화 시작
		$('#startRecognizeOnceAsyncButton').trigger('click'); // 음성 스크립트 분석 시작 
		analyzeStart(); // 10초마다 이미지 분석
		$('#voice').trigger('click'); // 음성분석(데시벨,주파수) 측정
      };

      var audioConfig  = SpeechSDK.AudioConfig.fromSpeakerOutput(player);

      synthesizer = new SpeechSDK.SpeechSynthesizer(speechConfig, audioConfig);

      synthesizer.synthesizing = function (s, e) {
        window.console.log(e);
        eventsDiv.innerHTML += "(synthesizing) Reason: " + SpeechSDK.ResultReason[e.result.reason] +
                "Audio chunk length: " + e.result.audioData.byteLength + "\r\n";
      };

      synthesizer.synthesisStarted = function (s, e) {
        window.console.log(e);
        eventsDiv.innerHTML += "(synthesis started)" + "\r\n";
        pauseButton.disabled = false;
      };

      // TTS 모두 출력 function
      synthesizer.synthesisCompleted = function (s, e) {
        console.log(e);
        eventsDiv.innerHTML += "(synthesized)  Reason: " + SpeechSDK.ResultReason[e.result.reason] +
                " Audio length: " + e.result.audioData.byteLength + "\r\n";
      };

      synthesizer.SynthesisCanceled = function (s, e) {
        const cancellationDetails = SpeechSDK.CancellationDetails.fromResult(e.result);
        let str = "(cancel) Reason: " + SpeechSDK.CancellationReason[cancellationDetails.reason];
        if (cancellationDetails.reason === SpeechSDK.CancellationReason.Error) {
          str += ": " + e.result.errorDetails;
        }
        window.console.log(e);
        eventsDiv.innerHTML += str + "\r\n";
        startSynthesisAsyncButton.disabled = false;
        pauseButton.disabled = true;
        resumeButton.disabled = true;
      };

      synthesizer.wordBoundary = function (s, e) {
        window.console.log(e);
        eventsDiv.innerHTML += "(WordBoundary), Text: " + e.text + ", Audio offset: " + e.audioOffset / 10000 + "ms." + "\r\n";
        wordBoundaryList.push(e);
      };

      const complete_cb = function (result) {
        if (result.reason === SpeechSDK.ResultReason.SynthesizingAudioCompleted) {
          resultsDiv.innerHTML += "synthesis finished";
        } else if (result.reason === SpeechSDK.ResultReason.Canceled) {
          resultsDiv.innerHTML += "synthesis failed. Error detail: " + result.errorDetails;
        }
        window.console.log(result);
        synthesizer.close();
        synthesizer = undefined;
      };
      const err_cb = function (err) {
        startSynthesisAsyncButton.disabled = false;
        phraseDiv.innerHTML += err;
        window.console.log(err);
        synthesizer.close();
        synthesizer = undefined;
      };
      if (isSsml.checked) {
        synthesizer.speakSsmlAsync(synthesisText.value,
                complete_cb,
                err_cb);
      } else {
        synthesizer.speakTextAsync(synthesisText.value,
                complete_cb,
                err_cb);
      }
    });

    // 최초 진입 시
    Initialize(function (speechSdk) {
      SpeechSDK = speechSdk;
      startSynthesisAsyncButton.disabled = false;
      pauseButton.disabled = true;
      resumeButton.disabled = true;

      if (typeof RequestAuthorizationToken === "function") {
        RequestAuthorizationToken();
      }
    });
  });
</script>
<style type="text/css">
#video{
    transform: rotateY(180deg);
    -webkit-transform:rotateY(180deg); /* Safari and Chrome */
    -moz-transform:rotateY(180deg); /* Firefox */
}
.attention-message.shown{
	position:relative;
	display: table; 
	margin-left: auto; 
	margin-right: auto; 
	width: 400px; 
	height: 400px; 
	background-size:100% ;
	padding-top : 0px;
	margin-top : 230px;
}
#attention{
	display: table-cell; 
  	vertical-align: middle;
}
#InterviewCircle{
	background-size: 500px 600px;
	z-index: 100;
	height: 550px;
}
#InterviewInterface{
	margin : -135px auto 0;
}
.Interview{
	position:absolute;
	top : 0;
}
</style>
</head>
<body style="overflow:hidden"> <!-- 나중에 overflow hidden 해야함 -->
	<!-- TTS부분 -->
	<div id="content" style="display:none">
	  <table>
	    <tr>
	      <td align="right">
	        <label for="subscriptionKey">
	          <a href="https://docs.microsoft.com/azure/cognitive-services/speech-service/get-started"
	             rel="noreferrer noopener"
	             target="_blank">Subscription Key</a>
	        </label>
	      </td>
	      <td><input id="subscriptionKeyTTS" type="text" size="40" value="0f67885dec4146beac75e32a4fb9e18c"></td>
	    </tr>
	    <tr>
	      <td align="right"><label for="regionOptions">Region</label></td>
	      <td>
	        <select id="regionOptions">
	          <option value="southeastasia">South East Asia</option>
	        </select>
	      </td>
	    </tr>
	    <tr>
	      <td align="right"><label >Voice</label></td>
	      <td>
	        <button id="updateVoiceListButton">Update Voice List</button>
	        <select id="voiceOptions">
	          <option value="Microsoft Server Speech Text to Speech Voice (ko-KR, SunHiNeural)">Microsoft Server Speech Text to Speech Voice (ko-KR, SunHiNeural)</option>
	          <option value="Microsoft Server Speech Text to Speech Voice (ko-KR, InJoonNeural)">Microsoft Server Speech Text to Speech Voice (ko-KR, InJoonNeural)</option>
	        </select>
	      </td>
	    </tr>
	    <tr>
	      <td align="right"><label for="isSSML">Is SSML</label><br></td>
	      <td>
	        <input type="checkbox" id="isSSML" name="isSSML" value="ssml">
	      </td>
	    </tr>
	    <tr>
	      <td align="right"><label for="synthesisText">Text</label></td>
	      <td>
	        <textarea id="synthesisText" style="display: inline-block;width:500px;height:100px"
	               placeholder="Input text or ssml for synthesis."></textarea>
	      </td>
	    </tr>
	    <tr>
	      <td></td>
	      <td>
	        <button id="startSynthesisAsyncButton">Start synthesis</button>
	        <button id="pauseButton">Pause</button>
	        <button id="resumeButton">Resume</button>
	      </td>
	    </tr>
	    <tr>
	      <td align="right" valign="top"><label for="resultsDiv">Results</label></td>
	      <td><textarea id="resultsDiv" readonly style="display: inline-block;width:500px;height:50px"></textarea></td>
	    </tr>
	    <tr>
	      <td align="right" valign="top"><label for="eventsDiv">Events</label></td>
	      <td><textarea id="eventsDiv" readonly style="display: inline-block;width:500px;height:200px"></textarea></td>
	    </tr>
	    <tr>
	      <td align="right" valign="top"><label for="highlightDiv">Highlight</label></td>
	      <td><div id="highlightDiv" style="display: inline-block;width:800px;"></div></td>
	    </tr>
	  </table>
	</div>
	<!-- TTS부분 -->
	
	<!-- 음성 STT위한 부분 -->
	<div id="content" style="display:none">
		<input type="button" id="voice" value="음성분석">
		<input type="button" id="voiceStop" value="음성분석종료">
		<table width="100%">
			<tr>
				<td align="right"><a
					href="https://docs.microsoft.com/azure/cognitive-services/speech-service/get-started"
					target="_blank">Subscription</a>:</td>
				<td><input id="subscriptionKeySTT" type="text" size="40"
					value="f50fc9d261a145018ed9746991d094db"></td>
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
	<div class="webcam" style="display:">
		<div class="contentarea">
			<div class="camera">
				<video id="video" autoplay muted>Video stream not available.</video>
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
			<div class="InterviewCircle" id="InterviewCircle">
				<img src="/images/bg.355cdfd9.png" alt="" class="bg">
				<div class="attention-message shown" id="time" style="background-image: url('/images/interview_circle.png');" >
					<div id="attention">이곳을 주목해주세요!</div>
				</div>
				<audio id="sampleVoice" src="/media/interview_guide_audio.5680f6cc.mp3"	autoplay=""></audio>
				<div class="MovingCircle circle false">
					<canvas width="600" height="600"></canvas>
				</div>
			</div>
			<div class="InterviewInterface" id="InterviewInterface">
				<div class="question-message shown">
					<div class="message-balloon" style="width: 650px;">
						<div>
							<div class="text-line false" >지금부터 면접을 시작하겠습니다. 최대 답변 시간은
								2분이며,</div>
							<div class="text-line false">질문을 잘 듣고 중앙의 원을 보며 차분하게 답변해
								주세요.</div>
							<div class="text-line false" style="color: #ff5d5d; font-weight: bold;">질문 시작 후 15초 이내에는 다음 질문으로 넘어갈 수 없습니다.</div>
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
</body>
</html>