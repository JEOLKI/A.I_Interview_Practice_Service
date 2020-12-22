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
	$('.present').css("display","none");
	
	// 언어선택
	$('.scriptGbBtn').on('click', function() {
		$('#title').css('display','none');
		
		$('scriptModalContent').html('<span>테스트 시작시 스크립트가 출력됩니다.<br>출력된 스크립트를 소리내여 읽어주세요.</span>').css({'color':'#A6A6A6', 'font-size':'0.9em'});
		$('#phraseDiv').html('');
		
		$('#help').css('display','none');
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
	
});

var phraseDiv;
var startRecognizeOnceAsyncButton;
var SpeechSDK = window.SpeechSDK;
var recognizer;
var audioConfig;
var subscriptionKey;
var serviceRegion;	 
var scriptGbSq;

document.addEventListener("DOMContentLoaded", function () {
	startRecognizeOnceAsyncButton = document.getElementById("startTestBtn");
	subscriptionKey = document.getElementById("subscriptionKey");
	serviceRegion = document.getElementById("serviceRegion");
	phraseDiv = document.getElementById("phraseDiv");


startRecognizeOnceAsyncButton.addEventListener("click", function () {
// 	phraseDiv.innerHTML = "";
	$('#startTestBtn').css("display","none");
	$('#endTestBtn').css("display", "");
	
	// 랜덤 지문 출력
	$.ajax(
		{url:"/scriptTest/retrieveScriptList.do",
		data : {scriptGbSq : scriptGbSq},
		method : "post",
		success : function(data){
				console.log('랜덤'+data.scriptVO.scriptContent);
  				$('.scriptContent').html('<span>'+data.scriptVO.scriptContent+'</span>');
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
    	  
    	  function colorPids(vol) {                                                                             
           let fullgage = $('.volume').width();                                                                       
           let prsentVol = Math.round(vol);                                                         
           let prenetGage = fullgage.slice(0, prsent)                                               
           let voluemGage = $('.volume').css("width",prenetGage);                                             
         }      
    	  
    	  navigator.mediaDevices.getUserMedia({ audio: true, video: true })                                     
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
                                                                                                                
              colorPids(average);                                                                               
            }
          })
    	  	    if(scriptGbContent ==''){
    	  	    	phraseDiv.innerHTML = ('<span style="color:red;">테스트 진행을 위해<br>상단 탭의 언어를 선택해주세요!</span>');
    	  	    	return false;
    	  	    } else if(scriptGbContent=="한국어"){
		 	    	speechConfig.speechRecognitionLanguage = "ko-KR";
		 	    	phraseDiv.innerHTML += '<blink>🎙인식중입니다.<blink>';
    	  	    } else if(scriptGbContent=="영어"){
    	  	    	speechConfig.speechRecognitionLanguage = "en-US";
    	  	    	phraseDiv.innerHTML += '<blink>🎙인식중입니다.<blink>';
    	  	    }else{
    	  	    	speechConfig.speechRecognitionLanguage = "ko-KR";
    	  	    	phraseDiv.innerHTML += '<blink>🎙인식중입니다.<blink>';
    	  	    }
    	  	    
	    	  recognizer = new SpeechSDK.SpeechRecognizer(speechConfig, audioConfig);
    	  	  recognizer.recognizeOnceAsync(
  	    	function (result) {
  	           	startRecognizeOnceAsyncButton.disabled = false;

  	           		var resultScript = "";
  	           		resultScript = result.text;
  	     			var result = $.post('/scriptTest/create.do', {
  	     				scriptSq : scriptSq,
  	     				performScript : resultScript}
  	     			,function(data) {
  	     				const jsonData = JSON.parse(data);
	  	     			if(resultScript == null){
	  	     				phraseDiv.innerHTML = "";
	  	     				phraseDiv.innerHTML += '다시 시도하여주세요'
	  	     			}else{
	  	     				phraseDiv.innerHTML = "";
 	  	     			phraseDiv.innerHTML += resultScript;
	  	     				$("#testResult").text(jsonData.testResult);
	  	     			}
  	     			});
  	     			
  	             recognizer.close();
  	             recognizer = undefined;
  	           },
  	           function (err) {
  	             startRecognizeOnceAsyncButton.disabled = false;
  	      		 phraseDiv.innerHTML = "";
  	             phraseDiv.innerHTML += '<span style="color:red;">마이크를 연결해주세요!</span>';
  	             recognizer.close();
  	             recognizer = undefined;
  	          	});
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
	    background-color: #FF5D5D;
	    color: white;
	    text-align: center;
	    padding-top: 5.5px;
	    border-radius: 16px;
	    padding: 5px 10px;
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
	#startTestBtn, #endTestBtn{
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
	.start{
		text-align: center;
	}
	.volume{
		border-radius: 16px;
		padding: 6px;
	    display: inline-block;
	    width: 85%;
	    margin: 7.5%;
	    background-color: #FFBEBE;
	}
	.present{
		margin : 0% 7.5%;
		border-radius: 16px;
		padding: 6px;
	    display: inline-block;
	    background-color: #FF4646;
        position: relative;
  	 	bottom: 40px;
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
				<p class="guide">문장을 정확하게 소리내어 읽어보세요.</p>
				<br><br>
				<p class="scriptContent"></p>
			</div>	
<!-- 			<br> -->
<!-- 			<div> -->
<!-- 				<span style="font-weight: bold; color: #FF5D5D; font-size: 17px; margin-left: 10px;">[스크립트]</span> -->
<!-- 				<div class="popup-content" id="scriptModalContent"></div> -->
<!-- 			</div> -->
<!-- 			<br><br> -->
<!-- 			<div> -->
<!-- 				<span style="font-weight: bold; color: #FF5D5D; font-size: 17px; margin-left: 10px;">[입력된 문장]</span> -->
<!-- 				<div id="phraseDiv"></div> -->
<!-- 				일치율 : <span id="testResult" class="informLbl" style="color: red; font-size: 20px; font-weight: bold;"></span> % -->
<!-- 			</div> -->
	
<!-- 			<div class="popup-close-box" id="popup-close-box" -->
<!-- 				style="font-size: 17px;"> -->
<!-- 				<label class="informLbl"> 시작하기 버튼을 클릭한 후<br>출력 문장을 소리내어 -->
<!-- 					읽어주세요. -->
<!-- 				</label><br> -->
<!-- 				<br> -->
			<div class="volume"></div>
			<div class="volume present"></div>
			<div class="start">
				<p class="guide">시작 버튼을 눌러주세요.</p>
				<button class="processBtn" id="startTestBtn">시작</button>
				<button class="processBtn" id="endTestBtn">완료</button>
				<input id="subscriptionKey" type="hidden" value="7ec161e7215b4f0e9a153abcdfa1f815"> 
				<input id="serviceRegion" type="hidden" value="koreacentral">
			</div>
		</div>
	</div>
</body>
</html>