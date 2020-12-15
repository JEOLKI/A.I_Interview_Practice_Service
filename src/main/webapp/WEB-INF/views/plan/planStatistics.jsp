<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<script src="https://cdn.amcharts.com/lib/4/core.js"></script>
<script src="https://cdn.amcharts.com/lib/4/charts.js"></script>
<script src="https://cdn.amcharts.com/lib/4/themes/kelly.js"></script>
<script src="https://cdn.amcharts.com/lib/4/themes/animated.js"></script>

<%@ include file="/WEB-INF/views/layout/commonLib.jsp" %>
 <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script>
</script>
<style>
body{
      background-color : #f5f7fb;
   }
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
	.saleList, .useList{
		margin-top: 50px;
		display: inline-block;
		float : left;
		width: 45%;
	}
	.chart{
		display: inline-block;
		float :right;
		width: 45%;
	}
	.chart{
		margin-left: 50px;
		height: 400px;
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
	.w3-container html{
		background-color: #f5f7fb;
	}
</style>
<script>

$(document).ready(function(){

	var useStartDate = $('#useStartDate').val() == ''? '2000-01-01' : $('#useStartDate').val();
	var useEndDate = $('#useEndDate').val() == ''? 'sysdate' : $('#useEndDate').val();
	
	// 첫페이지(이용자)
	$.ajax({ url : "/plan/totalUseStatistics.do", 
		 data : {"startDate" : useStartDate,
			 	 "endDate" 	 : useEndDate},
		 dataType : "json",
		 success : function(data){
			 $('#sale').css('display', 'none');
			 html="";
		
			 // Themes begin
			am4core.useTheme(am4themes_kelly);
			am4core.useTheme(am4themes_animated);
			// Themes end
			
				 
			 var chart = am4core.create("useChart", am4charts.XYChart);
				chart.hiddenState.properties.opacity = 0; // this creates initial fade-in
			
				
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
				 html += '<td class="useCount" value="'+planUse.useCount+'">'+numberWithCommas(planUse.useCount)+'</td>';
				 html += '</tr>';
				 
				 sum += planUse.useCount;
			 }
			 html += '<tr id="sum">';
			 html += '<td>합  계</td>';
			 html += '<td></td>';
			 html += '<td id="sumCount" value="'+sum+'">'+numberWithCommas(sum)+'</td>';
			 $('#useList').empty();
			 $('#useList').append(html);
			chartData2.push({plan:"Total", useCount:sum})
			chart.data =  chartData2;
			
				   

				var categoryAxis = chart.xAxes.push(new am4charts.CategoryAxis());
				categoryAxis.renderer.grid.template.location = 0;
				categoryAxis.dataFields.category = "plan";
				categoryAxis.renderer.minGridDistance = 40;
				categoryAxis.fontSize = 11;

				var valueAxis = chart.yAxes.push(new am4charts.ValueAxis());
				valueAxis.min = 0;
				valueAxis.max = sum+1;
				valueAxis.strictMinMax = true;
				valueAxis.renderer.minGridDistance = 30;
				// axis break
				var axisBreak = valueAxis.axisBreaks.create();
// 				axisBreak.startValue = sum/5*2;
// 				axisBreak.endValue = sum/5*4;
// 				axisBreak.breakSize = 0.005;

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
	})

		// 매출
	$('#saleTab, #saleSelectBtn, #saleSearchBtn').on('click', function() {
		
		var startDate = $('#saleStartDate').val() == ''? '2000-01-01' : $('#saleStartDate').val();
		var endDate = $('#saleEndDate').val() == ''? 'sysdate' : $('#saleEndDate').val();
		var searchKeyword = $('#saleSearchKeyword').val();
		$.ajax({ url : "/plan/totalSaleStatistics.do", 
				 data : {"startDate" : startDate,
					 	 "endDate" 	 : endDate,
					 	 "searchKeyword" :searchKeyword},
				 dataType : "json",
				 success : function(data){
					 html="";
				
					 // Themes begin
					am4core.useTheme(am4themes_kelly);
					am4core.useTheme(am4themes_animated);
					// Themes end
					
						 
					 var chart = am4core.create("saleChart", am4charts.XYChart);
						chart.hiddenState.properties.opacity = 0; // this creates initial fade-in
					
						
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
						 html += '<td class="planPrice" value="'+planUse.planPrice+'">'+numberWithCommas(planUse.planPrice)+'</td>';
						 html += '<td class="useCount" value="'+planUse.useCount+'">'+planUse.useCount+'</td>';
						 html += '<td class="sale" value="'+planUse.sale+'">'+numberWithCommas(planUse.sale)+'</td>';

						 html += '</tr>';
						 
						 countSum += planUse.useCount;
						 saleSum += planUse.sale;
					 }
					 html += '<tr id="sum">';
					 html += '<td>합  계</td>';
					 html += '<td></td>';
					 html += '<td></td>';
					 html += '<td id="countSum" value="'+countSum+'">'+countSum+'</td>';
					 html += '<td id="countSum" value="'+saleSum+'">'+numberWithCommas(saleSum)+'</td>';
					 $('#saleList').empty();
					 $('#saleList').append(html);
					chartData2.push({plan:"Total", sale:saleSum})
					chart.data =  chartData2;
					
						   

						var categoryAxis = chart.xAxes.push(new am4charts.CategoryAxis());
						categoryAxis.renderer.grid.template.location = 0;
						categoryAxis.dataFields.category = "plan";
						categoryAxis.renderer.minGridDistance = 40;
						categoryAxis.fontSize = 11;

						var valueAxis = chart.yAxes.push(new am4charts.ValueAxis());
						valueAxis.min = 0;
						valueAxis.max = saleSum+10000;
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

						var series = chart.series.push(new am4charts.ColumnSeries());
						series.dataFields.categoryX = "plan";
						series.dataFields.valueY = "sale";
						series.columns.template.tooltipText = "{valueY.value}";
						series.columns.template.tooltipY = 0;
						series.columns.template.strokeOpacity = 0;

									// as by default columns of the same series are of the same color, we add adapter which takes colors from chart.colors color set
									series.columns.template.adapter.add("fill", function(fill, target) {
									  return chart.colors.getIndex(target.dataItem.index);
									// end am4core.ready()
									}) 
				}

			})
		})
	
	$('#useStart').on('change',function(){
		$('#useStartDate').val($(this).val());
	})
	
	$('#useEnd').on('change',function(){
		$('#useEndDate').val($(this).val());
	})
	
	$('#saleStart').on('change',function(){
		$('#saleStartDate').val($(this).val());
	})
	
	$('#saleEnd').on('change',function(){
		$('#saleEndDate').val($(this).val());
	})
	
	// 전체 이용자 수 
	$('#useSelectBtn, #useSearchBtn').on('click',function(){
		var searchKeyword = $('#useSearchKeyword').val();
		$.ajax({ url : "/plan/totalUseStatistics.do", 
				 data : {"startDate" : useStartDate,
					 	 "endDate" 	 : useEndDate,
					 	 "searchKeyword" :searchKeyword},
				 dataType : "json",
				 success : function(data){
					 html="";
				
					 // Themes begin
					am4core.useTheme(am4themes_kelly);
					am4core.useTheme(am4themes_animated);
					// Themes end
					
						 
					 var chart = am4core.create("useChart", am4charts.XYChart);
						chart.hiddenState.properties.opacity = 0; // this creates initial fade-in
					
						
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
					
						   

						var categoryAxis = chart.xAxes.push(new am4charts.CategoryAxis());
						categoryAxis.renderer.grid.template.location = 0;
						categoryAxis.dataFields.category = "plan";
						categoryAxis.renderer.minGridDistance = 40;
						categoryAxis.fontSize = 11;

						var valueAxis = chart.yAxes.push(new am4charts.ValueAxis());
						valueAxis.min = 0;
						valueAxis.max = sum+1;
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
											// end am4core.ready()
											})	
						
						
					}
				})		
			})


	$('.nav-tabs>li>a').on('click', function(){
		target = $(this).data("target");
		$('.content').removeClass('in');
		$('.content').removeClass('active');
		if(target == 'use'){
			$('#use').addClass('in');
			$('#use').addClass('active');
			$('#use').css('display', '');
			$('#sale').css('display', 'none');
			
		} else if(target == 'sale'){
			$('#sale').addClass('in');
			$('#sale').addClass('active');
			$('#sale').css('display', '');
			$('#use').css('display', 'none');
		}
	})

})
function numberWithCommas(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}


</script>
</head>
<body>
	<form:form commandName="planVO" id="listForm" name="listForm" method="post">
		<h1>요금제 통계</h1>
			<div class="planStatistics">
				<div class="contentBox">
					<ul class="nav nav-tabs">
					    <li class="active"><a data-target="use" data-toggle="tab" href="#use">이용자</a></li>
					    <li><a id="saleTab" data-target="sale" data-toggle="tab" href="#sale">매출</a></li>
					</ul>
					<br><br>
					 <div class="tab-pane fade in active">
						    <div class="conditionmenu">
						    	기간 : 
						    	<input id="useStart" type="date">
						    	~
						    	<input id="useEnd" type="date">
						    		<input type="hidden" id="useStartDate" name="startDate" >
						    		<input type="hidden" id="useEndDate" name="endDate" >
						    		<img id="useSelectBtn" alt="" src="/images/searchBtn.png" style="width:25px;height:25px; display: inline-block; position: relative; top:-5px; left:5px;">
						    </div>
						    <div class="listmenu">
								<div id="search">
									<input type="text" id="useSearchKeyword" >
									<span id="useSearchBtn">검색</span>
								</div>
						    	<a href="${cp }/plan/list/excelDown.do">↓ 목록 내려받기</a> 
						    </div>
					 </div>
					 <div class="tab-pane fade">
					 		<div class="conditionmenu">
						    	기간 : 
						    	<input id="saleStart" type="date">
						    	~
						    	<input id="saleEnd" type="date">
						    		<input type="hidden" id="saleStartDate" name="startDate" >
						    		<input type="hidden" id="saleEndDate" name="endDate" >
						    		<img id="saleSelectBtn" alt="" src="/images/searchBtn.png" style="width:25px;height:25px; display: inline-block; position: relative; top:-5px; left:5px;">
						    </div>
						    <div class="listmenu">
								<div id="search">
									<input type="text" id="saleSearchKeyword" >
									<span id="saleSearchBtn">검색</span>
								</div>
						    	<a href="${cp }/plan/list/excelDown.do">↓ 목록 내려받기</a> 
						    </div>
					</div>
				</div>
				<div class="tab-content">
					<div class="contentBox">
					 <!-- 사용자 탭 -->
					  <div id="use" class="tab-pane fade content in active">
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
					 <div id="sale" class="tab-pane fade content">
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
	</form:form>		
</body>
</html>