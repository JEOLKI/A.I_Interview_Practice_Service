<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<script src="https://cdn.WebRTC-Experiment.com/RecordRTC.js"></script>
<script src="/js/audiodisplay.js"></script>
<script src="/js/recorderjs/recorder.js"></script>
<title>아이엠터뷰</title>

<link href="/css/main.8acfb306.chunk.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script src="microsoft.cognitiveservices.speech.sdk.bundle.js"></script>
<style>
body * {
	box-sizing: border-box;
}

.modal-wrapper {
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

.modal-box {
	background: white;
	width: 200px;
	height: 150px;
	border-radius: 10px;
}

.modal-title, .modal-content {
	text-align: center;
}

.modal-close-box {
	text-align: center;
	margin-right: 10px;
}
/* 
.pids-wrapper{
	height : 100%;
}

.pid{
	width : 10px;
	heigh : calc(10%-10px);
	display : inline-block;
	margin : 5px;
} */
</style>


<style type="text/css">/* Chart.js */
/*
 * DOM element rendering detection
 * https://davidwalsh.name/detect-node-insertion
 */
keyframes chartjs-render-animation {from { opacity:0.99;
	
}

to {
	opacity: 1;
}

}
.chartjs-render-monitor {
	animation: chartjs-render-animation 0.001s;
}

/*
 * DOM element resizing detection
 * https://github.com/marcj/css-element-queries
 */
.chartjs-size-monitor, .chartjs-size-monitor-expand,
	.chartjs-size-monitor-shrink {
	position: absolute;
	direction: ltr;
	left: 0;
	top: 0;
	right: 0;
	bottom: 0;
	overflow: hidden;
	pointer-events: none;
	visibility: hidden;
	z-index: -1;
}

.chartjs-size-monitor-expand>div {
	position: absolute;
	width: 1000000px;
	height: 1000000px;
	left: 0;
	top: 0;
}

.chartjs-size-monitor-shrink>div {
	position: absolute;
	width: 200%;
	height: 200%;
	left: 0;
	top: 0;
}

.thislabel {
	font-size: 12px;
	padding: 2px 10px;
	background-color: #e9edf1;
	border-radius: 30px;
	width: -webkit-max-content;
	width: -moz-max-content;
	width: max-content;
	margin-left: 12px;
}

.modal-box {
	width: 330px;
	height: 420px;
	padding: 10px;
}

.pro {
	margin: 10px;
	border: 1px solid black;
	height: 65%;
}
}
</style>
<script>
$(document).ready(function() {   
	$('#stopTestBtn').hide();
});   

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

var phraseDiv;
var startRecognizeOnceAsyncButton;

// subscription key and region for speech services.
var subscriptionKey, serviceRegion;
var authorizationToken;
var SpeechSDK;
var recognizer;

document.addEventListener("DOMContentLoaded", function () {
  startRecognizeOnceAsyncButton = document.getElementById("startTestBtn");
  subscriptionKey = document.getElementById("scriptModalContent");
  serviceRegion = document.getElementById("serviceRegion");
  phraseDiv = document.getElementById("phraseDiv");

  startRecognizeOnceAsyncButton.addEventListener("click", function () {
    startRecognizeOnceAsyncButton.disabled = true;
    phraseDiv.innerHTML = "";

    // if we got an authorization token, use the token. Otherwise use the provided subscription key
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

    recognizer.recognizeOnceAsync(
      function (result) {
        startRecognizeOnceAsyncButton.disabled = false;
        phraseDiv.innerHTML += result.text;
        window.console.log(result);

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

    document.getElementById('content').style.display = 'block';
    document.getElementById('warning').style.display = 'none';

    // in case we have a function for getting an authorization token, call it.
    if (typeof RequestAuthorizationToken === "function") {
        RequestAuthorizationToken();
    }
  }
});

var scriptContent;
function random(scriptGbSq){
	$.ajax(
   			{url:"/script/retrieveScriptList.do",
   			data : {scriptGbSq : scriptGbSq},
   			method : "post",
   			success : function(data){
   				console.log(data);
   				console.log(data.scriptVO.scriptContent);
	   				$('#scriptModalContent').html('');
	   				$('#scriptModalContent').html('<br><br>'+data.scriptVO.scriptContent);
	   				scriptContent = data.scriptVO.scriptContent;
   			},
   			error: function(data){
   				$('#scriptModalContent').html('');
   				$('#scriptModalContent').html('<br><br>해당하는 스크립트가 없습니다.');
   				console.log(data.status);
   			}
   		});
}

var audio = document.querySelector('audio');
function captureMicrophone(callback){
	navigator.getUserMedia({audio : true}, callback,
							function(error){
								alert('마이크를 연결해주세요.');
								console.error(error);
	});
};

var recorder;
//녹음 시작
function startTest(){

	$('#startTestBtn').hide();
	
	captureMicrophone(function (microphone){
		recorder = RecordRTC(microphone, {
			type : 'audio', //audio 타입 포맷 전송
			recorderType : StereoAudioRecorder,
			numberOfAudioChannels : 1, 
			desiredSampRate : 16000	//초당 audio 샘플 채취 수
		});
		
		recorder.startRecording();
		recorder.src = microphone;
	
		$('#stopTestBtn').show();
		var phraseDiv = $('#scriptModalContent').val();
		console.log("phraseDiv : "+phraseDiv);
		
		var scriptGbSq = $('.scriptGbBtn').val(); 	//question_type
		var result = $.post('/scriptTest/startTest.do', {
			scriptContent : scriptContent,
			scriptGbSq : scriptGbSq,
			phraseDiv : phraseDiv},function(data) {
				}).done(function(data){
					var html = "분석중입니다. 잠시만 기다려주세요!";
					$('#scriptModalContent').append(html);
				}).fail(function(data){
					alert("Error! : "+data.status);
				});
		});
};

	
//녹음 정지 + 콜백함수 전달 받음
function stopTest(){
	recorder.stopRecording(stopRecordingCallback);
	$('#startTestBtn').show();
	$('#stopTestBtn').hide();
};

var audioSource;
var blob;
let audioUrl;
function stopRecordingCallback(){
	
	//녹음된 오디오의 blob파일
	blob = recorder.getBlob();
	
	audioUrl = window.URL.createObjectURL(blob);
	
	audioSource = document.querySelector('audio > source');
	audioSource.src = audioUrl;
	
	$('#modal-close-box').empty();
	
	//파일 다운로드창 오픈
	createAudioElement(audioUrl);
};

//다운로드 받을 수 있는 링크 생성해주는 function
function createAudioElement(blobUrl){

	console.log("createAudioElement");
	let today =  new Date();
	let Y = today.getFullYear();
	let M = today.getMonth();
	let D = today.getDate();
	let H = today.getHours();
	let N = today.getMinutes();
	let S = today.getSeconds();
	
	let now = Y.toString()+M.toString()+D.toString()+H.toString()+N.toString()+S.toString();

	const downloadEl = document.createElement('a');
	downloadEl.style = 'display : block';
	downloadEl.download = 'STFofAI_Interview'+now+'.wav';
	downloadEl.innerHTML = '✔ 내 목소리 들어보기✔';
	downloadEl.href = blobUrl;
	
	const audioEl = document.createElement('audio');
	audioEl.controls = true;
	
	const sourceEl = document.createElement('source');
	sourceEl.src = blobUrl;
	sourceEl.type = 'audio/wav';

	audioEl.appendChild(sourceEl);
	
	document.getElementById("modal-close-box").appendChild(audioEl);
	document.getElementById("modal-close-box").appendChild(downloadEl);
};
 
//이 밑으로 마이크테스트
// 오른쪽 상단에 사용자가 입력하는 마이크 볼륨 출력
// function colorPids(vol){
// 	//마이크 게이지 바
// 	let all_pids = $('.pid');
	
	
// 	let amount_of_pids = Math.round(vol/10);
// 	let elem_range = all_pids.slice(0, amount_of_pids)
	
// 	for(var i=0; i<elem_range.length; i++){
// 	all_pids[i].style.backgroundcolor="#69ce2b";
// 	}
// }

// navigator.mediaDevices.getUserMedia({audio : true}).then(function (stream){
// 		var audioContext = new AudioContext();
// 		var analyser = audioContext.createAnalyser();
// 		var mic = audioContext.createMediaStreamSource(stream);
// 		javascriptNode = audioContext.createScriptProcessor(2048, 1, 1);

// 		analyser.smoothingTimeConstant = 0.8;
// 		analyser.fftSize = 1024;
		
// 		mic.connect(analyser);
// 		analyser.connect(javascriptNode);
// 		javascriptNode.connect(audioContext.destination);
// 		javascriptNode.onaudioprocess = function(){
// 			var array = new Uint8Array(analyser.frequencyBinCount);
// 			analyser.getByteFrequencyData(array);
// 			var values=0;
			
// 			var length = array.length;
// 			for(var i=0; i<length; i++){
// 				values +=(array[i]);
// 			}
			
// 			var average = values/length;
			
// 			console.log(Math.round(average));
// 			colorPids(average);
// 		}
// 	}).catch(function(err){
// 		handle the error
// 	});

</script>

</head>
<body>

	<audio id="audioTag" controls autoplay>
		<source src="" id="sourceTag">
	</audio>
	
	<div id="root">
		<div class="Main false">
			<%@ include file="/WEB-INF/views/layout/header.jsp"%>
			<div class="my-bar interview">
				<div class="title">내 면접</div>
				<div class="start-btn">
					<a href="/interview/ready.do"> 새 면접 만들기<img
						src="/static/media/right.2a3d42b5.svg" alt=""></a>
				</div>
			</div>
			<div class="MainComponent">
				<div class="MainBoard">
					<div class="board">
						<div class="RecentInterview box">
							<div class="illust-area">
								<img
									src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAIsAAABkCAYAAAC2C8OoAAAABHNCSVQICAgIfAhkiAAAFnVJREFUeF7tnQd01FX2x793MmmkTRqKJCGIfxUBiX35gxI8rgVdifL3T3GVoqtYgdW1u4a1YF2DuoCe/2qwAO5ZJChgV1B0bbtixQohCS2T3kibef9zJ5nJzDC/3++9aZnAvHNyOMzc1z9zX7vvPkI0HKQtkG9BMq0FUWFQKiiwiIKSkHsiyfmFgGk+SBScPu4Uy803/KF1UFLiv8+aNP5MAMlBzy+yEvwFwCNE9Ey/Fyv5yGIQ7glaOYIOS8rwUoBm+SrgcceM2PbNp29kmkymwUGrQOQm9BGA84ioud+KmDx8E4gmquafnzcUw3KHOqIdflgWPv3iK5RX7AKCCkvykSUgzNcr3IyLJ/+8svTJ/1KtwACV30zBGgL8aQA/YVlw7Rw8/uBdrhyffnYl5i24O4iwJOTnI9a0Q6ZO2z7b8MWxxx57sozsQSBzIRG91i/18BMWLitrly+3rEdHZyeW/30lihcvCSIsCuPjrJkXfVK6/NHf9EsDhj/T54l8D8shL4qfsFjSUvD+hpX46pttyB+Wg00ffhpsWIaXgWiKTAPcd+dNv9x601XDzWZzjIz8AJf5lIj654fhByxOUBqbmlE4eSaKb5+PrV9/j7INbwdTs8hPpkqXP7J71syLjxjgEMgW/zsiGi0rHFQ5A1gKxozE2pXLMeeaW7Bpy6eOrMtWLUd+Xg4KJ89AQ6PX3DxoE1wFiqOwBBUJ7cR0+sQ5iV3x0hrMunQqih9YguHDclBw/HG+QeFcorCEvOMiSrPwMPPcsocx6fRxKJpxtUOjFE44DWWrnnY0RMH483uWyb5CFJZDC5atH613VNh7mGGIePjZ+s027QaJwnJowcJaxDk/Ua55FBblJlONELxhqLo6ObPTNFXYxVgiZCcRJewcmpkAwApgL4DNAN4lom5HIRXmkVKVsmNhcM6GFAqmMsEtrxeoaBRSdfFH6PjDTbBwc4cuBAxLWoX15BjCH0mIi0DkKq0J2Fudk3W4V9FrAbwA4DFKOfJFf7b7NSYsK9C8Y3bEwtLQDmTf3xa6bgTwu2Nj8Mql8aHMw29YMitrThVC3E+Es3wVUAMWp2jnqFPOqf3+x1+GeMS12+egtbzU3wqHC5bG3gKmqWiWv7zX5W+9pOKNHWLClJEh3Rv0C5aMCuvNIDxIgGbhDGBB4XkzsPmjz/raIUBQOKFwwNIIu73HpsJk2lS6/JHW6KacBstCUGZVzYsAZhrRrgLLVbOmrXjmqcWzjdI0+j70sAj7JLSUb3IUJCm/4KW/l6ydOW1KvlHBDpLvlTRLekXNfSYSd8rUXRaW55Y+hNm//x87AD7U3CCTtpZMaGHxofq+/fb760aNGvlUIIUeQHGlYcmsrLkYEGtk6yYDy+xLpzIoziR5KlBAROWyeXjLhQ4WjTFSCDEBwIf+FniAxZODZbcYlGmzlgOULVs/I1j4AJC3773COiIqks0jPLDoTKaEEKcD+MDfAg+weFKwZFRa2b71zyp1M4JFJ63xRPSxSl5O2eBrFoNZtywsvHQ+6rE2NLb3Vat7yRh/6igdx3l2UnTB2dJxDASNYREiLrPKWguQkn1yALCsJ6Lf+VPB4MCSkl8EQQtAogTN5WV6BRFCjATwvUxhL36pA43tfZty7y0cJRMtYJkd32x2GP4EIRjCkl5ZfZ4JtFE1rwBg6QCQRkT8r1IIDiwKWQohRgBgK3jlQKkcNfShdwURjIwMYcmsrH4KoOtUMwsAFs6KjcnfUM0zCouPFrvnthtRfIeu7blsO0vAYv0PgBNkE3TKBQjLw0R0q2qeUVj6HZbqfQApX48JEJaXiWh6FBbVFuhPWISgjKoaG/mxkx4gLH5dUxnwmoWvLTQ0Nh1oMwqAVzeWtFRN6y+2Q/Vl8BO2YSgAWLp27xVoaf0p9ugRx6j+PgTwaV1utrIheUTDctLf2vH1Xt6p7gneS+fSZQ87bEg5sOFx6Ut9G6C8e8kmhBzY1nT2Nbe40nHei7FYUlG+swonTLjAA7awwQIgs8K6CwRlA3Zb1W40nDsVqa+8+KMyMALravOylTfnIhqWEY/u97Bn8YZFNP3qAmAz25NO7jt/27RxJSZOOM31fXpugQsI71t33qCFGZbPQVC+dOeA5eyL+HAWaW/88ydzztCjZTWMAC2py81aICvvlItoWLwr4710Lv/2AwzL67mX66093LXOzopdyB99hiu5ovN/i7Wrlrv+f8L4CzyGozDDsgyEeaod54KFI8bFIW39amlg7AIz6vOyV6vmOaBhYZtSHm54zlKy9DmPuQkPNaxBeM7Cw5O37Sl/V3j6aShb/7bH8MUNGE5YMipqzyGyK+95eMDSC0zqa6t/jM0dqjuHEQKdpkRk1WRnK1/aH9CwqP4yZOXDCQuEiM2orKkhQqps+VjuAFjkgVlfm5vdj9v9CrUcCDu4YYWFJ7lV1bdD0AMKzegbFueQ9Pban83ZWT69VQgyjavLyfxEJa+DYs7iT4Vl4oQbFuwQCRnmml8I6JmASQSfmsUZLzkZaRtePgAYIfByXV628mbcgIBl7ppOVDT2LZ3fXRCeg8SwwwIgvcp6vkmg5xaYRNCFheMnJyFt4z9+Mmdl9a6SRJs9xjyy/oiMConkfYpE9Jwl9m5P6/5Qmyg4W6g/YOG8VexaDGHpBcby9tpfY9LSRoBoTm1Olt+W/ZxcRMPCNi1f7enTLNPPnYi9e3b7+8OQjtdfsIB3dCtrVhPhf40Ka9u1Bw2/ldhXy0xH2opnnm2ceNIVRmkafR/RsHgXnk0F+UL3zsrQAuMLlkYh8G1nz2U/ZxgdZ2bDEL02Njx1PiByzxHA0wT8QS9hKc0CwDzu1M+631r937yAMoLB6PsBBYuzMgwN760EEnjvZcXKV3wmwbDMvfUGvL6/A6ta2/Ftl347T06Mw/j4WJyXGI+8GJN7muqw9MbOqLIugB2LtJbUhpolIV7EnFSwzPbGKmVbGa12HZCwBAKJe9zZ8/7kE5hjbrwaNfPm+pUNQ/On1EGYEB/L8f2GhSNnWa0ptna6ziTs80HkcVVVS7NQcjLMvzn5o66uuGlYv1zDf4ZfVYvsOYt/VVKL5QuYxGuvxKDrdUcBw0xY29yTlvzzUbEx0mc2mokKYcqorDuLyH6ZgBjNtwBsVXuyGotmxpvS07opLbXNlHPE9pghQ9a1jzp6Ka65vNqwgH4IHNKaxdleE6+8CR/8o890OBiwcNpJRLZW4MpAVyF+9GtIohzysFxf14zVbR1oueMv6CjrubAXLFicPSaA4rrc7EUh6cEwJnpIw+IExdneTmD0YOE5Cd83qOy2odLWt6w36jMhRGld3uA5RnKR/H3QYLHsqc9Hl20sUmI2N6SnN2hVWuVsaOseO+59vwuvbtNejQyzkMMTwt1nxin5WrmjoRXPtOw/oJgMjOmIIR5zllQiXJ2SiFtTB3nIb9zfCQauScj5kBGEhXU52SWRDIRe2YIGS0aFtYEIaUKIFXV5gzVv7KvA4m0pp1eRuyfF4s9nOlYghmFVWwduqNM+oe/e9iPMI/tO+p/KSMH0Qb79uHzT1Y0p1Y3SwNiASQ252T2OAgZYiGhYvLf79dr2jHwT3r3C2I1Thc2Owr310p3LkDAseuHhpjbwn0wQAg32FPNwPe0rk05/yCjDwsNNjM020RYTs7lhSLrrRr6lqrrABCq0x5jL3D/3rpSKZgkFLNfVNePlNvnLeJsOS8foWH2HPwzgiXvqpPtPAIvqcrOLpSNEiKAyLBmV1VsJNFZAbK3LHax8Oao/YVHtVJ6rbB+aKdVVhfvqDXd6nQnJahchxLEArgXAk6WniGgrpyGEYAPvGwHkskUpEb3V+znfl74BwEkA1hLRS72fM+1suslvPvEQuMzpqFAIwedQ/Pc1gBIi0twaDwSWr+pyBxdItaSbUH/CoqpVeOWzLjtNqopTrI34qEPerZmMdhFCMBxjewuwk4gcTpCEELwp5HwroRNAHhHtE0KwtnJ/kGocEX0ihGAbllVuFZlDRKVCCP6x841IZ3iMiG7WqrAmLDzcmLq7ptgJmxtyBjuI5tA7DBXaYmI2HTAMCUy0m2PXReowdOSuWum5CtdVZr7ibJfLa5vAqyPZIIQor8sbPFxLXgiRBIB/5e6HTUOIaK8Qgl2ZHuYW13F3WQjBtrznuH2+kIhKhBC8AnO/j/s0Ec0TQrC2WeYmr3v5TBOWzAprGQhTWGXW5WWnGzVCKFZDKnOWMd1f4D+L+yz4vcu7paMLRVanH0Sj2vR8z0MQD0UygVdFk/Zp7hj4TMJmNg/X+mH1wtLiFZE1SKUQYidrE7fvziWiN4UQrwM41+3zPxLR40KIvwJY6Pb5M0R0tRCCzzTcn+jbQkTsP8dn0GyJjIrqUn4rRwA763KzDX3A9Scs9u/KkLpjHeq/fFmzX7X2VfRAqMnJkuHEJZNVVaMkr7fvMqBgsdTXW2KabYW22JitHsONY3jqnmUnse6A4anLVmBLidkUrE05Gc0iqn+A7ZW5sOQcowvLhdZGfKwwp1DVLLybe4LCishBlc7NwAEFi9ZPxLUaMhhzdcZiaf8s7rCIqs9AOad6JCvam2BbeQnQvBuWESfrwqKyWnFmwifHz2fK3dBQneD25rG5Njfb51O6BwUsrrkMRNhWQw7tseoSmE6/BaYTL3MB0/3SVKDmJ8f/jWBRHSKcmTAsDI1e4IktT3BVg972Qzhh4S2FXqMt/+YsWhXn4Qkt3QVINm91H24sldZCE3g1ZF4RzNWQu/bgMpnOuhemUUWwvXUnxLZXXcUMFSwy2kV1JeTetrW52T7njeGC5UJr4zM8PPNEfmV26pfj4uNOVJ7gqv5KMiutPadpBjf0VfdZvKHgLGjkFIht6zyKGCpYOBPea+E9F1+BzRv4MNGfoLd4CAcsxQ2tf3uyuY03/RxhQlxs7brDLJqzerl1oURLZFRaywkYZnRDXwWWmItXwv7O3RK5Gw9DBXvqUKVgUuCeKf/qNh+ejlxP+1qwEfeIXfwQh9+hX+csl1gbX32vvdN1lXVsnLnxvcPSLSHXLM7hyehEVQUWyioAOuV+tUaaxZ/VkLPR9DbnHmpqwyOSh4g+OuHQhEX2t6UEi4J3SiNYVLf6uT5exteaVeQNPwZGZbu/Z8TWPlAMxzDUb5ol0mExsmFxlp+HnOlJCZiRFI8xsWbZajnkeBd3efN+vL6/U+pYQc+2xQkLD3Uceu8nBXUHNwqLRvfKzC94uLk/Pdno4pghQLwUvbymUfcUWgg01uVla84PGJZVbR0tTiMtvl5ya+qgKCyaEyqFYSh/1CnY8S99Z0Z68xaZJbIhJW4CDOeU6gZNYCQsCpOyqmo8zoZqcrKkYGEN16sVdc+GDirNcsyp5+OnH36Q6qN5V83Gskf1V056h4kyRk5SBXET0tusMzKvZM2iCsuW9s4tl9U0jWebYDbYKs1Ou2N4TMxirYPEgwoW1c6RkdfSLqqHhjJ5sYyvnWMjreKY/PoBy3RrQ9Xb7V0uHy9XpCSuetiSPDMKi2xvecn5Y6rgZ1aa0fRME5yR/IFl4t762m+7ujOcaZyTGPfmyqy0c6OwBNCD/iyjA8jOI6rRpqUsLBv3d+ZV2myOlVsakcOeRQ+WCpt94erWdpyXGMfzGYc9S3QYkuzVifvq8Z2BdwTJpOTFFJwV62mWRQ0tDU8073fYe/KucungtKkFZvMrWrC8ub/jhZk1Tb93FnRpRspr05ISLozCItl1vFqZuLfe7yMAyWxcYgLiK3tybKHsFRA9WMbsru3ebbO7rhxck5J4y32W5Ee0YLm6tulf/2zrcLlfnzYo4d9LM1NOjsKi0Iu8xORDwFBrGFVQjCa4rkPb3rpGYVHo9EBEWcNcVtOkbEUnmyevfOwpsQtkNYrMnCUKi2zrh0iODwR5q75Z8t6yUTFSiHB9auLem1OThhjJ+vpebxiKwuJPiwY5DmuZO+pblG4seheBIZmXkuj4SyPy2/NTFJaezSZpG9wgsyCdHJ/tbOz1Jyc7nzkvIQ7jE2Ix2dOvXBQW6Vb3ITgQYHEvNmubbzq7XeYHFd02pPGzLSZy/I2ONWOMttfKKCyHEiyB1DUQB4RCCFP+rtruFiEc1ow8vO0YmplIRO1F+xpqP+zscu3UzkiOn/JUeuqrU6obftjS0eXyFXJZUsL9JRkpd11V27RmTVvHxc66zEyKf/3JjNTJd9S33PR0y/5HnZ8XxsduXzPYovnEbdDMKmUbdaBpFtl6acj5rVk4vceaWh94vqX99ka7wNSkhBceS0++nD9/uKl17ost7f/XZBc0LSl+y0PpKY5bhK92dp64tL7t4887u+KnDorf+XRGyggist3S1pazr63r6/X7O9ML42ObJ6QmFCxMSNjOca6qbdqxpq0j/9T42K4zEuPPvj0lUdN3TBSWAGkwiB4QLKEtmnrqUVjU20wlRhQWldbylo0OQ4G0Xv/GjWqW0LZ/VLME0r5RzRJI6/VvXH6ypARCzAJhSTj8nEVh6d8ODyR3cvlV8fOiu2rm4YSloYFfkm9C/rAc1WI65PmBcH/jcvxPPv/y13GnnniUX5lHYCTKqLQWA6KIyFQSDh/zqrCUrX8L6za843g+V6Xj+J3nBbfd62jyBdfOxT23s78+ucCQLXrwCcfzv/zkL788X3i6yxzEMJFNH36CRYuf6HkeWKAM3faFaC93efY0TCApfz7IVIiW7RcZyoZRQNtNWKV1kxAYSyZaGEyIVGEpfmCJo+M4FN8+H/OvmQ2LRdtnCnfUwtvu83jUm+Nypz/+4F0ouuBs3eZdsvQ5FC9e4npd3inMb0gzNHrAsibisvJbRp5BNEBQCVrsS4BybV9iyfmFAD0Ooh7Hjs3bw74A0Wscn4VxeH1q6a53RFQwBZSBPBBYnJ3O0My6dKpHdtod5Vkq7nSGpuD44zy+YMjmXHOLx0PivuqjBSxrkpKlzx4AmRc05bCLYrSWr/D4PCE/H2bT4yB4vmM3EGDhivDElyAKbECx0WV3GUicMoHC4v5L56GlYMxxWLKsVKKjPEvJL80/vvgux5yGIfF+UV6vTpa0FJQ8eLcDWB4mWZOVVyi8AyXEJgixEK0oR7JpPgi+HShHGixujgYNvT6zxjE1d30JkIVAc2rzsvoe6ZEkJliwOLPj4UWpo9zKyZ3e0CjnpcFX9QKND4hyoMe3rc8QebD0PtAgsRpi704xwPs9o5N/LsWDDYskowNTLNJgyayqmQ0hZvMETEZTODQRyGKLNS/Qcwem1TtRWBS4jTRYtIru9OQUjMej3fMQQrDa3SHbZO6rIdk4B43cQIDF4XK9u9vRoTL3clU6RwjB3rqln9Aomn411m18RyWLg0c2EmFhOLyHFN6sI4ECm0kUuztHDkZP+HAnrpns8NFn+D2BDUZZ+y0NIdahZYfEk/DhKyH1+ejXf4EsmEUSQvB26hKjNHnvY9L5lxqJHZzfC/sktJRH1ItnrrMhAJrO8ELRG0II3uZ02YV658Fb7sPHnBHQ0jYU5Q5PmmIFmndoPh0YnjIcmAtlVtQUCdiL7ESlwdx8k6mQEGIxgNu8ZWV3U2XyGHAyAovQsj0iXznr97MHIUQ2gLn8nDJ37OLHlh775VfbDh9wneyjwG1t+1s3vPn+51J1EfZytKJM9+xIKqHQCf0/brty7cz6FzYAAAAASUVORK5CYII="
									alt="">
							</div>
							<div class="interface">
								<div class="title">최근 면접</div>
								면접본 날짜 ex)2020.11.27<br>면접
							</div>
							<a class="review-btn" href="/analysisresult/interviewresult.do">결과
								보기</a> <a class="review-btn" href="/analysisresult/interviewlist.do">면접
								분석</a>
						</div>
						<div class="ProspectArea box">
							<div class="title">
								목표기업<a class="link" href="/personal-info">내 프로필</a>
							</div>
							<div class="flex">
								<span>기업</span>
								<div class="prospect null false">
									없음
									<div class="under-line"></div>
								</div>
							</div>
							<div class="flex">
								<span>직무</span>
								<div class="prospect null false">
									없음
									<div class="under-line"></div>
								</div>
							</div>
						</div>



						<div class="HelpArea box">
							<div class="label"></div>
							<div class="title">
								발음연습 &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp
								<button id="modal-open-btn">발음 평가</button>
							</div>

							<br>
							<div class="graph-area">
								<div class="Emotion graph-area">
									<div class="area bright">
										<div class="chartjs-size-monitor">
											<div class="chartjs-size-monitor-expand">
												<div class=""></div>
											</div>
											<div class="chartjs-size-monitor-shrinke">
												<div class=""></div>
											</div>
										</div>
										<div class="label thislabel">한국어</div>
										<div>
											<canvas class="graph-canvas emotion chartjs-render-monitor"
												style="display: block; height: 20px; width: 120px;"
												width="80" height="50"></canvas>
											<div class="graduation-bar">
												<div class="graduation"></div>
												<div class="graduation"></div>
											</div>
											<img
												src="data:image/png;base64,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"
												class="graph-background emotion" alt="">
										</div>
									</div>

									<div class="area neutral">
										<div class="chartjs-size-monitor">
											<div class="chartjs-size-monitor-expand">
												<div class=""></div>
											</div>
											<div class="chartjs-size-monitor-shrinke">
												<div class=""></div>
											</div>
										</div>
										<div class="label thislabel">영어</div>
										<canvas class="graph-canvas emotion chartjs-render-monitor"
											width="80" height="50"
											style="display: block; height: 20px; width: 120px;"></canvas>
										<div class="graduation-bar">
											<div class="graduation"></div>
											<div class="graduation"></div>
										</div>
										<img
											src="data:image/png;base64,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"
											class="graph-background emotion" alt="">
									</div>

								</div>
							</div>
						</div>
						<div class="OrderArea box">
							<div class="title">이용권 구매하기</div>
							<div class="sub-title">1일권 부터 7일권까지 있습니다.</div>
							<a class="start-btn" href="/payment">GO!</a>
						</div>

						<div class="GraphComponent box">
							<div class="nav">
								<div class="title">
									내 성장
									<div class="sub">(최근 5회)</div>
								</div>
								<div class="select-area">
									<div class="emotion btn select">
										<div class="pot"></div>
										표정<img
											src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAcAAAAMCAYAAACulacQAAAABHNCSVQICAgIfAhkiAAAAIFJREFUGFdjZOBRWs7w5V4kAxbACBbjVfrP8PkehI0EEAJYFKCqRlOAYRSyFZiSIDu5FS8x/PvpjSnJrRDPwMToyPD5fgKqJLdiHAMTgzPD5/vxIAMQkmgSCEluxVgGJgZXhs/341D9ya0Yw8DE4M7w+X4sZiBwKxgwfH1wAVvwAQCMDiRNmEhjqAAAAABJRU5ErkJggg=="
											alt="" class="dash">
									</div>
									<div class="gaze btn false">
										<div class="pot"></div>
										시선<img
											src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAcAAAAMCAYAAACulacQAAAABHNCSVQICAgIfAhkiAAAAIFJREFUGFdjZOBRWs7w5V4kAxbACBbjVfrP8PkehI0EEAJYFKCqRlOAYRSyFZiSIDu5FS8x/PvpjSnJrRDPwMToyPD5fgKqJLdiHAMTgzPD5/vxIAMQkmgSCEluxVgGJgZXhs/341D9ya0Yw8DE4M7w+X4sZiBwKxgwfH1wAVvwAQCMDiRNmEhjqAAAAABJRU5ErkJggg=="
											alt="" class="dash">
									</div>
									<div class="sps btn false">
										<div class="pot"></div>
										말 빠르기<img
											src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAcAAAAMCAYAAACulacQAAAABHNCSVQICAgIfAhkiAAAAIFJREFUGFdjZOBRWs7w5V4kAxbACBbjVfrP8PkehI0EEAJYFKCqRlOAYRSyFZiSIDu5FS8x/PvpjSnJrRDPwMToyPD5fgKqJLdiHAMTgzPD5/vxIAMQkmgSCEluxVgGJgZXhs/341D9ya0Yw8DE4M7w+X4sZiBwKxgwfH1wAVvwAQCMDiRNmEhjqAAAAABJRU5ErkJggg=="
											alt="" class="dash">
									</div>
									<div class="audio btn false">
										<div class="pot"></div>
										음성<img
											src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAcAAAAMCAYAAACulacQAAAABHNCSVQICAgIfAhkiAAAAIFJREFUGFdjZOBRWs7w5V4kAxbACBbjVfrP8PkehI0EEAJYFKCqRlOAYRSyFZiSIDu5FS8x/PvpjSnJrRDPwMToyPD5fgKqJLdiHAMTgzPD5/vxIAMQkmgSCEluxVgGJgZXhs/341D9ya0Yw8DE4M7w+X4sZiBwKxgwfH1wAVvwAQCMDiRNmEhjqAAAAABJRU5ErkJggg=="
											alt="" class="dash">
									</div>
									<div class="habit btn false">
										<div class="pot"></div>
										습관어<img
											src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAcAAAAMCAYAAACulacQAAAABHNCSVQICAgIfAhkiAAAAIFJREFUGFdjZOBRWs7w5V4kAxbACBbjVfrP8PkehI0EEAJYFKCqRlOAYRSyFZiSIDu5FS8x/PvpjSnJrRDPwMToyPD5fgKqJLdiHAMTgzPD5/vxIAMQkmgSCEluxVgGJgZXhs/341D9ya0Yw8DE4M7w+X4sZiBwKxgwfH1wAVvwAQCMDiRNmEhjqAAAAABJRU5ErkJggg=="
											alt="" class="dash">
									</div>
								</div>
							</div>
							<div class="graph-area">
								<div class="Emotion graph-area">
									<div class="area bright">
										<div class="chartjs-size-monitor">
											<div class="chartjs-size-monitor-expand">
												<div class=""></div>
											</div>
											<div class="chartjs-size-monitor-shrink">
												<div class=""></div>
											</div>
										</div>
										<div class="label">긍정</div>
										<canvas class="graph-canvas emotion chartjs-render-monitor"
											style="display: block; height: 119px; width: 240px;"
											width="215" height="107"></canvas>
										<div class="graduation-bar">
											<div class="graduation"></div>
											<div class="graduation"></div>
										</div>
										<img
											src="data:image/png;base64,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"
											class="graph-background emotion" alt="">
									</div>
									<div class="area neutral">
										<div class="chartjs-size-monitor">
											<div class="chartjs-size-monitor-expand">
												<div class=""></div>
											</div>
											<div class="chartjs-size-monitor-shrink">
												<div class=""></div>
											</div>
										</div>
										<div class="label">무표정</div>
										<canvas class="graph-canvas emotion chartjs-render-monitor"
											width="215" height="107"
											style="display: block; height: 119px; width: 240px;"></canvas>
										<div class="graduation-bar">
											<div class="graduation"></div>
											<div class="graduation"></div>
										</div>
										<img
											src="data:image/png;base64,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"
											class="graph-background emotion" alt="">
									</div>
									<div class="area dark">
										<div class="chartjs-size-monitor">
											<div class="chartjs-size-monitor-expand">
												<div class=""></div>
											</div>
											<div class="chartjs-size-monitor-shrink">
												<div class=""></div>
											</div>
										</div>
										<div class="label">부정</div>
										<canvas class="graph-canvas emotion chartjs-render-monitor"
											width="215" height="107"
											style="display: block; height: 119px; width: 240px;"></canvas>
										<div class="graduation-bar">
											<div class="graduation"></div>
											<div class="graduation"></div>
										</div>
										<img
											src="data:image/png;base64,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"
											class="graph-background emotion" alt="">
									</div>
									<div class="area surprised">
										<div class="chartjs-size-monitor">
											<div class="chartjs-size-monitor-expand">
												<div class=""></div>
											</div>
											<div class="chartjs-size-monitor-shrink">
												<div class=""></div>
											</div>
										</div>
										<div class="label">당황</div>
										<canvas class="graph-canvas emotion chartjs-render-monitor"
											width="215" height="107"
											style="display: block; height: 119px; width: 240px;"></canvas>
										<div class="graduation-bar">
											<div class="graduation"></div>
											<div class="graduation"></div>
										</div>
										<img
											src="data:image/png;base64,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"
											class="graph-background emotion" alt="">
									</div>
								</div>
							</div>
						</div>
						<div class="HabitArea box">
							<div class="title">내 습관어</div>
							<div class="bar-area">
								<div class="unit">(회)</div>
								<div class="HabitBar">
									<div class="label">아..</div>
									<div class="range">
										<div class="gaze" style="width: 0px;"></div>
									</div>
									<div class="count">0</div>
								</div>
								<div class="HabitBar">
									<div class="label">어..</div>
									<div class="range">
										<div class="gaze" style="width: 0px;"></div>
									</div>
									<div class="count">0</div>
								</div>
								<div class="HabitBar">
									<div class="label">그..</div>
									<div class="range">
										<div class="gaze" style="width: 0px;"></div>
									</div>
									<div class="count">0</div>
								</div>
								<div class="HabitBar">
									<div class="label">저..</div>
									<div class="range">
										<div class="gaze" style="width: 0px;"></div>
									</div>
									<div class="count">0</div>
								</div>
								<div class="HabitBar">
									<div class="label">음..</div>
									<div class="range">
										<div class="gaze" style="width: 0px;"></div>
									</div>
									<div class="count">0</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="MyInterviews">
					<div class="title">면접 내역</div>
					<div class="interview-table">
						<div class="SetInterviewBox">
							<div class="date">2020. 11. 미정 (목)</div>
							<div class="name">면접</div>
							<button class="edit-btn">
								<img src="/static/media/question-write.87c3adf2.svg" alt="">
							</button>
							<a class="button" href="/member/interviewresult">결과 보기</a>
						</div>
					</div>
				</div>
			</div>
			<footer class="Footer --undefined">
				<div class="footer-body">
					<div class="info">
						<span>(주) 두들린</span><br>서울특별시 마포구 마포대로122, 프론트원 16층 | 대표 :
						이태규<br>사업자등록번호: 513-86-01891 | 마케팅ㆍ제휴 문의 :
						bryan95@doodlin.co.kr<br>통신판매업신고번호: 2020-서울강남-03334호 | 연락처 :
						010-3099-2394<br> <br>@Doodlin Corp. All Rights
						Reserved.
					</div>
					<div class="nav-flex">
						<div class="user-agreement">
							<a href="/agreement/user-agree">회원이용약관</a>
						</div>
						<div class="personal-info">
							<a href="/agreement/personal-agree">개인정보처리방침</a>
						</div>
						<div class="about-us">ABOUT US</div>
					</div>
					<div class="logo-area">
						<div class="icons">
							<a
								href="https://www.facebook.com/%EC%9D%B8%EA%B3%B5%EC%A7%80%EB%8A%A5-%EB%AA%A8%EC%9D%98%EB%A9%B4%EC%A0%91-iamterview-103464748013569"
								target="blank"><img
								src="/static/media/facebook-btn.ba58ba0e.svg" alt=""
								class="link-btn"></a><a
								href="https://www.instagram.com/iamterview" target="blank"><img
								src="/static/media/insta-btn.757adbff.svg" alt=""
								class="link-btn"></a><a
								href="https://blog.naver.com/iamterview" target="blank"><img
								src="/static/media/naver-btn.dda55f6e.svg" alt=""
								class="link-btn"></a>
						</div>
						<img src="/static/media/black.68a48bcd.svg" class="doodlin-logo"
							alt="doodlin-logo">
					</div>
				</div>
			</footer>
		</div>
	</div>

	<div class="modal-wrapper">
		<div class="modal-box">
					<div>
					<c:forEach items="${scriptGbList }" var="scriptGb">
						<button class="scriptGbBtn" value="${scriptGb.scriptGbSq }" onclick="random(${scriptGb.scriptGbSq });">
							<div class="label thislabel">${scriptGb.scriptGbContent }</div>
						</button>
						<input type="hidden" name="scritGbSq" value="${scriptGb.scriptGbSq }">
					</c:forEach>
					<button id="modal-close-btn" style="float: right;">close</button>

					<!-- 마이크 테스트 아 다른거 먼저 하자
				<div class="right">
					<img
						src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABQAAAAeCAYAAAAsEj5rAAAABHNCSVQICAgIfAhkiAAAActJREFUSEvtlq1uVVEQhb+laIKgDgkkJJDWgAUUkFBFBYIEUVPDEwBFERBAeAIEkgcA1SatgyYIQhNMW9UKTF0dVYvMYXbpOffce/ctCalgu7N/vrNmZs/MFiOG7SfAbeAi8AP4LunhqDMatmj7G3ClZ30fuC9ppe9sL3AErDD2JU1XAW2/Bh6NMivX1iSFO1pjQKHtz8C1CuCepLM1wB3gXAUQSQOC+hRWA4G5bnD+A8H23/kwAdPloh4HaHsTOA/My7bziryNPD0m8A/jJAEPGhOllZYo2z+BU0AxeaLUs30HWE63LYUPS1Q3JF3NGviyIvU+Spq3/R54APxWbPsDcDcmJE0FqKJA7AELaW4RtCXpcgBDckDD7HVJ18dAd4EXkt51St2SpFdNLh9RGZ+NKTm/mOpPpwu+Snqca9EenqWQxl0xf1gcOlV6HXg+rMyn3+4lLMx/GopbwPxrt49sAF+A6CMxbgCzwJn8bsEGgAmNqJW/Dwt2RPQT8GZsPSyENGsGuJCKAhIR3Uo/NyaObQHdDbZXgVtAbw/5t8AjaioSpdmyKynK1uFo9ZSsa5dqaRn91iuiC4ysuTkBcLvcv3Jm6NtmAmhr6y80wfzbDYp1UQAAAABJRU5ErkJggg=="
						alt="mic-volume">
					<div class="test">
						<div class="scripTestMic">
							<div class="VolumeMeter">
								<div class="none"></div>
								<div class="none"></div>
								<div class="none"></div>
								<div class="none"></div>
								<div class="none"></div>
								<div class="none"></div>
								<div class="none"></div>
								<div class="none"></div>
								<div class="none"></div>
								<div class="none"></div>
								<div class="none"></div>
								<div class="none"></div>
								<div class="none"></div>
								<div class="none"></div>
								<div class="none"></div>
								<div class="none"></div>
								<div class="none"></div>
								<div class="none"></div>
								<div class="none"></div>
								<div class="none"></div>
								<div class="none"></div>
								<div class="none"></div>
								<div class="none"></div>
								<div class="none"></div>
								<div class="none"></div>
								<div class="none"></div>
								<div class="none"></div>
								<div class="none"></div>
								<div class="none"></div>
								<div class="none"></div>
								<div class="none"></div>
								<div class="none"></div>
								<div class="none"></div>
								<div class="none"></div>
								<div class="none"></div>
								<div class="none"></div>
								<div class="none"></div>
								<div class="none"></div>
								<div class="none"></div>
							</div>
						</div>
					</div>
				</div> -->
			
			</div>

			<div class="modal-content pro" id="scriptModalContent">
			
			</div>
			ㅇㅣ게 뭐야 ?<br>
			<input id="serviceRegion" type="text" size="40" value="YourServiceRegion">
			
			나의 스크립트<br>
			<textarea id="phraseDiv" style="display: inline-block;width:500px;height:200px"></textarea>

			
			<div class="modal-close-box" id="modal-close-box">
				<label>시작하기 버튼을 클릭한 후<br>위의 문장을 소리내어 읽어주세요.
				</label><br>
				<button class="processBtn" id="startTestBtn" onclick="startTest()">시작
					하기</button>
				<button class="processBtn" id="stopTestBtn" onclick="stopTest()">종료
					하기</button>
			</div>

			<br>
			<br>
			<br>
		</div>
	</div>
	<script>
      const modalOpenBtn = document.getElementById("modal-open-btn");
      const modalCloseBtn = document.getElementById("modal-close-btn");
      const modalWrapper = document.querySelector(".modal-wrapper");

      console.log(modalWrapper.style);

      modalOpenBtn.addEventListener("click", () => {
        modalWrapper.style.display = "flex";
      });

      modalCloseBtn.addEventListener("click", () => {
        modalWrapper.style.display = "none";
      });
    </script>
</body>
</html>