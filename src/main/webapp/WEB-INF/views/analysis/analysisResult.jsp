<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/layout/commonLib.jsp" %>
<script>
	var talentNm = '';
	var habitMap = '';
	var habitLength = '';
	var habitLength = '';
	$(document).ready(function() {
			$.ajax({
					url : "/analysis/answer/retrieveAnalysis.do",
					data : { "questSq" : "${questSq}" ,"shareMemId" : "${shareMemId}"},
					dataType : "json",
					success : function(data){
						
						imageAnalysis = data.imageAnalysis;
						imageAnalysisList = data.imageAnalysisList;
						imageAnalysisChart(imageAnalysis);
						videoAnalysisChart(imageAnalysisList);
						
						
						/* 스크립트 */
						script = data.answerVO.ansContent;
						if(script != null && script !=''){
							scriptLength = script.length;
						}else {
							scriptLength = 0;
						}
						createScriptHtml(script,scriptLength);
						
						
						/* 습관어 */
						habitMap = data.habitAnalysisMap;
						habitLength = Object.keys(habitMap).length;
						createHabitHtml(habitMap,habitLength);
						
						/* 반복어 */
						repeatList = data.repeatAnalysisList;
						
						/* 빠르기 */
						speed = data.answerVO.ansSpeed;
						createSpeedHtml(speed,scriptLength);
						
						/* 인재상 - 인재상 & 퍼센트 */
						talentList = data.talentAnalysisList;
						createTalentHtml(talentList);
						
						/* 인재상 - 키워드 */
						keywordMap = data.keywordResultMap;
						createKeywordHtml(keywordMap,talentNm);
						
						/* 음성 */
						voiceList = data.voiceAnalysisList;
						decibelAnalysisChart(voiceList);
						frequencyAnalysisChart(voiceList);
					}
				
			})
			
			// 인재상 클릭 시 인재상별 키워드 출력 메서드
			$(document).on("click",".competency-percent",function(){
	         	$('.competency-percent.select').removeClass('select');
	          	$('.competency-percent').addClass('unselect');
	          	$(this).removeClass('unselect');
	          	$(this).addClass('select');
	          	talentNm = $(this).find('span').text();
				createKeywordHtml(keywordMap,talentNm);
			})
			
			
			//<div class="habitual toggle select">습관어</div>
			//<div class="repeat toggle false">반복어</div>
			// 습관어 / 반복어 토글 작동 메서드
			$('.toggle').on('click',function(){
				$('.toggle').removeClass('select');
				$('.toggle').removeClass('false');
				$('.toggle').addClass('false');
				$(this).removeClass('false');
				$(this).addClass('select');
				if($(this).text() == '습관어'){
					createHabitHtml(habitMap,habitLength);
				} else if($(this).text() == '반복어'){
					createRepeatHtml(repeatList);
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
					borderWidth: 0,
				}]
			},
			options: {
				responsive: false,
				scales: {
				},
				circumference :3/2* Math.PI,
				cutoutPercentage: 90,
				rotation : 0.75 * Math.PI,
				tooltips: {enabled: false},
			    hover: {mode: null}
			}
		});
		
	}
	
	/* 속도 */
	function createSpeedHtml(speed,scriptLength){
		// 추천시간
		goodTime = Math.ceil(Number(scriptLength)*60/300);
		goodMin =  Math.floor(Number(goodTime)/60);
		goodSec = Number(goodTime)%60;
		
		speedHtml = '<div class="title">말하기 속도</div>';
		
		if(speed==null || speed==0){ // 미감지
			speedHtml += '<div class="content-box none">';
			speedHtml += '<canvas class="answer-speed-graph" width="250" height="250"></canvas>';
			speedHtml += '<div class="average-speed">합격자 평균 속도<br>';
			speedHtml += '<span>300</span></div>';
			speedHtml += '<div class="minute-text">측정불가</div>';
			speedHtml += '<div class="error-percent"><b>측정에 실패했습니다</b></div>';
			speedHtml += '<div class="message">어떤 이유로 인해 측정에 실패했습니다 :(<br>혹시 마이크에 문제가 있는 건 아닌지 확인해 보세요!</div>';
			speedHtml += '</div>';
		
		} else if(speed < 300){ // 평균보다 느릴때
			speedHtml += '<div class="content-box slow">';
			speedHtml += 	'<canvas id="speedChart" class="answer-speed-graph" style="top:82px;" width="250" height="250"></canvas>';
			speedHtml += 	'<div class="average-speed">';
			speedHtml += 		'합격자 평균 속도<br>';
			speedHtml += 		'<span>300</span>';
			speedHtml += 	'</div>';
			speedHtml += 	'<div class="minute-text">';
				if(speed < 10){
					speedHtml +=		'<span>1분당</span><br><b>&nbsp;&nbsp;'+Math.ceil(speed)+'</b>자';
				}else if(speed < 100){
					speedHtml +=		'<span>1분당</span><br><b>&nbsp;'+Math.ceil(speed)+'</b>자';
				}else{
					speedHtml +=		'<span>1분당</span><br><b>'+Math.ceil(speed)+'</b>자';
				}
				speedHtml +=	'</div>';
// 			// 평균대비 속도 퍼센트
			speedHtml += 	'<div class="error-percent">';
			speedHtml += 		'평균보다<b class="num">'+Number(100 - Math.ceil(speed/300*100))+'% 느려요</b>';
			speedHtml += 	'</div>';
			speedHtml +=	'<div class="message">';
			speedHtml += 		'답변하신 내용은 <b>'+Number(goodMin)+'분 '+Number(goodSec-2)+'초 ~ '+Number(goodMin)+'분 '+Number(goodSec+2)+'초</b>정도 안에<br>이야기하시면 적당한 속도입니다.<br>';
			speedHtml += 		'다시한 번 연습해 보세요!';
			speedHtml += 	'</div>';
			speedHtml += '</div>';
		} else if (speed == 300){ // 평균속도일 때
			speedHtml += '<div class="content-box">';
			speedHtml += 	'<canvas id="speedChart" class="answer-speed-graph" style="top:82px;" width="250" height="250"></canvas>';
			speedHtml += 	'<div class="average-speed">';
			speedHtml += 		'합격자 평균 속도<br>';
			speedHtml += 		'<span>300</span>';
			speedHtml += 	'</div>';
			speedHtml += 	'<div class="minute-text">';
			speedHtml +=		'<span>1분당</span><br><b>'+speed+'</b>자';
			speedHtml +=	'</div>';
			// 평균대비 속도 퍼센트
			speedHtml += 	'<div class="error-percent">';
			speedHtml += 		'평균과<b class="num">일치합니다</b>';
			speedHtml += 	'</div>';
			speedHtml +=	'<div class="message">';
			speedHtml += 		'적당한 속도로 이야기하고 있습니다. 지금 속도를 유지해 주세요!';
			speedHtml += 	'</div>';
			speedHtml += '</div>';
		} else if (speed > 300){ // 평균보다 빠를때
			speedHtml += '<div class="content-box fast">';
			speedHtml += 	'<canvas id="speedChart" class="answer-speed-graph" style="top:82px;" width="250" height="250"></canvas>';
			speedHtml += 	'<div class="average-speed">';
			speedHtml += 		'합격자 평균 속도<br>';
			speedHtml += 		'<span>300</span>';
			speedHtml += 	'</div>';
			speedHtml += 	'<div class="minute-text">';
			speedHtml +=		'<span>1분당</span><br><b>'+speed+'</b>자';
			speedHtml +=		'</div>';
			// 평균대비 속도 퍼센트
			speedHtml += 	'<div class="error-percent">';
			speedHtml += 		'평균보다<b class="num">'+Number(Math.ceil(speed/300*100) - 100)+'% 빨라요</b>';
			speedHtml += 	'</div>';
			speedHtml +=	'<div class="message">';
			speedHtml += 		'답변하신 내용은 <b>'+Number(goodMin)+'분 '+Number(goodSec-2)+'초 ~ '+Number(goodMin)+'분 '+Number(goodSec+2)+'초</b>정도 안에<br>이야기하시면 적당한 속도입니다.<br>';
			speedHtml += 		'다시한 번 연습해 보세요!';
			speedHtml += 	'</div>';
			speedHtml += '</div>';
		}
		$('.AnswerSpeed').empty();
		$('.AnswerSpeed').append(speedHtml);
		
		
		// 속도 그래프
		var ctx = document.getElementById('speedChart');
		createSpeedChart(ctx, speed);
		
	}
	
	
	/* 인재상 - 키워드 리포트*/
	function createKeywordHtml(keywordMap,talentNm){
		keywordArr =keywordMap[talentNm];
		keywordHtml = '';
		if(keywordArr != null && keywordArr !=''){
			for(var i=0; i<keywordArr.length; i++){
				keywordHtml += '<span class="word">'+keywordArr[i]+'</span>';
			}
		}
		$('.JobCompetency .word-view').empty();
		$('.JobCompetency .word-view').append(keywordHtml);
		
		
	}
	
	
	/* 인재상 - 인재상 & 퍼센트  리포트*/
	function createTalentHtml(talentList){
		talentHtml = '';
		if(talentList.length == 0){
			talentHtml += '<div class="no-result"><div class="question-mark">?</div>인재상 미감지</div>';
		}else{
			gage = talentList[0].percent;
			talentHtml += '<div class="result">';
			talentHtml += '<div class="competency-percent select">';
			talentHtml +=	 '<div class="name-box"><span class="name">'+talentList[0].talentNm+'</span></div>';
			talentHtml +=	 '<div class="rectangle" style="width: '+Math.round(200*talentList[0].percent/gage)+'px;"></div>';
			talentHtml +=	 '<div class="percentage">'+talentList[0].percent+'%</div>';
			talentHtml += '</div>';
			window.talentNm = talentList[0].talentNm;
			for(var i=1; i< talentList.length; i++){
				talentHtml += '<div class="competency-percent unselect">';
				talentHtml +=	 '<div class="name-box"><span class="name">'+talentList[i].talentNm+'</span></div>';
				talentHtml +=	 '<div class="rectangle" style="width: '+Math.round(200*talentList[i].percent/gage)+'px;"></div>';
				talentHtml +=	 '<div class="percentage">'+talentList[i].percent+'%</div>';
				talentHtml += '</div>';
			}
			talentHtml += '<div class="word-view">';
			talentHtml += '</div>';
			talentHtml += '</div>';
		}
		$('.JobCompetency .content-box').html(talentHtml);
		
		
	}
	
	/* 반복어 리포트 */
	function createRepeatHtml(repeatList){
		
		repeatHtml = '';
		
		if(repeatList == null || repeatList ==''){
			repeatHtml += '<div class="comment no-exist">답변 중 반복어 사용 횟수';
			repeatHtml += '<span aria-hidden="true" class="fa fa-question-circle fa undefined"></span>';
			repeatHtml += '<div class="comment-box repeat">한 가지 단어를 지나치게 많이 반복하면 전문성과 언어 구사력에 있어 좋은 인상을 주기 어렵습니다.</div>';
			repeatHtml += '</div>';
			repeatHtml += '<div class="no-result-box">반복어 감지가 안되었습니다</div>';
		} else {
			repeatHtml += '<div class="comment exist">답변 중 반복어 사용 횟수';
			repeatHtml += '<span aria-hidden="true" class="fa fa-question-circle fa undefined"></span>';
			repeatHtml += '<div class="comment-box repeat">한 가지 단어를 지나치게 많이 반복하면 전문성과 언어 구사력에 있어 좋은 인상을 주기 어렵습니다.</div>';
			repeatHtml += '</div>';
			for(var i=0; i<repeatList.length; i++){
			repeatHtml += '<div class="habitual word-graph select repeat">';
				repeatHtml += '<div class="label">'+repeatList[i].repeatCount+'회</div>';
				repeatHtml += '<div class="rectangle" style="height: '+repeatList[i].repeatCount*20+'px;"></div>';
				repeatHtml += '<div class="name">'+repeatList[i].repeatContent+'</div>';
				repeatHtml += '</div>';
			}
		}
		repeatHtml += '<div class="bar"></div>';
		$('.graph-box-flex').empty();
		$('.graph-box-flex').html(repeatHtml);
	}
	
	/* 습관어 리포트 */
	function createHabitHtml(habitMap,habitLength){
		habitHtml = '';
		if(habitMap == null || habitMap =="" || habitLength == 0){
			habitHtml += '<div class="comment no-exist">답변 중 습관어 사용 횟수';
			habitHtml += '<span aria-hidden="true" class="fa fa-question-circle fa undefined"></span>';
			habitHtml += '<div class="comment-box habitual"> 무의식 중에 내뱉는 습관어는 인터뷰의 흐름을 끊고 자신의 메시지를 효과적으로 전달하는데 방해가 됩니다.</div>';
			habitHtml += '</div>';
			habitHtml += '<div class="no-result-box">습관어 감지가 안되었습니다</div>';
		} else{
			habitHtml += '<div class="comment exist">답변 중 습관어 사용 횟수';
			habitHtml += '<span aria-hidden="true" class="fa fa-question-circle fa undefined"></span>';
			habitHtml += '<div class="comment-box habitual"> 무의식 중에 내뱉는 습관어는 인터뷰의 흐름을 끊고 자신의 메시지를 효과적으로 전달하는데 방해가 됩니다.</div>';
			habitHtml += '</div>';
		
			
			for(var i=0; i<habitLength; i++){ 
				key = Object.keys(habitMap)[i]; 
				value = habitMap[key];
				habitHtml += '<div class="habitual word-graph select habitual">';
				habitHtml += '<div class="label">'+value+'회</div>';
				habitHtml += '<div class="rectangle" style="height: '+value*20+'px;"></div>';
				habitHtml += '<div class="name">'+key+'</div>';
				habitHtml += '</div>';
			}
		}
		habitHtml += '<div class="bar"></div>';
		$('.graph-box-flex').empty();
		$('.graph-box-flex').html(habitHtml);
	}
	
	/* 스크립트 리포트*/
	function createScriptHtml(script,scriptLength){
		if(script==null || script==''){
			$('.MyAnswer .stt').html('<span class="false false"></span>')						
		} else {
			$('.MyAnswer .stt').text(script);
		}
		$('.MyAnswer .length span').text(scriptLength);
	}

	/* 이미지 분석 */
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
	
	/* 이미지 분석 */
	function imageAnalysisChart(imageAnalysis){
		$("#positiveChart").empty();
		var title = ['other', 'happiness']
		var analysis = [ 1 - imageAnalysis.happiness, imageAnalysis.happiness ];
		var ctx = document.getElementById('positiveChart');
		createImageChart(ctx, title, analysis);
		$("#positiveSpan").empty().append(Math.round(imageAnalysis.happiness*100) + "%")
		$("#positiveBtag").empty().append(Math.round(imageAnalysis.happiness*100) + "%")
		
		$("#neutralChart").empty();
		title = ['other', 'netural']
		analysis = [ 1 - imageAnalysis.neutral,  imageAnalysis.neutral ];
		ctx = document.getElementById('neutralChart');
		createImageChart(ctx, title, analysis);
		$("#neutralSpan").empty().append(Math.round(imageAnalysis.neutral*100) + "%")
		$("#neutralBtag").empty().append(Math.round(imageAnalysis.neutral*100) + "%")
		
		$("#negativeChart").empty();
		var negativeEmotion = imageAnalysis.anger*1 + imageAnalysis.contempt*1 + imageAnalysis.disgust*1 + imageAnalysis.sadness*1;
		title = ['other', 'negative']
		analysis = [ 1 - negativeEmotion , negativeEmotion];
		ctx = document.getElementById('negativeChart');
		createImageChart(ctx, title, analysis);
		$("#negativeSpan").empty().append(Math.round(negativeEmotion*100) + "%")
		$("#negativeBtag").empty().append(Math.round(negativeEmotion*100) + "%")
		
		$("#panicChart").empty();
		var panicEmotion = imageAnalysis.fear*1 + imageAnalysis.surprise*1;
		title = ['other', 'panicEmotion']
		analysis = [ 1 - panicEmotion ,  panicEmotion ];
		ctx = document.getElementById('panicChart');
		createImageChart(ctx, title, analysis);
		$("#panicSpan").empty().append(Math.round(panicEmotion*100) + "%")
		$("#panicBtag").empty().append(Math.round(panicEmotion*100) + "%")
				
		$("#faceChart").empty();
		  var canvas = document.getElementById('faceChart');
		  if (canvas.getContext) {
		    var ctx = canvas.getContext('2d');
		    var faceTop = imageAnalysis.faceTop*1 + 300;
		    var faceLeft = imageAnalysis.faceLeft*1 + 50;
            ctx.strokeStyle = 'rgba(255, 102, 102, 1)';
            ctx.fillStyle = 'rgba(255, 102, 102, 0.2)';
            
		    ctx.strokeRect(faceTop , faceLeft, imageAnalysis.faceWidth, imageAnalysis.faceHeight );
            ctx.fillRect(faceTop , faceLeft, imageAnalysis.faceWidth, imageAnalysis.faceHeight );
		  }
	}
	
	/* 비디오 분석 */
	function videoAnalysisChart(imageAnalysisList){
		var ctx = document.getElementById('videoChart');
		
		labels = [];
		positive = [];
		neutral = [];
		negative = [];
		panic = [];
		for(var i = 0; i < imageAnalysisList.length ; i++){
			labels.push(i);
			positive.push(imageAnalysisList[i].happiness*100);
			neutral.push(imageAnalysisList[i].neutral*100);
			negativeScore= imageAnalysisList[i].anger*1 + imageAnalysisList[i].contempt*1 + imageAnalysisList[i].disgust*1  + imageAnalysisList[i].sadness*1 
			negative.push(negativeScore*100);
			panicScore = imageAnalysisList[i].fear*1 + imageAnalysisList[i].surprise*1;
			panic.push(panicScore*100);
		}
		
		new Chart(ctx, {
			    type: 'line',
			    data: {
			        labels: labels,
			        datasets: [
			        			{
						            label: 'happiness', 
									data: positive,
									borderColor: "#282c37",
									backgroundColor: 'transparent', 
									lineTension: 0.2,
								    fill: true,
						        },
			        			{
						            label: 'neutral',
									data: neutral,
									borderColor: "#9baec8",
									backgroundColor: 'transparent', 
									lineTension: 0.2,
								    fill: true,
						        },
			        			{
						            label: 'negative', 
									data: negative,
									borderColor: "#d9e1e8",
									backgroundColor: 'transparent', 
									lineTension: 0.2,
								    fill: true,
						        },
			        			{
						            label: 'panic', 
									data: panic,
									borderColor: "#2b90d9",
									backgroundColor: 'transparent', 
									lineTension: 0.2,
								    fill: true,
						        },
						        ]
			    },
			    
			    options: {
			        responsive: true,
			        legend: {
			            display: true
			          },
			        scales: {
			        	  xAxes: [{
				                display: false,
				                scaleLabel: {
				                    display: true,
				                }
				            }],
				            yAxes: [{
				                display: true,
				                ticks: {
				                    suggestedMin: 0,
				                    suggestedMax: 100,
				                    stepSize: 50
				                }
				            }]
			        }
			    }
			});
		
	}
	
	
	/* 데시벨 분석 그래프 */ 
	function decibelAnalysisChart(voiceList){
		var x = new Array();
		var decibel = new Array();
		var sumDecibel=0;
		
		for(var i =0; i<voiceList.length; i++){
			x[i] = i+1;
		}
		for(var i =0; i<voiceList.length; i++){
			decibel[i] = voiceList[i].voiceDecibel;
			sumDecibel += Number(voiceList[i].voiceDecibel);
		}
		averageDecibel = Math.round(sumDecibel/voiceList.length);
		
		$('#averageDecibel').text(averageDecibel+"dB");
		
		var ctx = document.getElementById('decibelChart');
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
	
	function frequencyAnalysisChart(voiceList){
		var x = new Array();
		var hrz = [0,50,100,150,200,250,300]; // X축 단위
		var frequency = new Array();
		var sumRange=0;
		
		for(var i =0; i<voiceList.length; i++){
			x[i] = i+1;
		}
		for(var i =0; i<voiceList.length; i++){
			frequency[i] = voiceList[i].voiceRange;
			sumRange += Number(voiceList[i].voiceRange);
		}
		averageRange = Math.round(sumRange/voiceList.length);
		$('#averageRange').text(averageRange+"Hz");
		
		var ctx = document.getElementById('frequencyChart');
		var scatterChart = new Chart(ctx, {
			customTooltips: function (tooltip) {
		        var tooltipEl = $('#user').text();

		        if (!tooltip) {
		            tooltipEl.css({
		                opacity: 0
		            });
		            return;
		        }

		        tooltipEl.removeClass('above below');
		        tooltipEl.addClass(tooltip.yAlign);

		        // split out the label and value and make your own tooltip here
		        var parts = tooltip.text.split(":");
		        var innerHtml = "<div id='user'  class='user-pitch' style='left: 238px;'><img src='/member/profile.do?memId=${S_MEMBER.memId }'	alt='profile-icon' class='profile-icon'><br><b>${S_MEMBER.memAlias }</b>님의 평균 음역대<br><span id='averageRange'></span><div class='line' ></div><div class='point'></div></div>";
		        tooltipEl.html(innerHtml);

		        tooltipEl.css({
		            opacity: 1,
		            left: tooltip.chart.canvas.offsetLeft + tooltip.x + 'px',
		            top: tooltip.chart.canvas.offsetTop + tooltip.y + 'px',
		            fontFamily: tooltip.fontFamily,
		            fontSize: tooltip.fontSize,
		            fontStyle: tooltip.fontStyle,
		        });
		    },
		    type: 'scatter',
		    data: {
		        datasets: [{
		            label: 'Scatter Dataset',
		            data: [{
		                x: averageRange,
		                y: 0
		            }],
		            pointRadius: 10,
		            backgroundColor: 'rgba(0, 0, 0, 1)',
		            borderColor: 'rgba(0, 0, 0, 1)'
		        }]
		    },
		    options: {
		    	tooltips:{
		    		enabled:false,
		            callbacks:{
		            	label: function(tooltipEl) {
		                    return tooltipEl;
		                }
		            }

		    	},
		    	responsive: true,
		    	hover: {
					animationDuration: 0
				},
				animation: {
					duration: 1,
					onComplete: function () {
						var chartInstance = this.chart,
							ctx = chartInstance.ctx;
						ctx.font = Chart.helpers.fontString(15, 20, Chart.defaults.global.defaultFontFamily);
						ctx.fillStyle = 'black';
						ctx.textAlign = 'center';
						ctx.textBaseline = 'bottom';

						this.data.datasets.forEach(function (dataset, i) {
							var meta = chartInstance.controller.getDatasetMeta(i);
							meta.data.forEach(function (bar, index) {
								if(${S_MEMBER == null}){
									var data = '"${shareMemId }"'+'님의 평균음역대';
								}else{
									var data = '"${S_MEMBER.memAlias }"'+'님의 평균음역대';
								}
								ctx.fillText(data, bar._model.x+10, bar._model.y - 70);
								
								ctx.font = "bold 20px Verdana";
								data = averageRange+'Hz';
								ctx.fillText(data, bar._model.x+10, bar._model.y - 25);
							});
						});
					}
				},
		    	legend: {
		    		display: false},
		        scales: {
		            xAxes: [{
		            	display:false,
		                type: 'linear',
		                position: 'bottom',
		                ticks:{
		                	suggestedMin: 10,
		                	suggestedMax: 310
		                }
		            }],
		            yAxes: [{
		            	display:false,
		            	type: 'linear',
		                position: 'bottom',
		                ticks:{
		                	suggestedMin: -100,
		                	suggestedMax: 100
		                }
		            }],
		            
		        }
		    		
		    }
		});
	}
	
</script>



<div class="review-body" id="review-id">
	<div class="title">답변영상 분석</div>
	<div class="ReviewVideo content-box">
		<div class="review-video-area">
			<video autoplay="autoplay" controls="controls" controlsList="nodownload" class="review-video">
				<source src="${cp }/answer/video.do?questSq=${questSq}"
            		type="video/webm">
			
			</video>
			<div class="review-emotion">
				<div class="happy max">
					긍정적 <b id="positiveBtag">0%</b>
				</div>
				<div class="calm max">
					무표정 <b id="neutralBtag">0%</b>
				</div>
				<div class="dark max">
					부정적 <b id="negativeBtag">0%</b>
				</div>
				<div class="surprised max">
					당황함 <b id="panicBtag">0%</b>
				</div>
			</div>
			<div class="review-face"
				style="top: 0px; left: 0px; width: 0px; height: 0px;"></div>
		</div>
		
		<div class="comments">
			<canvas id="videoChart"></canvas>
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
				</div>
			</div>
		</div>
	</div>
	
	<div class="answer-flex">
		<div class="JobCompetency">
			<div class="title">답변에 드러난 인재상</div>
			<div class="content-box">
				<div class="result">
				</div>
			</div>
		</div>
		
		
		<div class="AnswerSpeed">
			<div class="title">말하기 속도</div>
			
		</div>
	</div>
	
	
	<div class="AudioReview">
		<div class="title">목소리 크기</div>
		<div class="content-box intensity">
			<div class="graph-comment">
				<div class="user-intensity">
					<c:choose>
						<c:when test="${S_MEMBER == null }">
							${shareMemId}님의 평균 성량<br>
						</c:when>
						<c:when test="${S_MEMBER != null }">
							${S_MEMBER.memAlias }님의 평균 성량<br>
						</c:when>
					</c:choose>
					<c:choose>
						<c:when test="${S_MEMBER == null }">
							<img src="/member/profile.do?memId=${shareMemId}"	alt="profile-icon" class="profile-icon">
						</c:when>
						<c:when test="${S_MEMBER != null }">
							<img src="/member/profile.do?memId=${S_MEMBER.memId }"	alt="profile-icon" class="profile-icon">
						</c:when>
					</c:choose>
					<span id="averageDecibel"></span>
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
			<canvas id="decibelChart" class="audio-graph" width="791" height="179"
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
			<div class="pitch-line"></div>
			<div id="user"  class="user-pitch" style="left: 238px; display: none;">
				<c:choose>
					<c:when test="${S_MEMBER == null }">
						<img src="/member/profile.do?memId=${shareMemId}"	alt="profile-icon" class="profile-icon"><br>
					</c:when>
					<c:when test="${S_MEMBER != null }">
						<img src="/member/profile.do?memId=${S_MEMBER.memId }"	alt="profile-icon" class="profile-icon"><br>
					</c:when>
				</c:choose>
				<c:choose>
					<c:when test="${S_MEMBER == null }">
						<b>${shareMemId}</b>님의 평균 음역대<br>
					</c:when>
					<c:when test="${S_MEMBER != null }">
						<b>${S_MEMBER.memAlias }</b>님의 평균 음역대<br>
					</c:when>
				</c:choose>
				<span id="averageRange"></span>
				<div class="line" ></div>
				<div class="point"></div>
			</div>
				<canvas id="frequencyChart" class="audio-graph" width="791" height="300"
					style="display: block; height: 200px; width: 880px; position: absolute; margin-top: 60px;"></canvas>
			<div class="men-pitch-area" style="margin-left: 31%;">
				<div class="message">
					<b>선호되는 남성</b>의<br>평균 음역대<br>
					<span>110Hz~130Hz</span>
				</div>
			</div>
			<div class="women-pitch-area" style="margin-left: 22%;">
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
