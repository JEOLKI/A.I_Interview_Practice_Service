<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<!-- <script src="/js/microsoft.cognitiveservices.speech.sdk.bundle.js"></script> -->
<script src="https://cdn.jsdelivr.net/npm/microsoft-cognitiveservices-speech-sdk@latest/distrib/browser/microsoft.cognitiveservices.speech.sdk.bundle-min.js">
</script>
<script src="/js/require.js"></script>
<script type="text/javascript" src="/js/microsoft.cognitiveservices.speech.sdk.bundle.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
	const sdk = require(["microsoft-cognitiveservices-speech-sdk"]);
	const speechConfig = sdk.SpeechConfig.fromSubscription("197c1a7bc63c41a1931328e15925d597",  "koreacentral");
	const recognizer = new sdk.SpeechRecognizer(speechConfig);
$(document).ready(function(){
		console.log('연결');
	$('#a').on('click',function(){
		console.log('연결');
		fromMic();
	});
});

/* jshint eversion: 6 */
function fromMic() {
    let audioConfig = sdk.AudioConfig.fromDefaultMicrophoneInput();
    let recognizer = new sdk.SpeechRecognizer(speechConfig, audioConfig);
    
    console.log('Speak into your microphone.');
    
    recognizer.recognizing = (s, e) => {
        console.log(`RECOGNIZING: Text=${e.result.text}`);
    };

    recognizer.recognized = (s, e) => {
        if (e.result.reason == ResultReason.RecognizedSpeech) {
            console.log(`RECOGNIZED: Text=${e.result.text}`);
        }
        else if (e.result.reason == ResultReason.NoMatch) {
            console.log("NOMATCH: Speech could not be recognized.");
        }
    };

    recognizer.canceled = (s, e) => {
        console.log(`CANCELED: Reason=${e.reason}`);

        if (e.reason == CancellationReason.Error) {
            console.log(`"CANCELED: ErrorCode=${e.errorCode}`);
            console.log(`"CANCELED: ErrorDetails=${e.errorDetails}`);
            console.log("CANCELED: Did you update the subscription info?");
        }

        recognizer.stopContinuousRecognitionAsync();
    };

    recognizer.sessionStopped = (s, e) => {
        console.log("\n    Session stopped event.");
        recognizer.stopContinuousRecognitionAsync();
    };
}
fromMic();
</script>
</head>
<body>

<input type="button" id="a" value="녹음">


</body>
</html>