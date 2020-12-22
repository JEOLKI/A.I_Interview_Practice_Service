<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>AI_INTERVIEW</title>

<%@ include file="/WEB-INF/views/layout/commonLib.jsp" %>

<!-- Resources -->
<script src="https://cdn.amcharts.com/lib/4/core.js"></script>
<script src="https://cdn.amcharts.com/lib/4/charts.js"></script>
<script src="https://cdn.amcharts.com/lib/4/themes/animated.js"></script>

<script>
	
	$(document).ready(function() {
		
		$(".question-toggle").on('click', function(){
			
			$(".report").empty();
			
			if($(this).parent().attr("class").indexOf("close")>0){
				
				$(this).parent().addClass("open");
				$(this).parent().removeClass("close")
				
				$(this).parent().prevAll().addClass("close")
				$(this).parent().nextAll().addClass("close")
				
				$(this).parent().prevAll().removeClass("open")
				$(this).parent().nextAll().removeClass("open")

				
				var questSq = $(this).data("quest_sq");
				console.log(questSq);
					
				$.ajax({
						url : "/analysis/answer/retrieve.do",
						data : { "questSq" : questSq },
						success : function(data){
							var html = data;	
							$("#report"+questSq+"").html(html);
						}
				})
				
			}else if($(this).parent().attr("class").indexOf("open")>0){
				$(this).parent().addClass("close");
				$(this).parent().removeClass("open");
			} 
	
		})
		
		$(".pw-input").on('change', function(){
			var sharePw = $(".pw-input").val();
			
			if(sharePw.length == 4){
				$(".share-btn").removeAttr("disabled");
				$(".share-btn").addClass("active");
			}else{
				$(".share-btn").attr("disabled", "disabled");
				$(".share-btn").removeClass("active");
			}
			
		})
		
		$(".ShareBox").on("click", ".content-box > .active", function() {
			 var sharePw = $(".pw-input").val();
			 var dummy = document.createElement("textarea");
			 document.body.appendChild(dummy);
			 dummy.value = "${serverIp}/analysis/share.do?sharePw="+sharePw+"&interviewSq=${interviewVO.interviewSq }&shareMemId=${S_MEMBER.memId }&profilePath=${S_MEMBER.memProfilePath}";
			 dummy.select();
			 document.execCommand("copy");
			 document.body.removeChild(dummy);
			 alert("링크가 복사 되었습니다.")
		})
		
		$(".x-btn").on('click', function() {
			$(".PopUp").hide();
		})
		
		$(".title-flex .share-btn").on("click", function() {
			$(".PopUp").show();
		})
		
		$(".check-pw-mask").on('click', '.active',  function() {
			$(".pw-input").attr("type","text");
			$(this).addClass("checked");
			$(this).removeClass("active");
		})
		
		$(".check-pw-mask").on('click', '.checked',  function() {
			$(".pw-input").attr("type","password")
			$(this).addClass("active");
			$(this).removeClass("checked");
		})
		
		
		
	});
	
</script>

<style type="text/css">

#imagechartdiv {
  width: 100px;
  height: 100px;
}

.canvas-flex div{
	text-align: center;
}

#interviewNm{
	width: auto;
	display: inline-block;
}

#interviewNmUpdateBtn{
	position: absolute;
	margin-top: 20px;
	margin-left: 270px;
	background-color: transparent;
	z-index: 11;
}

#videoChart{
	height: 100%;
}


</style>
</head>

<body>

	<div class="ShareBox PopUp" style="display: none;">
	   <div class="content-box">
	      <img src="/images/xbtn.png" alt="" class="x-btn">
	      <div class="message">면접 결과 공유하기</div>
	      <div class="sub-message">분석 결과를 공유하기 위해서 4자리 숫자로 비밀번호를 설정해 주세요.
	         비밀번호를 입력한 사람만 공유한 결과를 볼 수 있습니다.</div>
	      <div class="warn-message">※모바일에서는 확인 불가</div>
	      <input type="password" class="pw-input" minlength="4" maxlength="4" autocomplete="off" value="">
	      <div class="check-pw-mask">
	         <div class="CustomCheck active undefined">
	         	<img alt="" src="/images/icon.8473a800.svg">
	         </div>
	         	비밀번호 보기
	      </div>
	      <div class="share-btn" >링크 복사</div>
	   </div>
	</div>

	<div id="root">
		<div class="Review">
		
			<%@ include file="/WEB-INF/views/layout/header.jsp" %>
			
			<div class="body">
				<div class="date">${interviewVO.interviewDate }</div>
				<form action="${cp }/interview/update.do" method="POST">
					<div class="title-flex">
						<div class="title-form">
							<input type="hidden" name="interviewSq" value="${interviewVO.interviewSq }">
							<input type="text" name="interviewNm" class="title-text" id="interviewNm" placeholder="${interviewVO.interviewNm }" value="${interviewVO.interviewNm }"> 
							<span></span>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<button id="interviewNmUpdateBtn" type="submit">
							<img
							src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAACNiR0NAAAABHNCSVQICAgIfAhkiAAAAUVJREFUOE+t1L1KxEAUBeBzM0RhC7WwECzUN4jdJou4im6tvY2NjY1PY2Ohjb11IhiQzLKFkAcQ1DcQbCTD5spEYtb8LMkmaVJk5ptzZ+aG0PFDi3iWNVzr9ZZuiXDCzCGAcyk9/UZj8Bczn4jIysKwHwTewUKg4xz7RLSfr4yZd3XK2glt+3BTCFqOY2MFgEZXU5SZP6T0tmsn1BiRCAAS02lkC2Guz6JxjNPx2H2oBaYYEW3pCcx4VyqyTdPc0CiAKym9uzTt3JLzWFYiXpWK9pTCdxj6n7P7WQlqzDDEM0A7FVfrLAjc+/y3UrAqWZYwvpDy8aZsoQLYBiscSlvsH9gF9gd2hSVgl1gCOs7ojQhJ2xT7E5dSutdN/kg0GIy4HKu+GvMWKAWZF8OSkvMJ22AJ2O8fDbMOML4mE/elyZ7lx/4AFWGhFXYrDvUAAAAASUVORK5CYII="
							alt="edit-icon">
							</button>
						</div>
						<div class="share-btn">
							<span aria-hidden="true" class="fa fa-share-square-o fa undefined"></span>
							면접결과 공유하기
						</div>
					</div>
				</form>

					<c:forEach items="${resultList }" var="question">
						<div class="QuestionReview close">
							<div class="question-toggle" data-quest_sq="${question.questSq }">
								<div class="mark-color"></div>
								<div class="no">질문 ${question.rnum }</div>
								<div class="question">${question.questContent }</div>
								<img
									src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAXCAYAAAAC9s/ZAAAABHNCSVQICAgIfAhkiAAAAOpJREFUOE/t1D0OgkAQBeA3JiaWHIFOKgkF1HoS8QR6A/UkchVbKACrLTkCrYnJmEHXwGYXLS3YihDex/7MDsExgqI+ATgCOKs4lGfroAnAtAf4hz3wy9Jroqg1K/LnUl7mVXWf89pEvgFBXmcqCVMKipqZWZBNHxkDJAzCVsUhdYBM30RcgA5L5gXktxTEFxOxAf0wmHYqWWVdKduQxWN26PcDW1iyn7tgIgBdibCXhgKGL2vuTur9Z31qg8vUR/QHDG4J5NnCgxnogA1xha2AuSdjYScwQIw1mxXrbCgdUpa+iqLG1Xjl/ROZHtQYX28HyAAAAABJRU5ErkJggg=="
									alt="up-down-dash" class="up-down-dash">
							</div>
							<div class="report" id="report${question.questSq }"> </div>						
						</div>	
					</c:forEach>


			</div>
			<img
				src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADMAAABMCAYAAADA1Y8+AAAABHNCSVQICAgIfAhkiAAABAlJREFUaEPtmEtsjFEYht/v77QkMqaIFJ2Z0tYUFRqkTSxII24bdCep2IjYIBoLFuIa4rIgLhHEQkLCxiWEIOKykFSIEkSbInoRUrTjkih6jpxeGNOZ/nP+c86o5MxmFvN973ee9z1z/jND0PkaVRCCg4kADQM5AYBnd78HAIqCsyhAbV3v/D04PUFzfZOuJZCiECFYUABOJXCoBETDpfU4bwHHQxCvQWP9SwBcWqO7wTtMuGAquLMQRDleh/fq4/wdiF1Aw4sHXjTlYUaOHQ8fVYCQ52VgSj0deA2Os3hT9zyleg/J+JAbqUQGpssMUKrtwF00150C8DMVndSSCYSHwD9wFRzkpiKqtYahGZ+/HUC0odVN1x1mRGExMp1lIAxyEzP2OcdX/GDH8bb+aV8z+oIhhIoWAGw+iNyhjZF0C3POAecyGmsvJjvxki9yZOEUZDorTK9RXr/jaLLTLjFMTjgfmQOr4CBLfpjhDobv4GxXoodtb5js0dnwZ20AwW94Wd7lGT6ivXU7Wlq+xIr0hgmOXQ2Hir1PSlMnZ+LGcDg5TG5+BBm+tWlajvqY9m+78K5BXIE6X38nEyxaB4fnq09JkwKjF2iq3d0bJpQ/DeRbnqZl6BvDfx5D48v7sclkIBTZBsIwfVPSpMTxAY11G8WVp2ubiad8lrM6TeP1j/nO9ovbQRdMsLASjjND/5Q0KTJ2B031p7pgwkW7AR5QGc1f13pup7wiz72djYza0FS7jpCTNwYDBqxXUwP+KYxYfHv7TkIwUgEH81Rh/n0/u0T4X574bm5xViOSWQ8HY9xq+/3nDK8I4cgWcTj3+8W6L/Ct+AG2B8QHu9d6qwj4B+PcsYOo2roDj55J/T8hN5DTJ0IocggEn1xnatUC5NaZEygpnoDWaBTli5eaA+LiBhCOHEltaXJVsSA9naaBjMAkAkkHkHaYWJBo9DNuVt/DojmzcP7aDZSXlSIQ8Bvbclph4kFmLl6CirmzsWnNSmzZdxDnrl7H7dMnjQFpg0kEIk6vzVWrfsNs3nsAkyeMMwakDabmyoXOhYqtJRLpOYbjYcR3Jx5o6KRSudMlSbU2GHHRjAcRMxPBxAMp35q74bTBtD2+/1ciPeYlg4kFyp40rX8lI7ZOoid8XzA9QLpuBtqSSWatG4yWSHRvMwujM5bOPwEN3c1SOQA0s1gYKUPtASBl159i+52RMc5uMxm3YmrtNpMxbmZZKcqnl+Hm3Wrcrr4n0ypdazwZ6RUpNFgYBfOMttpkjNqrIG6TUTDPaKtNxqi9CuI2GQXzjLbaZIzaqyBuk1Ewz2irTcaovQriNhkF84y22mSM2qsgbpNRMM9oq03GqL0K4jYZBfOMttpkjNqrIP4LB83BPP2b2F4AAAAASUVORK5CYII="
				alt="top-btn" class="top-btn hide">
				
				
			<footer class="SemiFooter --undefined">
				<footer class="TransparentFooter">
					<div class="nav-flex">
						<div class="user-agreement">
							<a>회원이용약관</a>
						</div>
						<div class="personal-info">
							<a>개인정보처리방침</a>
						</div>
						<div class="about-us">ABOUT US</div>
					</div>
					<div class="info">
						<img style="width: 80px; height: 15px; display: inline-block; vertical-align: bottom;" src="/images/ai_interview_logo_big.png" class="footer-logo" alt="footer-logo">@<b>Ourtech
							Corp.</b> All Rights Reserved.
					</div>
				</footer>
			</footer>
		</div>
	</div>
	
</body>

</html>