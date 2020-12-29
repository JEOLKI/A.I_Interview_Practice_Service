<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>AI_INTERVIEW</title>

<%@ include file="/WEB-INF/views/layout/commonLib.jsp" %>

<style>

	body * {
		box-sizing: border-box;
	}
	
	#pronunciation{
		padding: 30px 30px;
		padding-bottom: 0px;
	}
	
	#pronunciation .title{
		display: inline-block;
		float: left;
		margin-left: 20px;
	}
	
	#habitant{
	    font-size: 22px;
	    font-weight: 500;
	    text-align: center;
	    margin-top: 40px;
	}
	
	/* .OrderArea{ */
	/* 	margin : 40px 0px 0px; */
		
	/* } */
	.helloChart{
		width: 60%;
		hegiht : 70%;
	}
	.chartgraph{
		padding-left: 9%;
		padding-top: 10%;
	}
	
	#gazeChart, #speedChart, #habitChart,#voiceChart{
		display: none;
	}
	
	#resultBtn{
		text-align: center;
	    margin-right: 80px;
	    padding: 10px;
	    width: 120px;
	}
	
	.speechBtn{
		font-size: 14px;
		border-radius: 50px;
		border: 1px solid #000d22;
		padding: 5px 20px;
	}
	
	.speechBtn:hover, #resultBtn:hover {
		color: #3CA4FF;
		border-color: #3CA4FF;
	}
	
	#testBtnGrp{
		float: right;
		margin-right: 10px;
	}

	.btn.select #bashArrow{
		display: inline-block;
	    position: absolute;
	    margin-top: 7px;
	}
	
	#pronunciationChart{
		margin-top: 10px;
	}
	
	#gazeMessage{
		font-size: 0.8em;
		font: #323333;
		text-align: right;
		margin-bottom: 10px;
	}
	.message.left{
		display: inline-block;
		float: left; 
	}
	.graph-background{
		margin-top : 142px;
		margin-left: -1px;
		width : 450px;
		height: 30px;
	}
 	.voiceGraph-background{ 
 		margin-bottom : 192px; 
 		margin-left: 5px; 
 		width : 445px; 
 		height: 30px; 
 	} */

	#paging{
		text-align: center;
		margin-top: 30px;
	}
	
	#paging a, #paging strong{
		display: inline-block;
		border: 1px solid #4374D9;
		border-radius: 5px;
		width: 25px;
		padding: 1px;
		text-align: center;
	}
	
	#paging strong{
		background-color: #4374D9;
	    color: #fff;
	}
	
	#paging a:hover{
		background-color: #4374D9;
	    color: #fff;
	}
	
	.chartLabel{
		font-size: 10px;
	    padding: 2px 9px;
	    background-color: #e9edf1;
	    border-radius: 30px;
	    float: left;
	    margin-bottom: 5px;
	    margin-top: 5px;
	}
	
	.test-start-btn{
		display: inline-block;
	 	background-color: #13e3eb;
		font-size: 16px;
		border-radius: 50px;
		padding: 13px 24px;
		margin-top: 10px;
		font-weight: bold;
	}
</style>

<script>

	var imageAnalysisList;
	var labels = [];
	
	$(document).ready(function() {
		
		/* 발음평가 그래프 */
		$.ajax({url : "/scriptTest/retrieveScriptTestList.do",
			method : "get",
			data : {memId : "${S_MEMBER.memId}"},
			success : function(data){
				
				if(data.scriptTestList.length == 0){
					$('#testResultZone').empty();
					$('#testBtnGrp').hide();
					$('#pronunciation .title').empty();
					
					$('#pronunciation .title').append('<h4 style="margin-top:5px; float:center;" >발음 평가 🔉</h4>');
					
					var html ="";
					html += '<h4>지금 바로 테스트에 도전하고,<br>나만의 발음 그래프를 확인하세요!</h4>';
					html += '<a class="test-start-btn" onclick="testStartPopUp();">TEST START!</a>';
					$('#testResultZone').append(html);
				}else{
					scriptTestChart(data.scriptTestList);
				}
				
			
			}
		})
		
		/* 성장그래프 - 감정, 움직임 */
		$.ajax({url : "/analysis/image/retrieveGrowth.do",
			method : "get",
			success : function(data){
				imageAnalysisList = data.imageAnalysisGrowth;
				imageGrowthdata(imageAnalysisList);
			}
		})
		
		/* 성장그래프 - 말 빠르기 */
		$.ajax({url : "/analysis/speed/retrieveGrowth.do",
			method : "get",
			success : function(data){
				speedGrowthList = data.answerSpeedGrowth;
				speedGrowthdata(speedGrowthList);
			}
		})
		
		/* 성장그래프 - 습관어(차트)*/
		$.ajax({url : "/analysis/habit/retrieveGrowth.do",
			method : "get",
			success : function(data){
				habitGrowthList = data.habitAnalysisGrowth;
				habitGrowthdata(habitGrowthList);
			}
		})
		
		/* 성장그래프 - 습관어(바)*/
		$.ajax({url : "/analysis/habit/retrieveCount.do",
			method : "get",
			success : function(data){
				habitCountList = data.habitAnalysisCount;
				habitList = data.habitList;
				habitCountHtml(habitCountList,habitList);
			}
		})
		
		/* 성장그래프 - 음성 */
		$.ajax({url : "/analysis/voice/retrieveGrowth.do",
			method : "get",
			success : function(data){
				for (var i = 0; i < data.voiceAnalysisGrowth.length; i++) {
				}
				voiceGrowthList = data.voiceAnalysisGrowth;
				voiceGrowthdata(voiceGrowthList);
			}
		})
		
		
		$(".btn").on('click', function(){
			target = $(this).data("target");
			$(".btn").removeClass("select");
			$(this).addClass("select");
			$(".graph-content").hide();
			$("#"+target+"").show();
		})
		
		$('.start-btn').on('click',function(){
			document.location = "/interview/ready.do";
		})
		
		$("#popUpOpenBtn").on('click' , function () {
			testStartPopUp();
		});
	})

	function testStartPopUp(){
		 //var popupX = (document.body.offsetWidth / 2) - (480 / 2);
	  	  //var popupY= (window.screen.height / 2) - (620 / 2);
	  	  
	  	  var url = '/scriptTest/testPopup.do';
	  	  
	  	  var options = 'width=340, height=500, status=no, menubar=no, toolbar=no, resizable=no, scrollbars=no';
	      window.open(url, "", options);
	};
	
	function scriptTestChart(scriptTestList){
		
		koreanlabels = [0];
		englishlabels = [0];
		koreanScore = [0];
		englishScore = [0];
		
		for(var i = 0 ; i < scriptTestList.length; i++){
			
			if(scriptTestList[i].scriptGbContent == '한국어'){
				koreanScore.push(scriptTestList[i].scriptTestScore);
				koreanlabels.push(i);
			} else if (scriptTestList[i].scriptGbContent == '영어') {
				englishScore.push(scriptTestList[i].scriptTestScore);
				englishlabels.push(i);
			}
		}
		
		var myChart = new Chart(document.getElementById('englishTestChart'), {
				type: 'line',
			    data: { 
					labels: englishlabels, 
					datasets: [{ 
						label: 'English Test', 
						backgroundColor: 'transparent', 
						borderColor: 'rgb(255,+99,+132)',
						data: englishScore,
						lineTension: 0,
					    fill: true,
					    pointStyle: 'circle',
					    pointRadius: 2,
					    borderWidth: 1 //선굵기
					}]
			    },
			    options: {
			        responsive: true,
			        legend: {
			            display: false
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
		
		var myChart = new Chart(document.getElementById('koreanTestChart'), {
				type: 'line',
			    data: { 
					labels: koreanlabels, 
					datasets: [{ 
						label: 'English Test', 
						backgroundColor: 'transparent', 
						borderColor: 'rgb(255,+99,+132)',
						data: koreanScore,
						lineTension: 0,
					    fill: true,
					    pointStyle: 'circle',
					    pointRadius: 2,
					    borderWidth: 1 //선굵기
					}]
			    },
			    options: {
			        responsive: true,
			        legend: {
			            display: false
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

	/* 성장그래프 - 습관어(바) */
	function habitCountHtml(habitCountList, habitList){
		var fullGage = 187;
		var max = 0;
		for(var i = 0; i<habitCountList.length; i++){
			if(habitCountList[i].habitCount > max ){
				max = habitCountList[i].habitCount;
			}
		}
		habitCountHtml = '<div class="unit">(회)</div>';
		for(var i = 0; i<habitList.length; i++){
			var gage = 0;
			var count = 0;
			habitCountHtml += '<div class="HabitBar">';
			habitCountHtml += 	'<div class="label">'+habitList[i].habitGb +'..</div>';
			habitCountHtml += 	'<div class="range">';
			for(var j = 0; j<habitCountList.length; j++){
				if(habitList[i].habitGb == habitCountList[j].habitGb){
					gage = Number(fullGage*habitCountList[j].habitCount/max);
					count = habitCountList[j].habitCount;
				}
			}
			habitCountHtml += 		'<div class="gaze" style="width: '+gage+'px;"></div>';
			habitCountHtml += 	'</div>';
			habitCountHtml += 	'<div class="count">'+count+'</div>';
			habitCountHtml += '</div>';
		}
		$('.bar-area').empty();
		$('.bar-area').html(habitCountHtml);
	}
		
	
	
	/* 성장그래프 - 습관어(차트) 데이터 */
	function habitGrowthdata(habitGrowthList){
		var max = 20;
		
		
		analysis = [0];
		labels = [0];
		for(var i = habitGrowthList.length-1 ; i >=0 ; i--){
			labels.push(habitGrowthList[i].habitCount);
			analysis.push(habitGrowthList[i].habitCount);
		}
		var ctx = document.getElementById('habitGrowth');
		habitGrowthChart(ctx,labels,analysis, max);
		
	}
	
	/* 성장그래프 - 습관어 그래프 */
	function habitGrowthChart(ctx,labels,analysis,max){
		var myChart = new Chart(ctx, {
			type: 'line',
		    data: {
		        labels: labels,
		        datasets: [{
		            data: analysis,
		            borderColor: "rgb(114,219,237, 1)",
		            backgroundColor: "rgb(206,240,247, 0.5)",
		            fill: true,
		            lineTension: 0
		        }]
		    },
		    options: {
		        responsive: true,
		        legend: {
		            display: false
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
			                    suggestedMax: max,
			                    stepSize : 4
			                }
			            }]
		        }
		    }
		});
	}
	
	
	/* 성장그래프 - 말 빠르기 데이터 */
	function speedGrowthdata(speedGrowthList){
		var max = 700;

		analysis = [0];
		labels = [0];
		for(var i = speedGrowthList.length-1 ; i >=0 ; i--){
			labels.push(speedGrowthList[i].ansSpeed);
			analysis.push(speedGrowthList[i].ansSpeed);
		}
		var ctx = document.getElementById('speedGrowth');
		speedGrowthChart(ctx,labels,analysis, max);
		
	}
	
	/* 성장그래프 - 말 빠르기 그래프 */
	function speedGrowthChart(ctx,labels,analysis,max){
		var myChart = new Chart(ctx, {
			type: 'line',
		    data: {
		    	labels: labels,
		        datasets: [{
		            data: analysis,
		            borderColor: "rgb(114,219,237, 1)",
		            backgroundColor: "rgb(206,240,247, 0.5)",
		            fill: true,
		            lineTension: 0
		        }]
		    },
		    options: {
		        responsive: true,
		        legend: {
		            display: false
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
			                    suggestedMax: max
			                }
			            }]
		        }
		    }
		});
	}
	
	/* 성장그래프 - 감정분석 데이터*/	
	function imageGrowthdata(imageAnalysisList){
		
		lables = [];
		positiveAnalysis = [];
		neutralAnalysis = [];
		negativeAnalysis = [];
		panicAnalysis = [];
		faceAnalysis = [];
		
		
		for(var i = 0; i < imageAnalysisList.length ; i++){
			labels.push(i);
			
			positiveAnalysis.push(imageAnalysisList[i].happiness);
			
			neutralAnalysis.push(imageAnalysisList[i].neutral);
			
			negative = imageAnalysisList[i].anger*1 + imageAnalysisList[i].contempt*1 + imageAnalysisList[i].disgust*1  + imageAnalysisList[i].sadness*1 
			negativeAnalysis.push(negative);
			
			panic = imageAnalysisList[i].fear*1 + imageAnalysisList[i].surprise*1;
			panicAnalysis.push(panic);
			
			position = imageAnalysisList[i].faceTop*1 + imageAnalysisList[i].faceLeft*1;
			faceAnalysis.push(position);
			
		}
		
		imageGrowthChart(document.getElementById('positiveChart'), labels, ['happiness'], positiveAnalysis);
		imageGrowthChart(document.getElementById('neutralChart'), labels, ['neutral'], neutralAnalysis);
		imageGrowthChart(document.getElementById('negativeChart'), labels, ['negative'], negativeAnalysis);
		imageGrowthChart(document.getElementById('panicChart'), labels, ['panic'], panicAnalysis);
		imageGrowthChart(document.getElementById('faceChart'), labels, ['facePosition'], faceAnalysis);
		
	}
	
	/* 성장그래프 - 감정분석 차트*/
	function imageGrowthChart(ctx, labels, title, analysis, max){
		var myChart = new Chart(ctx, {
			type: 'line',
		    data: {
		        labels: labels,
		        datasets: [{
		            label: title,
		            data: analysis,
		            borderColor: "rgb(114,219,237, 1)",
		            backgroundColor: "rgb(206,240,247, 0.5)",
		            fill: true,
		            lineTension: 0
		        }]
		    },
		    options: {
		        responsive: true,
		        legend: {
		            display: false
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
			                    stepSize: 20
			                }
			            }]
		        }
		    }
		});
		
	}
	
	
	/* 음성분석 데이터*/
	function voiceGrowthdata(voiceGrowthList){
		var max = 250;

		labels= [0];
		analysisDecibel = [0];
		for(var i = voiceGrowthList.length-1 ; i >=0 ; i--){
			labels.push(voiceGrowthList[i].interviewSq);
			analysisDecibel.push(voiceGrowthList[i].voiceDecibel);
		}
		var ctx = document.getElementById('voiceGrowh');
		voiceGrowthChart(ctx,labels, analysisDecibel, max);
	}
	
	/* 음성분석 차트*/
	function voiceGrowthChart(ctx,labels,analysisDecibel, max){
		var myChart = new Chart(ctx, {
			type: 'line',
		    data: {
		    	labels: labels,
		        datasets: [{
		            data: analysisDecibel,
		            borderColor: "rgb(114,219,237, 1)",
		            backgroundColor: "rgb(206,240,247, 0.5)",
		            fill: true,
		            lineTension: 0
		        }]
		    },
		    options: {
		        responsive: true,
		        legend: {
		            display: false
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
			                    suggestedMax: max
			                }
			            }]
		        }
		    }
		});
	}
	
	 /* pagination 페이지 링크 function */
    function linkPage(pageNo){
    	document.listForm.pageIndex.value = pageNo;
    	document.listForm.action = "<c:url value='/analysis/interview/retrievePagingList.do'/>";
       	document.listForm.submit();
    }
	 
</script>

</head>
<body>

	<div id="root">
		<div class="Main false" style="overflow-y: hidden; ">
			<%@ include file="/WEB-INF/views/layout/header.jsp"%>
			<div class="my-bar interview">
				<div class="title">내 면접</div>
				<div class="start-btn">
					<a > 새 면접 만들기<img src="/images/right.2a3d42b5.svg" alt=""></a>
				</div>
			</div>
			<div class="MainComponent">
				<div class="MainBoard">
					<div class="board">
						<div class="RecentInterview box">
							<div class="illust-area">
								<img
									src="data:image/png;base64,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"
									alt="">
							</div>
							<div class="interface">
								<div class="title">최근 면접</div>
								${resultList[0].interviewDate }
								<br>
								${resultList[0].interviewNm } 
							</div>
							
							<a id="resultBtn" class="review-btn" href="/analysis/question/retrievePagingList.do?interviewSq=${resultList[0].interviewSq }">결과 보기</a> 
						</div>
						
						<div class="ProspectArea box">
							<div class="title">
								목표기업<a class="link" href="/member/myprofileview.do">내 프로필</a>
							</div>
							<div class="flex">
								<span>기업</span>
								<div class="prospect">
									<c:choose>
										<c:when test="${fn:length(S_MEMBER.memTargetCompany) > 5 }">
											${fn:substring(S_MEMBER.memTargetCompany,0,5)}...
										</c:when>
										<c:otherwise>
											${S_MEMBER.memTargetCompany }
										</c:otherwise>
									</c:choose>
									<div class="under-line"></div>
								</div>
							</div>
							<div class="flex">
								<span>직무</span>
								<div class="prospect">
									<c:choose>
										<c:when test="${fn:length(S_MEMBER.memTargetJob) > 5 }">
											${fn:substring(S_MEMBER.memTargetJob,0,5)}...
										</c:when>
										<c:otherwise>
											${S_MEMBER.memTargetJob }
										</c:otherwise>
									</c:choose>
									<div class="under-line"></div>
								</div>
							</div>
						</div>


						<div class="box HelpArea" id="pronunciation">
						
							<div class="label"></div>
							<div class="title">발음평가</div>
							<div id="testBtnGrp">
								<a id="popUpOpenBtn" class="speechBtn">발음평가하기</a>
							</div>
							
							<br>
							<br>
						
							<div id="testResultZone">
								<label class="chartLabel">한국어</label>
								<canvas id="koreanTestChart" class="graph-canvas" width="200" height="35"></canvas>	
								<label class="chartLabel">영어</label>
								<canvas id="englishTestChart" class="graph-canvas" width="200" height="35"></canvas>	
							</div>
						</div>
						
						
						
						<div class="OrderArea box">
							<div class="title">이용권 구매하기</div>
							<div class="sub-title">1일권 부터 7일권까지 있습니다.</div>
							<a class="start-btn" href="/plan/planList.do">GO!</a>
						</div>

						<div class="GraphComponent box">
							<div class="nav">
								<div class="title">
									내 성장
									<div class="sub">(최근 5회)</div>
								</div>
								<div class="select-area">
									<div class="emotion btn select" data-target="emotionChart">
										<div class="pot"></div>
										표정<img id="bashArrow" src="/images/arrow_small.png" alt="" class="dash">
									</div>
									<div class="gaze btn false" data-target="gazeChart">
										<div class="pot"></div>
										움직임<img id="bashArrow" src="/images/arrow_small.png" alt="" class="dash">
									</div>
									<div class="sps btn false" data-target="speedChart">
										<div class="pot"></div>
										말 빠르기<img id="bashArrow" src="/images/arrow_small.png" alt="" class="dash">
									</div>
									<div class="audio btn false" data-target="voiceChart">
										<div class="pot"></div>
										음성<img id="bashArrow" src="/images/arrow_small.png" alt="" class="dash">
									</div>
									<div class="habit btn false" data-target="habitChart">
										<div class="pot"></div>
										습관어<img id="bashArrow" src="/images/arrow_small.png" alt="" class="dash">
									</div>
								</div>
							</div>
							
							<div class="graph-area">
							
								<div id="emotionChart" class="Emotion graph-area graph-content">
									<div class="area bright">
										<div class="label">긍정</div>
										<canvas id="positiveChart" class="graph-canvas"
											width="215" height="160"></canvas>
									</div>
									<div class="area neutral">
										<div class="label">무표정</div>
										<canvas id="neutralChart" class="graph-canvas"
											width="215" height="160"></canvas>
									</div>
									<div class="area dark">
										<div class="label">부정</div>
										<canvas id="negativeChart" class="graph-canvas"
											width="215" height="160"></canvas>
									</div>
									<div class="area surprised">
										<div class="label">당황</div>
										<canvas id="panicChart" class="graph-canvas"
											width="215" height="160"></canvas>
									</div>
								</div>
								
								<div id="gazeChart" class="Gaze graph-area graph-content">
									<div class="area">
										<div id="gazeMessage">얼굴의 위치가 얼마나 움직였는지 보여줍니다. <br>(0에 가까울수록 움직이지 않음)</div>
										<canvas id="faceChart" class="graph-canvas" width="500" height="400"></canvas>
									</div>
								</div>
								
								<div id="speedChart" class="Sps graph-area graph-content">
									<div class="area"  style="margin-top:60px;">
										<div class="message left">(음절/분)</div>
										<div class="message">※적정 빠르기 
											<div class="gray-box"></div>
										</div>
										<canvas id="speedGrowth" class="graph-canvas" width="451" height="330"></canvas>
										<img src="/images/speed.png" class="graph-background sps" alt="">
									</div>
								</div>
								
								<div id="voiceChart" class="Voice graph-area graph-content">
									<div class="area" style="margin-top:60px;">
										<div class="message left">(dB)</div>
										<div class="message">※평균 성량을 나타냅니다.</div>
										<canvas id="voiceGrowh" class="graph-canvas" width="451" height="330"></canvas>
										<img src="/images/averageDecibel.png" class="graph-background sps" alt="" style=" margin-top : 192px; margin-left: 5px; 
		 									width : 445px; height: 30px; ">
									</div>
								</div>
								
								<div id="habitChart" class="Habit graph-area graph-content">
									<div class="area" style="margin-top:100px;">
										<div class="message">※습관어 사용량이 적을수록 좋습니다.</div>
										<canvas id="habitGrowth" class="graph-canvas" width="446" height="223"></canvas>
										<div class="graduation-bar">
											<div class="graduation"></div>
											<div class="graduation"></div>
										</div>
									</div>
								</div>
								
							</div>
							
						</div>
						<div class="HabitArea box" id="habitant">
							<div class="title">내 습관어</div>
							<div class="bar-area">
							
							</div>
						</div>
					</div>
				</div>
				
				<div class="MyInterviews">
					<div class="title">면접 내역</div>
						<form:form commandName="interviewVO" id="listForm" name="listForm" method="get">
							
							<c:forEach items="${resultList }" var="interview">
								<div class="interview-table">
									<div class="SetInterviewBox">
										<div class="date">${interview.interviewDate}</div>
										<span class="name">${interview.interviewNm}</span>
										<a class="button" href="/analysis/question/retrievePagingList.do?interviewSq=${interview.interviewSq }">결과 보기</a>
									</div>
								</div>
							</c:forEach>
							
							<div id="paging" style="text-align: center; margin-top: 30px;">
								<ui:pagination  paginationInfo = "${paginationInfo}" type="image" jsFunction="linkPage"></ui:pagination>
								<form:hidden path="pageIndex" />
							</div>
						
						</form:form>
				</div>
			</div>
		</div>
	</div>
	
	<%@ include file="/WEB-INF/views/chat/chatImage.jsp" %>
	
</body>
</html>