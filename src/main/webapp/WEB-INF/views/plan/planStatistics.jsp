<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.bundle.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js"></script>

<script src="https://cdn.amcharts.com/lib/4/core.js"></script>
<script src="https://cdn.amcharts.com/lib/4/charts.js"></script>
<script src="https://cdn.amcharts.com/lib/4/themes/kelly.js"></script>
<script src="https://cdn.amcharts.com/lib/4/themes/animated.js"></script>

<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<%@ include file="/WEB-INF/views/layout/commonLib.jsp" %>
 <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script>
</script>
<style>
	#search{
		display: inline-block; 
	}
	
	.listmenu, .conditionmenu{
		margin-bottom: 20px;
	}
	.body{
		margin : 30px;
	}
	
	.content__title{
		margin-bottom: 30px;
	}
	
	h1{
		font-weight:bold;
	}
	
	#content{
		display: inline-block;
		width: 50%;
		
	}
	th, td{
		width: 250px;
		text-align: center;
	}
	th{
		font-size: 1.2em;
	}
	tr{
		height: 50px;
	}
	#sum{
		border-top: 1px solid black;
		font-weight: bold;
	}
	.title{
		border-bottom: 2px solid black;
	}
	.useList, .saleList, .chart{
		display: inline-block;
		float : left;
		width: 45%;
	}
	.chart{
		margin-left: 50px;
		height: 400px;
	}
</style>
<script>
$(document).ready(function(){
	
	$('#questGbRegistBtn').on('click', function() {
		if($('#questGbContent').val()==''){
			var html = '<span style="color:red">**내용을 입력해주세요</span><br><br>';
			$('#check').empty();
			$('#check').append(html);
		}else{
			$('#questGbRegistFrm').submit();
		}
	})
	
		
	$('#massiveCreate').on('click',function(){
		$('input[type="file"]').click();
	})
	
	$('input[type="file"]').on('change',function(){
		$('#massiveForm').submit();
	})
	
	$('#sort').on('change',function(){
		pageUnit = $(this).val();
		document.location="/questGb/retrievePagingList.do?pageUnit="+pageUnit;
	})
	
	$('#useStart').on('change',function(){
		console.log($(this).val());
		$('#useStartDate').val($(this).val());
	})
	
	$('#useEnd').on('change',function(){
		console.log($(this).val());
		$('#useEndDate').val($(this).val());
	})
	
	$('#saleStart').on('change',function(){
		console.log($(this).val());
		$('#saleStartDate').val($(this).val());
	})
	
	$('#saleEnd').on('change',function(){
		console.log($(this).val());
		$('#saleEndDate').val($(this).val());
	})
	
	// 전체 이용자 수 
	$('#useSearchBtn').on('click',function(){
		var startDate = $('#useStartDate').val() == ''? '2000-01-01' : $('#useStartDate').val();
		var endDate = $('#useEndDate').val() == ''? 'sysdate' : $('#useEndDate').val();
		console.log(startDate);
		console.log(endDate);
		$.ajax({ url : "/plan/totalUseStatistics.do", 
				 data : {"startDate" : startDate,
					 	 "endDate" 	 : endDate},
				 dataType : "json",
				 success : function(data){
					 console.log(data);
					 html="";
				
					 // Themes begin
					am4core.useTheme(am4themes_kelly);
					am4core.useTheme(am4themes_animated);
					// Themes end
					
						 
					 var chart = am4core.create("useChart", am4charts.XYChart);
						chart.hiddenState.properties.opacity = 0; // this creates initial fade-in
						console.log("차트");
					
						
 				   var sum = 0;
					var chartData2 = [];
					var plan="";
					var useCount=0;
					for(var i=0; i< data.totalUseList.length; i++){
						var planUse = data.totalUseList[i];
						
						plan=planUse.planNm;
						useCount=planUse.useCount;
						
					    chartData2.push({plan:plan, useCount: useCount}); 
							
						 html += '<tr class="plan">';
						 html += '<td>'+planUse.rn+'</td>';
						 html += '<td class="planNm">'+planUse.planNm+'</td>';
						 html += '<td class="useCount" value="'+planUse.useCount+'">'+planUse.useCount+'</td>';
						 html += '</tr>';
						 
						 sum += planUse.useCount;
					 }
					 html += '<tr id="sum">';
					 html += '<td>합  계</td>';
					 html += '<td></td>';
					 html += '<td id="sumCount" value="'+sum+'">'+sum+'</td>';
					 $('#useList').empty();
					 $('#useList').append(html);
					chartData2.push({plan:"Total", useCount:sum})
					chart.data =  chartData2;
					
					console.log(chart.data);
						   

						var categoryAxis = chart.xAxes.push(new am4charts.CategoryAxis());
						categoryAxis.renderer.grid.template.location = 0;
						categoryAxis.dataFields.category = "plan";
						categoryAxis.renderer.minGridDistance = 40;
						categoryAxis.fontSize = 11;

						var valueAxis = chart.yAxes.push(new am4charts.ValueAxis());
						valueAxis.min = 0;
						valueAxis.max = 10;
						valueAxis.strictMinMax = true;
						valueAxis.renderer.minGridDistance = 30;
						// axis break
						var axisBreak = valueAxis.axisBreaks.create();
// 						axisBreak.startValue = 4;
// 						axisBreak.endValue = 8;
// 						axisBreak.breakSize = 0.005;

						// fixed axis break
						var d = (axisBreak.endValue - axisBreak.startValue) / (valueAxis.max - valueAxis.min);
						axisBreak.breakSize = 0.05 * (1 - d) / d; // 0.05 means that the break will take 5% of the total value axis height

						// make break expand on hover
						var hoverState = axisBreak.states.create("hover");
						hoverState.properties.breakSize = 1;
						hoverState.properties.opacity = 0.1;
						hoverState.transitionDuration = 1500;

						axisBreak.defaultState.transitionDuration = 1000;
						/*
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
						});*/

						var series = chart.series.push(new am4charts.ColumnSeries());
						series.dataFields.categoryX = "plan";
						series.dataFields.valueY = "useCount";
						series.columns.template.tooltipText = "{valueY.value}";
						series.columns.template.tooltipY = 0;
						series.columns.template.strokeOpacity = 0;

						// as by default columns of the same series are of the same color, we add adapter which takes colors from chart.colors color set
						series.columns.template.adapter.add("fill", function(fill, target) {
						  return chart.colors.getIndex(target.dataItem.index);
						});// end am4core.ready()


					 
				 }
			
		})
	})
	
	
	// 매출
	$('#saleSearchBtn').on('click',function(){
		var startDate = $('#saleStartDate').val() == ''? '2000-01-01' : $('#saleStartDate').val();
		var endDate = $('#saleEndDate').val() == ''? 'sysdate' : $('#saleEndDate').val();
		console.log(startDate);
		console.log(endDate);
		$.ajax({ url : "/plan/totalSaleStatistics.do", 
				 data : {"startDate" : startDate,
					 	 "endDate" 	 : endDate},
				 dataType : "json",
				 success : function(data){
					 console.log(data);
					 html="";
				
					 // Themes begin
					am4core.useTheme(am4themes_kelly);
					am4core.useTheme(am4themes_animated);
					// Themes end
					
						 
					 var chart = am4core.create("saleChart", am4charts.XYChart);
						chart.hiddenState.properties.opacity = 0; // this creates initial fade-in
						console.log("차트");
					
						
 				   var countSum = 0;
 				   var saleSum = 0;
					var chartData2 = [];
					var plan="";
					var sale=0;
					for(var i=0; i< data.totalSaleList.length; i++){
						var planUse = data.totalSaleList[i];
						
						plan=planUse.planNm;
						sale=planUse.sale;
						
					    chartData2.push({plan:plan, sale: sale}); 
							
						 html += '<tr class="plan">';
						 html += '<td>'+planUse.rn+'</td>';
						 html += '<td class="planNm">'+planUse.planNm+'</td>';
						 html += '<td class="planPrice" value="'+planUse.planPrice+'">'+planUse.planPrice+'</td>';
						 html += '<td class="useCount" value="'+planUse.useCount+'">'+planUse.useCount+'</td>';
						 html += '<td class="sale" value="'+planUse.sale+'">'+planUse.sale+'</td>';
						 html += '</tr>';
						 
						 countSum += planUse.useCount;
						 saleSum += planUse.sale;
					 }
					 html += '<tr id="sum">';
					 html += '<td>합  계</td>';
					 html += '<td></td>';
					 html += '<td></td>';
					 html += '<td id="countSum" value="'+countSum+'">'+countSum+'</td>';
					 html += '<td id="countSum" value="'+saleSum+'">'+saleSum+'</td>';
					 $('#saleList').empty();
					 $('#saleList').append(html);
					chartData2.push({plan:"Total", sale:saleSum})
					chart.data =  chartData2;
					
					console.log(chart.data);
						   

						var categoryAxis = chart.xAxes.push(new am4charts.CategoryAxis());
						categoryAxis.renderer.grid.template.location = 0;
						categoryAxis.dataFields.category = "plan";
						categoryAxis.renderer.minGridDistance = 40;
						categoryAxis.fontSize = 11;

						var valueAxis = chart.yAxes.push(new am4charts.ValueAxis());
						valueAxis.min = 0;
						valueAxis.max =  100000;
						valueAxis.strictMinMax = true;
						valueAxis.renderer.minGridDistance = 30;
						// axis break
						var axisBreak = valueAxis.axisBreaks.create();
// 						axisBreak.startValue = 4;
// 						axisBreak.endValue = 8;
// 						axisBreak.breakSize = 0.005;

						// fixed axis break
						var d = (axisBreak.endValue - axisBreak.startValue) / (valueAxis.max - valueAxis.min);
						axisBreak.breakSize = 0.05 * (1 - d) / d; // 0.05 means that the break will take 5% of the total value axis height

						// make break expand on hover
						var hoverState = axisBreak.states.create("hover");
						hoverState.properties.breakSize = 1;
						hoverState.properties.opacity = 0.1;
						hoverState.transitionDuration = 1500;

						axisBreak.defaultState.transitionDuration = 1000;
						/*
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
						});*/

						var series = chart.series.push(new am4charts.ColumnSeries());
						series.dataFields.categoryX = "plan";
						series.dataFields.valueY = "sale";
						series.columns.template.tooltipText = "{valueY.value}";
						series.columns.template.tooltipY = 0;
						series.columns.template.strokeOpacity = 0;

						// as by default columns of the same series are of the same color, we add adapter which takes colors from chart.colors color set
						series.columns.template.adapter.add("fill", function(fill, target) {
						  return chart.colors.getIndex(target.dataItem.index);
						});// end am4core.ready()


					 
				 }
			
		
	})
	
	})


})


</script>
</head>
<body>
<form:form commandName="planVO" id="listForm" name="listForm" method="post">
		<!-- 헤더 -->
		<div id="root">
			<div class="Main false">
				<div class="w3-container managerbox">
					<div class="body">
						<div class="content__title">
							<h1>요금제 통계</h1>
						</div>
						
						<div class="planStatistics">
							<ul class="nav nav-tabs">
							    <li class="active"><a data-toggle="tab" href="#use">이용자</a></li>
							    <li><a data-toggle="tab" href="#sale">매출</a></li>
							</ul>
							<br><br>
							<div class="tab-content">
							 
							 
							 <!-- 사용자 탭 -->
							  <div id="use" class="tab-pane fade in active">
								    <div class="conditionmenu">
								    	<form id="conditionStatisticsFrm" action="${cp }/plan/totalStatistics.do"> 
								    	기간 : 
								    	<input id="useStart" type="date">
								    	~
								    	<input id="useEnd" type="date">
								    		<input type="hidden" id="useStartDate" name="startDate" >
								    		<input type="hidden" id="useEndDate" name="endDate" >
								    		<img id="useSearchBtn" alt="" src="/images/searchBtn.png" style="width:25px;height:25px; display: inline-block; position: relative; top:-5px; left:5px;">
								    	</form>
								    </div>
								    <div class="listmenu">
								    	<select id="sort">
											<c:forEach var="value" begin="5" end="20" step="5">
												<c:choose>
													<c:when test="${pageUnit == value  }">
														<option value="${value }" selected="selected" >${value }개씩</option>
													</c:when>
													<c:otherwise>
														<option value="${value }" >${value }개씩</option>
													</c:otherwise>
												</c:choose>
											</c:forEach>
										</select> 
										<div id="search">
											<input type="text" id="searchKeyword" >
											<span onclick="search()">검색</span>
										</div>
								    	<a href="${cp }/plan/list/excelDown.do">↓ 목록 내려받기</a> 
										<!-- excel file 읽어오기 -->
									    <form id="massiveForm" name="massiveForm" enctype="multipart/form-data" method="post" action="<c:url value="${cp }/plan/massiveCreateProcess.do"/>" >
									        <input type="file" name="excelFile" style="display:none;"/>
									    </form>
								    </div>
								    <div class="use">
								  	<table class="useList">
								  		<tr class="title">
								  			<th></th>
								  			<th>요 금 제</th>
								  			<th>이용자 수</th>
								  		</tr>
								  		<tbody id="useList">
								  		</tbody>
								  	</table>
								  </div>	
								<div id="useChart" class="use chart"></div>
							</div>
							
							
							<!-- 매출 탭 -->
							 <div id="sale" class="tab-pane fade">
							 		<div class="conditionmenu">
								    	<form id="conditionStatisticsFrm" action="${cp }/plan/totalStatistics.do"> 
								    	기간 : 
								    	<input id="saleStart" type="date">
								    	~
								    	<input id="saleEnd" type="date">
								    		<input type="hidden" id="saleStartDate" name="startDate" >
								    		<input type="hidden" id="saleEndDate" name="endDate" >
								    		<img id="saleSearchBtn" alt="" src="/images/searchBtn.png" style="width:25px;height:25px; display: inline-block; position: relative; top:-5px; left:5px;">
								    	</form>
								    </div>
								    <div class="listmenu">
								    	<select id="sort">
											<c:forEach var="value" begin="5" end="20" step="5">
												<c:choose>
													<c:when test="${pageUnit == value  }">
														<option value="${value }" selected="selected" >${value }개씩</option>
													</c:when>
													<c:otherwise>
														<option value="${value }" >${value }개씩</option>
													</c:otherwise>
												</c:choose>
											</c:forEach>
										</select> 
										<div id="search">
											<input type="text" id="searchKeyword" >
											<span onclick="search()">검색</span>
										</div>
								    	<a href="${cp }/plan/list/excelDown.do">↓ 목록 내려받기</a> 
										<!-- excel file 읽어오기 -->
									    <form id="massiveForm" name="massiveForm" enctype="multipart/form-data" method="post" action="<c:url value="${cp }/plan/massiveCreateProcess.do"/>" >
									        <input type="file" name="excelFile" style="display:none;"/>
									    </form>
								    </div>
							  <div class="sale">
							  	<table class="saleList">
								  	<tr class="title">
								  			<th></th>
								  			<th>요 금 제</th>
								  			<th>가  격</th>
								  			<th>이용자 수</th>
								  			<th>매  출</th>
								  	</tr>
								  	<tbody id="saleList">
								  	</tbody>
								</table>
							  </div>
							  <div id="saleChart" class="sale chart"></div>
							</div>
							</div>
					</div>
				</div>
			</div>
		</div>
</form:form>		
</body>
</html>