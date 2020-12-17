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
$(window).resize(function(){
    window.resizeTo(320,510);
});

$(document).ready(function() {
	$('#scriptModalContent').html('<br><br>이곳에 스크립트가 출력됩니다.');
	
	$('.scriptGbBtn').on('click', function() {
		scriptGbContent = $(this).data('content');
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
	startRecognizeOnceAsyncButton.disabled = true;
	phraseDiv.innerHTML = "";

	if (subscriptionKey == "" || subscriptionKey == "subscription") {
       alert("Please enter your Microsoft Cognitive Services Speech subscription key!");
       return;
	};
		      
		  var speechConfig = SpeechSDK.SpeechConfig.fromSubscription("c8fade57c0084e95b64bf948ed3184a5", "koreacentral");
    	  recognizer = new SpeechSDK.SpeechRecognizer(speechConfig, audioConfig);
    	  audioConfig = SpeechSDK.AudioConfig.fromDefaultMicrophoneInput();
    	      
    	  	    console.log("스구 : "+scriptGbContent);
    	  	    
    	  	    if(scriptGbContent =="" && scriptGbContent != '한국어' && scriptGbContent != '영어'){
    	  	    	$('#popup-close-box').html('<br><br><span style="color:red;">테스트 진행을 위해<br>상단 탭의 언어를 선택해주세요!</span>');
    	  	    	speechConfig = null;
    	  	    	recognizer = null;
    	  	    } else if(scriptGbContent=="한국어"){
//     	  	    	speechConfig = SpeechSDK.SpeechConfig.fromSubscription(subscriptionKey, serviceRegion);
    	  	    	speechConfig.speechRecognitionLanguage = "ko-KR";
    	  	    	scriptModalContent.innerHTML += '<br><br><blink>🎙인식중입니다.<blink>';
    	  	    } else if(scriptGbContent=="영어"){
//     	  	  		speechConfig = SpeechSDK.SpeechConfig.fromSubscription(subscriptionKey, serviceRegion);
    	  	    	speechConfig.speechRecognitionLanguage = "en-US";
    	  	        scriptModalContent.innerHTML += '<br><br><blink>🎙인식중입니다.<blink>';
    	  	    }else{
//     	  	  		speechConfig = SpeechSDK.SpeechConfig.fromSubscription(subscriptionKey, serviceRegion);
    	  	    	speechConfig.speechRecognitionLanguage = "ko-KR";
    	  	        scriptModalContent.innerHTML += '<br><br><blink>🎙인식중입니다.<blink>';
    	  	    }
    	  	    
    	  	  recognizer.recognizeOnceAsync(
    	  	  	    	function (result) {
    	  	  	           	startRecognizeOnceAsyncButton.disabled = false;

    	  	  	           		var resultScript = result.text;
    	  	  	     			var result = $.post('/scriptTest/create.do', {
    	  	  	     				scriptSq : scriptSq,
    	  	  	     				performScript : resultScript}
    	  	  	     			,function(data) {
    	  	  	     				const jsonData = JSON.parse(data);
    	  	  	     				console.log(jsonData.testResult);
    	  	  	     				 
    	  	  	     				$("#testResult").text(jsonData.testResult);
    	  	  	     				
    	  	  	     			});
    	  	  	     			scriptModalContent.innerHTML = '<br><br>결과를 확인해주세요.';
    	  	  	     			phraseDiv.innerHTML += resultScript;
    	  	  	     			
    	  	  	             recognizer.close();
    	  	  	             recognizer = undefined;
    	  	  	           },
    	  	  	           function (err) {
    	  	  	             startRecognizeOnceAsyncButton.disabled = false;
    	  	  	             phraseDiv.innerHTML += '<span style="color:red;">마이크를 연결해주세요!</span>';

    	  	  	             recognizer.close();
    	  	  	             recognizer = undefined;
    	  	  	          	});
   });
});


var scriptSq;
var scriptGbContent;
function random(scriptGbSq){
	
	startRecognizeOnceAsyncButton.disabled = false;
	$("#testResult").empty();
	$('#startTestBtn').show();
	$('#scriptModalContent').html('');
	
	$.ajax(
   			{url:"/scriptTest/retrieveScriptList.do",
   			data : {scriptGbSq : scriptGbSq},
   			method : "post",
   			success : function(data){
   				console.log(data);
   				console.log(data.scriptVO.scriptContent);
	   				$('#scriptModalContent').html('<br><br>'+data.scriptVO.scriptContent);
	   				scriptSq = data.scriptVO.scriptSq;
	   				console.log("scriptSq : "+scriptSq);
   			},
   			error: function(data){
   				$('#scriptModalContent').html('<br><br>해당하는 스크립트가 없습니다.');
   				console.log(data.status);
   			}
   		});
};

// var audio = document.querySelector('audio');
// function captureMicrophone(callback){
// 	navigator.getUserMedia({audio : true}, callback,
// 							function(error){
// 								alert('마이크를 연결해주세요.');
// 								console.error(error);
// 	});
// };
</script>

<style>

	body{
		background-color : #f5f7fb;
	}

	#phraseDiv{
		text-align: center;
		text-decoration: underline;
		border: 1px solid black;
		border-radius: 5px;
		height: 70px;
		width: 94%;
		margin: 2px 3%;
	}
	
	#scriptModalContent {
		border: 1px solid #3b3b46;
		margin: 10px 10px;
		height: 150px;
		border-radius: 5px;
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
	
	#startTestBtn{
		border-radius: 5px;
		font-size : 12pt;
		background: #3b3b46;
		border: 1px solid #3b3b46;
		color: #fff;
		width: 100%;
		margin: 0px 3%;
	}
	
	#startTestBtn:hover{
	    background-color: white;
	    color: #000d22;;
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
	
</style>
</head>

<body>

	<div class="contentBox">
	
		<div class="pro" style="font-size:13px;">
			<ul class="nav nav-tabs">
				<c:forEach items="${scriptGbList }" var="scriptGb">
						<li class="selectLang">
				    		<a class="scriptGbBtn" data-content="${scriptGb.scriptGbContent }" data-toggle="tab" onclick="random(${scriptGb.scriptGbSq });" aria-expanded="false">${scriptGb.scriptGbContent }</a>
							<input type="hidden" id="scriptGbSq" name="scritGbSq" value="${scriptGb.scriptGbSq }">
					   </li>
				</c:forEach>
			</ul>
		</div>
				
				<div class="popup-content" id="scriptModalContent">
				</div>
				<div style="margin-top: 0px; padding-top:0px; text-align: center; font-size:14px;">
				내가 말한
				<br>
				<div id="phraseDiv">
				
				</div>
				과의 일치도는
				<span id="testResult" class="informLbl"></span>
				% 입니다.			
				</div>
	
				<div class="popup-close-box" id="popup-close-box" style="font-size:14px;">
					<label class="informLbl">
					시작하기 버튼을 클릭한 후<br>위의 문장을 소리내어 읽어주세요.
					</label><br><br>
					<button class="processBtn" id="startTestBtn">
						시작 하기
					</button>
				</div>
				
	 			<input id="subscriptionKey" type="hidden" value="c8fade57c0084e95b64bf948ed3184a5">
	 			<input id="serviceRegion" type="hidden" value="koreacentral">
 			
 	</div>
 			
</body>
</html>