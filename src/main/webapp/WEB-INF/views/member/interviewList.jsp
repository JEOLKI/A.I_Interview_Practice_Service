<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>AI_INTERVIEW</title>

<link href="/css/main.8acfb306.chunk.css" rel="stylesheet">
<style type="text/css">/* Chart.js */
/*
 * DOM element rendering detection
 * https://davidwalsh.name/detect-node-insertion
 */
@
keyframes chartjs-render-animation {from { opacity:0.99;
	
}

to {
	opacity: 1;
}

}
.chartjs-render-monitor {
	animation: chartjs-render-animation 0.001s;
}

/*
 * DOM element resizing detection
 * https://github.com/marcj/css-element-queries
 */
.chartjs-size-monitor, .chartjs-size-monitor-expand,
	.chartjs-size-monitor-shrink {
	position: absolute;
	direction: ltr;
	left: 0;
	top: 0;
	right: 0;
	bottom: 0;
	overflow: hidden;
	pointer-events: none;
	visibility: hidden;
	z-index: -1;
}

.chartjs-size-monitor-expand>div {
	position: absolute;
	width: 1000000px;
	height: 1000000px;
	left: 0;
	top: 0;
}

.chartjs-size-monitor-shrink>div {
	position: absolute;
	width: 200%;
	height: 200%;
	left: 0;
	top: 0;
}
</style>
</head>
<body>
	<noscript>You need to enable JavaScript to run this app.</noscript>
	<div id="root">
		<div class="Review">
		<%@include file="/WEB-INF/views/layout/header.jsp" %>			

			<div class="body">
				<div class="date">2020년 11월 19일_19시 40분</div>
				<div class="title-flex">
					<div class="title-form">
						<input type="text" class="title-text" placeholder="이름 없는 면접"
							maxlength="30" value="면접"><span>면접</span><img
							src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAACNiR0NAAAABHNCSVQICAgIfAhkiAAAAUVJREFUOE+t1L1KxEAUBeBzM0RhC7WwECzUN4jdJou4im6tvY2NjY1PY2Ohjb11IhiQzLKFkAcQ1DcQbCTD5spEYtb8LMkmaVJk5ptzZ+aG0PFDi3iWNVzr9ZZuiXDCzCGAcyk9/UZj8Bczn4jIysKwHwTewUKg4xz7RLSfr4yZd3XK2glt+3BTCFqOY2MFgEZXU5SZP6T0tmsn1BiRCAAS02lkC2Guz6JxjNPx2H2oBaYYEW3pCcx4VyqyTdPc0CiAKym9uzTt3JLzWFYiXpWK9pTCdxj6n7P7WQlqzDDEM0A7FVfrLAjc+/y3UrAqWZYwvpDy8aZsoQLYBiscSlvsH9gF9gd2hSVgl1gCOs7ojQhJ2xT7E5dSutdN/kg0GIy4HKu+GvMWKAWZF8OSkvMJ22AJ2O8fDbMOML4mE/elyZ7lx/4AFWGhFXYrDvUAAAAASUVORK5CYII="
							alt="edit-icon">
					</div>
					<div class="share-btn">
						<span aria-hidden="true" class="fa fa-share-square-o fa undefined"></span>면접
						결과 공유하기
					</div>
				</div>
				<div class="QuestionReview close">
					<div class="question-toggle">
						<div class="mark-color"></div>
						<div class="no">질문 1</div>
						<div class="question">아무거나</div>
						<img
							src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAXCAYAAAAC9s/ZAAAABHNCSVQICAgIfAhkiAAAALtJREFUOE/tlNENAiEQRB8dWMKVopV4V4F2oFbitWIHlmAJdqAZwia4t6CffhxfhDCPZRg20R5n4ARcAM3DkVYAqwf8iQcb4Bkk8uco34FtAPkGmIFROXgBguwcpAeQeA8kA+gGHtICmFiaDBiBa/GghkSAWjwBs0U5ghxdP1iIcwmV+x5yAw6loQzlztqeTzad/0w1xPboifXUC7GvwAQRJBS3AFr3kI+y69D1+oFBmuJeBXaIzHt0Gi9vYl5GGAktdnMAAAAASUVORK5CYII="
							alt="up-down-dash" class="up-down-dash">
					</div>
				</div>
			</div>
<!-- 			<img -->
<!-- 				src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADMAAABMCAYAAADA1Y8+AAAABHNCSVQICAgIfAhkiAAABAlJREFUaEPtmEtsjFEYht/v77QkMqaIFJ2Z0tYUFRqkTSxII24bdCep2IjYIBoLFuIa4rIgLhHEQkLCxiWEIOKykFSIEkSbInoRUrTjkih6jpxeGNOZ/nP+c86o5MxmFvN973ee9z1z/jND0PkaVRCCg4kADQM5AYBnd78HAIqCsyhAbV3v/D04PUFzfZOuJZCiECFYUABOJXCoBETDpfU4bwHHQxCvQWP9SwBcWqO7wTtMuGAquLMQRDleh/fq4/wdiF1Aw4sHXjTlYUaOHQ8fVYCQ52VgSj0deA2Os3hT9zyleg/J+JAbqUQGpssMUKrtwF00150C8DMVndSSCYSHwD9wFRzkpiKqtYahGZ+/HUC0odVN1x1mRGExMp1lIAxyEzP2OcdX/GDH8bb+aV8z+oIhhIoWAGw+iNyhjZF0C3POAecyGmsvJjvxki9yZOEUZDorTK9RXr/jaLLTLjFMTjgfmQOr4CBLfpjhDobv4GxXoodtb5js0dnwZ20AwW94Wd7lGT6ivXU7Wlq+xIr0hgmOXQ2Hir1PSlMnZ+LGcDg5TG5+BBm+tWlajvqY9m+78K5BXIE6X38nEyxaB4fnq09JkwKjF2iq3d0bJpQ/DeRbnqZl6BvDfx5D48v7sclkIBTZBsIwfVPSpMTxAY11G8WVp2ubiad8lrM6TeP1j/nO9ovbQRdMsLASjjND/5Q0KTJ2B031p7pgwkW7AR5QGc1f13pup7wiz72djYza0FS7jpCTNwYDBqxXUwP+KYxYfHv7TkIwUgEH81Rh/n0/u0T4X574bm5xViOSWQ8HY9xq+/3nDK8I4cgWcTj3+8W6L/Ct+AG2B8QHu9d6qwj4B+PcsYOo2roDj55J/T8hN5DTJ0IocggEn1xnatUC5NaZEygpnoDWaBTli5eaA+LiBhCOHEltaXJVsSA9naaBjMAkAkkHkHaYWJBo9DNuVt/DojmzcP7aDZSXlSIQ8Bvbclph4kFmLl6CirmzsWnNSmzZdxDnrl7H7dMnjQFpg0kEIk6vzVWrfsNs3nsAkyeMMwakDabmyoXOhYqtJRLpOYbjYcR3Jx5o6KRSudMlSbU2GHHRjAcRMxPBxAMp35q74bTBtD2+/1ciPeYlg4kFyp40rX8lI7ZOoid8XzA9QLpuBtqSSWatG4yWSHRvMwujM5bOPwEN3c1SOQA0s1gYKUPtASBl159i+52RMc5uMxm3YmrtNpMxbmZZKcqnl+Hm3Wrcrr4n0ypdazwZ6RUpNFgYBfOMttpkjNqrIG6TUTDPaKtNxqi9CuI2GQXzjLbaZIzaqyBuk1Ewz2irTcaovQriNhkF84y22mSM2qsgbpNRMM9oq03GqL0K4jYZBfOMttpkjNqrIP4LB83BPP2b2F4AAAAASUVORK5CYII=" -->
<!-- 				alt="top-btn" class="top-btn hide"> -->
<%-- <%@ include file="/WEB-INF/views/layout/semiFooter.jsp" %> --%>
		</div>
	</div>
	<div id="ch-plugin">
		<div id="ch-plugin-core">
<!-- 			<style data-styled="active" data-styled-version="5.1.1"></style> -->
<!-- 			<style data-styled="active" data-styled-version="5.1.1"></style> -->
<!-- 			<style data-styled="active" data-styled-version="5.1.1"></style> -->
<!-- 			<style data-styled="active" data-styled-version="5.1.1"></style> -->
<!-- 			<div data-ch-testid="full-screen-push-message" hidden="" -->
<!-- 				class="FullScreenPushMessagestyled__Wrapper-nxoc25-9 jNIDNu PushMessagestyled__PCPopupMessage-vqm8p7-1 egLHoW" -->
<!-- 				style="z-index: 100000000 !important;"> -->
<!-- 				<div -->
<!-- 					class="FullScreenPushMessagestyled__MainWrapper-nxoc25-8 fCsTtf"> -->
<!-- 					<div -->
<!-- 						class="FullScreenPushMessagestyled__SVGIconWrapper-nxoc25-0 kmAVFX"> -->
<!-- 						<div name="cancel" size="16" width="24" height="24" -->
<!-- 							class="SVGIconstyled__SVGIcon-sc-15isf0b-0 cQJNXd"></div> -->
<!-- 					</div> -->
<!-- 					<div class="FullScreenPushMessagestyled__Header-nxoc25-3 fzszwe"> -->
<!-- 						<div size="24" radius="8px" -->
<!-- 							class="Avatarstyled__Avatar-yfy5xq-0 jUtegZ"></div> -->
<!-- 						<div class="FullScreenPushMessagestyled__Name-nxoc25-2 fqimYT">(알 -->
<!-- 							수 없음)</div> -->
<!-- 						<div -->
<!-- 							class="FullScreenPushMessagestyled__HeaderContent-nxoc25-1 dVbCKK">9:00 -->
<!-- 							AM</div> -->
<!-- 					</div> -->
<!-- 					<div class="FullScreenPushMessagestyled__Content-nxoc25-7 Eohuv"> -->
<!-- 						<div class="FullScreenPushMessagestyled__Text-nxoc25-4 kOiAv"></div> -->
<!-- 					</div> -->
<!-- 				</div> -->
			</div>
		</div>
	</div>
</body>
</html>