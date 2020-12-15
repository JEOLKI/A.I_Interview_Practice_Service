<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
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
	.list {
		display: inline-block;
		float : left;
		width: 45%;
	}
	.chart{
		display: inline-block;
		float : right;
		width: 45%;
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
	.chart{
		padding :10px;
		margin-left: 50px;
		height: 400px;
		width: 45%;
	}
	#sum{
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
</style>
<script>
$(document).ready(function(){
	
	
	$.ajax({ url : "/talent/retrieveStatisticsPagingList.do", 
		 data : {"startDate" : startDate,
			 	 "endDate" 	 : endDate},
		 dataType : "json",
		 success : function(data){
			 html="";
		
			 // Themes begin
			am4core.useTheme(am4themes_animated);
			// Themes end
			
			
		var chart = am4core.create("talentCountChart", am4charts.PieChart);		 
			
				
		 var sum = 0;
		 var chartData2 = [];
		 var talent="";
		 var talentCount=0;
		 for(var i=0; i< data.talentCountList.length; i++){
				var talent = data.talentCountList[i];
				
				talentName=talent.talentNm;
				talentCount=talent.talentCount;
				
			    chartData2.push({talentName:talentName, talentCount: talentCount}); 
					
				 html += '<tr class="talent">';
				 html += '<td>'+talent.rn+'</td>';
				 html += '<td class="talentNm">'+talent.talentNm+'</td>';
				 html += '<td class="talentCount" value="'+talent.talentCount+'">'+talent.talentCount+'</td>';
				 html += '</tr>';
				 
				 sum += talent.talentCount;
			 }
			 html += '<tr id="sum">';
			 html += '<td>합  계</td>';
			 html += '<td></td>';
			 html += '<td id="sumCount" value="'+sum+'">'+sum+'</td>';
			 $('#talentCountList').empty();
			 $('#talentCountList').append(html);
			chart.data =  chartData2;
			
				   
			chart.radius = am4core.percent(70);
			// Set inner radius
			chart.innerRadius = am4core.percent(50);
			
			// Add and configure Series
			var pieSeries = chart.series.push(new am4charts.PieSeries());
			pieSeries.dataFields.value = "talentCount";
			pieSeries.dataFields.category = "talentName";

			pieSeries.labels.template.maxWidth = 65;
			pieSeries.labels.template.wrap = true;

			// end am4core.ready()


			 
		 }
	
})
	
	
	
	$('#start').on('change',function(){
		$('#startDate').val($(this).val());
	})
	
	$('#end').on('change',function(){
		$('#endDate').val($(this).val());
	})
	
	var startDate = $('#startDate').val() == ''? '2000-01-01' : $('#startDate').val();
	var endDate = $('#endDate').val() == ''? 'sysdate' : $('#endDate').val();
	
	// 전체 인재상 수
	$('#selectBtn, #searchBtn, #sort').on('click',function(){
		var searchKeyword = $('#searchKeyword').val();
		var pageUnit = $(this).val();
		$.ajax({ url : "/talent/retrieveStatisticsPagingList.do", 
				 data : {"startDate" : startDate,
				 	 	 "endDate" 	 : endDate,
				 		 "searchKeyword" : searchKeyword},
				 dataType : "json",
				 success : function(data){
					 html="";
				
					 // Themes begin
					am4core.useTheme(am4themes_animated);
					// Themes end
					
					
				var chart = am4core.create("talentCountChart", am4charts.PieChart);		 
					
						
 				 var sum = 0;
				 var chartData2 = [];
				 var talent="";
				 var talentCount=0;
				 for(var i=0; i< data.talentCountList.length; i++){
						var talent = data.talentCountList[i];
						
						talentName=talent.talentNm;
						talentCount=talent.talentCount;
						
					    chartData2.push({talentName:talentName, talentCount: talentCount}); 
							
						 html += '<tr class="talent">';
						 html += '<td>'+talent.rn+'</td>';
						 html += '<td class="talentNm">'+talent.talentNm+'</td>';
						 html += '<td class="talentCount" value="'+talent.talentCount+'">'+talent.talentCount+'</td>';
						 html += '</tr>';
						 
						 sum += talent.talentCount;
					 }
					 html += '<tr id="sum">';
					 html += '<td>합  계</td>';
					 html += '<td></td>';
					 html += '<td id="sumCount" value="'+sum+'">'+sum+'</td>';
					 $('#talentCountList').empty();
					 $('#talentCountList').append(html);
					chart.data =  chartData2;
					
					// Set inner radius
					chart.innerRadius = am4core.percent(50);
					
					// Add and configure Series
					var pieSeries = chart.series.push(new am4charts.PieSeries());
					pieSeries.dataFields.value = "talentCount";
					pieSeries.dataFields.category = "talentName";

					pieSeries.labels.template.maxWidth = 50;
					pieSeries.labels.template.wrap = true;
					// end am4core.ready()

					
					 
				 }
			
		})
	})
	
	
	
})	


</script>
</head>
<body>
<form:form commandName="TalentAnalysisVO" id="listForm" name="listForm" method="post">
		<!-- 헤더 -->
		<div id="root">
			<div class="Main false">
				<div class="w3-container managerbox">
					<div class="body">
						<div class="content__title">
							<h1>인재상 통계</h1>
						</div>
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
							  <div class="list">
							  	<table class="talentCountList">
								  	<tr class="title">
								  			<th></th>
								  			<th>인 재 상</th>
								  			<th>도출 수</th>
								  	</tr> 
								  	<tbody id="talentCountList">
								  	</tbody>
								</table>
							  </div>
							  <div id="talentCountChart" class="talentCount chart"></div>
							  </div>
							</div>
							</div>
					</div>
				</div>
			</div>
		</div>
</form:form>	
</body>
</html>