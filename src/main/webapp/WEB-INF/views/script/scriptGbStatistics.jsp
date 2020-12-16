<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://cdn.amcharts.com/lib/4/core.js"></script>
<script src="https://cdn.amcharts.com/lib/4/charts.js"></script>
<script src="https://cdn.amcharts.com/lib/4/themes/kelly.js"></script>
<script src="https://cdn.amcharts.com/lib/4/themes/animated.js"></script>
<%@ include file="/WEB-INF/views/layout/commonLib.jsp" %>
<title>AI_INTERVIEW</title>

<style>
/* 	#search{ */
/* 		display: inline-block; */
/* 	} */
	
/* 	#searchBtn{ */
/* 		display: inline-block; */
/* 	    vertical-align: middle; */
/* 	    border: 1px solid #000d22; */
/* 	    border-radius: 5px; */
/* 	    height: 23px; */
/* 	    padding: 0px 10px; */
/* 	    text-align: center; */
/* 	    position: relative; */
/* 	    top: -2px; */
/* 	} */
	
/* 	#searchBtn:hover{ */
/* 	    background-color: #000d22; */
/* 	    color: #fff; */
/* 	} */
	
/* 	.listmenu, .conditionmenu{ */
/* 		display: inline-block;  */
/* 	} */
	
/* 	.conditionmenu{ */
/* 		float: left; */
/* 	} */
	
/* 	.listmenu{ */
/* 		float: right; */
/* 		position: relative; */
/* 		top : 7px; */
/* 	} */
	
/* 	.body{ */
/* 		margin : 30px; */
/* 	} */
	
/* 	.content__title{ */
/* 		margin-bottom: 30px; */
/* 	} */
	
/* 	h1{ */
/* 		font-weight:bold; */
/* 	} */
	
/* 	td{ */
/* 		width: 250px; */
/* 		text-align: center; */
/* 	} */
	
/* 	tr{ */
/* 		height: 50px; */
/* 	} */
	
/* 	.list { */
/* 		display: inline-block; */
/* 		float : left; */
/* 		width: 45%; */
/* 	} */
	
/* 	.chart{ */
/* 		display: inline-block; */
/* 		float : right; */
/* 		width: 45%; */
/* 	} */
	
/* 	.title th{ */
/* 		width: 250px; */
/* 		border-bottom: 2px solid black; */
/* 		text-align: center; */
/* 		font-size: 1.2em; */
/* 	} */
	
/* 	table{ */
/* 		border-collapse: collapse; */
/* 	} */
	
/* 	.chart{ */
/* 		padding :10px; */
/* 		margin-left: 50px; */
/* 		height: 400px; */
/* 		width: 45%; */
/* 	} */
	
/* 	#sum{ */
/* 		border-top: 1px solid black; */
/* 		font-weight: bold; */
/* 	} */
	
/* 	.contentBox{ */
/* 		width: 70%; */
/* 		padding: 20px 30px; */
/* 		background-color: white; */
/* 		border-radius: 10px; */
/* 		margin: 10px 0px; */
/* 		box-shadow: 5px 5px #EAEAEA; */
/* 		display: inline-block; */
/* 		float: left; */
/* 	} */
	
/* 	input{ */
/* 		border-radius: 5px; */
/* 		border : 1px solid black; */
/* 	} */
	
/* 	.scriptGbCountList{ */
/* 		margin-top: 50px; */
/* 	} */
</style>

<script>
// $(document).ready(function(){
// 	$.ajax({ url : "/scriptGubun/retrieveStatisticsPagingList.do", 
// 		 data : {"startDate" : startDate,
// 			 	 "endDate" 	 : endDate},
// 		 dataType : "json",
// 		 success : function(data){
// 			html="";
		
// 			// Themes begin
// 			am4core.useTheme(am4themes_animated);
// 			// Themes end
// 			var chart = am4core.create("scriptGbCountChart", am4charts.PieChart);		 
					
// 			var sum = 0;
// 			var chartData2 = [];
// 			var scriptGb="";
// 			var scriptGbCount=0;
// 			for(var i=0; i< data.scriptGbCountList.length; i++){
// 				var scriptGb = data.scriptGbCountList[i];
				
// 				scriptGbContent=scriptGb.scriptGbContent;
// 				scriptGbCount=scriptGb.scriptGbCount;
				
// 			    chartData2.push({scriptGbContent:scriptGbContent, scriptGbCount: scriptGbCount}); 
					
// 				 html += '<tr class="scriptGb">';
// 				 html += '<td>'+scriptGb.rn+'</td>';
// 				 html += '<td class="scriptGbContent">'+scriptGb.scriptGbContent+'</td>';
// 				 html += '<td class="scriptGbCount" value="'+scriptGb.scriptGbCount+'">'+scriptGb.scriptGbCount+'</td>';
// 				 html += '</tr>';
				 
// 				 sum += scriptGb.scriptGbCount;
// 			 }
// 			 html += '<tr id="sum">';
// 			 html += '<td>합  계</td>';
// 			 html += '<td></td>';
// 			 html += '<td id="sumCount" value="'+sum+'">'+sum+'</td>';
// 			 $('#scriptGbCountList').empty();
// 			 $('#scriptGbCountList').append(html);
// 			chart.data =  chartData2;
				   
// 			chart.radius = am4core.percent(70);
// 			// Set inner radius
// 			chart.innerRadius = am4core.percent(50);
			
// 			// Add and configure Series
// 			var pieSeries = chart.series.push(new am4charts.PieSeries());
// 			pieSeries.dataFields.value = "scriptGbCount";
// 			pieSeries.dataFields.category = "scriptGbContent";

// 			pieSeries.labels.template.maxWidth = 65;
// 			pieSeries.labels.template.wrap = true;
// 			// end am4core.ready()
// 		 }
	
// });
	
// 	$('#start').on('change',function(){
// 		$('#startDate').val($(this).val());
// 	})
// 	$('#end').on('change',function(){
// 		$('#endDate').val($(this).val());
// 	})
// 	var startDate = $('#startDate').val() == ''? '2000-01-01' : $('#startDate').val();
// 	var endDate = $('#endDate').val() == ''? 'sysdate' : $('#endDate').val();
	
// 	// 전체 스크립트 구분 수
// 	$('#selectBtn, #searchBtn, #sort').on('click',function(){
// 		var searchKeyword = $('#searchKeyword').val();
// 		var pageUnit = $(this).val();
// 		$.ajax({ url : "/scriptGubun/retrieveStatisticsPagingList.do", 
// 				 data : {"startDate" : startDate,
// 				 	 	 "endDate" 	 : endDate,
// 				 		 "searchKeyword" : searchKeyword},
// 				 dataType : "json",
// 				 success : function(data){
// 					 html="";
// 					 // Themes begin
// 					am4core.useTheme(am4themes_animated);
// 					// Themes end
					
// 				var chart = am4core.create("scriptGbCountChart", am4charts.PieChart);		 
						
//  				 var sum = 0;
// 				 var chartData2 = [];
// 				 var scriptGb="";
// 				 var scriptGbCount=0;
// 				 for(var i=0; i< data.scriptGbCountList.length; i++){
// 						var scriptGb = data.scriptGbCountList[i];
						
// 						scriptGbContent=scriptGb.scriptGbContent;
// 						scriptGbCount=scriptGb.scriptGbCount;
						
// 					    chartData2.push({scriptGbContent:scriptGbContent, scriptGbCount: scriptGbCount}); 
							
// 						 html += '<tr class="scriptGb">';
// 						 html += '<td>'+scriptGb.rn+'</td>';
// 						 html += '<td class="scriptGbContent">'+scriptGb.scriptGbContent+'</td>';
// 						 html += '<td class="scriptGbCount" value="'+scriptGb.scriptGbCount+'">'+scriptGb.scriptGbCount+'</td>';
// 						 html += '</tr>';
						 
// 						 sum += scriptGb.scriptGbCount;
// 					 }
// 					 html += '<tr id="sum">';
// 					 html += '<td>합  계</td>';
// 					 html += '<td></td>';
// 					 html += '<td id="sumCount" value="'+sum+'">'+sum+'</td>';
// 					 $('#scriptGbCountList').empty();
// 					 $('#scriptGbCountList').append(html);
// 					chart.data =  chartData2;
					
// 					// Set inner radius
// 					chart.innerRadius = am4core.percent(50);
					
// 					// Add and configure Series
// 					var pieSeries = chart.series.push(new am4charts.PieSeries());
// 					pieSeries.dataFields.value = "scriptGbCount";
// 					pieSeries.dataFields.category = "scriptGbContent";

// 					pieSeries.labels.template.maxWidth = 50;
// 					pieSeries.labels.template.wrap = true;
// 					// end am4core.ready()
// 				 }
// 		});
// 	});
// });
</script>

</head>



<body>
<%-- <form:form commandName="ScriptGbAnalysisVO" id="listForm" name="listForm" method="post"> --%>
<!-- 	<h1>스크립트 구분 통계</h1> -->
<!-- 	<div class="scriptGbStatistics"> -->
<!-- 		 <div id="scriptGb"> -->
<!-- 			<div class="contentBox">	 -->
<!-- 		 		<div class="conditionmenu"> -->
<!-- 			    	기간 : <input id="start" type="date"> -->
<!-- 			    	~ -->
<!-- 			    	<input id="end" type="date"> -->
<!-- 			    		<input type="hidden" id="startDate" name="startDate" > -->
<!-- 			    		<input type="hidden" id="endDate" name="endDate" > -->
<!-- 			    		<img id="selectBtn" alt="" src="/images/searchBtn.png" style="width:25px;height:25px; display: inline-block; position: relative; top:5px; left:5px;"> -->
<!-- 			    </div> -->
<!-- 			    <div class="listmenu"> -->
<!-- 					<div id="search"> -->
<!-- 						<input type="text" id="searchKeyword" > -->
<!-- 						<span id="searchBtn">검색</span> -->
<!-- 					</div> -->
<!-- 					<span >&nbsp;&nbsp;&nbsp;&nbsp;</span> -->
<!-- 			    </div> -->
<!-- 			</div> -->
<!-- 			<div class="contentBox">	  -->
<!-- 		  		<div class="list"> -->
<!-- 		  			<table class="scriptGbCountList"> -->
<!-- 					  	<tr class="title"> -->
<!-- 					  			<th></th> -->
<!-- 					  			<th>언 어</th> -->
<!-- 					  			<th>도출 수</th> -->
<!-- 					  	</tr>  -->
<!-- 					  	<tbody id="scriptGbCountList"> -->
<!-- 					  	</tbody> -->
<!-- 					</table> -->
<!-- 		  		</div> -->
<!-- 			 	 <div id="scriptGbCountChart" class="scriptGbCount chart"></div> -->
<!-- 			 </div> -->
<!-- 		</div> -->
<!-- 	</div> -->
<%-- </form:form>	 --%>
<!-- </body> -->
</html>