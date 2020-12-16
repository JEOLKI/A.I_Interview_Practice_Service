<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="/js/microsoft.cognitiveservices.speech.sdk.bundle.js"></script>
<script src="https://cdn.jsdelivr.net/npm/microsoft-cognitiveservices-speech-sdk@latest/distrib/browser/microsoft.cognitiveservices.speech.sdk.bundle-min.js">
</script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
$(document).ready(function(){
   // Replace below with your own subscription key
   const speechSubscriptionKey = "c8fade57c0084e95b64bf948ed3184a5";
   // Replace below with your own service region (e.g., "westus").
   const serviceRegion = "koreacentral";
   
   
   
//    const sdk = require("microsoft-cognitiveservices-speech-sdk");
   const speechConfig = sdk.SpeechConfig.fromSubscription(speechSubscriptionKey, serviceRegion);
   
   
   function fromFile() {
      str = "";
base64 = btoa(str.replace(/[\u00A0-\u2666]/g, function(c) {
          return '&#' + c.charCodeAt(0) + ';';
      }));
      wav = makeblob(base64);
      
       // wavByteContent should be a byte array of the raw wav content
       let file = new File([wav],"wav");
       let audioConfig = sdk.AudioConfig.fromWavFileInput(file);
       let recognizer = new sdk.SpeechRecognizer(speechConfig, audioConfig);
         
         
         recognizer.recognizeOnceAsync(result => { console.log(`RECOGNIZED: Text=${result.text}`);
       });
       
       
       switch (result.reason) {
      case ResultReason.RecognizedSpeech:
          console.log(`RECOGNIZED: Text=${result.text}`);
          break;
      case ResultReason.NoMatch:
          console.log("NOMATCH: Speech could not be recognized.");
          break;
      case ResultReason.Canceled:
          const cancellation = CancellationDetails.fromResult(result);
          console.log(`CANCELED: Reason=${cancellation.reason}`);
      
          if (cancellation.reason == CancellationReason.Error) {
              console.log(`CANCELED: ErrorCode=${cancellation.ErrorCode}`);
              console.log(`CANCELED: ErrorDetails=${cancellation.errorDetails}`);
              console.log("CANCELED: Did you update the subscription info?");
          }
          break;
      }
       
       
       
   }
   fromFile();
   

});
    function makeblob(dataURL) {
        var BASE64_MARKER = ';base64,';
        if (dataURL.indexOf(BASE64_MARKER) == -1) {
            var parts = dataURL.split(',');
            var contentType = parts[0].split(':')[1];
            var raw = decodeURIComponent(parts[1]);
            return new Blob([raw], { type: contentType });
        }
        var parts = dataURL.split(BASE64_MARKER);
        var contentType = parts[0].split(':')[1];
        var raw = window.atob(parts[1]);
        var rawLength = raw.length;

        var uInt8Array = new Uint8Array(rawLength);

        for (var i = 0; i < rawLength; ++i) {
            uInt8Array[i] = raw.charCodeAt(i);
        }

        return new Blob([uInt8Array], { type: contentType });
    }
</script>
</head>
<body>
   인터뷰 텍스트 추출 from 파일
</body>
</html>