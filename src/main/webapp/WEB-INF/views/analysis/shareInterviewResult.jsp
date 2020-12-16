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
		
		$(".share-btn").on("click",function(){
			 var dummy = document.createElement("textarea");
			 document.body.appendChild(dummy);
			 dummy.value = "${serverIp}/analysis/share.do";
			 dummy.select();
			 document.execCommand("copy");
			 document.body.removeChild(dummy);
			 console.log(dummy.value)
		})
		
		$("#shareLogin").on('click', function() {
			document.location="${cp }/login/home.do"; 
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

</style>
</head>

<body>
	<div id="root">
		<div class="SharedReview">
		
			<%@ include file="/WEB-INF/views/layout/header.jsp" %>
			
			<div class="body">
			
				<div class="title-flex">
					<div class="message-area">
						<div class="title">
							<span>${shareMemId }</span> 님이 공유한 면접 결과입니다
						</div>
						
						<div class="sub-title">아래의 질문들을 클릭하면 그 질문에 대한 자세한 분석 결과를 확인할 수 있습니다.</div>
					</div>
						
					<div class="kakao-suggest">
						친구가 본 모의면접, 궁금하지 않으세요?<br>지금 바로 시작해 보세요!
						<button id="shareLogin" class="login">시작하기</button>
					</div>
				</div>
				
				<div class="date">${interviewVO.interviewDate }</div>
				<div class="title">${interviewVO.interviewNm }</div>

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
							<a href="/agreement/user-agree">회원이용약관</a>
						</div>
						<div class="personal-info">
							<a href="/agreement/personal-agree">개인정보처리방침</a>
						</div>
						<div class="about-us">ABOUT US</div>
					</div>
					<div class="info">
						<img
							src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADcAAAAQCAYAAACycufIAAAABHNCSVQICAgIfAhkiAAAAvJJREFUSEvdVs1O20AQnrGTCiWHhido6Qs03MIatUHFVk8FpF6rkmsvTS+VeipVq16bPgGoTxBuKEbCHLLkVvMGeQQ4JEgE71QTe+naMf/hgm9rz3r3m++bbwbhgT1CuO8Q8Q/DwgeGDVLghHADRCATJBEeAUAIoEIpd7evSkCt9vopYrSCiBVEqmfjieAQALYQ4Rd/47WUfjMbJ4T3FoDe8PuzM/WjULA+IMJzXkeR3ej1dvqTe9yWjul2/aXFxVfPoggXx8w5jpcCNgmEjpTCxsFBp539Vq3WK+Xyo68AMHHRdLJoXynasG1rLwZH+1L6E0lwHPcnAH6J90YviKzviPgyXlPAl88BF+iYbreTUuI1wOnfqU/d7m5LrxhYqVTcQ8TqVcwymLuDGzP+TcrOhnlerLw4AReCM7PJF5+ZKVQty2oiwso5PAVrmkEhvLb+RkTHANhSSgW93m6g47UqpgUuYX1eSj/UZ9wYnJkZx1luAli6VvpSduaEcKuI+Dc57BgA6uaB9wwuHA5HS2EYsC+wgdyMuct0TUTzALCOiB8TcA0p/a08aU6TOSLYNpTyWxvSFMB5G4jAxgFKwRoiNbXOo8iay3Mxjp0muMHgdLZUKoaI+CR2T7XEJXBncGlpUiNhLreI05KOnXgaNcdmUast17XjAtDRYDCaK5WK7RsZSlZijuOx7N7rjNm2ta7XzGRem5g2c9oJheC+pksC2gA0e2twWfOQ0q8I4XLNbSashFL6XIcTzzRladq843jsluPmzgwCYOXarUDfcmHBW7Us2tSbzT4jhNvX+ucGmzdB3Bc4M+FmRi9p4pwBHrnOn6oGlbw5HAxO64YFc/NmG36sdxBBH5GMEQnHU0hOzYVE6anm5GR0WC4XP180oWQvbvqAPv9WEwpfbjgcrWpg+mecwSzAPHlmweXFsPvZNnrXBcf/MJ3yUllmD0ymjkAp1TKnjmxcPF8W1olw9f8cmI66L3A8sFtWxO1hrJ4sc/8Az8CsuRK8Ou8AAAAASUVORK5CYII="
							class="doodlin-logo" alt="doodlin-logo">@<b>Doodlin
							Corp.</b> All Rights Reserved.
					</div>
				</footer>
			</footer>
		</div>
	</div>
</body>

</html>