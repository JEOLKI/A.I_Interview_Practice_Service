<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- 차트 링크 -->
<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>
<link href="/css/main.8acfb306.chunk.css" rel="stylesheet">
<style>
	.content{
		padding-top: 20px;
	}
</style>

	<div class="content">
		<canvas id="myChart" class="graph-canvas emotion chartjs-render-monitor"
			style="display: block; height: 228px; width: 365px;" width="365"
			height="228"></canvas>
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
	
	
	
	var ctx = document.getElementById('myChart'); 
	var chart = new Chart(ctx,{ 
		//챠트 종류를 선택  
		type: 'line', 
	
		// 챠트를 그릴 데이타 
		
		data: { 
			labels: count, 
			datasets: [{ 
				label: 'English Test', 
				backgroundColor: 'transparent', 
				borderColor: 'rgb(255,+99,+132)',
				data: english,
				lineTension: 0,
			    fill: true,
			    pointStyle: 'circle',
			    pointRadius: 2,
			    borderWidth: 1 //선굵기
			},{
				label: 'Korean Test', 
				backgroundColor: 'transparent', 
				borderColor: 'rgb(54,+162,+235)',
				data: korean,
				lineTension: 0,
			    fill: true,
			    pointStyle: 'circle',
			    pointRadius: 2,
			    borderWidth: 1 //선굵기
			},{
				label: 'Speech Test', 
				backgroundColor: 'transparent', 
				borderColor: 'rgb(255,+205,+86)',
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
