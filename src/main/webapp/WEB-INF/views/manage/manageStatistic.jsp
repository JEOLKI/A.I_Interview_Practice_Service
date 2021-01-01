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
				$("#interviewCount").text(data.interviewCount);
				
				saleList = data.dailySaleList;
				cashChart(saleList);

				saleSum = numberWithCommas(data.saleSum);
				year = new Date().getFullYear();
				$('#year').append(year);
				$('#saleSum').append(saleSum);
				
				planUseList  = data.totalUseList;
				createUseChart(planUseList);
				
				talentList = data.talentCountList;
				talentChart(talentList);
				
				habitList = data.habitUseList;
				habitChart(habitList);
				
				repeatList = data.repeatUseList;
				repeatChart(repeatList);
				
			}
		
		})
		
		
		$(".boardTr").on("click", function(){
			
			// data-board_sq
			var boardGbSq = $(this).data("board_gb_sq");
			var boardGbNm = $(this).data("board_gb_nm");
	
			window.top.location.href="/board/retrievePagingList.do?boardGbSq=" + boardGbSq +"&boardGbNm="+boardGbNm; 
			
		});
		
		$(".createBtn").on("click", function(){
	
			window.top.location.href="${cp }/board/create.do?boardGbSq=1&boardGbNm=공지사항"; 
			
		});
	});

	/* 숫자 세자리마다 "," */
	function numberWithCommas(x) {
	    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}

	
	function interviewChart(interviewList){
		
		datas = [];
		for(var i = 0; i<interviewList.length; i++ ){
			data = { "date" : interviewList[i].interviewDate , "value" : interviewList[i].count }
			datas.push(data);
		}
		
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

	function cashChart(saleList){
		
		am4core.ready(function() {

			// Themes begin
			am4core.useTheme(am4themes_animated);
			// Themes end

			// Create chart instance
			var chart = am4core.create("cashChart", am4charts.XYChart);

			var dataSet = [];
			for(var i =0; i<saleList.length; i++){
				var sale = saleList[i];
				
				dataSet.push({date : sale.startDate, value: sale.sale})
			}
			
			// Add data
			chart.data = dataSet;

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
	
	
	function talentChart(talentList){
		
		am4core.ready(function() {

		// Themes begin
		am4core.useTheme(am4themes_animated);
		// Themes end

		var iconPath = "M53.5,476c0,14,6.833,21,20.5,21s20.5-7,20.5-21V287h21v189c0,14,6.834,21,20.5,21 c13.667,0,20.5-7,20.5-21V154h10v116c0,7.334,2.5,12.667,7.5,16s10.167,3.333,15.5,0s8-8.667,8-16V145c0-13.334-4.5-23.667-13.5-31 s-21.5-11-37.5-11h-82c-15.333,0-27.833,3.333-37.5,10s-14.5,17-14.5,31v133c0,6,2.667,10.333,8,13s10.5,2.667,15.5,0s7.5-7,7.5-13 V154h10V476 M61.5,42.5c0,11.667,4.167,21.667,12.5,30S92.333,85,104,85s21.667-4.167,30-12.5S146.5,54,146.5,42 c0-11.335-4.167-21.168-12.5-29.5C125.667,4.167,115.667,0,104,0S82.333,4.167,74,12.5S61.5,30.833,61.5,42.5z"

		var chart = am4core.create("talentChart", am4charts.SlicedChart);
		chart.hiddenState.properties.opacity = 0; // this makes initial fade in effect

		var dataSet = [];
		for(var i =0; i<talentList.length; i++){
			var talent = talentList[i];
			dataSet.push({name : talent.talentNm, value: talent.talentCount})
		}
		
		chart.data = dataSet;

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
	
	function habitChart(habitList) {
		am4core.ready(function() {

			// Themes begin
			am4core.useTheme(am4themes_animated);
			// Themes end

			// Create chart instance
			var chart = am4core.create("habitChart", am4charts.PieChart);

			var dataSet = [];
			for(var i =0; i<habitList.length; i++){
				var habit = habitList[i];
				dataSet.push({habit : habit.habitGb, useCount: habit.useCount})
			}
			
			
			// Add data
			chart.data = dataSet;

			// Set inner radius
			chart.innerRadius = am4core.percent(50);
			chart.logo.disabled = true;
			
			// Add and configure Series
			var pieSeries = chart.series.push(new am4charts.PieSeries());
			pieSeries.dataFields.value = "useCount";
			pieSeries.dataFields.category = "habit";
			pieSeries.slices.template.stroke = am4core.color("#fff");
			pieSeries.slices.template.strokeWidth = 2;
			pieSeries.slices.template.strokeOpacity = 1;
			pieSeries.labels.template.disabled = true;
			pieSeries.ticks.template.disabled = true;

			// This creates initial animation
			pieSeries.hiddenState.properties.opacity = 1;
			pieSeries.hiddenState.properties.endAngle = -90;
			pieSeries.hiddenState.properties.startAngle = -90;

			}); // end am4core.ready()
	}
	
	function repeatChart(repeatList) {
		am4core.ready(function() {

			// Themes begin
			am4core.useTheme(am4themes_animated);
			// Themes end

			var chart = am4core.create("repeatChart", am4charts.XYChart);

			var categoryAxis = chart.yAxes.push(new am4charts.CategoryAxis());
			categoryAxis.dataFields.category = "repeat";
			categoryAxis.renderer.inversed = true;
			categoryAxis.renderer.line.disabled = true; //disables axis line
			categoryAxis.renderer.grid.template.disabled = true;  //disables grid
			categoryAxis.renderer.minGridDistance = 20;
			
			var valueAxis = chart.xAxes.push(new am4charts.ValueAxis());
			valueAxis.min = 0;
			valueAxis.renderer.line.disabled = true; //disables axis line
			valueAxis.renderer.labels.template.disabled = true; //disables labels
			valueAxis.renderer.grid.template.disabled = true;  //disables grid

			var series = chart.series.push(new am4charts.ColumnSeries());
			series.dataFields.categoryY = "repeat";
			series.dataFields.valueX = "useCount";
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
			
			var dataSet = [];
			for(var i =0; i<repeatList.length; i++){
				var repeat = repeatList[i];
				dataSet.push({repeat : repeat.repeatContent, useCount: repeat.repeatCount})
			}
			
			categoryAxis.sortBySeries = series;
			chart.data = dataSet;



			}); // end am4core.ready()
	}
	
	function createUseChart(planUseList){
		
		// Themes begin
		am4core.useTheme(am4themes_animated);
		// Themes end
		
		var chart = am4core.create("planUseChart", am4charts.XYChart);
		chart.hiddenState.properties.opacity = 0; // this creates initial fade-in
		chart.logo.disabled = true;
			
		var sum = 0;
		var min = 0;
		var max = 0;
		var chartData = [];
		for(var i=0; i< planUseList.length; i++){
			var planUse = planUseList[i];
			
			chartData.push({plan:planUse.planNm, useCount: planUse.useCount});
		    
			if(min > planUse.useCount){
				min = planUse.useCount;
			}
			if(max < planUse.useCount){
				max = planUse.useCount;
			}
			
		    sum += planUse.useCount;
				
		}
		chartData.push({plan:"Total", useCount:sum})
		chart.data =  chartData;

		var categoryAxis = chart.xAxes.push(new am4charts.CategoryAxis());
		categoryAxis.renderer.grid.template.location = 0;
		categoryAxis.dataFields.category = "plan";
		categoryAxis.renderer.minGridDistance = 40;
		categoryAxis.fontSize = 11;
		categoryAxis.renderer.line.disabled = true; //disables axis line
		categoryAxis.renderer.grid.template.disabled = true;  //disables grid

		var valueAxis = chart.yAxes.push(new am4charts.ValueAxis());
		valueAxis.min = 0;
		valueAxis.max = sum+1;
		valueAxis.strictMinMax = true;
		valueAxis.renderer.minGridDistance = 30;
		valueAxis.renderer.line.disabled = true; //disables axis line
		valueAxis.renderer.labels.template.disabled = true; //disables labels
		valueAxis.renderer.grid.template.disabled = true;  //disables grid
		
		// axis break
		if(sum-max > 2){
			var axisBreak = valueAxis.axisBreaks.create();
			axisBreak.startValue = max+1;
			axisBreak.endValue = sum-1;
			axisBreak.breakSize = 0.005;
			// fixed axis break
			var d = (axisBreak.endValue - axisBreak.startValue) / (valueAxis.max - valueAxis.min);
			axisBreak.breakSize = 0.05 * (1 - d) / d; 
	
			// make break expand on hover
			var hoverState = axisBreak.states.create("hover");
			hoverState.properties.breakSize = 1;
			hoverState.properties.opacity = 0.1;
			hoverState.transitionDuration = 1500;
	
			axisBreak.defaultState.transitionDuration = 1000;
			// this is exactly the same, but with events
			axisBreak.events.on("over", function() {
			  axisBreak.animate(
				[{ property: "breakSize", to: 1 }, { property: "opacity", to: 0.1 }],
				1500,
				am4core.ease.sinOut
			  );
			});
			axisBreak.events.on("out", function() {
			  axisBreak.animate(
				[{ property: "breakSize", to: 0.005 }, { property: "opacity", to: 1 }],
				1000,
				am4core.ease.quadOut
			  );
			});
		}
		
		

		var series = chart.series.push(new am4charts.ColumnSeries());
		series.dataFields.categoryX = "plan";
		series.dataFields.valueY = "useCount";
		series.columns.template.tooltipText = "{valueY.value}";
		series.columns.template.tooltipY = 0;
		series.columns.template.strokeOpacity = 0;

		// as by default columns of the same series are of the same color, we add adapter which takes colors from chart.colors color set
		series.columns.template.adapter.add("fill", function(fill, target) {
		  return chart.colors.getIndex(target.dataItem.index);
		// end am4core.ready()
		})	
			
	}
</script>



<style>
	
	body{
		padding: 30px;
	}
	
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
	
	#interviewChart, #cashChart, #habitChart, #planUseChart{
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
		height: 150px;
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
	
	.content-table{
		width: 100%;
		margin: 20px auto;
		border-collapse: collapse; 
		font-size: 0.8em;
	}
	
	.content-table th{
		border-top: 2px solid #4374D9;
		height: 40px;
		text-align: center;
	}
		
	.content-table td{
		height: 30px;
		text-align: center;
		border-top: 1px solid #4374D9;
	}
	
	.content-table td:first-child{
		width: 100px;
	}
	
	.content-table tr:hover{
		background-color: #4374D9;
	    color: #fff;
	}
	
	.createBtn{
		display: inline-block;
		vertical-align : top;
		border: 1px solid #000d22;
		border-radius: 5px;
		height: 25px;
		width: 100px;
		text-align: center;
		float: right;
	}
	
	.createBtn:hover{
	    background-color: #000d22;
	    color: #fff;
	}
	
	#boardSum, #memberSum{
		font-size: 2.0em;
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
		<span class="chartTitle"><span id="year"></span>년 매출</span>
		<br>
		<div class="chartContent">총<span id="saleSum" class="span">&nbsp;</span>원</div>
		<div id="cashChart"></div>
	</div>
	
	
	<div class="contentBoxMediumFlat">
		<c:choose>
			<c:when test="${memberListSize ==0 }">
				<div id="memberSum">가입한 회원수  <span class="span">0</span>명</div>
			</c:when>
		</c:choose>
		<c:choose>
			<c:when test="${memberListSize !=0 }">
				<div id="memberSum">가입한 회원수  <span class="span">${memberListSize}</span>명</div>
			</c:when>
		</c:choose>
	</div>

	<div class="contentBoxMediumFlat">
		<div id="boardSum">등록된 게시글 수 <span class="span">${boardList.size() }</span>개</div>
	</div>
	
	<div class="contentBoxLargeLeft">
		<span class="chartTitle">인재상 분포</span>
		<div id="talentChart"></div>
	</div>
	
	<div class="contentBoxMedium">
		<span class="chartTitle">요금제</span>
		<div id="planUseChart"></div>
	</div>
	
	<div class="contentBoxLargeRight">
		<span class="chartTitle">최근 게시글</span>
		
		<a class="createBtn">공지사항 등록</a>
		
		<table class="content-table" id="dataTable">
					<thead>
						<tr>
							<th>게시판</th>
							<th>제목</th>
							<th>아이디</th>
							<th>작성일시</th>
						</tr>
					</thead>
				<tbody id="boardList">
					<c:forEach items="${boardList }" var="board">
						<tr class="boardTr" data-board_gb_sq="${board.boardGbSq }" data-board_gb_nm="${board.boardGbNm }">
				
							<td>${board.boardGbNm }</td>	
					
							<c:choose>
								<c:when test="${board.boardSt =='N' }">
									<td style="text-align: left;"><c:forEach var="i" begin="1" end="${board.level}" >&nbsp;&nbsp;</c:forEach>
											[삭제된 게시글 입니다.]
									</td>
								</c:when>
								<c:otherwise>
									<td style="text-align: left;"><c:forEach var="i" begin="1" end="${boardVO.level}" >&nbsp;&nbsp;</c:forEach>
											 ${board.boardTitle }
									</td>
								</c:otherwise>
							</c:choose>
						
							<td>${board.memId } </td>
							<td>${board.boardDate }</td>
						
						</tr>
					</c:forEach>
				</tbody>
			</table>
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