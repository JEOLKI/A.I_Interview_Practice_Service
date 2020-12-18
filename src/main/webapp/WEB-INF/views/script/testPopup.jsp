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
	
	// 언어선택
	$('.scriptGbBtn').on('click', function() {
		$('#scriptModalContent').html('문장 출력란');
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
	phraseDiv.innerHTML = "";

	// 랜덤 지문 출력
	$.ajax(
		{url:"/scriptTest/retrieveScriptList.do",
		data : {scriptGbSq : scriptGbSq},
		method : "post",
		success : function(data){
				console.log('랜덤'+data.scriptVO.scriptContent);
  				$('#scriptModalContent').html(data.scriptVO.scriptContent);
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

	#phraseDiv{
		text-align: center;
		border: 1px solid black;
		border-radius: 5px;
		height: auto;
		width: 94%;
		margin: 2px 3%;
		padding: 20px;
	}
	
	#scriptModalContent {
		border: 1px solid #3b3b46;
		margin: 10px 10px;
		height: 65px;
		border-radius: 5px;
		text-align: center;
		padding: 20px;
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
				    		<a class="scriptGbBtn" data-content="${scriptGb.scriptGbContent }" data-toggle="tab" data-sq="${scriptGb.scriptGbSq }" aria-expanded="false">${scriptGb.scriptGbContent }</a>
							<input type="hidden" id="scriptGbSq" name="scritGbSq" value="${scriptGb.scriptGbSq }">
					   </li>
				</c:forEach>
			</ul>
		</div>
		
		<div id="help">
			<div class="popup-content">
				<span style="font-weight: bold; font-size: 23px; margin-bottom: 40px; display: block;">발음 테스트</span>
				<div>
					<img src="/images/speechtest.png" style="width: 50%;">
				</div>
				<div style="text-align: center; margin-top: 40px; font-size: 17px;">
					테스트할 언어를 선택 후 시작하기 버튼을<br>
					클릭하여 출력된 문장을 읽어주세요.<br><br>
				</div>
			</div>
		</div>

		
		<div id="play" style="display: none; text-align: center;">
			<span style="font-weight: bold;color: red; font-size: 17px">[출력 문장]</span>
			<div class="popup-content" id="scriptModalContent"></div>
			<div
				style="margin-top: 0px; padding-top: 0px; text-align: center; font-size: 17px;">
				<br><br>
				<span style="font-weight: bold;color: red;">[입력 문장]</span>
				<div id="phraseDiv"></div>
				일치율 : <span id="testResult" class="informLbl" style="color: red; font-size: 20px; font-weight: bold;"></span> %
			</div>
	
			<div class="popup-close-box" id="popup-close-box"
				style="font-size: 17px;">
				<label class="informLbl"> 시작하기 버튼을 클릭한 후<br>출력 문장을 소리내어
					읽어주세요.
				</label><br>
				<br>
				<button class="processBtn" id="startTestBtn">시작 하기</button>
			</div>
	
			<input id="subscriptionKey" type="hidden"
				value="7ec161e7215b4f0e9a153abcdfa1f815"> <input id="serviceRegion"
				type="hidden" value="koreacentral">
		</div>
	</div>
</body>
</html>