<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>AI_INTERVIEW</title>
<script src="/js/microsoft.cognitiveservices.speech.sdk.bundle-min.js"></script>
<script src="/js/microsoft.cognitiveservices.speech.sdk.bundle.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">

<%@ include file="/WEB-INF/views/layout/commonLib.jsp"%>

<style>
blink {
  animation: 1s linear infinite condemned_blink_effect;
}

@-webkit-keyframes condemned_blink_effect {
  0% {  visibility: hidden; }
  50% {  visibility: hidden; }
  100% { visibility: visible; }
}

@keyframes condemned_blink_effect {
  0% { visibility: hidden; }
  50% { visibility: hidden; }
  100% { visibility: visible; }
}

</style>
<script type="text/javascript" language="javascript">
    scriptGbContent='';
    scriptGbSq = 0;
    window.onload = function(){
	    window.resizeTo(480,620);
    }
	
$(document).ready(function() {
	
	$('#endTestBtn').css("display", "none");
	$('#resultBtn').css('display','none');
	$('#result').css('display','none');
	$('.present').css("display","none");
	
	// 언어선택
	$('.scriptGbBtn').on('click', function() {
		$('#title').css('display','none');
		
		
		$('#help').css('display','none');			// 첫 안내 페이지 안보이기
		$('#result').css('display','none');			// 결과 페이지 안보이기
		$('#play').css('display','');				// 테스트 진행 페이지 보이기
		$('#endTestBtn').css('display','none');		// 완료 버튼 안보이기
		$('.scriptContent').empty();				// 테스트할 스크립트란 비우기
		
		scriptGbContent = $(this).data('content');
		scriptGbSq = $(this).data('sq');
		
		if(scriptGbSq == 0){
			$('#play').hide();
		}else{
			$('#play').show();
		}
		
		startRecognizeOnceAsyncButton.disabled = false;
		$("#testResult").empty();
		$('#startTestBtn').show();
	});
	
	// 결과보기 버튼 클릭 시
	$('#resultBtn').on('click',function(){
		$('#help').css('display','none');
		$('#play').css('display','none');
		$('#result').css('display','');
		$('.guide.test').html('');

		$.ajax(
			{url:"/scriptTest/create.do",
			data : {"resultScript" : resultScript,
					"scriptSq" : scriptSq},
			type : "post",
			success : function(data){
				performScript = data.performScript;
				differentArr = data.differentArr;
				scriptArr = performScript.split(' ');
				html = "";
				if(scriptArr>1){
					for(var i =0; i<scriptArr.length; i++){
						if(scriptArr[i] == differentArr[i]){
							html += '<span style="color:#FF4646;">'+scriptArr[i]+'&nbsp</span>';
						} else{
							html += scriptArr[i]+"&nbsp";
						}
					}
				} else {
					$('.guide.result').html('어떤 이유로 인해 측정에 실패했습니다 :(<br>혹시 마이크에 문제가 있는 건 아닌지 확인해 보세요!').css('fontSize','0.85em');
				}
				
				$('.scriptContent').html(html);

				testScore = data.result;
				var ctx = document.getElementById('scoreChart');
				createScoreChart(ctx, testScore);
				
				scoreText = "";
				if(testScore < 10){
					scoreText += '<span>일치율</span><br><b>&ensp;&nbsp;'+testScore+'</b>%';
				} else if(testScore < 100){
					scoreText += '<span>일치율</span><br><b>&nbsp;'+testScore+'</b>%';
				} else{
					scoreText += '<span>일치율</span><br><b>'+testScore+'</b>%';
				}
				$('.scoreText').html(scoreText);
			},
			error : function(data){
				console.log(data.status);
			}
		});
	})
	
	// 다시 테스트하기 버튼 클릭 시
	$('#retryBtn').on('click',function(){
		$('#help').css('display','none');		// 첫 안내페이지 안보이기
		$('#result').css('display','none');		// 결과 페이지 안보이기
		$('#play').css('display','');			// 테스트 진행 페이지 보이기
		$('#resultBtn').css('display','none');	// 결과 버튼 안보이기
		$('#endTestBtn').css('display','none');	// 완료 버튼 안보이기
		$('#startTestBtn').css('display','');	// 시작 버튼 보이기
		$('.scriptContent').empty();			// 테스트할 스크립트란 비우기
		$('.guide.test').val('시작 버튼을 눌러주세요.');
	})
});

var startRecognizeOnceAsyncButton;
var SpeechSDK = window.SpeechSDK;
var recognizer;
var audioConfig;
var subscriptionKey;
var serviceRegion;	 
var scriptGbSq;
var resultScript = "";
document.addEventListener("DOMContentLoaded", function () {
	startRecognizeOnceAsyncButton = document.getElementById("startTestBtn");
	subscriptionKey = document.getElementById("subscriptionKey");
	serviceRegion = document.getElementById("serviceRegion");


startRecognizeOnceAsyncButton.addEventListener("click", function () {
	$('#startTestBtn').css("display","none");
	$('#endTestBtn').css("display", "");
	$('.guide.test').html('읽기를 마친 후 완료버튼을 눌러주세요.');
	 
	
	// 랜덤 지문 출력
	$.ajax(
		{url:"/scriptTest/retrieveScriptList.do",
		data : {scriptGbSq : scriptGbSq},
		method : "post",
		success : function(data){
  				$('.scriptContent').html(data.scriptVO.scriptContent);
  				$('#synthesisText').val(data.scriptVO.scriptContent);
  				scriptSq = data.scriptVO.scriptSq;
  				if(data.scriptGbContent == '영어'){
  					 $('#voiceOptions>.ko-KR').remove(); // #voiceOptions태그의 .ko-KR 클래스만 제거
  				}else if(data.scriptGbContent == '한국어'){
  					 $('#voiceOptions>.en-US').remove(); // #voiceOptions태그의 .en-US 클래스만 제거
  				}
		},
		error: function(data){
			$('#scriptModalContent').html('해당하는 스크립트가 없습니다.');
		}
	});
	if (subscriptionKey == "" || subscriptionKey == "subscription") {
       return;
	};
		      
	  var speechConfig = SpeechSDK.SpeechConfig.fromSubscription("7ec161e7215b4f0e9a153abcdfa1f815", "koreacentral");
   	  audioConfig = SpeechSDK.AudioConfig.fromDefaultMicrophoneInput();
    	  
    	  function colorGage(vol) {                                                                             
           let fullgage = $('.volume').width();                                                                       
           let presentVol = Math.round(vol)*2;                                                         
           let voluemGage = $('.present').css({"width":presentVol, "display" : ""});                                             
         }      
    	  
    	  navigator.mediaDevices.getUserMedia({ audio: true })                                     
          .then(function(stream) {                                                                              
            var audioContext = new AudioContext();                                                                  
            var analyser = audioContext.createAnalyser();                                                           
            var microphone = audioContext.createMediaStreamSource(stream);                                          
            var javascriptNode = audioContext.createScriptProcessor(2048, 1, 1);                                    
                                                                                                                
            analyser.smoothingTimeConstant = 0.9;                                                               
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
                                                                                                                
              colorGage(average);                                                                               
            }
            
        	// 마이크 볼륨그리기 중지
     		 endTestBtn.onclick = function() {
	   			$('.present').css("display","none");  
	   			$('#endTestBtn').css('display','none');
	   			$('#resultBtn').css('display','');
	   			$('.guide.test').html('');
	   		 	audioContext.close().then(function() {
	   			})
   			 } 
          })
   	  	    if(scriptGbContent ==''){
   	  	    	$('.scriptContent').html('<span style="color:#FF4646;">테스트 진행을 위해<br>상단 탭의 언어를 선택해주세요!</span>');
   	  	    	return false;
   	  	    } else if(scriptGbContent=="한국어"){
	 	    	speechConfig.speechRecognitionLanguage = "ko-KR";
   	  	    } else if(scriptGbContent=="영어"){
   	  	    	speechConfig.speechRecognitionLanguage = "en-US";
   	  	    }else{
   	  	    	speechConfig.speechRecognitionLanguage = "ko-KR";
   	  	    }
    	  	    
	    	recognizer = new SpeechSDK.SpeechRecognizer(speechConfig, audioConfig);
          
          recognizer.recognizing = (s, e) => {
  	
	  	console.log(`RECOGNIZING: Text=${e.result.text}`);
	    };
	        
	   	recognizer.recognized = (s, e) => { // 음성에서 스크립트 추출
	   		editText = e.result.text.replace(/undefined/g,'');
	   		console.log('음성인식 : '+ editText);
	   	
			console.log(`RECOGNIZED: Text=${e.result.text}`);
			resultScript+=editText;
			
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
   
	//음성 스탑버튼 클릭 시 
	endTestBtn.addEventListener("click", function () {
		startRecognizeOnceAsyncButton.disabled = false;
	   	recognizer.stopContinuousRecognitionAsync();
	});
});

//테스트 완료 시 ScriptTest 생성하는 ajax
function createScriptTest(resultScript, scriptSq){
	
	$.ajax(
		{url:"/scriptTest/create.do",
		data : {"resultScript" : resultScript,
				"scriptSq" : scriptSq},
		type : "post",
		success : function(data){
			testScore = data.result;
			resultScript = data.performScript;
		},
		error : function(data){
			console.log(data.status);
		}
	});
};
/* 스코어 차트 */
function createScoreChart(ctx, testScore){

	var scoreChart = new Chart(ctx, {
		type: 'doughnut',
		data: {
			datasets: [{
				data: [testScore, 100-testScore],
				backgroundColor: [
					'rgba(71,65,243, 1)',
					'rgba(234, 234, 234, 1)'
				],
				borderWidth: 0,
			}]
		},
		options: {
			responsive: false,
			scales: {
			},
			circumference :Math.PI,
			cutoutPercentage: 90,
			rotation : Math.PI,
			tooltips: {enabled: false},
		    hover: {mode: null}
		}
	});
	
}
/* 아래부터 TTS */
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
  voiceOptions = document.getElementById("voiceOptions");
  isSsml = document.getElementById("isSSML");

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
                "<span class='highlight'>" + wordBoundary.text + "</span>" +
                synthesisText.value.substr(wordBoundary.textOffset + wordBoundary.wordLength);
      } else {
      }
    }
  }, 50);


  // 시작버튼
  startSynthesisAsyncButton.addEventListener("click", function () {
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
      startSynthesisAsyncButton.disabled = false;
      wordBoundaryList = [];
      
    };

    var audioConfig  = SpeechSDK.AudioConfig.fromSpeakerOutput(player);

    synthesizer = new SpeechSDK.SpeechSynthesizer(speechConfig, audioConfig);

    synthesizer.synthesizing = function (s, e) {
      window.console.log(e);
    };

    synthesizer.synthesisStarted = function (s, e) {
      window.console.log(e);
    };

    // TTS 모두 출력 function
    synthesizer.synthesisCompleted = function (s, e) {
      console.log(e);
    };

    synthesizer.SynthesisCanceled = function (s, e) {
      const cancellationDetails = SpeechSDK.CancellationDetails.fromResult(e.result);
      let str = "(cancel) Reason: " + SpeechSDK.CancellationReason[cancellationDetails.reason];
      if (cancellationDetails.reason === SpeechSDK.CancellationReason.Error) {
        str += ": " + e.result.errorDetails;
      }
      window.console.log(e);
      startSynthesisAsyncButton.disabled = false;
    };

    synthesizer.wordBoundary = function (s, e) {
      window.console.log(e);
      wordBoundaryList.push(e);
    };

    const complete_cb = function (result) {
      if (result.reason === SpeechSDK.ResultReason.SynthesizingAudioCompleted) {
      } else if (result.reason === SpeechSDK.ResultReason.Canceled) {
      }
      window.console.log(result);
      synthesizer.close();
      synthesizer = undefined;
    };
    const err_cb = function (err) {
      startSynthesisAsyncButton.disabled = false;
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

    if (typeof RequestAuthorizationToken === "function") {
      RequestAuthorizationToken();
    }
  });
});
</script>

<style>

	body{
		background-color : #f5f7fb;
	}

	#phraseDiv, #scriptModalContent {
		text-align: center;
		border: 1px solid black;
		border-radius: 5px;
		height: 65px;
		width: 94%;
	    vertical-align: middle;
	    justify-content: center;
		margin-top: 5px;
		margin-left: 3%;
	}
	#phraseDiv>span, #scriptModalContent>span{
		position: relative;
	    top: 20%;
	    transform: translateY(-20%);
	}
	.popup-title, .popup-content {
		text-align: center;
	}
	
	.popup-close-box {
		text-align: center;
		margin-right: 10px;
	}
	
	.pro {
		margin: 10px;
		height: 50%;
	}
	
	.menuSelect {
		margin-right: 10px;
		padding : 10px;
	}
	
	.processBtn {
		text-align: center;
		margin-right: 10px;
		padding : 10px;
	}
	
	.informLbl{
		margin-top: 30px;
		font-weight: normal;
	}

	html {
		overflow:hidden;
	}

	.contentBox{
		width: 93%;
		padding: 20px 30px;
		background-color: white;
		border-radius: 10px;
		margin: 10px 3%;
		box-shadow: 5px 5px #EAEAEA;
		display: inline-block;
	}
	
	#title{
		font-weight: bold; 
		font-size: 23px; 
		margin-bottom: 40px; 
		display: block; 
		text-align: center;
	}
	
	.listenBtn{
		display: inline-block;
	    height: 35px;
	    background-color: #24468A;
	    color: white;
	    font-size : 0.9em;
	    text-align: center;
	    padding-top: 6px;
	    border-radius: 16px;
	    padding: 6.5px 10px;
        margin: 5px 15px;
	}
	
	.scriptBox{
		width: 95%;
		height: 200px;
		background-color: #f5f7fb;
		border-radius: 10px;
		padding: 20px 30px;
		margin: 10px 3%;
		text-align: center;
	}
	
	.scriptContent{
		font-weight: bold;
		font-size : 1.3em;
		color: #35356C;
	}
	
	.resultScriptBox{
		width: 95%;
		height: 170px;
		background-color: #f5f7fb;
		border-radius: 10px;
		padding: 20px 30px;
		margin: 10px 3%;
		text-align: center;
	}
	
	.processBtn{
		width: 95%;
		border-radius: 5px;
		font-size : 12pt;
		background: #3b3b46;
		color: #fff;
		margin: 10px 3%;
	}
	
	.processBtn:hover{
	    background-color: white;
	    color: #000d22;
	}
	
	.guide{
		display : inline-block;
		font-size: 0.9em;
		color: #35356C; 
		margin: 5px 0px;
	}
	
	.test{
		text-align: center;
	}
	
	.volume{
		border-radius: 16px;
		padding: 6px;
	    display: inline-block;
	    width: 70%;
	    margin: 7.5% 15%;
	    background-color: #FFBEBE;
	}
	
	.present{
		margin : 0% 15%;
		border-radius: 16px;
		padding: 6px;
	    display: inline-block;
	    background-color: #FF4646;
        position: relative;
  	 	bottom: 40px;
	}
	
	#scoreChart{
	    margin: 10px auto;
	}
	
	.scoreText{
		width: 105px;
	    margin: 85px auto 0;
	    padding-left: 10px;
	    text-align: left;
	    letter-spacing: -.4px;
	    position: relative;
	    bottom: 170px;
	    color: #4741F3;
	}
	
	b{
		font-size: 50px;
	}
	
	.score{
		height: 170px;
	}
</style>
</head>

<body>

	<div class="contentBox">
		<span id="title">발음 테스트</span>	
		<div class="pro" style="font-size:13px;">
			<ul class="nav nav-tabs">
				<c:forEach items="${scriptGbList }" var="scriptGb">
						<li class="selectLang">
				    		<a class="scriptGbBtn" data-content="${scriptGb.scriptGbContent }" data-toggle="tab" data-sq="${scriptGb.scriptGbSq }" aria-expanded="false">${scriptGb.scriptGbContent }</a>
							<input type="hidden" id="scriptGbSq" name="scritGbSq" value="${scriptGb.scriptGbSq }">
					   	</li>
				</c:forEach>
			</ul>
		</div>
		
		<div id="help">
			<div class="popup-content">
				<div>
					<img src="/images/speak.svg" style="width: 50%;">
				</div>
				<div style=" margin-top: 40px; font-size: 17px;">
					테스트할 언어를 선택 후 시작하기 버튼을<br>
					클릭하여 출력된 문장을 읽어주세요.<br><br>
				</div>
			</div>
		</div>

		
		<div id="play" style="display: none;">
			<span class="listenBtn" id="startSynthesisAsyncButton">발음 듣기</span>
			<div class="scriptBox">
				<p class="guide script">문장을 정확하게 소리내어 읽어보세요.</p>
				<br><br>
				<p class="scriptContent"></p>
			</div>	
			<div class="volume"></div>
			<div class="volume present"></div>
			<div class="test">
				<p class="guide test">시작 버튼을 눌러주세요.</p>
				<button class="processBtn" id="startTestBtn">시작</button>
				<button class="processBtn" id="endTestBtn">완료</button>
				<button class="processBtn" id="resultBtn">결과 보기</button>
				<input id="subscriptionKey" type="hidden" value="7ec161e7215b4f0e9a153abcdfa1f815"> 
				<input id="serviceRegion" type="hidden" value="koreacentral">
			</div>
		</div>
		
		<div id="result">
			<div class="score">
				<canvas class="chart" id="scoreChart"></canvas>
				<div class="scoreText"></div>
			</div>
			<div class="resultScriptBox">
				<p class="guide result">붉은색으로 표시된 부분이 일치하지 않습니다.</p>
				<br><br>
				<p class="scriptContent"></p>
			</div>
			<button class="processBtn" id="retryBtn">다시 테스트하기</button>
		</div>
	</div>
	<!-- TTS부분 -->
	<div id="tts" style="display:none">
	  <table>
	    <tr>
	      <td align="right">
	        <label for="subscriptionKey">
	          <a href="https://docs.microsoft.com/azure/cognitive-services/speech-service/get-started"
	             rel="noreferrer noopener"
	             target="_blank">Subscription Key</a>
	        </label>
	      </td>
	      <td><input id="subscriptionKeyTTS" type="text" size="40" value="197c1a7bc63c41a1931328e15925d597"></td>
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
	          <option class="ko-KR" value="Microsoft Server Speech Text to Speech Voice (ko-KR, SunHiNeural)">Microsoft Server Speech Text to Speech Voice (ko-KR, SunHiNeural)</option>
	          <option class="ko-KR" value="Microsoft Server Speech Text to Speech Voice (ko-KR, InJoonNeural)">Microsoft Server Speech Text to Speech Voice (ko-KR, InJoonNeural)</option>
	          <option class="en-US" value="Microsoft Server Speech Text to Speech Voice (en-US, JennyNeural)">Microsoft Server Speech Text to Speech Voice (en-US, JennyNeural)</option>
	          <option class="en-US" value="Microsoft Server Speech Text to Speech Voice (en-US, GuyNeural)">Microsoft Server Speech Text to Speech Voice (en-US, GuyNeural)</option>
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
	      </td>
	    </tr>
	  </table>
	</div>
	<!-- TTS부분 -->
</body>
</html>