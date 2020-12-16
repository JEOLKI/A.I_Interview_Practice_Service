<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>AI_INTERVIEW</title>

<%@ include file="/WEB-INF/views/layout/commonLib.jsp" %>

<script type="text/javascript">

	$(document).ready(function(){
		
		$(".input-area input[type='text']").on('change', function(){
			var sharePw = $(".input-area input[type='text']").val();
			
			if("${sharePw}".length == 4){
				$(".submit-btn").removeAttr("disabled");
				$(".submit-btn").addClass("active");
			}else{
				$(".submit-btn").attr("disabled", "disabled");
				$(".submit-btn").removeClass("active");
			}
			
		})
		
		$(".submit-btn").on("click", function() {
			$('.wrong-message').remove();
			var sharePw = $(".input-area input[type='text']").val();
			if(sharePw == "${sharePw}"){
				$(".submit-btn").removeAttr("disabled");
				$(".submit-btn").addClass("active");
				document.location="${shareUrl}"; 
			}else{
				$(".submit-btn").attr("disabled", "disabled");
				$(".submit-btn").removeClass("active");
				$('.input-area').prepend("<div class='wrong-message'>잘못된 코드입니다.</div>");
				
			}
		})
	});	

</script>
	
<style type="text/css">

	.able{
		background: #000d22;
		color: white;
	}
	
	
	
</style>	
</head>
<body>

   <div id="root">
      <div class="PassWordInput PopUp Block">
         <div class="content-box">
            <img src="/images/ai_interview_logo_big.png" alt="">
            <div class="message">비밀번호 입력</div>
            <div class="sub-message">
               <span>${shareMemId }</span> 님의 분석 결과를 확인하기 위해서 4자리의 비밀번호를 입력해 주세요. 비밀번호를 입력한 사람만 공유한 결과를 볼 수 있습니다.
            </div>
            <div class="warn-message">※모바일에서는 확인 불가</div>
            <div class="input-area">
               <input id="pw" type="text" minlength="4" maxlength="4" value="">
            </div>
            <input type="button" class="submit-btn" disabled="disabled" value="확인"/>
         </div>
      </div>
   </div>
   
</body>
</html>