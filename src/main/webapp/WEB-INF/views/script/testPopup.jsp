<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>AI_INTERVIEW</title>
<script src="https://cdn.jsdelivr.net/npm/microsoft-cognitiveservices-speech-sdk@latest/distrib/browser/microsoft.cognitiveservices.speech.sdk.bundle-min.js"></script>
<script src="/js/microsoft.cognitiveservices.speech.sdk.bundle.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">

<%@ include file="/WEB-INF/views/layout/commonLib.jsp"%>

<style>
blink {
  -webkit-animation: 1s linear infinite condemned_blink_effect;
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
document.addEventListener("DOMContentLoaded", function () {
startRecognizeOnceAsyncButton = document.getElementById("startTestBtn");
subscriptionKey = document.getElementById("subscriptionKey");
serviceRegion = document.getElementById("serviceRegion");
phraseDiv = document.getElementById("phraseDiv");

startRecognizeOnceAsyncButton.addEventListener("click", function () {
$('#startTestBtn').hide();
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
  
    var recognizer = new SpeechSDK.SpeechRecognizer(speechConfig, audioConfig);
    var audioConfig = SpeechSDK.AudioConfig.fromDefaultMicrophoneInput();
    
    var scriptGbContent = $('#scriptGbBtn').val();
    console.log("뭐야"+scriptGbContent);
    if(scriptGbContent==""){
    	$('#popup-close-box').html('<br><br><span style="color:red;">테스트 진행을 위해<br>상단 탭의 언어를 선택해주세요!</span>');
    	recognizer.close();
        recognizer = undefined;
    } else if(scriptGbContent=="한국어"){
    	speechConfig.speechRecognitionLanguage = "ko-KR";
    } else if(scriptGbContent=="영어"){
        speechConfig.speechRecognitionLanguage = "en-US";
    }else{
        speechConfig.speechRecognitionLanguage = "ko-KR";
    }
    
    scriptModalContent.innerHTML += '<br><br><blink>🎙인식중입니다.<blink>';
    
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

	if (!!window.SpeechSDK) {
	SpeechSDK = window.SpeechSDK;
	startRecognizeOnceAsyncButton.disabled = false;
	
		if (typeof RequestAuthorizationToken === "function") {
		    RequestAuthorizationToken();
		}
	};
   });
});


var scriptSq;
function random(scriptGbSq){
	$('#startTestBtn').show();
	$('#scriptModalContent').html('');

	var html = '';
	html += '<label class="informLbl">시작하기 버튼을 클릭한 후<br>위의 문장을 소리내어 읽어주세요.</label>';
	html += '<br><br>';
	html += '<button class="processBtn" id="startTestBtn">시작 하기</button>';
	$('#popup-close-box').html(html);
	
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

var audio = document.querySelector('audio');
function captureMicrophone(callback){
	navigator.getUserMedia({audio : true}, callback,
							function(error){
								alert('마이크를 연결해주세요.');
								console.error(error);
	});
};

$('#selectLang').on('click', function() {
	$(this).attr('class') = 'active';
});
</script>

<style>

#phraseDiv{
	text-align: center;
	text-decoration: underline;
}

#scriptModalContent {
	position: relative;
	background-color : #EBECF0;
	top: 0px;
	left: 0;
	width : 200px;
	height : 120px;
	justify-content: center;
	align-items: center;
	border : 3px solid black;
	font-size : 10pt;
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
	font-size : 12pt;
}

.informLbl{
	margin-top: 30px;
	font-weight: normal;
}

html {
	overflow:hidden;
}  
</style>
</head>

<body>
	<div class="pro" style="font-size:13px;">
		<ul class="nav nav-tabs">
			<c:forEach items="${scriptGbList }" var="scriptGb">
					<li id="selectLang">
			    		<a id="scriptGbBtn" data-toggle="tab" value="${scriptGb.scriptGbContent }" onclick="random(${scriptGb.scriptGbSq });" aria-expanded="false">${scriptGb.scriptGbContent }</a>
				   </li>	
				<input type="hidden" name="scritGbSq" value="${scriptGb.scriptGbSq }">
			</c:forEach>
			</ul>
	</div>
			
			<div class="popup-content" id="scriptModalContent">
				
			</div>
			
			<div style="text-align: center; font-size:14px;">
			<label class="informLbl">내가 말한</label>
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
			
			
			<input id="subscriptionKey" type="hidden"
				value="c8fade57c0084e95b64bf948ed3184a5"> <input
				id="serviceRegion" type="hidden" size="40" value="koreacentral">
			<br> <br> <br>
</body>
</html>