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
	$('#scriptModalContent').html('<br><br>이곳에 스크립트가 출력됩니다.');
	$('#phraseDiv').hide();
	
});

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
            	
            	scriptGbSq = $('.scriptGbBtn').val();
      			var result = $.post('/scriptTest/create.do', {
      				scriptSq : scriptSq,
      				performScript : resultScript}
      			,function(data) {
      				const jsonData = JSON.parse(data);
      				console.log(jsonData.result);
      				
      				$("#result").text('과의 일치도는' + jsonData.result + '% 입니다.');
      				
      				
      			});
      		$('#phraseDiv').show();
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
    $('#startTestBtn').show();

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
</script>

<style>

#phraseDiv{
	text-align: center;
	border-bottom: 1px solid black;
}

#scriptModalContent {
	position: relative;
	background-color : #EBECF0;
	top: 0px;
	left: 0;
	width : 550px;
	height : 250px;
	justify-content: center;
	align-items: center;
	border : 3px solid black;
	font-size : 18pt;
	display: block;
	margin : auto;
	padding: auto;
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
	border-bottom: 3px solid black;
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
	border-radius: 30px;
	font-size : 15pt;
}

.informLbl{
	margin-top: 30px;
}
</style>
</head>

<body>
	<div class="pro">
		<div class="menuSelect">
			<c:forEach items="${scriptGbList }" var="scriptGb">
						<button class="processBtn" value="${scriptGb.scriptGbSq }" style="text-align: left" onclick="random(${scriptGb.scriptGbSq });">
							<div class="label thislabel">${scriptGb.scriptGbContent }</div>
						</button>
						<input type="hidden" name="scritGbSq"
							value="${scriptGb.scriptGbSq }">
						<input type="hidden" id="scriptGbContent" value="${scriptGb.scriptGbContent }"/>
			</c:forEach>
		<button class="processBtn" id="testCloseBtn">close</button>
		</div>
	</div>
			
			<div class="popup-content" id="scriptModalContent">
				
			</div>
			
			<div style="text-align: center"><br><br>
			<label class="informLbl">내가 말한</label>
			<br>
			<div id="phraseDiv"></div>
			<br>
			<span id="result" class="informLbl">과의 일치도는${scriptTestresult } %입니다.</span>			
			</div>

			<div class="popup-close-box" id="popup-close-box">
				<br><label class="informLbl">
				시작하기 버튼을 클릭한 후<br>위의 문장을 소리내어 읽어주세요.
				</label><br><br>
				<button class="processBtn" id="startTestBtn">
					시작 하기
				</button>
			</div>
			<input id="subscriptionKey" type="hidden"
				value="8e1d8a815cd34bd4b7fee2b71344ef49"> <input
				id="serviceRegion" type="hidden" size="40" value="koreacentral">
			<br> <br> <br>
</body>

<script>
const modalCloseBtn = document.getElementById("testCloseBtn");

modalCloseBtn.addEventListener("click", () => {
	window.close();
  });
</script>
</html>