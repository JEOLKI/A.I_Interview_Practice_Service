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
</style>
<script>
$(document).ready(function(){
	
	var startDate = $('#startDate').val() == ''? '2000-01-01' : $('#startDate').val();
	var endDate = $('#endDate').val() == ''? 'sysdate' : $('#endDate').val();
	
	$.ajax({ url : "/talent/retrieveStatisticsPagingList.do", 
		 data : {"startDate" : startDate,
			 	 "endDate" 	 : endDate},
		 dataType : "json",
		 success : function(data){
		
			var talentCountList = data.talentCountList;
		
			createChart(talentCountList);	//차트 그리기
			createHtml(talentCountList);	//표 그리기

		 }// success function()
	
	})// ajax
	
	
	
	$('#start').on('change',function(){
		$('#startDate').val($(this).val());
	})
	
	$('#end').on('change',function(){
		$('#endDate').val($(this).val());
	})
	
	
	
	// 전체 인재상 수
	$('#selectBtn, #searchBtn, #sort').on('click',function(){
		var searchKeyword = $('#searchKeyword').val();
		startDate = $('#startDate').val() == ''? '2000-01-01' : $('#startDate').val();
		endDate = $('#endDate').val() == ''? 'sysdate' : $('#endDate').val();
		$.ajax({ url : "/talent/retrieveStatisticsPagingList.do", 
				 data : {"startDate" : startDate,
				 	 	 "endDate" 	 : endDate,
				 		 "searchKeyword" : searchKeyword},
				 dataType : "json",
				 success : function(data){
					
					 var talentCountList = data.talentCountList;
						
					createChart(talentCountList);	//차트 그리기
					createHtml(talentCountList);	//표 그리기
					
				 }	// success function()
		}) // ajax
	})
	
	
	
})	


function createChart(talentCountList){
	// Themes begin
	am4core.useTheme(am4themes_animated);
	// Themes end
	
	var chart = am4core.create("talentCountChart", am4charts.PieChart);		 
	
	chart.logo.disabled = true;
		
	var chartData = [];
	var talentCount=0;
	for(var i=0; i< talentCountList.length; i++){
			var talent = talentCountList[i];
			
			talentName=talent.talentNm;
			talentCount=talent.talentCount;
			
		    chartData.push({talentName:talentName, talentCount: talentCount}); 
				
	}
	
	chart.data =  chartData;

	// Set radius
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

function createHtml(talentCountList){
	var sum = 0;
	html = '';
	for(var i=0; i< talentCountList.length; i++){
		var talent = talentCountList[i];
		
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
}

</script>
</head>
<body>
<form:form commandName="TalentAnalysisVO" id="listForm" name="listForm" method="post">
		<h1>인재상 통계</h1>
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
</form:form>	
</body>
</html>