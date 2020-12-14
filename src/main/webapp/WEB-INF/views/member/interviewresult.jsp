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

<link href="/css/main.8acfb306.chunk.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-latest.js"></script>

<script>
	$(document).ready(function() {
		$("#review-id").hide();
		$('.open').on('click', function() {
			$("#review-id").toggle();
		})
	});
</script>

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
		
			<%@ include file="/WEB-INF/views/layout/header.jsp" %>
			
			<div class="body">
				<div class="date">2020년 11월 19일_19시 40분</div>
				<div class="title-flex">
					<div class="title-form">
						<input type="text" class="title-text" placeholder="이름 없는 면접"
							maxlength="30" value="1.면접 입니다."> 
							&nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp 
							&nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp
							<span> </span><img
							src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAACNiR0NAAAABHNCSVQICAgIfAhkiAAAAUVJREFUOE+t1L1KxEAUBeBzM0RhC7WwECzUN4jdJou4im6tvY2NjY1PY2Ohjb11IhiQzLKFkAcQ1DcQbCTD5spEYtb8LMkmaVJk5ptzZ+aG0PFDi3iWNVzr9ZZuiXDCzCGAcyk9/UZj8Bczn4jIysKwHwTewUKg4xz7RLSfr4yZd3XK2glt+3BTCFqOY2MFgEZXU5SZP6T0tmsn1BiRCAAS02lkC2Guz6JxjNPx2H2oBaYYEW3pCcx4VyqyTdPc0CiAKym9uzTt3JLzWFYiXpWK9pTCdxj6n7P7WQlqzDDEM0A7FVfrLAjc+/y3UrAqWZYwvpDy8aZsoQLYBiscSlvsH9gF9gd2hSVgl1gCOs7ojQhJ2xT7E5dSutdN/kg0GIy4HKu+GvMWKAWZF8OSkvMJ22AJ2O8fDbMOML4mE/elyZ7lx/4AFWGhFXYrDvUAAAAASUVORK5CYII="
							alt="edit-icon">
					</div>
					<div class="share-btn">
						<span aria-hidden="true" class="fa fa-share-square-o fa undefined"></span>면접
						결과 공유하기
					</div>
				</div>


				<div class="QuestionReview open">
					<div class="question-toggle">
						<div class="mark-color"></div>
						<div class="no">질문 1</div>
						<div class="question">질문1입니다.</div>
						<img
							src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAXCAYAAAAC9s/ZAAAABHNCSVQICAgIfAhkiAAAAOpJREFUOE/t1D0OgkAQBeA3JiaWHIFOKgkF1HoS8QR6A/UkchVbKACrLTkCrYnJmEHXwGYXLS3YihDex/7MDsExgqI+ATgCOKs4lGfroAnAtAf4hz3wy9Jroqg1K/LnUl7mVXWf89pEvgFBXmcqCVMKipqZWZBNHxkDJAzCVsUhdYBM30RcgA5L5gXktxTEFxOxAf0wmHYqWWVdKduQxWN26PcDW1iyn7tgIgBdibCXhgKGL2vuTur9Z31qg8vUR/QHDG4J5NnCgxnogA1xha2AuSdjYScwQIw1mxXrbCgdUpa+iqLG1Xjl/ROZHtQYX28HyAAAAABJRU5ErkJggg=="
							alt="up-down-dash" class="up-down-dash">
					</div>
				</div>


				<div class="review-body" id="review-id">
					<div class="title">답변영상 분석</div>
					<div class="ReviewVideo content-box">
						<div class="review-video-area">
							<img
									src="/images/calm.e5d1123e.png"
									class="review-video">
							<div class="review-controller">
								<div class="full-btn shown">
									<img
										src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEEAAABKCAYAAADkMDmGAAAABHNCSVQICAgIfAhkiAAAA3pJREFUeF7tnMlqFUEUhr9/ob6AICI+gYhL3bh04TsI7gVdGKdIxIFoEDG6iMPC2SAOKIo4ghtBF4KCwQkEZ3EWVOKsLUe6JF7IpW66c3s4qWWodPX/dVG3zn9OlRhraIwB/0NIkmQaMCjpkSc4f2dCkiSzgRPAxFT8JWC5pOseYCj9+jeA8Q2CE6A/hfGizjAMwllgbhORX4DNQI+kz3WEYRBeApMixD0HVko6ENG3Ul0Mgk37VpqtE4skXW3ln8rcdyQQgp5jwFJJj8ssMObdskCw538DtgLrJX2KGbCMfbJCCJpeA6uAXZJ+l1Fos3fKC0IY4zawQNLlKoHIG0LQfhrokHS/CjBGC4Jp/wFsB1ZL+lBmGKMJIeh+D6wBdkj6WUYY7YAQdN8Dlkg6UzYQ7YQQtFtwZputO2WBUQQE0/7Lfk6BLklvi4ZRFISg+yPQbRsuSbaQFtKKhhBEPwCWSTpeBIWyQAjar6SbrYF2wigbBNNuUe3+NGxvi5lTRghhEgwCG4FNkr6O5swoM4Sg+ynQCRyS1Kr3EcWuChCCEDNzLDi7FqWshU5VghBkHU7NnGct6GzatYoQTJCtEb3ABkm2dmRqVYUQRJtJ3AXsybJeVB1CgHEzjUdGZObUBUKAcTI1c2wHGt3qBsGEfwf6gHWxZk4dIYQZYNGpmTk7JVnUOmyrM4Qg2nwL8zvPD0fBA4Sg/QIwX9KrRhieIJj2h8BMSW+GgvAGwbT3SVroHcItSdO9QxiQNMM7hF5JHZ4hWFpwliRLCP1rnhbGi8C8xl8GI+EBwt10s3TO42bp3ZAcqLttsyVxLIBa6zWAOgUsluQylM5UIVP1hTHYa3uz1EpVFYIZrVvSqjmXRuuRtN46t/rJKs0E18kXS7Ks8JqGc52QtaSrVdJ3SnKZmnddpOG6XMd14Zb7Ej7XxZyuy3pdF3ibubHN3J1YcyM6l55zx9GKHVwf+shkbuT8gaMfl9dMsEyvHQTbncXciH7rnDtmhWBHAs3c6M6jiixnbdGPywLhaFqZnpu5Ef3WOXccCYRaHhM202JKBFw7MG41xv1ZagYjxml7F5sJ+6yMpcnIdnVAj10fUOerA6YClq2d0ADCzI2DZm21y9xo+xRIBwzXidhdKrbKz0n/7us6kaH0kySZDIyT9KSor1LEuGNXDFl9QhHkyzbmHyAfvFpPdmuzAAAAAElFTkSuQmCC"
										alt="btn-icon">
								</div>
								<div class="time">0</div>
							</div>
							<div class="review-emotion">
								<div class="happy max">
									긍정적 <b>0%</b>
								</div>
								<div class="calm max">
									무표정 <b>0%</b>
								</div>
								<div class="dark max">
									부정적 <b>0%</b>
								</div>
								<div class="surprised max">
									당황함 <b>0%</b>
								</div>
							</div>
							<div class="review-face"
								style="top: 0px; left: 0px; width: 0px; height: 0px;"></div>
						</div>
						<div class="comments">
							<div class="comment select">
								<div class="time">0:04</div>
								<div class="text">너무 경직 되어있습니다. 긴장을 풀어주세요.</div>
							</div>
							<div class="comment one">
								<div class="time">0:04</div>
								<div class="text">긍정적인 표정입니다. 계속 유지해주세요.</div>
							</div>
							<div class="comment two">
								<div class="time">0:05</div>
								<div class="text">좀 더 미소를 지으면서 답변하면 좋겠어요.</div>
							</div>
							<div class="comment three">
								<div class="time">0:11</div>
								<div class="text">목소리 크기가 너무 커요.</div>
							</div>
						</div>
					</div>
					<div class="MyAnswer">
						<div class="title">나의 답변</div>
						<div class="content-box">
							<div class="text">
								<div class="length">
									총 <span>82</span>자
								</div>
								<div class="stt">
									<span class="false no-repeat">안녕 안녕 안녕 </span><span
										class="point no-repeat"> </span><span class="false no-repeat">아
										이렇게 시간 초를 왜 안 나와 아니 오늘 보면서 말하고 써 있었어 자기 얼굴은 안 보이네 보여 주지도 않고 바로
										카레 하나 보다 근데 그게 더 면접이 맡기는 거울 보면서 면접 안 하잖아 답변완료 </span>
								</div>
							</div>
							<div class="words">
								<div class="toggle-flex">
									<div class="habitual toggle select">습관어</div>
									<div class="repeat toggle false">반복어</div>
								</div>
								<div class="graph-box-flex">
									<div class="comment exist">
										답변 중 습관어 사용 횟수<span aria-hidden="true"
											class="fa fa-question-circle fa undefined"></span>
										<div class="comment-box habitual">무의식 중에 내뱉는 습관어는 인터뷰의
											흐름을 끊고 자신의 메시지를 효과적으로 전달하는데 방해가 됩니다.</div>
									</div>
									<div class="habitual word-graph select habitual">
										<div class="label">1회</div>
										<div class="rectangle" style="height: 110px;"></div>
										<div class="name">아</div>
									</div>
									<div class="bar"></div>
								</div>
							</div>
						</div>
					</div>
					<div class="answer-flex">
						<div class="JobCompetency">
							<div class="title">답변에 드러난 인재상</div>
							<div class="content-box">
								<div class="result">
									<div class="competency-percent select">
										<div class="name-box">
											<span class="name">전문성</span>
										</div>
										<div class="rectangle" style="width: 150px;"></div>
										<div class="percentage">2.63%</div>
									</div>
									<div class="competency-percent unselect">
										<div class="name-box">
											<span class="name">혁신</span>
										</div>
										<div class="rectangle" style="width: 150px;"></div>
										<div class="percentage">2.63%</div>
									</div>
									<div class="competency-percent unselect">
										<div class="name-box">
											<span class="name">정직</span>
										</div>
										<div class="rectangle" style="width: 150px;"></div>
										<div class="percentage">2.63%</div>
									</div>
									<div class="word-view">
										<span class="word">자기</span>
									</div>
								</div>
							</div>
						</div>
						<div class="AnswerSpeed">
							<div class="title">말하기 속도</div>
							<div class="content-box slow">
								<canvas class="answer-speed-graph" width="250" height="250"></canvas>
								<div class="average-speed">
									합격자 평균 속도<br>
									<span>300</span>
								</div>
								<div class="minute-text">
									<span>1분당</span><br>
									<b>240</b>자
								</div>
								<div class="error-percent">
									평균보다<b class="num">20% 느려요</b>
								</div>
								<div class="message">
									답변하신 내용은<b>0분 15초 ~ 0분 19초</b>정도 안에<br>이야기하시면 적당한 속도입니다.<br>다시
									한 번 연습해 보세요!
								</div>
							</div>
						</div>
					</div>
					<div class="AudioReview">
						<div class="title">목소리 크기</div>
						<div class="content-box intensity">
							<div class="graph-comment">
								<div class="user-intensity">
									dsfaqwef님의 평균 성량<br>
									<img
										src="https://aida-users.s3.ap-northeast-2.amazonaws.com/profile/2324.jpg"
										alt="profile-icon" class="profile-icon"><span>61dB</span>
								</div>
								<div class="comment">
									일반적으로 좋은 평가를 받는 성량은 <b>55dB</b>입니다.<br>
									<br>안정적인 목소리는 신뢰도를 높입니다.<br>55dB 라인에서 완만한 곡선을 유지해
									보세요.
								</div>
								<div class="average-intensity">
									합격자 평균 성량<br>
									<span>55dB</span>
								</div>
							</div>
							<canvas class="audio-graph" width="791" height="179"
								style="display: block; height: 200px; width: 880px;"></canvas>
							<div class="guide-line">
								55dB
								<div class="dot-line"></div>
							</div>
							<img src="/static/media/audio-graph-background.493484c7.png"
								class="audio-graph-background" alt="audio-graph-background">
							<div class="gradient-box"></div>
						</div>
						<div class="title">목소리 음역대</div>
						<div class="pitch-graph">
							<div class="user-pitch" style="left: 238px;">
								<img
									src="https://aida-users.s3.ap-northeast-2.amazonaws.com/profile/2324.jpg"
									alt="profile-icon" class="profile-icon"><br>
								<b>dsfaqwef</b> 님의 평균 음역대<br>
								<span>123Hz</span>
								<div class="line"></div>
								<div class="point"></div>
							</div>
							<div class="pitch-line"></div>
							<div class="men-pitch-area">
								<div class="message">
									<b>선호되는 남성</b>의<br>평균 음역대<br>
									<span>110Hz~130Hz</span>
								</div>
							</div>
							<div class="women-pitch-area">
								<div class="message">
									<b>선호되는 여성</b>의<br>평균 음역대<br>
									<span>210Hz~240Hz</span>
								</div>
							</div>
						</div>
					</div>
					<div class="EmotionGraph">
						<div class="title">표정 분석</div>
						<div class="message">면접 중의 지으신 표정의 비율을 확인해 보세요.</div>
						<div class="chracter-flex">
							<div class="background-box"></div>
								<img src="/images/happy.b6f96d37.png" alt="character">
								<img src="/images/calm.e5d1123e.png" alt="character">
								<img src="/images/dark.cdc202f0.png" alt="character">
								<img src="/images/surprised.783e5dfe.png" alt="character">
						</div>
						<div class="canvas-flex">
							<div>
								<canvas width="160" height="160"></canvas>
								41%
							</div>
							<div>
								<canvas width="160" height="160"></canvas>
								36%
							</div>
							<div>
								<canvas width="160" height="160"></canvas>
								17%
							</div>
							<div>
								<canvas width="160" height="160"></canvas>
								6%
							</div>
						</div>
					</div>
					<div class="GazeGraph">
						<div class="title">움직임 분포도</div>
						<div class="message">
							면접 시 면접관을 응시하는 것이 중요합니다.
						</div>
						<div class="content-box">
							<img src="/images/interviewer-character.2272ffa3.png"
								alt="interviewer-character">
							<div class="background-box"></div>
							<div class="x-axis"></div>
							<div class="y-axis"></div>
							<canvas width="630" height="375"></canvas>
						</div>
					</div>
					<div class="close-btn">
						<img
							src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAA8AAAAcCAYAAAC+lOV/AAAABHNCSVQICAgIfAhkiAAAAVxJREFUOE/tlV1Og0AQx2cgIbyAPJLwoTewnqDtDfQE6g16BDxJ6wnsEXoDOYLhI+GxTXjaBNYMYZrtyqK+GklIyO78/vvfycyAYHiSJHkCgGVZls+mGJzaIBARt7QnpdyZBL7AKsjCJoELeAqcEzjDGngCgKsRPH/rDgZYB7uuW9m2/T7e+QEAMkS81XOAU2Bd13mappKC+75ft22be5530AWQgwDgRCcSSJAKV1V1CIIgUAVIlOELcAqmNVWA4aN6ImdXP5nXWUBKucEoihZsVS0YE8wOXNcNJivMZFuvxn9YychctjnsDybsOPb0S1EU2dS4Mt45SZIdIj4CQF4Uxd1v4XtEfOOBUJbl/sflOU4YGgBLAKDOW+sNZLRNcBiGN47j0HDgeZYJIV6bpvmg/VmYAqhlbdsmy9eK7cHJtzD3r+/7GwCgd3AxTBLTr8S0HsfxyrKshRBi/wm8FRbNSBQb/gAAAABJRU5ErkJggg=="
							alt="close-arrow" class="close-arrow">
					</div>
				</div>






			</div>
			<img
				src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADMAAABMCAYAAADA1Y8+AAAABHNCSVQICAgIfAhkiAAABAlJREFUaEPtmEtsjFEYht/v77QkMqaIFJ2Z0tYUFRqkTSxII24bdCep2IjYIBoLFuIa4rIgLhHEQkLCxiWEIOKykFSIEkSbInoRUrTjkih6jpxeGNOZ/nP+c86o5MxmFvN973ee9z1z/jND0PkaVRCCg4kADQM5AYBnd78HAIqCsyhAbV3v/D04PUFzfZOuJZCiECFYUABOJXCoBETDpfU4bwHHQxCvQWP9SwBcWqO7wTtMuGAquLMQRDleh/fq4/wdiF1Aw4sHXjTlYUaOHQ8fVYCQ52VgSj0deA2Os3hT9zyleg/J+JAbqUQGpssMUKrtwF00150C8DMVndSSCYSHwD9wFRzkpiKqtYahGZ+/HUC0odVN1x1mRGExMp1lIAxyEzP2OcdX/GDH8bb+aV8z+oIhhIoWAGw+iNyhjZF0C3POAecyGmsvJjvxki9yZOEUZDorTK9RXr/jaLLTLjFMTjgfmQOr4CBLfpjhDobv4GxXoodtb5js0dnwZ20AwW94Wd7lGT6ivXU7Wlq+xIr0hgmOXQ2Hir1PSlMnZ+LGcDg5TG5+BBm+tWlajvqY9m+78K5BXIE6X38nEyxaB4fnq09JkwKjF2iq3d0bJpQ/DeRbnqZl6BvDfx5D48v7sclkIBTZBsIwfVPSpMTxAY11G8WVp2ubiad8lrM6TeP1j/nO9ovbQRdMsLASjjND/5Q0KTJ2B031p7pgwkW7AR5QGc1f13pup7wiz72djYza0FS7jpCTNwYDBqxXUwP+KYxYfHv7TkIwUgEH81Rh/n0/u0T4X574bm5xViOSWQ8HY9xq+/3nDK8I4cgWcTj3+8W6L/Ct+AG2B8QHu9d6qwj4B+PcsYOo2roDj55J/T8hN5DTJ0IocggEn1xnatUC5NaZEygpnoDWaBTli5eaA+LiBhCOHEltaXJVsSA9naaBjMAkAkkHkHaYWJBo9DNuVt/DojmzcP7aDZSXlSIQ8Bvbclph4kFmLl6CirmzsWnNSmzZdxDnrl7H7dMnjQFpg0kEIk6vzVWrfsNs3nsAkyeMMwakDabmyoXOhYqtJRLpOYbjYcR3Jx5o6KRSudMlSbU2GHHRjAcRMxPBxAMp35q74bTBtD2+/1ciPeYlg4kFyp40rX8lI7ZOoid8XzA9QLpuBtqSSWatG4yWSHRvMwujM5bOPwEN3c1SOQA0s1gYKUPtASBl159i+52RMc5uMxm3YmrtNpMxbmZZKcqnl+Hm3Wrcrr4n0ypdazwZ6RUpNFgYBfOMttpkjNqrIG6TUTDPaKtNxqi9CuI2GQXzjLbaZIzaqyBuk1Ewz2irTcaovQriNhkF84y22mSM2qsgbpNRMM9oq03GqL0K4jYZBfOMttpkjNqrIP4LB83BPP2b2F4AAAAASUVORK5CYII="
				alt="top-btn" class="top-btn hide">
<%-- 			<%@ include file="/WEB-INF/views/layout/semiFooter.jsp" %> --%>
		</div>
	</div>
	<div id="ch-plugin">
		<div id="ch-plugin-core">
			<style data-styled="active" data-styled-version="5.1.1"></style>
			<style data-styled="active" data-styled-version="5.1.1"></style>
			<div data-ch-testid="full-screen-push-message" hidden=""
				class="FullScreenPushMessagestyled__Wrapper-nxoc25-9 jNIDNu PushMessagestyled__PCPopupMessage-vqm8p7-1 egLHoW"
				style="z-index: 100000000 !important;">
				<div
					class="FullScreenPushMessagestyled__MainWrapper-nxoc25-8 fCsTtf">
					<div
						class="FullScreenPushMessagestyled__SVGIconWrapper-nxoc25-0 kmAVFX">
						<div name="cancel" size="16" width="24" height="24"
							class="SVGIconstyled__SVGIcon-sc-15isf0b-0 cQJNXd"></div>
					</div>
					<div class="FullScreenPushMessagestyled__Header-nxoc25-3 fzszwe">
						<div size="24" radius="8px"
							class="Avatarstyled__Avatar-yfy5xq-0 jUtegZ"></div>
						<div class="FullScreenPushMessagestyled__Name-nxoc25-2 fqimYT">(알
							수 없음)</div>
						<div
							class="FullScreenPushMessagestyled__HeaderContent-nxoc25-1 dVbCKK">9:00
							AM</div>
					</div>
					<div class="FullScreenPushMessagestyled__Content-nxoc25-7 Eohuv">
						<div class="FullScreenPushMessagestyled__Text-nxoc25-4 kOiAv"></div>
					</div>
				</div>
			</div>
			<div size="300" class="Screenstyled__Screen-sc-3ge3qf-0 gUFjvy"></div>
			<div data-ch-testid="launcher"
				class="Launcherstyled__Wrapper-oef45p-0 ekjiAG">
				<div class="Launcherstyled__TextLauncher-oef45p-1 lbMRR">
					<div
						class="Launcherstyled__TextLauncherContent-oef45p-2 inNMmP textLauncherContent">문제가
						생겼나요?</div>
					<div
						class="Launcherstyled__TextLauncherIcon-oef45p-3 lfSkuP textLauncherIcon">
						<div data-ch-testid="badge" hidden=""
							class="Badgestyled__Badge-sc-1ztqq4-0 Launcherstyled__Badge-oef45p-5 bZpFRQ">0</div>
					</div>
				</div>
			</div>
		</div>
		<div id="ch-plugin-script" style="display: none"
			class="ch-messenger-hidden">
			<iframe id="ch-plugin-script-iframe"
				style="position: relative !important; height: 100% !important; width: 100% !important; border: none !important;"></iframe>
		</div>
	</div>
	<style data-styled="active" data-styled-version="5.1.1"></style>
</body>

</html>