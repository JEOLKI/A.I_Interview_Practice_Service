<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Detect Faces Sample</title>
	<link rel="stylesheet" href="/css/main.css" type="text/css" media="all">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script src="/js/capture.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.9.0/jquery.min.js"></script>

</head>
<body>

<div class="contentarea">

  <div class="camera">
    <video id="video" autoplay >Video stream not available.</video>
    <button id="startbutton">Take photo</button> 
  </div>
  
  <canvas id="canvas">
  </canvas>
  
  <div class="output">
    <img id="photo" alt="The screen capture will appear in this box."> 
  </div>
  
	<div id="imgurl">
	
	</div>
	
</div>

	<script type="text/javascript">
		
		var index = 0;
	
		function processImage() {
			var subscriptionKey = "cae766a534074d6b89f02281da4e14cf";
			var uriBase = "https://faceanalysis-jh.cognitiveservices.azure.com/face/v1.0/detect";
			// Request parameters.
			var params = {
				"detectionModel" : "detection_01",
				"returnFaceAttributes": "age,gender,headPose,smile,facialHair,glasses,emotion,hair,makeup,occlusion,accessories,blur,exposure,noise",
				"returnFaceId" : "true"
			};
			
			// Display the image.
			var sourceImageUrl = document.getElementById("inputImage").value;
			document.querySelector("#sourceImage").src = sourceImageUrl;
			// Perform the REST API call.
			$.ajax({
								url : uriBase + "?" + $.param(params),
								// Request headers.
								processData: false,
								beforeSend : function(xhrObj) {
									xhrObj.setRequestHeader("Content-Type",
											"application/octet-stream");
									xhrObj.setRequestHeader(
											"Ocp-Apim-Subscription-Key",
											subscriptionKey);
								},
								type : "POST",
								
								// Request body.
								data : makeblob($('#inputImage').val()),
							})
					.done(
							function(data) {
								// Show formatted JSON on webpage.
								emotion = data[0].faceAttributes.emotion;
								face = data[0].faceRectangle
								var html = '<input type="text" name="imageAnalysisVOList['+index+'].anger" value="'+emotion.anger+'" >'
								 html += '<input type="text" name="imageAnalysisVOList['+index+'].contempt" value="'+emotion.contempt+'" >'
								 html += '<input type="text" name="imageAnalysisVOList['+index+'].disgust" value="'+emotion.disgust+'" >'
								 html += '<input type="text" name="imageAnalysisVOList['+index+'].fear" value="'+emotion.fear+'" >'
								html += '<input type="text" name="imageAnalysisVOList['+index+'].happiness" value="'+emotion.happiness+'" >'
								 html += '<input type="text" name="imageAnalysisVOList['+index+'].neutral" value="'+emotion.neutral+'" >'
								 html += '<input type="text" name="imageAnalysisVOList['+index+'].sadness" value="'+emotion.sadness+'" >'
								 html += '<input type="text" name="imageAnalysisVOList['+index+'].surprise" value="'+emotion.surprise+'" >'
								 html += '<input type="text" name="imageAnalysisVOList['+index+'].faceTop" value="'+face.top+'" >'
								 html += '<input type="text" name="imageAnalysisVOList['+index+'].faceLeft" value="'+face.left+'" >'
								 html += '<input type="text" name="imageAnalysisVOList['+index+'].faceHeight" value="'+face.height+'" >'
								 html += '<input type="text" name="imageAnalysisVOList['+index+'].faceWidth" value="'+face.width+'" >'
								
								$("#ddd").append(html);
								
								 index += 1;
								 
								$("#responseTextArea").val(JSON.stringify(data, null, 2));
							})
					.fail(
							function(jqXHR, textStatus, errorThrown) {
								// Display error message.
								var errorString = (errorThrown === "") ? "Error. "
										: errorThrown + " (" + jqXHR.status
												+ "): ";
								errorString += (jqXHR.responseText === "") ? ""
										: (jQuery.parseJSON(jqXHR.responseText).message) ? jQuery
												.parseJSON(jqXHR.responseText).message
												: jQuery
														.parseJSON(jqXHR.responseText).error.message;
								alert(errorString);
							});
		};


		makeblob = function (dataURL) {
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
		
		$(document).ready(function(){
			
			
			
			/* var jsonData = JSON.stringify(param);
		    jQuery.ajaxSettings.traditional = true;
		    */
			
			$("#testgo").on('click', function(){
				$("#ddd").submit();
				
			})
			
		});		
		
	</script>


	<input type="text" name="inputImage" id="inputImage"
		value="" />
	<button onclick="processImage()">Analyze face</button>
	<br>
	<br>
	<div id="wrapper" style="width: 1020px; display: table;">
		<div id="jsonOutput" style="width: 600px; display: table-cell;">
			Response:<br>
			<br>
			<textarea id="responseTextArea" class="UIInput"
				style="width: 580px; height: 400px;"></textarea>
		</div>
		<div id="imageDiv" style="width: 420px; display: table-cell;">
			Source image:<br>
			<br> <img id="sourceImage" width="400" />
		</div>
	</div>

	<button id="testgo">전송테스트</button>

	<form id="ddd" action="/test/test.do" method="post">
	
	</form>


</body>
</html>