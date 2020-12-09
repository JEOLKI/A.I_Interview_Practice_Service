<%@ page language="java" contentType="text/html; charset=UTF-8"	
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="/css/main.8acfb306.chunk.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-latest.js"></script>
<style type="text/css">/* Chart.js */
/*
 * DOM element rendering detection
 * https://davidwalsh.name/detect-node-insertion
 */

</style>
</head>
<body>
	<noscript>You need to enable JavaScript to run this app.</noscript>
	<div id="root">
		<div class="Review">
			
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
				
				<div class="QuestionReview open">
					<div class="question-toggle">
						<div class="mark-color"></div>
						<div class="no">질문 1</div>
						<div class="question">아무거나</div>
						<img
							src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAXCAYAAAAC9s/ZAAAABHNCSVQICAgIfAhkiAAAAOpJREFUOE/t1D0OgkAQBeA3JiaWHIFOKgkF1HoS8QR6A/UkchVbKACrLTkCrYnJmEHXwGYXLS3YihDex/7MDsExgqI+ATgCOKs4lGfroAnAtAf4hz3wy9Jroqg1K/LnUl7mVXWf89pEvgFBXmcqCVMKipqZWZBNHxkDJAzCVsUhdYBM30RcgA5L5gXktxTEFxOxAf0wmHYqWWVdKduQxWN26PcDW1iyn7tgIgBdibCXhgKGL2vuTur9Z31qg8vUR/QHDG4J5NnCgxnogA1xha2AuSdjYScwQIw1mxXrbCgdUpa+iqLG1Xjl/ROZHtQYX28HyAAAAABJRU5ErkJggg=="
							alt="up-down-dash" class="up-down-dash">
					</div>
					
				
					<div class="review-body">
						<div class="title">답변영상 분석</div>
						<div class="ReviewVideo content-box">
							<div class="review-video-area">
								<video
									src="https://aida-interview.s3.amazonaws.com/2343_20201119104000/video/1.webm?X-Amz-Algorithm=AWS4-HMAC-SHA256&amp;X-Amz-Credential=AKIASE7AF636DBHQOXM6%2F20201209%2Fap-northeast-2%2Fs3%2Faws4_request&amp;X-Amz-Date=20201209T034435Z&amp;X-Amz-Expires=3600&amp;X-Amz-SignedHeaders=host&amp;X-Amz-Signature=da72ecf80f5f0d0665b549e00c779ea767f66680df090c01fb0917505bbb25c1"
									class="review-video"></video>
								<div class="review-controller">
									<div class="full-btn shown">
										<img
											src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEEAAABKCAYAAADkMDmGAAAABHNCSVQICAgIfAhkiAAAA3pJREFUeF7tnMlqFUEUhr9/ob6AICI+gYhL3bh04TsI7gVdGKdIxIFoEDG6iMPC2SAOKIo4ghtBF4KCwQkEZ3EWVOKsLUe6JF7IpW66c3s4qWWodPX/dVG3zn9OlRhraIwB/0NIkmQaMCjpkSc4f2dCkiSzgRPAxFT8JWC5pOseYCj9+jeA8Q2CE6A/hfGizjAMwllgbhORX4DNQI+kz3WEYRBeApMixD0HVko6ENG3Ul0Mgk37VpqtE4skXW3ln8rcdyQQgp5jwFJJj8ssMObdskCw538DtgLrJX2KGbCMfbJCCJpeA6uAXZJ+l1Fos3fKC0IY4zawQNLlKoHIG0LQfhrokHS/CjBGC4Jp/wFsB1ZL+lBmGKMJIeh+D6wBdkj6WUYY7YAQdN8Dlkg6UzYQ7YQQtFtwZputO2WBUQQE0/7Lfk6BLklvi4ZRFISg+yPQbRsuSbaQFtKKhhBEPwCWSTpeBIWyQAjar6SbrYF2wigbBNNuUe3+NGxvi5lTRghhEgwCG4FNkr6O5swoM4Sg+ynQCRyS1Kr3EcWuChCCEDNzLDi7FqWshU5VghBkHU7NnGct6GzatYoQTJCtEb3ABkm2dmRqVYUQRJtJ3AXsybJeVB1CgHEzjUdGZObUBUKAcTI1c2wHGt3qBsGEfwf6gHWxZk4dIYQZYNGpmTk7JVnUOmyrM4Qg2nwL8zvPD0fBA4Sg/QIwX9KrRhieIJj2h8BMSW+GgvAGwbT3SVroHcItSdO9QxiQNMM7hF5JHZ4hWFpwliRLCP1rnhbGi8C8xl8GI+EBwt10s3TO42bp3ZAcqLttsyVxLIBa6zWAOgUsluQylM5UIVP1hTHYa3uz1EpVFYIZrVvSqjmXRuuRtN46t/rJKs0E18kXS7Ks8JqGc52QtaSrVdJ3SnKZmnddpOG6XMd14Zb7Ej7XxZyuy3pdF3ibubHN3J1YcyM6l55zx9GKHVwf+shkbuT8gaMfl9dMsEyvHQTbncXciH7rnDtmhWBHAs3c6M6jiixnbdGPywLhaFqZnpu5Ef3WOXccCYRaHhM202JKBFw7MG41xv1ZagYjxml7F5sJ+6yMpcnIdnVAj10fUOerA6YClq2d0ADCzI2DZm21y9xo+xRIBwzXidhdKrbKz0n/7us6kaH0kySZDIyT9KSor1LEuGNXDFl9QhHkyzbmHyAfvFpPdmuzAAAAAElFTkSuQmCC"
											alt="btn-icon">
									</div>
									<div class="time">0</div>
								</div>
								<div class="review-emotion">
									<div class="happy false">
										긍정적 <b>0%</b>
									</div>
									<div class="calm max">
										무표정 <b>8%</b>
									</div>
									<div class="dark false">
										부정적 <b>2%</b>
									</div>
									<div class="surprised false">
										당황함 <b>0%</b>
									</div>
								</div>
								<div class="review-face"
									style="top: 101.685px; left: 200.529px; width: 81.7174px; height: 90.8915px;"></div>
							</div>
							<div class="comments"></div>
						</div>
						<div class="MyAnswer">
							<div class="title">나의 답변</div>
							<div class="content-box">
								<div class="text">
									<div class="length">
										총 <span>0</span>자
									</div>
									<div class="stt">
										<span class="false no-repeat"></span>
									</div>
								</div>
								<div class="words">
									<div class="toggle-flex">
										<div class="habitual toggle select">습관어</div>
										<div class="repeat toggle false">반복어</div>
									</div>
									<div class="graph-box-flex">
										<div class="comment no-exist">
											답변 중 습관어 사용 횟수<span aria-hidden="true"
												class="fa fa-question-circle fa undefined"></span>
											<div class="comment-box habitual">무의식 중에 내뱉는 습관어는 인터뷰의
												흐름을 끊고 자신의 메시지를 효과적으로 전달하는데 방해가 됩니다.</div>
										</div>
										<div class="no-result-box">습관어 감지가 안되었습니다</div>
										<div class="bar"></div>
									</div>
								</div>
							</div>
						</div>
						<div class="answer-flex">
							<div class="JobCompetency">
								<div class="title">답변에 드러난 인재상</div>
								<div class="content-box">
									<div class="no-result">
										<div class="question-mark">?</div>
										인재상 미감지
									</div>
								</div>
							</div>
							<div class="AnswerSpeed">
								<div class="title">말하기 속도</div>
								<div class="content-box none">
									<canvas class="answer-speed-graph" width="250" height="250"></canvas>
									<div class="average-speed">
										합격자 평균 속도<br>
										<span>300</span>
									</div>
									<div class="minute-text">측정불가</div>
									<div class="error-percent">
										<b>측정에 실패했습니다</b>
									</div>
									<div class="message">
										어떤 이유로 인해 측정에 실패했습니다 :(<br>혹시 마이크에 문제가 있는 건 아닌지 확인해 보세요!
									</div>
								</div>
							</div>
						</div>
						<div class="AudioReview">
							<div class="title">목소리 크기</div>
							<div class="content-box intensity">
								<div class="graph-comment">
									<div class="user-intensity">
										paresf1님의 평균 성량<br>
										<img
											src="https://aida-users.s3.ap-northeast-2.amazonaws.com/profile/2343.jpg"
											alt="profile-icon" class="profile-icon"><span>55dB</span>
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
									style="display: block; height: 280px; width: 1200px;"></canvas>
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
								<div class="user-pitch" style="left: 105px;">
									<img
										src="https://aida-users.s3.ap-northeast-2.amazonaws.com/profile/2343.jpg"
										alt="profile-icon" class="profile-icon"><br>
									<b>paresf1</b> 님의 평균 음역대<br>
									<span>78Hz</span>
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
								<img src="/static/media/happy.b6f96d37.png" alt="character"><img
									src="/static/media/calm.e5d1123e.png" alt="character"><img
									src="/static/media/dark.cdc202f0.png" alt="character"><img
									src="/static/media/surprised.783e5dfe.png" alt="character">
							</div>
							<div class="canvas-flex">
								<div>
									<canvas width="160" height="160"></canvas>
									12%
								</div>
								<div>
									<canvas width="160" height="160"></canvas>
									64%
								</div>
								<div>
									<canvas width="160" height="160"></canvas>
									21%
								</div>
								<div>
									<canvas width="160" height="160"></canvas>
									3%
								</div>
							</div>
						</div>
						<div class="GazeGraph">
							<div class="title">시선분포도</div>
							<div class="message">
								면접 시 면접관을 응시하는 것이 중요합니다.<br>원의 크기가 클 수록 그곳을 오래 응시한 것입니다.
							</div>
							<div class="content-box">
								<img src="/static/media/interviewer-character.2272ffa3.png"
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
				
				
				
			</div>
			<img
				src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADMAAABMCAYAAADA1Y8+AAAABHNCSVQICAgIfAhkiAAABAlJREFUaEPtmEtsjFEYht/v77QkMqaIFJ2Z0tYUFRqkTSxII24bdCep2IjYIBoLFuIa4rIgLhHEQkLCxiWEIOKykFSIEkSbInoRUrTjkih6jpxeGNOZ/nP+c86o5MxmFvN973ee9z1z/jND0PkaVRCCg4kADQM5AYBnd78HAIqCsyhAbV3v/D04PUFzfZOuJZCiECFYUABOJXCoBETDpfU4bwHHQxCvQWP9SwBcWqO7wTtMuGAquLMQRDleh/fq4/wdiF1Aw4sHXjTlYUaOHQ8fVYCQ52VgSj0deA2Os3hT9zyleg/J+JAbqUQGpssMUKrtwF00150C8DMVndSSCYSHwD9wFRzkpiKqtYahGZ+/HUC0odVN1x1mRGExMp1lIAxyEzP2OcdX/GDH8bb+aV8z+oIhhIoWAGw+iNyhjZF0C3POAecyGmsvJjvxki9yZOEUZDorTK9RXr/jaLLTLjFMTjgfmQOr4CBLfpjhDobv4GxXoodtb5js0dnwZ20AwW94Wd7lGT6ivXU7Wlq+xIr0hgmOXQ2Hir1PSlMnZ+LGcDg5TG5+BBm+tWlajvqY9m+78K5BXIE6X38nEyxaB4fnq09JkwKjF2iq3d0bJpQ/DeRbnqZl6BvDfx5D48v7sclkIBTZBsIwfVPSpMTxAY11G8WVp2ubiad8lrM6TeP1j/nO9ovbQRdMsLASjjND/5Q0KTJ2B031p7pgwkW7AR5QGc1f13pup7wiz72djYza0FS7jpCTNwYDBqxXUwP+KYxYfHv7TkIwUgEH81Rh/n0/u0T4X574bm5xViOSWQ8HY9xq+/3nDK8I4cgWcTj3+8W6L/Ct+AG2B8QHu9d6qwj4B+PcsYOo2roDj55J/T8hN5DTJ0IocggEn1xnatUC5NaZEygpnoDWaBTli5eaA+LiBhCOHEltaXJVsSA9naaBjMAkAkkHkHaYWJBo9DNuVt/DojmzcP7aDZSXlSIQ8Bvbclph4kFmLl6CirmzsWnNSmzZdxDnrl7H7dMnjQFpg0kEIk6vzVWrfsNs3nsAkyeMMwakDabmyoXOhYqtJRLpOYbjYcR3Jx5o6KRSudMlSbU2GHHRjAcRMxPBxAMp35q74bTBtD2+/1ciPeYlg4kFyp40rX8lI7ZOoid8XzA9QLpuBtqSSWatG4yWSHRvMwujM5bOPwEN3c1SOQA0s1gYKUPtASBl159i+52RMc5uMxm3YmrtNpMxbmZZKcqnl+Hm3Wrcrr4n0ypdazwZ6RUpNFgYBfOMttpkjNqrIG6TUTDPaKtNxqi9CuI2GQXzjLbaZIzaqyBuk1Ewz2irTcaovQriNhkF84y22mSM2qsgbpNRMM9oq03GqL0K4jYZBfOMttpkjNqrIP4LB83BPP2b2F4AAAAASUVORK5CYII="
				alt="top-btn" class="top-btn show">
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
	<script>!function(e){function r(r){for(var n,f,i=r[0],l=r[1],a=r[2],c=0,s=[];c<i.length;c++)f=i[c],Object.prototype.hasOwnProperty.call(o,f)&&o[f]&&s.push(o[f][0]),o[f]=0;for(n in l)Object.prototype.hasOwnProperty.call(l,n)&&(e[n]=l[n]);for(p&&p(r);s.length;)s.shift()();return u.push.apply(u,a||[]),t()}function t(){for(var e,r=0;r<u.length;r++){for(var t=u[r],n=!0,i=1;i<t.length;i++){var l=t[i];0!==o[l]&&(n=!1)}n&&(u.splice(r--,1),e=f(f.s=t[0]))}return e}var n={},o={1:0},u=[];function f(r){if(n[r])return n[r].exports;var t=n[r]={i:r,l:!1,exports:{}};return e[r].call(t.exports,t,t.exports,f),t.l=!0,t.exports}f.m=e,f.c=n,f.d=function(e,r,t){f.o(e,r)||Object.defineProperty(e,r,{enumerable:!0,get:t})},f.r=function(e){"undefined"!=typeof Symbol&&Symbol.toStringTag&&Object.defineProperty(e,Symbol.toStringTag,{value:"Module"}),Object.defineProperty(e,"__esModule",{value:!0})},f.t=function(e,r){if(1&r&&(e=f(e)),8&r)return e;if(4&r&&"object"==typeof e&&e&&e.__esModule)return e;var t=Object.create(null);if(f.r(t),Object.defineProperty(t,"default",{enumerable:!0,value:e}),2&r&&"string"!=typeof e)for(var n in e)f.d(t,n,function(r){return e[r]}.bind(null,n));return t},f.n=function(e){var r=e&&e.__esModule?function(){return e.default}:function(){return e};return f.d(r,"a",r),r},f.o=function(e,r){return Object.prototype.hasOwnProperty.call(e,r)},f.p="/";var i=this["webpackJsonpiam-front"]=this["webpackJsonpiam-front"]||[],l=i.push.bind(i);i.push=r,i=i.slice();for(var a=0;a<i.length;a++)r(i[a]);var p=l;t()}([])</script>
	<script src="/static/js/2.f1e4c4b1.chunk.js"></script>
	<script src="/static/js/main.a74e6755.chunk.js"></script>
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
						class="Launcherstyled__TextLauncherIcon-oef45p-3 kZmISt textLauncherIcon">
						<div data-ch-testid="badge"
							class="Badgestyled__Badge-sc-1ztqq4-0 Launcherstyled__Badge-oef45p-5 iwEgLY">1</div>
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