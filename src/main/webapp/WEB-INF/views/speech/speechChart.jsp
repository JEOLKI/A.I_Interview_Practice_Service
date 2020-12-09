<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>
</head>
<link href="/css/main.8acfb306.chunk.css" rel="stylesheet">
<style>

</style>
	<div class="content">
		<canvas id="myChart" class="graph-canvas emotion chartjs-render-monitor"
			style="display: block; height: 20px; width: 120px;" width="80"
			height="50"></canvas>
		<div class="graduation-bar">
			<div class="graduation"></div>
			<div class="graduation"></div>
		</div>
 	</div>
	
	
	<script>
	
	var count = [];
	var english = [];
	var korean = [];
	var speech = [] ;
	
	for (var i = 0; i < ${count }; i++) {
			count.push(i)
	} 

	
	<c:forEach items = "${EnglishList}" var = "english">
		english.push("${english.scriptTestScore}")
	</c:forEach>
		 
	<c:forEach items = "${KoreanList}" var = "korean">
		korean.push("${korean.scriptTestScore}")
	</c:forEach>
		
	<c:forEach items = "${speechList}" var = "speech">
		speech.push("${speech.speechTestScore}")
	</c:forEach> 
	
	
	//.getContext('2d')
	var ctx = document.getElementById('myChart'); 
	var chart = new Chart(ctx, { 
		//챠트 종류를 선택  
		type: 'line', 
	
		// 챠트를 그릴 데이타 
		
		data: { 
			labels: count, 
			datasets: [{ 
				label: 'English Test', 
				backgroundColor: 'transparent', 
				borderColor: 'SlateBlue',
				data: english,
				lineTension: 0,
			    fill: true,
			    pointStyle: 'circle',
			    pointRadius: 2,
			    borderWidth: 1 //선굵기
			},{
				label: 'Korean Test', 
				backgroundColor: 'transparent', 
				borderColor: 'DarkTurquoise',
				data: korean,
				lineTension: 0,
			    fill: true,
			    pointStyle: 'circle',
			    pointRadius: 2,
			    borderWidth: 1 //선굵기
			},{
				label: 'Speech Test', 
				backgroundColor: 'transparent', 
				borderColor: 'DeepSkyBlue',
				data: speech,
				lineTension: 0,
			    fill: true,
			    pointStyle: 'circle',
			    pointRadius: 2,
			    borderWidth: 1 //선굵기
			}],
			
		}, 
		// 옵션
		options: {
			scales: { //X,Y축 옵션
	            yAxes: [{
	                ticks: {
	                    beginAtZero:true  //Y축의 값이 0부터 시작
	                }
	            }]
	        }
		}
		
		
		});
	</script>
