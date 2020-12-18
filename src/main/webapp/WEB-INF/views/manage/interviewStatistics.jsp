<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<%@ include file="/WEB-INF/views/layout/commonLib.jsp" %>

<!-- Resources -->
<script src="https://cdn.amcharts.com/lib/4/core.js"></script>
<script src="https://cdn.amcharts.com/lib/4/charts.js"></script>
<script src="https://cdn.amcharts.com/lib/4/themes/animated.js"></script>

<!-- Chart code -->
<script>
	
	$(document).ready(function(){
		
		$.ajax({
			url : "/interview/retrieveStatistics.do",
			dataType : "json",
			success : function(data){
				interviewList = data.interviewList;
				StatisticsChart(interviewList);
			}
		
		})
		
	});
	
	function StatisticsChart(interviewList){
		var count = 0;
		datas = [];
		for(var i = 0; i<interviewList.length; i++ ){
			data = { "date" : interviewList[i].interviewDate , "value" : interviewList[i].count }
			datas.push(data);
			count += 1;
		}
		
		trendLine = [];
		firstdata = { "date" : interviewList[parseInt(interviewList.length/2)].interviewDate , "value" : interviewList[parseInt(interviewList.length/2)].count }
		lastdata = { "date" : interviewList[interviewList.length-1].interviewDate , "value" : interviewList[interviewList.length-1].count }
		trendLine.push(firstdata);
		trendLine.push(lastdata);
		
		am4core.ready(function() {
			
			// Themes begin
			am4core.useTheme(am4themes_animated);
			// Themes end
			
			// Create chart instance
			var chart = am4core.create("chartdiv", am4charts.XYChart);
			
			// Enable chart cursor
			chart.cursor = new am4charts.XYCursor();
			chart.cursor.lineX.disabled = true;
			chart.cursor.lineY.disabled = true;
			
			// Enable scrollbar
			//chart.scrollbarX = new am4core.Scrollbar();
			
			// Add data
			chart.data = datas;
			
			// Create axes
			var dateAxis = chart.xAxes.push(new am4charts.DateAxis());
			dateAxis.renderer.grid.template.location = 0.5;
			dateAxis.dateFormatter.inputDateFormat = "yyyy-MM-dd";
			dateAxis.renderer.minGridDistance = 40;
			dateAxis.tooltipDateFormat = "MMM dd, yyyy";
			dateAxis.dateFormats.setKey("day", "dd");
			
			var valueAxis = chart.yAxes.push(new am4charts.ValueAxis());
			valueAxis.min = 0;
			valueAxis.max = count + 1;
			valueAxis.renderer.minGridDistance = 50;
			
			// Create series
			var series = chart.series.push(new am4charts.LineSeries());
			series.tooltipText = "{date}\n[bold font-size: 17px]면접 횟수 : {valueY}[/]";
			series.dataFields.valueY = "value";
			series.dataFields.valueY = "value";
			series.dataFields.dateX = "date";
			series.strokeDasharray = 3;
			series.strokeWidth = 2
			series.strokeOpacity = 0.3;
			series.strokeDasharray = "3,3"
			
			var bullet = series.bullets.push(new am4charts.CircleBullet());
			bullet.strokeWidth = 2;
			bullet.stroke = am4core.color("#fff");
			bullet.setStateOnChildren = true;
			bullet.propertyFields.fillOpacity = "opacity";
			bullet.propertyFields.strokeOpacity = "opacity";
			
			var hoverState = bullet.states.create("hover");
			hoverState.properties.scale = 1.7;
			
			function createTrendLine(data) {
			  var trend = chart.series.push(new am4charts.LineSeries());
			  trend.dataFields.valueY = "value";
			  trend.dataFields.dateX = "date";
			  trend.strokeWidth = 2
			  trend.stroke = trend.fill = am4core.color("#c00");
			  trend.data = data;
			
			  var bullet = trend.bullets.push(new am4charts.CircleBullet());
			  bullet.tooltipText = "{date}\n[bold font-size: 17px]면접 횟수 : {valueY}[/]";
			  bullet.strokeWidth = 2;
			  bullet.stroke = am4core.color("#fff")
			  bullet.circle.fill = trend.stroke;
			
			  var hoverState = bullet.states.create("hover");
			  hoverState.properties.scale = 1.7;
			
			  return trend;
			};
			
			createTrendLine(trendLine);
			
			}); // end am4core.ready()
	}
	
</script>

<style>

	body{
		padding: 30px;
	}

	#chartdiv {
	  width: 90%;
	  height: 500px;
	}
	
	.contentBox{
		width: 70%;
		padding: 40px 30px;
		background-color: white;
		border-radius: 10px;
		margin: 10px 0px;
		box-shadow: 5px 5px #EAEAEA;
		display: inline-block;
		float: left;
	}
	
</style>


</head>
<body>
	
	<h1>면접 통계</h1>
	
	<div class="contentBox">
	
		<div id="chartdiv"></div>
		
	</div>



</body>
</html>