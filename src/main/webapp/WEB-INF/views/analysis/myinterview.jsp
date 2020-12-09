<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>아이엠터뷰</title>

<link href="/css/main.8acfb306.chunk.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>
<style>
body * {
	box-sizing: border-box;
}

.TestChart{
	background:transparent;
	background-color: white;
	height: 500px;
	
}
#pronunciation{
	padding : 10px 20px;
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

#gazeChart{
	display: none;
}


</style>

<script>

var imageAnalysisList;
var labels = [];


$(document).ready(function() {
	TestChart();
	
	$.ajax({url : "/analysis/image/retrieveGrowth.do",
		method : "get",
		success : function(data){
			console.log(data.imageAnalysisGrowth)
			imageAnalysisList = data.imageAnalysisGrowth;
			imageGrowthdata(imageAnalysisList);
		}
	})
	
	$(".btn").on('click', function(){
		target = $(this).data("target");
		$(".btn").removeClass("select");
		$(this).addClass("select");
		$(".graph-content").hide();
		$("#"+target+"").show();
		console.log(target);
	})
	
})

function TestChart(){
  $.ajax({url : "/speech/speechChart.do",
	  method : "get",
	  success : function(data){
		  var html = data;	
		  $("#TestChart").html(html);
	  }
  })
}


function imageGrowthdata(imageAnalysisList){
	
	var max = 1;
	
	for(var i = 0; i < imageAnalysisList.length ; i++){
		labels.push(i);
		analysis = [0];
		analysis.push(imageAnalysisList[i].happiness);
	}
	var title = ['happiness']
	var ctx = document.getElementById('positiveChart');
	imageGrowthChart(ctx, labels, title, analysis, max);
	
	title = ['netural']
	for(var i = 0; i < imageAnalysisList.length ; i++){
		analysis = [0];
		analysis.push(imageAnalysisList[i].neutral);
	}
	ctx = document.getElementById('neutralChart');
	imageGrowthChart(ctx, labels, title, analysis, max);
	
	title = ['negative']
	for(var i = 0; i < imageAnalysisList.length ; i++){
		negative = imageAnalysisList[i].anger*1 + imageAnalysisList[i].contempt*1 + imageAnalysisList[i].disgust*1  + imageAnalysisList[i].sadness*1 
		analysis = [0];
		analysis.push(negative);
	}
	ctx = document.getElementById('negativeChart');
	imageGrowthChart(ctx, labels, title, analysis, max);
	
	title = ['panic']
	for(var i = 0; i < imageAnalysisList.length ; i++){
		panic = imageAnalysisList[i].fear*1 + imageAnalysisList[i].surprise*1;
		analysis = [0];
		analysis.push(panic);
	}
	ctx = document.getElementById('panicChart');
	imageGrowthChart(ctx, labels, title, analysis, max);
	
	max = 30;
	title = ['facePosition']
	for(var i = 0; i < imageAnalysisList.length ; i++){
		position = imageAnalysisList[i].faceTop*1 + imageAnalysisList[i].faceLeft*1;
		analysis = [0];
		analysis.push(position);
	}
	ctx = document.getElementById('faceChart');
	imageGrowthChart(ctx, labels, title, analysis, max);
	
}

function imageGrowthChart(ctx, labels, title, analysis, max){
	var myChart = new Chart(ctx, {
		type: 'line',
	    data: {
	        labels: labels,
	        datasets: [{
	            label: title,
	            data: analysis,
	            borderColor: "rgba(255, 201, 14, 1)",
	            backgroundColor: "rgba(255, 201, 14, 0.5)",
	            fill: true,
	            lineTension: 0
	        }]
	    },
	    options: {
	        responsive: true,
	        scales: {
	            xAxes: [{
	                display: true,
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




</script>

</head>
<body>

	<div id="root">
		<div class="Main false">
			<%@ include file="/WEB-INF/views/layout/header.jsp"%>
			<div class="my-bar interview">
				<div class="title">내 면접</div>
				<div class="start-btn">
					<a href="/interview/ready.do"> 새 면접 만들기<img
						src="/static/media/right.2a3d42b5.svg" alt=""></a>
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
								면접본 날짜 ex)2020.11.27<br>면접
							</div>
							<a class="review-btn" href="/analysisresult/interviewresult.do">결과
								보기</a> <a class="review-btn" href="/analysisresult/interviewlist.do">면접
								분석</a>
						</div>
						<div class="ProspectArea box">
							<div class="title">
								목표기업<a class="link" href="/personal-info">내 프로필</a>
							</div>
							<div class="flex">
								<span>기업</span>
								<div class="prospect null false">
									없음
									<div class="under-line"></div>
								</div>
							</div>
							<div class="flex">
								<span>직무</span>
								<div class="prospect null false">
									없음
									<div class="under-line"></div>
								</div>
							</div>
						</div>


						<div class="box HelpArea" id="pronunciation">
						
							<div class="label"></div>
							<div class="title"> 발음연습 &nbsp &nbsp
								<button id="popUpOpenBtn">발음 평가</button>&nbsp &nbsp
								<button id="speechOpen">발음 평가</button>
							</div>
							<div id="TestChart"></div>	
							<br>
							
						</div>
						
						
						
						<div class="OrderArea box">
							<div class="title">이용권 구매하기</div>
							<div class="sub-title">1일권 부터 7일권까지 있습니다.</div>
							<a class="start-btn" href="/payment">GO!</a>
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
										표정<img
											src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAcAAAAMCAYAAACulacQAAAABHNCSVQICAgIfAhkiAAAAIFJREFUGFdjZOBRWs7w5V4kAxbACBbjVfrP8PkehI0EEAJYFKCqRlOAYRSyFZiSIDu5FS8x/PvpjSnJrRDPwMToyPD5fgKqJLdiHAMTgzPD5/vxIAMQkmgSCEluxVgGJgZXhs/341D9ya0Yw8DE4M7w+X4sZiBwKxgwfH1wAVvwAQCMDiRNmEhjqAAAAABJRU5ErkJggg=="
											alt="" class="dash">
									</div>
									<div class="gaze btn false" data-target="gazeChart">
										<div class="pot"></div>
										움직임<img
											src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAcAAAAMCAYAAACulacQAAAABHNCSVQICAgIfAhkiAAAAIFJREFUGFdjZOBRWs7w5V4kAxbACBbjVfrP8PkehI0EEAJYFKCqRlOAYRSyFZiSIDu5FS8x/PvpjSnJrRDPwMToyPD5fgKqJLdiHAMTgzPD5/vxIAMQkmgSCEluxVgGJgZXhs/341D9ya0Yw8DE4M7w+X4sZiBwKxgwfH1wAVvwAQCMDiRNmEhjqAAAAABJRU5ErkJggg=="
											alt="" class="dash">
									</div>
									<div class="sps btn false">
										<div class="pot"></div>
										말 빠르기<img
											src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAcAAAAMCAYAAACulacQAAAABHNCSVQICAgIfAhkiAAAAIFJREFUGFdjZOBRWs7w5V4kAxbACBbjVfrP8PkehI0EEAJYFKCqRlOAYRSyFZiSIDu5FS8x/PvpjSnJrRDPwMToyPD5fgKqJLdiHAMTgzPD5/vxIAMQkmgSCEluxVgGJgZXhs/341D9ya0Yw8DE4M7w+X4sZiBwKxgwfH1wAVvwAQCMDiRNmEhjqAAAAABJRU5ErkJggg=="
											alt="" class="dash">
									</div>
									<div class="audio btn false">
										<div class="pot"></div>
										음성<img
											src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAcAAAAMCAYAAACulacQAAAABHNCSVQICAgIfAhkiAAAAIFJREFUGFdjZOBRWs7w5V4kAxbACBbjVfrP8PkehI0EEAJYFKCqRlOAYRSyFZiSIDu5FS8x/PvpjSnJrRDPwMToyPD5fgKqJLdiHAMTgzPD5/vxIAMQkmgSCEluxVgGJgZXhs/341D9ya0Yw8DE4M7w+X4sZiBwKxgwfH1wAVvwAQCMDiRNmEhjqAAAAABJRU5ErkJggg=="
											alt="" class="dash">
									</div>
									<div class="habit btn false">
										<div class="pot"></div>
										습관어<img
											src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAcAAAAMCAYAAACulacQAAAABHNCSVQICAgIfAhkiAAAAIFJREFUGFdjZOBRWs7w5V4kAxbACBbjVfrP8PkehI0EEAJYFKCqRlOAYRSyFZiSIDu5FS8x/PvpjSnJrRDPwMToyPD5fgKqJLdiHAMTgzPD5/vxIAMQkmgSCEluxVgGJgZXhs/341D9ya0Yw8DE4M7w+X4sZiBwKxgwfH1wAVvwAQCMDiRNmEhjqAAAAABJRU5ErkJggg=="
											alt="" class="dash">
									</div>
								</div>
							</div>
							
							<div class="graph-area">
							
								<div id="emotionChart" class="Emotion graph-area graph-content">
									<div class="area bright">
										<div class="label">긍정</div>
										<canvas id="positiveChart" class="graph-canvas emotion chartjs-render-monitor"
											width="250" height="150"></canvas>
									</div>
									<div class="area neutral">
										<div class="label">무표정</div>
										<canvas id="neutralChart" class="graph-canvas emotion chartjs-render-monitor"
											width="215" height="107"
											style="display: block; height: 119px; width: 240px;"></canvas>
									</div>
									<div class="area dark">
										<div class="label">부정</div>
										<canvas id="negativeChart" class="graph-canvas emotion chartjs-render-monitor"
											width="215" height="107"
											style="display: block; height: 119px; width: 240px;"></canvas>
									</div>
									<div class="area surprised">
										<div class="label">당황</div>
										<canvas id="panicChart" class="graph-canvas"
											width="215" height="107"
											style="display: block; height: 119px; width: 240px;"></canvas>
									</div>
								</div>
								
								<div id="gazeChart" class="Gaze graph-area graph-content">
									<div class="area">
										<canvas id="faceChart" class="graph-canvas" width="500" height="400"></canvas>
									</div>
								</div>
								
							</div>
							
						</div>
						<div class="HabitArea box" id="habitant">
							<div class="title">내 습관어</div>
							<div class="bar-area">
								<div class="unit">(회)</div>
								<div class="HabitBar">
									<div class="label">아..</div>
									<div class="range">
										<div class="gaze" style="width: 0px;"></div>
									</div>
									<div class="count">0</div>
								</div>
								<div class="HabitBar">
									<div class="label">어..</div>
									<div class="range">
										<div class="gaze" style="width: 0px;"></div>
									</div>
									<div class="count">0</div>
								</div>
								<div class="HabitBar">
									<div class="label">그..</div>
									<div class="range">
										<div class="gaze" style="width: 0px;"></div>
									</div>
									<div class="count">0</div>
								</div>
								<div class="HabitBar">
									<div class="label">저..</div>
									<div class="range">
										<div class="gaze" style="width: 0px;"></div>
									</div>
									<div class="count">0</div>
								</div>
								<div class="HabitBar">
									<div class="label">음..</div>
									<div class="range">
										<div class="gaze" style="width: 0px;"></div>
									</div>
									<div class="count">0</div>
								</div>
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
									<div class="name">${interview.interviewNm}</div>
									<button class="edit-btn interviewNmUpdateBtn">
										<img src="/images/question-write.87c3adf2.svg" alt="">
									</button>
									<a class="button" href="/analysis/question/retrievePagingList.do?interviewSq=${interview.interviewSq }">결과 보기</a>
								</div>
							</div>
						</c:forEach>
					</form:form>
				</div>
				
			</div>
			<footer class="Footer --undefined">
				<div class="footer-body">
					<div class="info">
						<span>(주) 두들린</span><br>서울특별시 마포구 마포대로122, 프론트원 16층 | 대표 :
						이태규<br>사업자등록번호: 513-86-01891 | 마케팅ㆍ제휴 문의 :
						bryan95@doodlin.co.kr<br>통신판매업신고번호: 2020-서울강남-03334호 | 연락처 :
						010-3099-2394<br> <br>@Doodlin Corp. All Rights
						Reserved.
					</div>
					<div class="nav-flex">
						<div class="user-agreement">
							<a href="/agreement/user-agree">회원이용약관</a>
						</div>
						<div class="personal-info">
							<a href="/agreement/personal-agree">개인정보처리방침</a>
						</div>
						<div class="about-us">ABOUT US</div>
					</div>
					<div class="logo-area">
						<div class="icons">
							<a
								href="https://www.facebook.com/%EC%9D%B8%EA%B3%B5%EC%A7%80%EB%8A%A5-%EB%AA%A8%EC%9D%98%EB%A9%B4%EC%A0%91-iamterview-103464748013569"
								target="blank"><img
								src="/static/media/facebook-btn.ba58ba0e.svg" alt=""
								class="link-btn"></a><a
								href="https://www.instagram.com/iamterview" target="blank"><img
								src="/static/media/insta-btn.757adbff.svg" alt=""
								class="link-btn"></a><a
								href="https://blog.naver.com/iamterview" target="blank"><img
								src="/static/media/naver-btn.dda55f6e.svg" alt=""
								class="link-btn"></a>
						</div>
						<img src="/static/media/black.68a48bcd.svg" class="doodlin-logo"
							alt="doodlin-logo">
					</div>
				</div>
			</footer>
		</div>
	</div>

	<div class="modal-wrapper">
		<div class="modal-box">
			<div>
				<c:forEach items="${scriptGbList }" var="scriptGb">
					<button class="scriptGbBtn" value="${scriptGb.scriptGbSq }"
						onclick="random(${scriptGb.scriptGbSq });">
						<div class="label thislabel">${scriptGb.scriptGbContent }</div>
					</button>
					<input type="hidden" name="scritGbSq"
						value="${scriptGb.scriptGbSq }">
				</c:forEach>
				<button id="modal-close-btn" style="float: right;">close</button>


			</div>
			<div class="modal-content pro" id="scriptModalContent">

			</div>
			
			<div style="text-align: center">
			<label>내가 말한</label>
			<br><input style="text-align: center" type="text" value="" id="phraseDiv"><br>
			과의 일치도는 <label id="valiPercent"></label>%입니다.
					
			</div>

			<div class="modal-close-box" id="modal-close-box">
				<br><label>시작하기 버튼을 클릭한 후<br>위의 문장을 소리내어 읽어주세요.
				</label><br>
				<button class="processBtn" id="startTestBtn">
					시작 하기					<!-- onclick="startTest()" -->
				</button>
				<!-- <button class="processBtn" id="stopTestBtn">종료 하기</button> -->
			</div>
			<input id="subscriptionKey" type="hidden"
				value="8e1d8a815cd34bd4b7fee2b71344ef49"> <input
				id="serviceRegion" type="hidden" size="40" value="koreacentral">
			<br> <br> <br>
		</div>
	</div>
		<script>
      const popUpOpenBtn = document.getElementById("popUpOpenBtn");

      popUpOpenBtn.addEventListener("click", () => {
    	  var url = '/scriptTest/testPopup.do';
    	  var options = 'top=10, left=10, width=500, height=600, status=no, menubar=no, toolbar=no, resizable=no';
        window.open(url, "", options);
      });
      
      const speechOpen = document.getElementById("speechOpen");

      speechOpen.addEventListener("click", () => {
    	  var url = '/speech/speech.do';
    	  var options = 'top=10, left=10, width=500, height=600, status=no, menubar=no, toolbar=no, resizable=no';
      window.open(url, "", options);

        
      });
    </script>
</body>
</html>