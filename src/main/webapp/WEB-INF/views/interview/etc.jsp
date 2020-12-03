<%@ page language="java" contentType="text/html; charset=UTF-8"                                       
    pageEncoding="UTF-8"%>                                                                            
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>                                                                                                
<head>                                                                                                
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">                                   
<script	src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>                   
<title>Insert title here</title>                                                                      
</head>                                                                                               
<script>   
function colorPids(vol) {                                                                             
	  let all_pids = $('.pid');                                                                       
	  let amout_of_pids = Math.round(vol/10);                                                         
	  let elem_range = all_pids.slice(0, amout_of_pids)                                               
	  for (var i = 0; i < all_pids.length; i++) {                                                     
	    all_pids[i].style.backgroundColor="#e6e7e8";                                                  
	  }                                                                                               
	  for (var i = 0; i < elem_range.length; i++) {                                                   
                                                                                                      
	    // console.log(elem_range[i]);                                                                
	    elem_range[i].style.backgroundColor="#69ce2b";                                                
	  }                                                                                               
	}                                                                                                 
	                                                                                                  
	                                                                                                  
navigator.mediaDevices.getUserMedia({ audio: true, video: true })                                     
.then(function(stream) {                                                                              
  audioContext = new AudioContext();                                                                  
  analyser = audioContext.createAnalyser();                                                           
  microphone = audioContext.createMediaStreamSource(stream);                                          
  javascriptNode = audioContext.createScriptProcessor(2048, 1, 1);                                    
                                                                                                      
  analyser.smoothingTimeConstant = 0.8;                                                               
  analyser.fftSize = 1024;                                                                            
                                                                                                      
  microphone.connect(analyser);                                                                       
  analyser.connect(javascriptNode);                                                                   
  javascriptNode.connect(audioContext.destination);                                                   
  javascriptNode.onaudioprocess = function() {                                                        
      var array = new Uint8Array(analyser.frequencyBinCount);                                         
      analyser.getByteFrequencyData(array);                                                           
      var values = 0;                                                                                 
                                                                                                      
      var length = array.length;                                                                      
      for (var i = 0; i < length; i++) {                                                              
        values += (array[i]);                                                                         
      }                                                                                               
                                                                                                      
      var average = values / length;                                                                  
                                                                                                      
    console.log(Math.round(average));                                                                 
    colorPids(average);                                                                               
  }                                                                                                   
  })                                                                                                  
  .catch(function(err) {                                                                              
    /* handle the error */                                                                            
});                                                                                                   
                                                                                                      
                                                                                                      
</script>                                                                                             
<style>                                                                                               
.pids-wrapper{                                                                                        
  width: 100%;                                                                                        
}                                                                                                     
.pid{                                                                                                 
  width: calc(10% - 10px);                                                                            
  height: 10px;                                                                                       
  display: inline-block;                                                                              
  margin: 5px;                                                                                        
}                                                                                                     
</style>                                                                                              
<body>                                                                                                
마이크 테스트                               
                                                              
<div class="pids-wrapper">                                                                            
  <div class="pid"></div><br>                                                                         
  <div class="pid"></div><br>                                                                         
  <div class="pid"></div><br>                                                                         
  <div class="pid"></div><br>                                                                         
  <div class="pid"></div><br>                                                                         
  <div class="pid"></div><br>                                                                         
  <div class="pid"></div><br>                                                                         
  <div class="pid"></div><br>                                                                         
  <div class="pid"></div><br>                                                                         
  <div class="pid"></div><br>                                                                         
</div>                                                                                                
                                                                                                      
</body>                                                                                               
</html>