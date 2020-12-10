<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/layout/commonLib.jsp" %>
<script src="/js/Chart.js"></script>
<script src="https://cdn.amcharts.com/lib/4/core.js"></script>
<script src="https://cdn.amcharts.com/lib/4/charts.js"></script>
<link href="/css/main.8acfb306.chunk.css" rel="stylesheet">
<script>
	
	$(document).ready(function() {
				
			$.ajax({
					url : "/analysis/answer/retrieveAnalysis.do",
					data : { "questSq" : "${questSq}" },
					dataType : "json",
					success : function(data){
						console.log(data);
						
						imageAnalysis = data.imageAnalysis;
						imageAnalysisChart(imageAnalysis);
						
						
						/* 스크립트 */
						script = data.answerVO.ansContent;
						scriptLength = script.length;
						console.log(scriptLength);
						$('.MyAnswer .stt').text(script);
						$('.MyAnswer .length span').text(scriptLength);
						
						/* 습관어 */
						habitMap = data.habitAnalysisMap;
						createHabitHtml(habitMap);
						
						/* 반복어 */
						repeatList = data.repeatAnalysisList;
						createRepeatHtml(repeatList);
						
						/* 빠르기 */
						speed = data.answerVO.ansSpeed;
						createSpeedHtml(speed,scriptLength);
						
						/* 인재상 - 인재상 & 퍼센트 */
						talentList = data.talentAnalysisList;
						createTalentHtml(talentList);
						
						/* 인재상 - 키워드 */
						keywordSet = data.keywordSet;
						createKeywordHtml(keywordSet);
						
						/* 음성 - 데시벨*/
						decibelList = data.voiceAnalysisList;
						decibelAnalysisChart(decibelList);
					}
				
			})
			
	});
	/* 속도 차트 */
	function createSpeedChart(ctx, speed){
	
		
		
		var speedChart = new Chart(ctx, {
			type: 'doughnut',
			data: {
				datasets: [{
					data: [speed, 600-speed],
					backgroundColor: [
						'rgba(71,65,243, 1)',
						'rgba(234, 234, 234, 1)'
					],
					borderWidth: 0
				}]
			},
			options: {
				responsive: false,
				scales: {
				},
				circumference :3/2* Math.PI,
				cutoutPercentage: 90,
				rotation : 0.75 * Math.PI
			}
		});
		
	}
	
	/* 속도 */
	function createSpeedHtml(speed,scriptLength){
		
		// 속도 그래프
		var ctx = document.getElementById('speedChart');
		createSpeedChart(ctx, speed);
		if(speed < 100){
			speedHtml ='<span>1분당</span><br><b>&nbsp;&nbsp;'+speed+'</b>자';
		}else {
			speedHtml ='<span>1분당</span><br><b>'+speed+'</b>자';
		}
		$('.minute-text').html(speedHtml);
		
		// 평균대비 속도 퍼센트
		errorHtml = '';
		if(speed < 300){
			slow = 100 -Math.ceil(speed/300*100);
			errorHtml += '평균보다<b class="num">'+slow+'% 느려요</b>';
		} else if(speed = 300){
			errorHtml += '평균과<b class="num">일치합니다</b>';
		} else {
			slow = Math.ceil(speed/300*100) - 100;
			errorHtml += '평균보다<b class="num">'+slow+'% 빨라요</b>';
		}
		$('.error-percent').html(errorHtml);
		
		// 추천시간
		goodTime = Math.ceil(Number(scriptLength)*60/300);
		goodMin =  Math.floor(Number(goodTime)/60);
		goodSec = Number(goodTime)%60;
		messageHtml = '';
		if(Number(goodMin)==0 && Number(goodSec)==0){
			messageHtml += '적당한 속도로 이야기하고 있습니다. 지금 속도를 유지해 주세요!';
		}else {
			messageHtml += '답변하신 내용은 <b>'+Number(goodMin)+'분 '+Number(goodSec-2)+'초 ~ '+Number(goodMin)+'분 '+Number(goodSec+2)+'초</b>정도 안에<br>이야기하시면 적당한 속도입니다.<br>다시 한 번 연습해 보세요!';
		}
		$('.message').html(messageHtml);
	}
	
	
	/* 인재상 - 키워드 리포트*/
	function createKeywordHtml(keywordSet){
		keywordArr = Array.from(keywordSet);
		keywordHtml = '';
		for(var i=0; i<keywordArr.length; i++){
			keywordHtml += '<span class="word">'+keywordArr[i]+'</span>';
		}
		$('.word-view').html(keywordHtml);
	}
	
	
	/* 인재상 - 인재상 & 퍼센트  리포트*/
	function createTalentHtml(talentList){
		gage = talentList[0].percent;
		talentHtml = '';
		for(var i=0; i< talentList.length; i++){
			talentHtml += '<div class="competency-percent select">';
			talentHtml +=	 '<div class="name-box"><span class="name">'+talentList[i].talentNm+'</span></div>';
			talentHtml +=	 '<div class="rectangle" style="width: '+Math.round(150*talentList[i].percent/gage)+'px;"></div>';
			talentHtml +=	 '<div class="percentage">'+talentList[i].percent+'%</div>';
			talentHtml += '</div>';
		}					
		$('.JobCompetency .result').html(talentHtml);
	}
	
	/* 반복어 리포트 */
	function createRepeatHtml(repeatList){
		repeatHtml = "";
		for(var i=0; i<repeatList.length; i++){
			repeatHtml += '<div class="label">'+repeatList[i].repeatCount+'회</div>';
			repeatHtml += '<div class="rectangle" style="height: '+repeatList[i].repeatCount*20+'px;"></div>';
			repeatHtml += '<div class="name">'+repeatList[i].repeatContent+'</div>';
		}
		$('.habitual.word-graph.select.repeat').html(repeatHtml);
	}
	
	/* 습관어 리포트 */
	function createHabitHtml(habitMap){
		habitLength = Object.keys(habitMap).length;
		habitHtml ="";
		for(var i=0; i<habitLength; i++){ 
			key = Object.keys(habitMap)[i]; 
			value = habitMap[key];
			
			habitHtml += '<div class="label">'+value+'회</div>';
			habitHtml += '<div class="rectangle" style="height: '+value*10+'px;"></div>';
			habitHtml += '<div class="name">'+key+'</div>';
		}
		$('.habitual.word-graph.select.habitual').empty();
		$('.habitual.word-graph.select.habitual').html(habitHtml);
	}

	function createImageChart(ctx, title, analysis){
		var myChart = new Chart(ctx, {
		    type: 'doughnut',
		    data: {
		        labels: title,
		        datasets: [{
		            label: 'score',
		            data: analysis,
		            backgroundColor: [
		                'rgba(54, 162, 235, 0.2)',
		                'rgba(255, 99, 132, 0.2)',
		                'rgba(255, 206, 86, 0.2)',
		                'rgba(75, 192, 192, 0.2)',
		                'rgba(153, 102, 255, 0.2)'
		            ],
		            borderColor: [
		                'rgba(54, 162, 235, 1)',
		                'rgba(255, 99, 132, 1)',
		                'rgba(255, 206, 86, 1)',
		                'rgba(75, 192, 192, 1)',
		                'rgba(153, 102, 255, 1)'
		            ],
		            borderWidth: 1	
		        }]
		    },
		    options: {maintainAspectRatio: false,
		          legend: {
		            display: false
		          },
		          cutoutPercentage: 80,}
		});
	}
	
	function imageAnalysisChart(imageAnalysis){
		$("#positiveChart").empty();
		var title = ['other', 'happiness']
		var analysis = [ 1 - imageAnalysis.happiness, imageAnalysis.happiness ];
		var ctx = document.getElementById('positiveChart');
		createImageChart(ctx, title, analysis);
		$("#positiveSpan").empty().append(Math.round(imageAnalysis.happiness*100) + "%")
		
		$("#neutralChart").empty();
		title = ['other', 'netural']
		analysis = [ 1 - imageAnalysis.neutral,  imageAnalysis.neutral ];
		ctx = document.getElementById('neutralChart');
		createImageChart(ctx, title, analysis);
		$("#neutralSpan").empty().append(Math.round(imageAnalysis.neutral*100) + "%")
		
		$("#negativeChart").empty();
		var negativeEmotion = imageAnalysis.anger*1 + imageAnalysis.contempt*1 + imageAnalysis.disgust*1 + imageAnalysis.sadness*1;
		title = ['other', 'anger', 'contempt', 'disgust', 'sadness']
		analysis = [ 1 - negativeEmotion , imageAnalysis.anger, imageAnalysis.contempt, imageAnalysis.disgust, imageAnalysis.sadness];
		ctx = document.getElementById('negativeChart');
		createImageChart(ctx, title, analysis);
		$("#negativeSpan").empty().append(Math.round(negativeEmotion*100) + "%")
		
		$("#panicChart").empty();
		var panicEmotion = imageAnalysis.fear*1 + imageAnalysis.surprise*1;
		title = ['other', 'fear', 'surprise']
		analysis = [ 1 - panicEmotion ,  imageAnalysis.fear , imageAnalysis.surprise ];
		ctx = document.getElementById('panicChart');
		createImageChart(ctx, title, analysis);
		$("#panicSpan").empty().append(Math.round(panicEmotion*100) + "%")
				
		$("#faceChart").empty();
		  var canvas = document.getElementById('faceChart');
		  if (canvas.getContext) {
		    var ctx = canvas.getContext('2d');
		    var faceTop = imageAnalysis.faceTop*1 + 200;
		    ctx.strokeStyle = 'red';
		    ctx.strokeRect(faceTop , imageAnalysis.faceLeft, imageAnalysis.faceWidth, imageAnalysis.faceHeight );
		  }
	}
	
	/* 데시벨 분석 그래프 */ 
	function decibelAnalysisChart(decibelList){
		var x = new Array();
		var decibel = new Array();
		var sumDecibel=0;
		
		for(var i =0; i<decibelList.length; i++){
			x[i] = i+1;
		}
		for(var i =0; i<decibelList.length; i++){
			decibel[i] = decibelList[i].voiceDecibel;
			sumDecibel += Number(decibelList[i].voiceDecibel);
		}
		averageDecibel = Math.round(sumDecibel/decibelList.length);
		
		$('#averageDecibel').text(averageDecibel+"dB");
		
		var ctx = document.getElementById('audioChart');
		var myChart = new Chart(ctx, {
			type: 'line',
		    data: {
		        labels: x,
		        datasets: [{
		            label: null,
		            data: decibel,
		            borderColor: "rgba(20, 80, 220, 1)",
		            backgroundColor: "rgba(20, 80, 200, 0.5)",
		            fill: true,
		            lineTension: 0.5,
		            pointRadius:0
		        }]
		    },
		    options: {
		    	legend: {
		    		display: false},
		        responsive: true,
		        scales: {
		            xAxes: [{
		                display: false,
		                scaleLabel: {
		                    display: true,
		                }
		            }],
		            yAxes: [{
		                display: false,
		                ticks: {
		                    suggestedMin: 0,
		                    suggestedMax: 80
		                }
		            }]
		        }
		    }
		});
		
	}
	
	
</script>



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
						<div class="rectangle" style="height: 10px;"></div>
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
				<canvas id="speedChart" class="answer-speed-graph" style="top:90px;" width="250" height="250"></canvas>
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
					${S_MEMBER.memAlias }님의 평균 성량<br>
					<img
						src="/member/profile.do?memId=${S_MEMBER.memId }"
						alt="profile-icon" class="profile-icon"><span id="averageDecibel"></span>
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
			<canvas id="audioChart" class="audio-graph" width="791" height="179"
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
		<!-- HTML -->
			<div>
				<canvas id="positiveChart" width="160" height="160"></canvas>
				<span id="positiveSpan"></span>
			</div>
			<div id="neutralDiv">
				<canvas id="neutralChart" width="160" height="160"></canvas>
				<span id="neutralSpan"></span>
			</div>
			<div id="negativeDiv">
				<canvas id="negativeChart" width="160" height="160"></canvas>
				<span id="negativeSpan"></span>
			</div>
			<div id="panicDiv">
				<canvas id="panicChart" width="160" height="160"></canvas>
				<span id="panicSpan"></span>
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
			<canvas id="faceChart" width="630" height="375"></canvas>
		</div>
	</div>
	<div class="close-btn">
		<img
			src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAA8AAAAcCAYAAAC+lOV/AAAABHNCSVQICAgIfAhkiAAAAVxJREFUOE/tlV1Og0AQx2cgIbyAPJLwoTewnqDtDfQE6g16BDxJ6wnsEXoDOYLhI+GxTXjaBNYMYZrtyqK+GklIyO78/vvfycyAYHiSJHkCgGVZls+mGJzaIBARt7QnpdyZBL7AKsjCJoELeAqcEzjDGngCgKsRPH/rDgZYB7uuW9m2/T7e+QEAMkS81XOAU2Bd13mappKC+75ft22be5530AWQgwDgRCcSSJAKV1V1CIIgUAVIlOELcAqmNVWA4aN6ImdXP5nXWUBKucEoihZsVS0YE8wOXNcNJivMZFuvxn9YychctjnsDybsOPb0S1EU2dS4Mt45SZIdIj4CQF4Uxd1v4XtEfOOBUJbl/sflOU4YGgBLAKDOW+sNZLRNcBiGN47j0HDgeZYJIV6bpvmg/VmYAqhlbdsmy9eK7cHJtzD3r+/7GwCgd3AxTBLTr8S0HsfxyrKshRBi/wm8FRbNSBQb/gAAAABJRU5ErkJggg=="
			alt="close-arrow" class="close-arrow">
	</div>
</div>
