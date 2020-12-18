<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>AI_INTERVIEW</title>

<%@ include file="/WEB-INF/views/layout/commonLib.jsp" %>

<!-- Resources -->
<script src="https://cdn.amcharts.com/lib/4/core.js"></script>
<script src="https://cdn.amcharts.com/lib/4/charts.js"></script>

<script>

	$(document).ready(function(){
		
		$.ajax({
			url : "/boardGubun/retrieveStatistics.do",
			dataType : "json",
			success : function(data){
				boardGbList = data.boardGbList;
				StatisticsChart(boardGbList);
			}
		
		})
		
	});

	
	function StatisticsChart(boardGbList){
		
		datas = [];
		for(var i = 0; i<boardGbList.length; i++ ){
			data = { "boardGubun" : boardGbList[i].boardGbNm , "value" : boardGbList[i].count }
			datas.push(data);
		}
		
		am4core.ready(function() {
		
		// Themes begin
		// Themes end
		
		var chart = am4core.create("chartdiv", am4charts.XYChart);
		chart.padding(40, 40, 40, 40);
		
		var categoryAxis = chart.yAxes.push(new am4charts.CategoryAxis());
		categoryAxis.renderer.grid.template.location = 0;
		categoryAxis.dataFields.category = "boardGubun";
		categoryAxis.renderer.minGridDistance = 1;
		categoryAxis.renderer.inversed = true;
		categoryAxis.renderer.grid.template.disabled = true;
		
		var valueAxis = chart.xAxes.push(new am4charts.ValueAxis());
		valueAxis.min = 0;
		
		var series = chart.series.push(new am4charts.ColumnSeries());
		series.dataFields.categoryY = "boardGubun";
		series.dataFields.valueX = "value";
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
		
		categoryAxis.sortBySeries = series;
		chart.data = datas;
		
		}); // end am4core.ready()
		
	}
	

</script>

<style>

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
	
	h3{
		margin-left: 3%;
	}

</style>

</head>
<body>
	
	<h1>게시판 통계</h1>

	<div class="contentBox">
		<h3>게시판 별 게시글 개수</h3>
		<div id="chartdiv"></div>
	</div>

</body>
</html>