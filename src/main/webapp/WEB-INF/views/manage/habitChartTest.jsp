<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="/WEB-INF/views/layout/commonLib.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="https://cdn.amcharts.com/lib/4/core.js"></script>
<script src="https://cdn.amcharts.com/lib/4/charts.js"></script>
<script src="https://cdn.amcharts.com/lib/4/themes/animated.js"></script>
<style>
.contentBox{
		width: 70%;
		padding: 20px 30px;
		background-color: white;
		border-radius: 10px;
		margin: 10px 0px;
		box-shadow: 5px 5px #EAEAEA;
		display: inline-block;
		float: left;
	}
	input{
		border-radius: 5px;
		border : 1px solid black;
	}
	.title th{
		border-bottom: 2px solid black;
	}
	table{
		border-collapse:  collapse;
	}
	td, th{
		width: 250px;
		text-align: center;
	}
	
	tr{
		height: 50px;
	}
	.rn{ 
		width: 50px;
	}
	.habit {
		display: inline-block;
		float : left;
		width: 45%;
		margin-top: 50px;
	}
	#habitChart{
		display: inline-block;
		float : right;
		width: 45%;
		height: 400px;
		padding :10px;
	}
	#habitSum{
		border-top: 1px solid black;
		font-weight: bold;
	}
</style>
<script type="text/javascript" language="javascript" defer="defer">
$(document).ready(function(){
	
	var startDate = $('#startDate').val() == ''? '2000-01-01' : $('#startDate').val();
	var endDate = $('#endDate').val() == ''? 'sysdate' : $('#endDate').val();
	
	$.ajax({ url : "/habit/retrieveHabitStatisticsList.do", 
		 data : {"startDate" : startDate,
		 	 	 "endDate" 	 : endDate},
		 dataType : "json",
		 success : function(data){
			console.log(data);
			
			var resultList = data.resultList;
			
			createHtml(resultList); 	// 표 그리기
			createChart(resultList); 	// 차트 그리기
		 }// success function()
	})// ajax
	
	$('#start').on('change',function(){
		$('#startDate').val($(this).val());
	})
	
	$('#end').on('change',function(){
		$('#endDate').val($(this).val());
	})
	
	$('#selectBtn').on('click',function(){
		startDate = $('#startDate').val() == ''? '2000-01-01' : $('#startDate').val();
		endDate = $('#endDate').val() == ''? 'sysdate' : $('#endDate').val();
		$.ajax({ url : "/habit/retrieveHabitStatisticsList.do", 
			 data : {"startDate" : startDate,
			 	 	 "endDate" 	 : endDate},
			 dataType : "json",
			 success : function(data){
				console.log(data);
				
				var resultList = data.resultList;
				
				createHtml(resultList); 	// 표 그리기
				createChart(resultList); 	// 차트 그리기
			 }// success function()
		})// ajax

	})
})


function createChart(resultList){
	// Themes begin
	am4core.useTheme(am4themes_animated);
	// Themes end
	
	var chart = am4core.create("habitChart", am4charts.PieChart);		 
	
	chart.logo.disabled = true;
		
	var dataSet = []
	for(var i = 0; i < resultList.length; i++){
		var habit = resultList[i];
	
		name = habit.habitGb;
		value = habit.useCount;
	
		dataSet.push({name: name+"..", value: value});

	}
	
	chart.data =  dataSet;

	// Set radius
	chart.radius = am4core.percent(70);
	// Set inner radius
	chart.innerRadius = am4core.percent(50);
	
	// Add and configure Series
	var pieSeries = chart.series.push(new am4charts.PieSeries());
	pieSeries.dataFields.value = "value";
	pieSeries.dataFields.category = "name";

	pieSeries.labels.template.maxWidth = 65;
	pieSeries.labels.template.wrap = true;

	// end am4core.ready()
}

function createHtml(resultList){
	var sum = 0;
	html='';
	for(var i = 0; i < resultList.length; i++){
		var habit = resultList[i];
		 html += '<tr class="habitList">';
		 html += '<td>'+habit.rn+'</td>';
		 html += '<td class="habitGb">'+habit.habitGb+'</td>';
		 html += '<td class="useCount" value="'+habit.useCount+'">'+habit.useCount+'</td>';
		 html += '</tr>';
		 
		 sum += habit.useCount;
		 
	}// dataSetting for 
	 html += '<tr id="habitSum">';
	 html += '<td>합  계</td>';
	 html += '<td></td>';
	 html += '<td id="sumCount" value="'+sum+'">'+sum+'</td>';
	 html += '</tr>';
	 $('#habitList').empty();
	 $('#habitList').append(html);

}
</script>
</head>
<body>
chartTest.jsp

<form:form commandName="habitAnalysisVO" id="listForm" name="listForm" method="post">
		<h1>습관어 통계</h1>
			<div class="habitStatistics">
				<div class="contentBox">
				    <div class="conditionmenu">
				    	기간 : 
				    	<input id="start" type="date">
				    	~
				    	<input id="end" type="date">
				    		<input type="hidden" id="startDate" name="startDate" >
				    		<input type="hidden" id="endDate" name="endDate" >
				    		<img id="selectBtn" alt="" src="/images/searchBtn.png" style="width:25px;height:25px; display: inline-block; position: relative; top: 4px; left:5px;">
				    </div>
				</div>
					<div class="contentBox">
					    <div class="habit">
					  	<table class="haibtList">
					  		<tr class="title">
					  			<th class="rn"></th>
					  			<th>습관어</th>
					  			<th>사  용</th>
					  		</tr>
					  		<tbody id="habitList">
					  		</tbody>
					  	</table>
					  </div>	
					<div id="habitChart" class="habitChart"></div>
				</div>
			</div>
	</form:form>	
</body>
</html>