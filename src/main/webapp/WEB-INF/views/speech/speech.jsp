   <%@ page language="java" contentType="text/html; charset=UTF-8"
       pageEncoding="UTF-8"%>
   <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
   <html>
      <head>
       <script src="/js/jquery.js"></script>
       <script src="/js/speech/recorder.js"></script>
       <script src="/js/speech/Fr.voice.js?=v2"></script>
       <script src="/js/speech/recorder2.js"></script>
        <style>
         .button{
           display: inline-block;
           vertical-align: middle;
           margin: 0px 5px;
           padding: 5px 12px;
           cursor: pointer;
           outline: none;
           font-size: 13px;
           text-decoration: none !important;
           text-align: center;
           color:#fff;
           background-color: #4D90FE;
           background-image: linear-gradient(top,#4D90FE, #4787ED);
           background-image: -ms-linear-gradient(top,#4D90FE, #4787ED);
           background-image: -o-linear-gradient(top,#4D90FE, #4787ED);
           background-image: linear-gradient(top,#4D90FE, #4787ED);
           border: 1px solid #4787ED;
           box-shadow: 0 1px 3px #BFBFBF;
         }
         a.button{
           color: #fff;
         }
         .button:hover{
           box-shadow: inset 0px 1px 1px #8C8C8C;
         }
         .button.disabled{
           box-shadow:none;
           opacity:0.7;
         }
         </style>
		<script>
			$(document).ready(function(){
				$("#Test").on('click', function(){
					
					var aq = $("#Test").val();
					console.log(aq)
					
					var fd = new FormData();
					fd.append("name", "test");
					fd.append("test", aq);
					for (var pair of fd.entries()) { console.log(pair[0]+ ', ' + pair[1]); }
					console.log(fd)
				})
			})
			
		
		</script>       
       
       
      </head>
      <body>
       <div id="content">
         <h2>스피치 평가</h2>
<!--          <audio controls src="" id="audio"></audio> -->
         <div style="margin:10px;">
           <a class="button" id="record">Start</a>
<!--            <a class="button disabled one" id="stop">Reset</a> -->
<!--            <a class="button disabled one" id="play">Play</a> -->
           <a class="button disabled one" id="download">Stop</a>
<!--            <a class="button disabled one" id="base64">Base64 URL</a> -->
<!--            <a class="button disabled one" id="mp3">MP3 URL</a> -->
           <a></a>
         </div>
       </div>
       
      </body>
   </html>