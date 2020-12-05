<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>


<html>
    <div class="left">
        <div id="startButton" class="button">
        Start
        </div>
        <h2>Preview</h2>
        <video id="preview" width="160" height="120" autoplay muted></video>
    </div>

    <div class="right">
        <div id="stopButton" class="button">
        Stop
        </div>
        <h2>Recording</h2>
        <video id="recording" width="160" height="120" controls></video>
        <a id="downloadButton" class="button">
        Download
        </a>
    </div>
    
    <input id="videotest" type="file" value="" name="video">
    
	<button id="dd">zz</button>
	
    <script>

    let preview = document.getElementById("preview");
    let recording = document.getElementById("recording");
    let startButton = document.getElementById("startButton");
    let stopButton = document.getElementById("stopButton");
    let downloadButton = document.getElementById("downloadButton");
    let logElement = document.getElementById("log");

    let recordingTimeMS = 5000;
    let recordedBlob ="";

    function log(msg) {
        //logElement.innerHTML += msg + "\n";
    }

    function wait(delayInMS) {
        return new Promise(resolve => setTimeout(resolve, delayInMS));
    }

    function startRecording(stream, lengthInMS) {
        let recorder = new MediaRecorder(stream);
        let data = [];

        recorder.ondataavailable = event => data.push(event.data);
        recorder.start();
        log(recorder.state + " for " + (lengthInMS/1000) + " seconds...");

        let stopped = new Promise((resolve, reject) => {
        recorder.onstop = resolve;
        recorder.onerror = event => reject(event.name);
        });

        let recorded = wait(lengthInMS).then(
        () => recorder.state == "recording" && recorder.stop()
        );

        return Promise.all([
            stopped,
            recorded
        ])
        .then(() => data);
    }

    function stop(stream) {
        stream.getTracks().forEach(track => track.stop());
    }

    startButton.addEventListener("click", function() {
        navigator.mediaDevices.getUserMedia({
            video: true,
            audio: false
        }).then(stream => {
                preview.srcObject = stream;
                downloadButton.href = stream;
                preview.captureStream = preview.captureStream || preview.mozCaptureStream;
                return new Promise(resolve => preview.onplaying = resolve);
              }).then(() => startRecording(preview.captureStream(), recordingTimeMS))
              .then (recordedChunks => {
                recordedBlob = new Blob(recordedChunks, { type: "video/webm" });
                
                recording.src = URL.createObjectURL(recordedBlob);  
                downloadButton.href = recording.src;
                downloadButton.download = "RecordedVideo.webm";

                log("Successfully recorded " + recordedBlob.size + " bytes of " +
                    recordedBlob.type + " media.");
              })
              .catch(log);
        }, false);


        stopButton.addEventListener("click", function() {
        stop(preview.srcObject);
        }, false);

        
        
        
        $(document).ready(function(){
    		$("#dd").on("click", function(){
				
    		    var fd = new FormData();
    		    fd.append("name", "test");
    		    fd.append("data", recordedBlob);
    		    $.ajax({
    		        type: 'POST',
    		        url:'/answer/test.do',
    		        data: fd,
    		        contentType: false, //don't set this, it will be set automatically and properly 
    		        processData: false,
    		        success: function (newSkill) {
    		            console.log(newSkill)
    		        }
    		    })
    		    
    		});
    	});
        
 
    </script>
</html>