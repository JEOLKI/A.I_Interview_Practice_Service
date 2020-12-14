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
	.talentCount, .chart{
		display: inline-block;
		float : left;
		width: 45%;
	}
	.title{
		border-bottom: 2px solid black;
	}
	.chart{
		padding :10px;
		margin-left: 50px;
		height: 400px;
		widows: 20%
	}
	#sum{
		border-top: 1px solid black;
		font-weight: bold;
	}
</style>
<script>
$(document).ready(function(){
	
	
	$('#sort').on('change',function(){
		pageUnit = $(this).val();
		document.location="/talent/retrieveStatisticsPagingList.do?pageUnit="+pageUnit;
	})
	
	$('#start').on('change',function(){
		console.log($(this).val());
		$('#startDate').val($(this).val());
	})
	
	$('#end').on('change',function(){
		console.log($(this).val());
		$('#endDate').val($(this).val());
	})
	
	// 전체 이용자 수 
	$('#searchBtn').on('click',function(){
		var startDate = $('#startDate').val() == ''? '2000-01-01' : $('#startDate').val();
		var endDate = $('#endDate').val() == ''? 'sysdate' : $('#endDate').val();
		console.log(startDate);
		console.log(endDate);
		$.ajax({ url : "/talent/retrieveStatisticsPagingList.do", 
				 data : {"startDate" : startDate,
					 	 "endDate" 	 : endDate},
				 dataType : "json",
				 success : function(data){
					 console.log(data);
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
					
// 					console.log(chart.data);
						   

// 					// Set inner radius
					chart.innerRadius = am4core.percent(50);
					
					// Add and configure Series
					var pieSeries = chart.series.push(new am4charts.PieSeries());
					pieSeries.dataFields.value = "talentCount";
					pieSeries.dataFields.category = "talentName";
					pieSeries.slices.template.stroke = am4core.color("#fff");
					pieSeries.slices.template.strokeWidth = 2;
					pieSeries.slices.template.strokeOpacity = 1;
					
					// This creates initial animation
					pieSeries.hiddenState.properties.opacity = 1;
					pieSeries.hiddenState.properties.endAngle = -90;
					pieSeries.hiddenState.properties.startAngle = -90;

// 						});// end am4core.ready()


					 
				 }
			
		})
	})
	
})	
/* 검색 */
	function searchList(){
	document.listForm.action = "<c:url value='/talent/retrieveStatisticsPagingList.do'/>";
		document.listForm.submit();
	}
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
							 		<div class="conditionmenu">
								    	기간 : 
								    	<input id="start" type="date">
								    	~
								    	<input id="end" type="date">
								    		<input type="hidden" id="startDate" name="startDate" >
								    		<input type="hidden" id="endDate" name="endDate" >
								    		<img id="searchBtn" alt="" src="/images/searchBtn.png" style="width:25px;height:25px; display: inline-block; position: relative; top:2px; left:5px;">
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
											<span onclick="searchList()">검색</span>
										</div>
								    	<a href="${cp }/talent/list/excelDown.do">↓ 목록 내려받기</a> 
								    </div>
							  <div class="talentCount">
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
</form:form>	
</body>
</html>