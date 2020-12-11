
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="/js/jquery.js"></script>
<script src="/js/speech/recorder.js"></script>
<script src="/js/speech/Fr.voice.js?=v2"></script>
<script src="/js/speech/recorder2.js"></script>
<link href="/css/speech/main.css" rel="stylesheet">
<link href="/css/speechfontawesome-all.min.css" rel="stylesheet">
<link href="/css/speech/noscript.css" rel="stylesheet">
<style>
/* .button { */
/* 	display: inline-block; */
/* 	vertical-align: middle; */
/* 	margin: 0px 5px; */
/* 	padding: 5px 12px; */
/* 	cursor: pointer; */
/* 	outline: none; */
/* 	font-size: 13px; */
/* 	text-decoration: none !important; */
/* 	text-align: center; */
/* 	color: #fff; */
/* 	background-color: #4D90FE; */
/* 	background-image: linear-gradient(top, #4D90FE, #4787ED); */
/* 	background-image: -ms-linear-gradient(top, #4D90FE, #4787ED); */
/* 	background-image: -o-linear-gradient(top, #4D90FE, #4787ED); */
/* 	background-image: linear-gradient(top, #4D90FE, #4787ED); */
/* 	border: 1px solid #4787ED; */
/* 	box-shadow: 0 1px 3px #BFBFBF; */
/* } */

a.button {
	color: #fff;
}

.button:hover {
	box-shadow: inset 0px 1px 1px #8C8C8C;
}

.button.disabled {
	box-shadow: none;
	opacity: 0.7;
}
</style>
<script>
// 			$(document).ready(function(){
// 				$("#Test").on('click', function(){
					
// 					var aq = $("#Test").val();
// 					console.log(aq)
					
// 					var fd = new FormData();
// 					fd.append("name", "test");
// 					fd.append("test", aq);
// 					for (var pair of fd.entries()) { console.log(pair[0]+ ', ' + pair[1]); }
// 					console.log(fd)
// 				})
// 			})
			
		
		</script>


</head>
<body>

								
<div id="main">							
<section id="intro" class="main">
	<div class="spotlight">
		<div class="content">
			<header class="major">
			<h2>English Speech Test</h2>
			</header>
			<p>
			Start를 누르고 영어로 자유롭게 말하면 됩니다.<br> 끝나면 stop을 눌러주세요
			</p>
			
			<ul class="actions">
				<li><a class="button" id="record">Start</a></li>
				<li><a class="button disabled one" id="download">Stop</a></li>
			</ul>
			
			<span>나의 점수 : </span>&nbsp <a class="myScore" ></a>
		</div>
		<span class="image"><img src="/images/pic01.jpg" alt=""></span>
	</div>
</section>
</div>
<!-- 		<div style="margin: 10px;"> -->
<!-- 			<a class="button" id="record">Start</a> -->
<!-- 			<a class="button disabled one" id="download">Stop</a> -->
<!-- 			<span>나의 점수 : </span>&nbsp <a class="myScore" ></a>  -->
<!-- 			<a></a> -->
<!-- 		</div> -->

</body>
</html>