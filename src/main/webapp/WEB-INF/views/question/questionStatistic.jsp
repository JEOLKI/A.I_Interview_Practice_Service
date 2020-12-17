<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="https://cdn.amcharts.com/lib/4/core.js"></script>
<script src="https://cdn.amcharts.com/lib/4/charts.js"></script>
<script src="https://cdn.amcharts.com/lib/4/themes/kelly.js"></script>
<script src="https://cdn.amcharts.com/lib/4/themes/animated.js"></script>
<%@ include file="/WEB-INF/views/layout/commonLib.jsp" %>
<style>
/* #talentCountChart{ */
/*  width: 60%; */
/*   height: 500px; */
/* } */
#search{
		display: inline-block;
	}
	.listmenu, .conditionmenu{
		display: inline-block; 
	}
	.conditionmenu{
		float: left;
	}
	.listmenu{
		float: right;
		position: relative;
		top : 7px;
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
	
	td{
		width: 250px;
		text-align: center;
	}
	
	tr{
		height: 50px;
	}
 	.rn{ 
		width: 50px;
	} 
 	.content{ 
 		width: 450px; 
 	} 
	.questGb {
		display: inline-block;
		float : left;
		width: 45%;
		margin-top: 50px;
	}
	.questGbAndSampList{
		width: 100%;
	}
	#questGbChart{
		display: inline-block;
		float : right;
		width: 45%;
		height: 400px;
		padding :10px;
	}
	.title th{
		width: 250px;
		border-bottom: 2px solid black;
		text-align: center;
		font-size: 1.2em;
	}
	
	table{
		border-collapse: collapse;
	}
	#questGbSum{
		border-top: 1px solid black;
		font-weight: bold;
	}
	#sampQuestSum{
		border-top: 1px solid black;
		font-weight: bold;
	}
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
	.talentCountList{
		margin-top: 50px;
	}
	#searchBtn{
		display: inline-block;
	    vertical-align: middle;
	    border: 1px solid #000d22;
	    border-radius: 5px;
	    height: 23px;
	    padding: 0px 10px;
	    text-align: center;
	    position: relative;
	    top: -2px;
	}
	
	#searchBtn:hover{
	    background-color: #000d22;
	    color: #fff;
	}
	.sort{
		height: 26px;
	    border-radius: 5px;
	    border: 1px solid gray;
	    position: relative;
	    top: -2px;
	    margin-left: 30px;
	}
</style>
<script type="text/javascript" language="javascript" defer="defer">
$(document).ready(function(){
	
	var startDate = $('#startDate').val() == ''? '2000-01-01' : $('#startDate').val();
	var endDate = $('#endDate').val() == ''? 'sysdate' : $('#endDate').val();
	var sort = '';
	
	$('.sort').on('change',function(){
		sort = $('.sort').val() == ''? '직무별' : $('.sort').val();
	})
	
	$.ajax({ url : "/sampQuest/retrieveQuestGbStatisticsList.do", 
		 data : {"startDate" : startDate,
			 	 "endDate" 	 : endDate},
		 dataType : "json",
		 success : function(data){
			 $('.questGbAndSampList').css('display', 'none');
			 $('#questGbAndSampChart').css('display', 'none');
			 
			 html="";
		
			 // Themes begin
			am4core.useTheme(am4themes_animated);
			// Themes end
			
			
		var chart = am4core.create("questGbChart", am4charts.PieChart);		 
			
				
		 var sum = 0;
		 var chartData2 = [];
		 var questGbNm="";
		 var questGbCount=0;
		 for(var i=0; i< data.resultList.length; i++){
				var questGb = data.resultList[i];
				
				questGbNm=questGb.questGbContent;
				questGbCount=questGb.useCount;
				
			    chartData2.push({questGbNm:questGbNm, questGbCount: questGbCount}); 
					
				 html += '<tr class="questGbList">';
				 html += '<td>'+questGb.rn+'</td>';
				 html += '<td class="questGbContent">'+questGbNm+'</td>';
				 html += '<td class="useCount" value="'+questGbCount+'">'+questGbCount+'</td>';
				 html += '</tr>';
				 
				 sum += questGbCount;
			 }
			 html += '<tr id="questGbSum">';
			 html += '<td>합  계</td>';
			 html += '<td></td>';
			 html += '<td id="sumCount" value="'+sum+'">'+sum+'</td>';
			 html += '</tr>';
			 $('#questGbList').empty();
			 $('#questGbList').append(html);
			chart.data =  chartData2;
			
				   
			chart.radius = am4core.percent(64);
			// Set inner radius
			chart.innerRadius = am4core.percent(50);
			
			// Add and configure Series
			var pieSeries = chart.series.push(new am4charts.PieSeries());
			pieSeries.dataFields.value = "questGbCount";
			pieSeries.dataFields.category = "questGbNm";

			pieSeries.labels.template.maxWidth = 65;
			pieSeries.labels.template.wrap = true;

			// end am4core.ready()


			 
		 }
	
	})
	
	
	
	$('#start').on('change',function(){
		console.log($(this).val());
		$('#startDate').val($(this).val());
		console.log($('#startDate').val());
	})
	
	$('#end').on('change',function(){
		console.log($(this).val());
		$('#endDate').val($(this).val());
		console.log($('#endDate').val());
	})
	
	
	// 전체 직무별
	$('#selectBtn, #searchBtn, .sort').on('click',function(){
		var startDate = $('#startDate').val() == ''? '2000-01-01' : $('#startDate').val();
		var endDate = $('#endDate').val() == ''? 'sysdate' : $('#endDate').val();
		var searchKeyword = $('#searchKeyword').val();
		console.log(sort);
		console.log(startDate);
		console.log(endDate);
		if(sort == '직무별'){
			console.log('직무별차트');
			$.ajax({ url : "/sampQuest/retrieveQuestGbStatisticsList.do", 
				 data : {"startDate" : startDate,
					 	 "endDate" 	 : endDate,
					 	 "searchKeyword" : searchKeyword},
				 dataType : "json",
				 success : function(data){
					 $('.questGbAndSampList').css('display', 'none');
					 $('#questGbAndSampChart').css('display', 'none');
					 $('.questGb').css('display', '');
					 $('#questGbChart').css('display', '');
					 
					 html="";
				
					 // Themes begin
					am4core.useTheme(am4themes_animated);
					// Themes end
					
					
				var chart = am4core.create("questGbChart", am4charts.PieChart);		 
					
						
				 var sum = 0;
				 var chartData2 = [];
				 var questGbNm="";
				 var questGbCount=0;
				 for(var i=0; i< data.resultList.length; i++){
						var questGb = data.resultList[i];
						
						questGbNm=questGb.questGbContent;
						questGbCount=questGb.useCount;
						
					    chartData2.push({questGbNm:questGbNm, questGbCount: questGbCount}); 
							
						 html += '<tr class="questGbList">';
						 html += '<td>'+questGb.rn+'</td>';
						 html += '<td class="questGbContent">'+questGbNm+'</td>';
						 html += '<td class="useCount" value="'+questGbCount+'">'+questGbCount+'</td>';
						 html += '</tr>';
						 
						 sum += questGbCount;
					 }
					 html += '<tr id="questGbSum">';
					 html += '<td>합  계</td>';
					 html += '<td></td>';
					 html += '<td id="sumCount" value="'+sum+'">'+sum+'</td>';
					 html += '</tr>';
					 $('#questGbList').empty();
					 $('#questGbList').append(html);
					chart.data =  chartData2;
					
						   
					chart.radius = am4core.percent(64);
					// Set inner radius
					chart.innerRadius = am4core.percent(50);
					
					// Add and configure Series
					var pieSeries = chart.series.push(new am4charts.PieSeries());
					pieSeries.dataFields.value = "questGbCount";
					pieSeries.dataFields.category = "questGbNm";

					pieSeries.labels.template.maxWidth = 65;
					pieSeries.labels.template.wrap = true;

					// end am4core.ready()

				 }
			
			})
			
		} else if(sort == '샘플질문별'){
			console.log('샘플질문별차트');
			console.log(startDate);
			console.log(endDate);
			$.ajax({ url : "/sampQuest/retrieveQuestGbAndSampStatisticsList.do", 
				 data : {"startDate" : startDate,
					 	 "endDate" 	 : endDate,
					 	 "searchKeyword" : searchKeyword},
				 dataType : "json",
				 success : function(data){
					 $('.questGb').css('display', 'none');
					 $('#questGbChart').css('display', 'none');
					 $('.questGbAndSampList').css('display', '');
					 $('#questGbAndSampChart').css('display', '');
					 
					 html="";
				
					 // Themes begin
						am4core.useTheme(am4themes_kelly);
						am4core.useTheme(am4themes_animated);
						// Themes end
						
							 
						var chart = am4core.create("questGbAndSampChart", am4charts.XYChart);
							chart.hiddenState.properties.opacity = 0; // this creates initial fade-in
						
							
						var max = 0;
						var sum = 0;
						var chartData2 = [];
						var rn="";
						var useCount=0;
						for(var i=0; i< data.resultList.length; i++){
							var question = data.resultList[i];
							
							rn = question.rn;
							useCount = question.useCount;
							
						    chartData2.push({rn:rn, useCount: useCount}); 

							 html += '<tr class="questGbAndSampList">';
							 html += '<td class="rn">'+rn+'</td>';
							 html += '<td class="questGbContent">'+question.questGbContent+'</td>';
							 html += '<td class="content">'+question.sampQuestContent+'</td>';
							 html += '<td class="useCount" value="'+useCount+'">'+useCount+'</td>';
							 html += '</tr>';
							 
							 sum += useCount;
							 
						    if(max < useCount){
						    	max = useCount;
						    }
						    	
						 }
						 html += '<tr id="sampQuestSum">';
						 html += '<td>합  계</td>';
						 html += '<td></td>';
						 html += '<td></td>';
						 html += '<td id="sumCount" value="'+sum+'">'+sum+'</td>';
						 html += '</tr>';
						 $('#questGbAndSampList').empty();
						 $('#questGbAndSampList').append(html);
						chart.data =  chartData2;
						
							   

							var categoryAxis = chart.xAxes.push(new am4charts.CategoryAxis());
							categoryAxis.renderer.grid.template.location = 0;
							categoryAxis.dataFields.category = "rn";
							categoryAxis.renderer.minGridDistance = 40;
							categoryAxis.fontSize = 11;

							var valueAxis = chart.yAxes.push(new am4charts.ValueAxis());
							valueAxis.min = 0;
							valueAxis.max = max+1;
							valueAxis.strictMinMax = true;
							valueAxis.renderer.minGridDistance = 30;
							// axis break
							var axisBreak = valueAxis.axisBreaks.create();
//			 				axisBreak.startValue = sum/5*2;
//			 				axisBreak.endValue = sum/5*4;
//			 				axisBreak.breakSize = 0.005;

							// fixed axis break
							var d = (axisBreak.endValue - axisBreak.startValue) / (valueAxis.max - valueAxis.min);
							axisBreak.breakSize = 0.05 * (1 - d) / d; // 0.05 means that the break will take 5% of the total value axis height

							// make break expand on hover
							var hoverState = axisBreak.states.create("hover");
							hoverState.properties.breakSize = 1;
							hoverState.properties.opacity = 0.1;
							hoverState.transitionDuration = 1500;

							axisBreak.defaultState.transitionDuration = 1000;

							var series = chart.series.push(new am4charts.ColumnSeries());
							series.dataFields.categoryX = "rn";
							series.dataFields.valueY = "useCount";
							series.columns.template.tooltipText = "{valueY.value}";
							series.columns.template.tooltipY = 0;
							series.columns.template.strokeOpacity = 0;

									// as by default columns of the same series are of the same color, we add adapter which takes colors from chart.colors color set
									series.columns.template.adapter.add("fill", function(fill, target) {
									  return chart.colors.getIndex(target.dataItem.index);
									// end am4core.ready()
									})
	
	
						 
					 }// success
				
				})
		}// else
	})
	
	
	
})	

	
</script>
</head>
<body>
<form:form commandName="SampleQuestionVO" id="listForm" name="listForm" method="post">
		<h1>질문 통계</h1>
						<div class="talentStatistics">
							 <div id="talent">
								<div class="contentBox">	
							 		<div class="conditionmenu">
								    	기간 : 
								    	<input id="start" type="date">
								    	~
								    	<input id="end" type="date">
								    		<input type="hidden" id="startDate" name="startDate" >
								    		<input type="hidden" id="endDate" name="endDate" >
								    		<img id="selectBtn" alt="" src="/images/searchBtn.png" style="width:25px;height:25px; display: inline-block; position: relative; top:5px; left:5px;">
										<select name="sort" class="sort" >
											<option value="직무별">직무별</option>
											<option value="샘플질문별">샘플질문별</option>
										</select>								    		
								    </div>
								    <div class="listmenu">
										<div id="search">
											<input type="text" id="searchKeyword" >
											<span id="searchBtn">검색</span>
										</div>
										<span >&nbsp;&nbsp;&nbsp;&nbsp;</span>
								    </div>
								 </div>
								<div class="contentBox">	 
								  <div class="questGb">
								  	<table class="questGbList">
									  	<tr class="title">
									  			<th></th>
									  			<th>직  무</th>
									  			<th>이용 수</th>
									  	</tr> 
									  	<tbody id="questGbList">
									  	</tbody>
									</table>
								  </div>
								  <div id="questGbChart" class="questGbChart"></div>
								  <div class="questGbAndSamp">
								  	<table class="questGbAndSampList">
									  	<tr class="title">
									  			<th class="rn"></th>
									  			<th>직  무</th>
									  			<th class="content">샘플 질문</th>
									  			<th>이용 수</th>
									  	</tr> 
									  	<tbody id="questGbAndSampList">
									  	</tbody>
									</table>
								  </div>
								  <div id="questGbAndSampChart" class="questGbAndSampChart"></div>
							  </div>
							</div>
							</div>
</form:form>	
</body>
</html>