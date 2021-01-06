<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>AI_INTERVIEW</title>

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
	    window.resizeTo(400,630);
    }
	
$(document).ready(function() {
	
	$('#result').css('display','none');
	$('.present').css("display","none");
	
	// 언어선택
	$('.scriptGbBtn').on('click', function() {
		
		scriptGbContent = $(this).data('content');
		scriptGbSq = $(this).data('sq');
		
		document.location = '/scriptTest/testStart.do?scriptGbSq='+scriptGbSq;
		
	});

});
function close(){
	window.onbeforeunload = function (e) {
		opener.parent.location.reload();
	};
}
</script>

<style>

	body{
		background-color : #f5f7fb;
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
	
	.informLbl{
		margin-top: 30px;
		font-weight: normal;
	}

	html {
		overflow:hidden;
	}

	.contentBox{
		width: 93%;
		padding: 20% 30px;
		background-color: white;
		border-radius: 10px;
		margin: 10px 3%;
		box-shadow: 5px 5px #EAEAEA;
		display: inline-block;
	}
	
	#title{
		font-weight: bold; 
		font-size: 23px; 
		margin-bottom: 40px; 
		display: block; 
		text-align: center;
	}
</style>
</head>

<body onload="close();">
	<div class="contentBox">
		<span id="title">발음 테스트</span>	
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
				<div>
					<img src="/images/speak.svg" style="width: 50%;">
				</div>
				<div style=" margin-top: 40px; font-size: 17px;">
					테스트할 언어를 선택 후 시작하기 버튼을<br>
					클릭하여 출력된 문장을 읽어주세요.<br><br>
				</div>
			</div>
		</div>
	</div>
</body>
</html>