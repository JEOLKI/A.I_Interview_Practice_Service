<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>Insert title here</title>
<link href="/css/main.8acfb306.chunk.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script src="https://cdn.jsdelivr.net/npm/microsoft-cognitiveservices-speech-sdk@latest/distrib/browser/microsoft.cognitiveservices.speech.sdk.bundle-min.js"></script>
<script src="/js/microsoft.cognitiveservices.speech.sdk.bundle.js"></script>

<%@ include file="/WEB-INF/views/layout/commonLib.jsp"%>


<script type="text/javascript" language="javascript" defer="defer">
	$(document).ready(function() {
		
	
var authorizationEndpoint = "token.php";
function RequestAuthorizationToken() {
    if (authorizationEndpoint) {
      var a = new XMLHttpRequest();
      a.open("GET", authorizationEndpoint);
      a.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
      a.onload = function() {
    	  
          serviceRegion.value = 'koreacentral'; 
          authorizationToken = this.responseText;
          subscriptionKey.disabled = true;
          subscriptionKey.value = "using authorization token (hit F5 to refresh)";
      }
    }
  }

var phraseDiv;
var startRecognizeOnceAsyncButton;

var subscriptionKey, serviceRegion;
var authorizationToken;
var SpeechSDK;
var recognizer;

var scriptGbSq;
var scriptGbContent = $('#scriptGbContent').val();
document.addEventListener("DOMContentLoaded", function () {
startRecognizeOnceAsyncButton = document.getElementById("startTestBtn");
subscriptionKey = document.getElementById("subscriptionKey");
serviceRegion = document.getElementById("serviceRegion");
phraseDiv = document.getElementById("phraseDiv");

startRecognizeOnceAsyncButton.addEventListener("click", function () {

$('#startTestBtn').hide();
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
    
    if(scriptGbContent == "한국어"){
        speechConfig.speechRecognitionLanguage = "ko-KR";        	
    }else if(scriptGbContent == "영어"){
        speechConfig.speechRecognitionLanguage = "en-US";        	
    }else{
        speechConfig.speechRecognitionLanguage = "ko-KR";        	
    }
    
    var audioConfig  = SpeechSDK.AudioConfig.fromDefaultMicrophoneInput();
    recognizer = new SpeechSDK.SpeechRecognizer(speechConfig, audioConfig);

    recognizer.recognizeOnceAsync(
    		
    		
            function (result) {
            	startRecognizeOnceAsyncButton.disabled = false;

            	var resultScript = result.text;
            	
            	scriptGbSq = $('.scriptGbBtn').val(); 	//question_type
      			var result = $.post('/scriptTest/create.do', {
      				scriptSq : scriptSq,
      				performScript : resultScript}
      			,function(data) {
      				const jsonData = JSON.parse(data);
      				console.log(jsonData.result);
      				
      				$("#result").text('과의 일치도는' + jsonData.result + '% 입니다.');
      				
      				
      			});
      		$('#phraseDiv').val(resultScript);
              recognizer.close();
              recognizer = undefined;
            },
            function (err) {
              startRecognizeOnceAsyncButton.disabled = false;
              phraseDiv.innerHTML += err;
              window.console.log(err);

              recognizer.close();
              recognizer = undefined;
            });

});

if (!!window.SpeechSDK) {
SpeechSDK = window.SpeechSDK;
startRecognizeOnceAsyncButton.disabled = false;

if (typeof RequestAuthorizationToken === "function") {
    RequestAuthorizationToken();
}
}
});


var scriptSq;
function random(scriptGbSq){
	$('#startTestBtn').show();
	$.ajax(
   			{url:"/scriptTest/retrieveScriptList.do",
   			data : {scriptGbSq : scriptGbSq},
   			method : "post",
   			success : function(data){
   				console.log(data);
   				console.log(data.scriptVO.scriptContent);
	   				$('#scriptModalContent').html('');
	   				$('#scriptModalContent').html('<br><br>'+data.scriptVO.scriptContent);
	   				scriptSq = data.scriptVO.scriptSq;
   			},
   			error: function(data){
   				$('#scriptModalContent').html('');
   				$('#scriptModalContent').html('<br><br>해당하는 스크립트가 없습니다.');
   				console.log(data.status);
   			}
   		});
};

var audio = document.querySelector('audio');
function captureMicrophone(callback){
	navigator.getUserMedia({audio : true}, callback,
							function(error){
								alert('마이크를 연결해주세요.');
								console.error(error);
	});
};
	});
</script>

<style>

.popup-wrapper {
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background: rgba(0, 0, 0, 0.5);
	display: none;
	justify-content: center;
	align-items: center;
}

.popup-box {
	background: white;
	width: 200px;
	height: 200px;
	border-radius: 10px;
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
	border: 1px solid black;
	height: 50%;
}

.popup-box {
	width: 330px;
	height: 450px;
	padding: 10px;
}

</style>
</head>

<body>
	<div class="popup-wrapper">
		<div class="popup-box">
			<div>
				<c:forEach items="${scriptGbList }" var="scriptGb">
					<button class="scriptGbBtn" value="${scriptGb.scriptGbSq }"
						onclick="random(${scriptGb.scriptGbSq });">
						<div class="label thislabel">${scriptGb.scriptGbContent }</div>
					</button>
					<input type="hidden" name="scritGbSq"
						value="${scriptGb.scriptGbSq }">
					<input type="hidden" id="scriptGbContent" value="${scriptGb.scriptGbContent }"/>
				</c:forEach>


			</div>
			<div class="popup-content pro" id="scriptModalContent">

			</div>
			
			<div style="text-align: center">
			<label>내가 말한</label>
			<br><input style="text-align: center" type="text" value="" id="phraseDiv"><br>
			<span id="result">과의 일치도는${scriptTestresult } %입니다.</span>			
			</div>

			<div class="popup-close-box" id="popup-close-box">
				<br><label>시작하기 버튼을 클릭한 후<br>위의 문장을 소리내어 읽어주세요.
				</label><br>
				<button class="processBtn" id="startTestBtn">
					시작 하기
				</button>
			</div>
			<input id="subscriptionKey" type="hidden"
				value="8e1d8a815cd34bd4b7fee2b71344ef49"> <input
				id="serviceRegion" type="hidden" size="40" value="koreacentral">
			<br> <br> <br>
		</div>
	</div>
</body>
</html>