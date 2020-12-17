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

<script>
	
	$(document).ready(function(){
		
		$.ajax({
			url : "/analysis/manageStatistic.do",
			dataType : "json",
			success : function(data){
				interviewList = data.interviewList;
				interviewChart(interviewList);
				
				
				cashChart();
				talentChart();
				habitChart();
				repeatChart();
			}
		
		})
		
		
		
	});


	
	function interviewChart(interviewList){
		
		datas = [];
		for(var i = 0; i<interviewList.length; i++ ){
			data = { "date" : interviewList[i].interviewDate , "value" : interviewList[i].count }
			datas.push(data);
		}
		
		$("#interviewCount").text(interviewList.length);
		
		am4core.ready(function() {

			// Themes begin
			am4core.useTheme(am4themes_animated);
			// Themes end

			// Create chart instance
			var chart = am4core.create("interviewChart", am4charts.XYChart);

			// Add data
			chart.data = datas;

			// Set input format for the dates
			chart.dateFormatter.inputDateFormat = "yyyy-MM-dd";

			// Create axes
			var dateAxis = chart.xAxes.push(new am4charts.DateAxis());
			dateAxis.renderer.line.disabled = true; //disables axis line
			dateAxis.renderer.labels.template.disabled = true; //disables labels
			dateAxis.renderer.grid.template.disabled = true;  //disables grid

			var valueAxis = chart.yAxes.push(new am4charts.ValueAxis());
			valueAxis.renderer.baseGrid.disabled = true;
			valueAxis.renderer.line.disabled = true; //disables axis line
			valueAxis.renderer.labels.template.disabled = true; //disables labels
			valueAxis.renderer.grid.template.disabled = true;  //disables grid


			// Create series
			var series = chart.series.push(new am4charts.LineSeries());
			series.dataFields.valueY = "value";
			series.dataFields.dateX = "date";
			series.tooltipText = "{value}"
			series.strokeWidth = 2;
			series.minBulletDistance = 15;

			chart.logo.disabled = true;

			// Make bullets grow on hover
			var bullet = series.bullets.push(new am4charts.CircleBullet());
			bullet.circle.strokeWidth = 1;
			bullet.circle.radius = 1;
			bullet.circle.fill = am4core.color("#fff");

			var bullethover = bullet.states.create("hover");
			bullethover.properties.scale = 1.3;


			dateAxis.start = 0.79;
			dateAxis.keepSelection = false;


			}); // end am4core.ready()
		
	}

	function cashChart(){
		
		am4core.ready(function() {

			// Themes begin
			am4core.useTheme(am4themes_animated);
			// Themes end

			// Create chart instance
			var chart = am4core.create("cashChart", am4charts.XYChart);

			// Add data
			chart.data = [{
			  "date": "2012-07-27",
			  "value": 13
			}, {
			  "date": "2012-07-28",
			  "value": 11
			}, {
			  "date": "2012-07-29",
			  "value": 15
			}, {
			  "date": "2012-07-30",
			  "value": 16
			}, {
			  "date": "2012-07-31",
			  "value": 18
			}, {
			  "date": "2012-08-01",
			  "value": 13
			}, {
			  "date": "2012-08-02",
			  "value": 22
			}, {
			  "date": "2012-08-03",
			  "value": 23
			}, {
			  "date": "2012-08-04",
			  "value": 20
			}, {
			  "date": "2012-08-05",
			  "value": 17
			}, {
			  "date": "2012-08-06",
			  "value": 16
			}, {
			  "date": "2012-08-07",
			  "value": 18
			}, {
			  "date": "2012-08-08",
			  "value": 21
			}, {
			  "date": "2012-08-09",
			  "value": 26
			}, {
			  "date": "2012-08-10",
			  "value": 24
			}, {
			  "date": "2012-08-11",
			  "value": 29
			}, {
			  "date": "2012-08-12",
			  "value": 32
			}];

			// Set input format for the dates
			chart.dateFormatter.inputDateFormat = "yyyy-MM-dd";

			// Create axes
			var dateAxis = chart.xAxes.push(new am4charts.DateAxis());
			dateAxis.renderer.line.disabled = true; //disables axis line
			dateAxis.renderer.labels.template.disabled = true; //disables labels
			dateAxis.renderer.grid.template.disabled = true;  //disables grid

			var valueAxis = chart.yAxes.push(new am4charts.ValueAxis());
			//valueAxis.renderer.baseGrid.disabled = true;
			valueAxis.renderer.line.disabled = true; //disables axis line
			valueAxis.renderer.labels.template.disabled = true; //disables labels
			valueAxis.renderer.grid.template.disabled = true;  //disables grid


			// Create series
			var series = chart.series.push(new am4charts.LineSeries());
			series.dataFields.valueY = "value";
			series.dataFields.dateX = "date";
			series.tooltipText = "{value}"
			series.strokeWidth = 2;
			series.minBulletDistance = 15;

			chart.logo.disabled = true;

			// Make bullets grow on hover
			var bullet = series.bullets.push(new am4charts.CircleBullet());
			bullet.circle.strokeWidth = 1;
			bullet.circle.radius = 1;
			bullet.circle.fill = am4core.color("#fff");

			var bullethover = bullet.states.create("hover");
			bullethover.properties.scale = 1.3;


			dateAxis.start = 0.79;
			dateAxis.keepSelection = false;


			}); // end am4core.ready()
		
	}
	
	
	function talentChart(){
		
		am4core.ready(function() {

		// Themes begin
		am4core.useTheme(am4themes_animated);
		// Themes end

		var iconPath = "M53.5,476c0,14,6.833,21,20.5,21s20.5-7,20.5-21V287h21v189c0,14,6.834,21,20.5,21 c13.667,0,20.5-7,20.5-21V154h10v116c0,7.334,2.5,12.667,7.5,16s10.167,3.333,15.5,0s8-8.667,8-16V145c0-13.334-4.5-23.667-13.5-31 s-21.5-11-37.5-11h-82c-15.333,0-27.833,3.333-37.5,10s-14.5,17-14.5,31v133c0,6,2.667,10.333,8,13s10.5,2.667,15.5,0s7.5-7,7.5-13 V154h10V476 M61.5,42.5c0,11.667,4.167,21.667,12.5,30S92.333,85,104,85s21.667-4.167,30-12.5S146.5,54,146.5,42 c0-11.335-4.167-21.168-12.5-29.5C125.667,4.167,115.667,0,104,0S82.333,4.167,74,12.5S61.5,30.833,61.5,42.5z"

		var chart = am4core.create("talentChart", am4charts.SlicedChart);
		chart.hiddenState.properties.opacity = 0; // this makes initial fade in effect

		chart.data = [{
		    "name": "The first",
		    "value": 354
		}, {
		    "name": "The second",
		    "value": 245
		}, {
		    "name": "The third",
		    "value": 187
		}, {
		    "name": "The fourth",
		    "value": 123
		}, {
		    "name": "The fifth",
		    "value": 87
		}, {
		    "name": "The sixth",
		    "value": 45
		}, {
		    "name": "The seventh",
		    "value": 23
		}];

		var series = chart.series.push(new am4charts.PictorialStackedSeries());
		series.dataFields.value = "value";
		series.dataFields.category = "name";
		series.alignLabels = true;

		series.maskSprite.path = iconPath;
		series.ticks.template.locationX = 1;
		series.ticks.template.locationY = 0.5;
		series.labelsContainer.width = 200;

		chart.logo.disabled = true;
		
		}); // end am4core.ready()
		
	}
	
	function habitChart() {
		am4core.ready(function() {

			// Themes begin
			am4core.useTheme(am4themes_animated);
			// Themes end

			// Create chart instance
			var chart = am4core.create("habitChart", am4charts.PieChart);

			// Add data
			chart.data = [ {
			  "country": "Lithuania",
			  "litres": 501.9
			}, {
			  "country": "Czech Republic",
			  "litres": 301.9
			}, {
			  "country": "Ireland",
			  "litres": 201.1
			}, {
			  "country": "Germany",
			  "litres": 165.8
			}, {
			  "country": "Australia",
			  "litres": 139.9
			}, {
			  "country": "Austria",
			  "litres": 128.3
			}];

			// Set inner radius
			chart.innerRadius = am4core.percent(50);
			chart.logo.disabled = true;
			
			// Add and configure Series
			var pieSeries = chart.series.push(new am4charts.PieSeries());
			pieSeries.dataFields.value = "litres";
			pieSeries.dataFields.category = "country";
			pieSeries.slices.template.stroke = am4core.color("#fff");
			pieSeries.slices.template.strokeWidth = 2;
			pieSeries.slices.template.strokeOpacity = 1;

			// This creates initial animation
			pieSeries.hiddenState.properties.opacity = 1;
			pieSeries.hiddenState.properties.endAngle = -90;
			pieSeries.hiddenState.properties.startAngle = -90;

			}); // end am4core.ready()
	}
	
	function repeatChart() {
		am4core.ready(function() {

			// Themes begin
			am4core.useTheme(am4themes_animated);
			// Themes end

			var chart = am4core.create("repeatChart", am4charts.XYChart);
			chart.padding(40, 40, 40, 40);

			var categoryAxis = chart.yAxes.push(new am4charts.CategoryAxis());
			categoryAxis.dataFields.category = "network";
			categoryAxis.renderer.inversed = true;
			categoryAxis.renderer.line.disabled = true; //disables axis line
			categoryAxis.renderer.grid.template.disabled = true;  //disables grid
			
			var valueAxis = chart.xAxes.push(new am4charts.ValueAxis());
			valueAxis.min = 0;
			valueAxis.renderer.line.disabled = true; //disables axis line
			valueAxis.renderer.labels.template.disabled = true; //disables labels
			valueAxis.renderer.grid.template.disabled = true;  //disables grid

			var series = chart.series.push(new am4charts.ColumnSeries());
			series.dataFields.categoryY = "network";
			series.dataFields.valueX = "MAU";
			series.tooltipText = "{valueX.value}"
			series.columns.template.strokeOpacity = 0;
			series.columns.template.column.cornerRadiusBottomRight = 5;
			series.columns.template.column.cornerRadiusTopRight = 5;

			var labelBullet = series.bullets.push(new am4charts.LabelBullet())
			labelBullet.label.horizontalCenter = "left";
			labelBullet.label.dx = 10;
			labelBullet.label.text = "{values.valueX.workingValue.formatNumber('#.0as')}";
			labelBullet.locationX = 1;

			// as by default columns of the same series are of the same color, we add adapter which takes colors from chart.colors color set
			series.columns.template.adapter.add("fill", function(fill, target){
			  return chart.colors.getIndex(target.dataItem.index);
			});
			
			chart.logo.disabled = true;
			
			categoryAxis.sortBySeries = series;
			chart.data = [
			    {
			      "network": "저",
			      "MAU": 2255
			    },
			    {
			      "network": "그",
			      "MAU": 4300
			    },
			    {
			      "network": "아",
			      "MAU": 1000
			    },
			    {
			      "network": "에",
			      "MAU": 2465
			    },
			    {
			      "network": "이",
			      "MAU": 3550
			    }];



			}); // end am4core.ready()
	}
	
</script>



<style>
	
	.contentBoxMedium{
		width: 27%;
		height: 180px;
		padding: 20px 30px;
		background-color: white;
		border-radius: 10px;
		margin: 10px 1%;
		box-shadow: 5px 5px #EAEAEA;
		display: inline-block;
		float: left;
		overflow: hidden;
	}
	
	.contentBoxLargeLeft{
		width: 27%;
		height: 420px;
		padding: 20px 30px;
		background-color: white;
		border-radius: 10px;
		margin: 10px 1%;
		box-shadow: 5px 5px #EAEAEA;
		display: inline-block;
		float: left;
	}
	
	.contentBoxLargeRight{
		width: 27%;
		height: 420px;
		padding: 20px 30px;
		background-color: white;
		border-radius: 10px;
		margin: 10px;
		margin-right: 40px;
		box-shadow: 5px 5px #EAEAEA;
		display: inline-block;
		float: right;
	}
	
	.contentBoxSmall{
		width: 10.6%;
		height: 180px;
		padding: 20px 30px;
		background-color: white;
		border-radius: 10px;
		margin: 10px 1%;
		box-shadow: 5px 5px #EAEAEA;
		display: inline-block;
		float: left;
	}
	
	.contentBoxMediumFlat{
		width: 27%;
		height: 60px;
		padding: 20px 30px;
		background-color: white;
		border-radius: 10px;
		margin: 10px 1%;
		box-shadow: 5px 5px #EAEAEA;
		display: inline-block;
		float: left;
	}
	
	#interviewChart, #cashChart, #habitChart{
		width: 100%;
		height: 150px;
	}
	
	#talentChart{
		width: 100%;
		height: 400px;
	}
	
	.chartTitle{
		font-weight: bold;
	}
	
	#repeatChart{
		width: 100%;
		height: 200px;
		margin: 0px;
		padding: 0px;
	}
	
	.chartContent{
		margin: 5px;
	}
	
	.span{
		color: #F15F5F;
		font-weight: bold;
	}
	
</style>

</head>
<body>
	
	<div class="contentBoxMedium">
		<span class="chartTitle">진행중인 면접 횟수</span>
		<br>
		<div class="chartContent">총 <span class="span" id="interviewCount"></span>회</div>
		<div id="interviewChart"></div>
	</div>
	
	<div class="contentBoxMedium">
		<span class="chartTitle">2020년 매출</span>
		<br>
		1000원
		
		<div id="cashChart"></div>
	</div>
	
	
	<div class="contentBoxMediumFlat">
		총 회원수 : 1명
	</div>

	<div class="contentBoxMediumFlat">
		총 게시글수 1개
	</div>
	
	<div class="contentBoxLargeLeft">
		<span class="chartTitle">인재상 분포</span>
		<div id="talentChart"></div>
	</div>
	
	<div class="contentBoxMedium">
		<span class="chartTitle">요금제</span>
	</div>
	
	<div class="contentBoxLargeRight">
		
	</div>
	
	<div class="contentBoxSmall">
		<span class="chartTitle">습관어</span>
		<div id="habitChart"></div>
	</div>
	
	<div class="contentBoxSmall" >
		<span class="chartTitle">반복어</span>
		<div id="repeatChart"></div>
	</div>
	


</body>
</html>