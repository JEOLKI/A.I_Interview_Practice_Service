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
		
// 		$('scriptModalContent').html('<span>테스트 시작시 스크립트가 출력됩니다.<br>출력된 스크립트를 소리내여 읽어주세요.</span>').css({'color':'#A6A6A6', 'font-size':'0.9em'});
// 		$('#phraseDiv').html('');
		
		$('#help').css('display','none');
		$('#result').css('display','none');
		$('#play').css('display','');
		
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

		$.ajax(
			{url:"/scriptTest/create.do",
			data : {"resultScript" : resultScript,
					"scriptSq" : scriptSq},
			type : "post",
			success : function(data){
				console.log("성공");
				console.log(data);
				performScript = data.performScript;
				diffrentIndexs = data.diffrentIndexs;
				console.log(diffrentIndexs);
				scriptArr = Array.from(performScript);
				html = "";
				length = html.length;
				for(var i =0; i<scriptArr.length; i++){
					console.log(length);
					for(var j=0; j<diffrentIndexs.length;j++){
						if(diffrentIndexs[j]==i){
							html += '<span style="color:#FF4646;">'+scriptArr[i]+'</span>';
							length++;
							break;
						}
					}
					if(length <=i){
						html += scriptArr[i];
						length++;
					}
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
					scoreText += '<span>일치율</span><br><b>'+100+'</b>%';
				}
				$('.scoreText').html(scoreText);
			},
			error : function(data){
				console.log(data.status);
			}
		});
	})
	
	$('#retryBtn').on('click',function(){
		$('#help').css('display','none');
		$('#play').css('display','');
		$('#result').css('display','none');
		$('#resultBtn').css('display','none');
		$('#endTestBtn').css('display','none');
		$('#startTestBtn').css('display','');
		$('.scriptContent').empty();
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
	
	// 랜덤 지문 출력
	$.ajax(
		{url:"/scriptTest/retrieveScriptList.do",
		data : {scriptGbSq : scriptGbSq},
		method : "post",
		success : function(data){
  				$('.scriptContent').html(data.scriptVO.scriptContent);
  				scriptSq = data.scriptVO.scriptSq;
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

//테스트 끝날 때 ScriptTest 생성하는 ajax
function createScriptTest(resultScript, scriptSq){
	
	// 확인용 console.log
	console.log(resultScript);
	console.log(scriptSq);
	
	$.ajax(
		{url:"/scriptTest/create.do",
		data : {"resultScript" : resultScript,
				"scriptSq" : scriptSq},
		type : "post",
		success : function(data){
			console.log("성공");
			console.log(data);
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

	console.log("차트그려")
	console.log(testScore);
	
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
			<span class="listenBtn">발음 듣기</span>
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
				<p class="guide result">마이크를 통해 입력된 문장입니다.</p>
				<br><br>
				<p class="scriptContent"></p>
			</div>
			<button class="processBtn" id="retryBtn">다시 테스트하기</button>
		</div>
	</div>
</body>
</html>