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
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<%@ include file="/WEB-INF/views/layout/commonLib.jsp" %>
<title>AI_INTERVIEW</title>

<script>
/**
 *  yyyyMMdd 포맷으로 반환
 */
function getFormatDate(date){
    var year = date.getFullYear();              //yyyy
    var month = (1 + date.getMonth());          //M
    month = month >= 10 ? month : '0' + month;  //month 두자리로 저장
    var day = date.getDate();                   //d
    day = day >= 10 ? day : '0' + day;          //day 두자리로 저장
    return  year + '' + month + '' + day;       //'-' 추가하여 yyyy-mm-dd 형태 생성 가능
}

var today = new Date();
today = getFormatDate(today);
</script>

<style>
	body{
      background-color : #f5f7fb;
      padding: 30px;
   }

 	.conditionmenu{ 
 		display: inline-block;  
 		float: left; 
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
	
 	.title th{ 
 		width: 250px; 
 		border-bottom: 2px solid black; 
 		text-align: center; 
 		font-size: 1.2em; 
 	} 
	
 	table{ 
 		border-collapse: collapse; 
 	} 

 	#sumCnt{ 
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
 	
 	.tabContent{
 		width: 45%;
 		margin: 0px;
 	}
 	
 	.chart { 
  		display: inline-block;
 		float : right; 
 		width: 45%; 
 		padding :10px; 
  		margin-left: 50px;
 		height: 400px; 
 		margin: 0px;
 	} 
	
 	input{ 
 		border-radius: 5px; 
 		border : 1px solid black; 
 	} 

 	.scriptContentTitle{
 		width : 50%;
 	}
</style>

<script>
var startDate;
var endDate;
var scriptGbSq;


$(document).ready(function(){
	startDate = $('#start').val() == ''? '20201002' : $('#start').val();
	endDate = $('#end').val() == ''? today : $('#end').val();
	
	var scriptRankingList=[];
	var scriptScoreList=[];
	//시작 시 score chart
	$.ajax({url : "/scriptGubun/retrieveScoreList.do",
			data : {"startDate" : startDate,
					"endDate" : endDate,
					"scriptGbSq" : scriptGbSq},
			dataType : "json",
			success : function(data){
				scriptScoreList = data.scriptScoreList;
				drawScoreChart(scriptScoreList);
			}//success 종료
	}); //score ajax 종료
	
	//시작 시 ranking table
 	$.ajax({url : "/scriptGubun/retrieveRankingList.do", 
			data : {"startDate" : startDate,
			 	 	"endDate" 	: endDate,
			 	 	"scriptGbSq": scriptGbSq},
		dataType : "json",
		success : function(data){
			scriptRankingList = data.scriptRankingList;
			drawRankingChart(scriptRankingList);
			}	//sucess 종료	 
	}); //ranking ajax 종료
	
	$('.scriptGbTab').on('click', function(){
		scriptGbSq = $(this).attr('value');
	});
	
	$('#selectBtn, .scriptGbTab').on('click',function(){
	 	//ranking table
		$.ajax({url : "/scriptGubun/retrieveRankingList.do", 
				data : {"startDate" : startDate,
					 	 "endDate" 	 : endDate,
					 	 "scriptGbSq": scriptGbSq},
				dataType : "json",
				success : function(data){
					scriptRankingList = data.scriptRankingList;
					drawRankingChart(scriptRankingList);
					}	//sucess 종료	 
		}); //ranking ajax 종료
		
		//score chart
		$.ajax({url : "/scriptGubun/retrieveScoreList.do",
				data : {"startDate" : startDate,
						"endDate" : endDate,
						"scriptGbSq" : scriptGbSq},
				dataType : "json",
				success : function(data){
					scriptScoreList = data.scriptScoreList;
					drawScoreChart(scriptScoreList);
				}//success 종료
		}); //score ajax 종료
	});// searchBtn 종료
	
	/* Score Chart */
	function drawScoreChart(scriptScoreList){
		am4core.ready(function() {
			am4core.useTheme(am4themes_kelly);
			am4core.useTheme(am4themes_animated);
				 
			var chart = am4core.create("scoreChart", am4charts.XYChart);
			chart.logo.disabled = true;
			chart.hiddenState.properties.opacity = 0; // this creates initial fade-in
			
			var chartData = [];
			var scoreList = [0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100];
			var zero=0, one=0, two=0, three=0, four=0, five=0, six=0, seven=0, eight=0, nine=0, ten=0;
			for(var i=0; i<scriptScoreList.length; i++){
				var testScore = scriptScoreList[i].scriptTestScore;
				
				var resultScore = (testScore/10)*10;
				if(resultScore==0){
					zero += 1;
				}else if(resultScore==10){
					one += 1;
				}else if(resultScore==20){
					two += 1;
				}else if(resultScore==30){
					three += 1;
				}else if(resultScore==40){
					four += 1;
				}else if(resultScore==50){
					five += 1;
				}else if(resultScore==60){
					six += 1;
				}else if(resultScore==70){
					seven += 1;
				}else if(resultScore==80){
					eight += 1;
				}else if(resultScore==90){
					nine += 1;
				}else if(resultScore==100) {
					ten += 1;
				}
			}
			var cntNumList = [zero, one, two, three, four, five, six, seven, eight, nine, ten];
			
			var sumLiteral=0;
			for(var i=0; i<cntNumList.length; i++){
				literal = cntNumList[i];	//바 그릴 데이터
				example = scoreList[i]; 	//x축에 찍을 데이터
				
				sumLiteral += literal;
			    chartData.push({example:example, literal:literal}); 
			 };
			 
			chart.data =  chartData;
			
			var categoryAxis = chart.xAxes.push(new am4charts.CategoryAxis());
			categoryAxis.renderer.grid.template.location = 0;
			categoryAxis.dataFields.category = "example";
			categoryAxis.renderer.minGridDistance = 40;
			categoryAxis.fontSize = 11;

			var valueAxis = chart.yAxes.push(new am4charts.ValueAxis());
			valueAxis.min=0;
			valueAxis.max=sumLiteral+1;
			valueAxis.strictMinMax = true;
			valueAxis.renderer.minGridDistance = 30;
			var axisBreak = valueAxis.axisBreaks.create();

			var d = (axisBreak.endValue - axisBreak.startValue) / (valueAxis.max - valueAxis.min);
			axisBreak.breakSize = 0.05 * (1 - d) / d;

			var hoverState = axisBreak.states.create("hover");
			hoverState.properties.breakSize = 1;
			hoverState.properties.opacity = 0.1;
			hoverState.transitionDuration = 1500;

			axisBreak.defaultState.transitionDuration = 1000;

			var series = chart.series.push(new am4charts.ColumnSeries());
			series.dataFields.categoryX = "example";
			series.dataFields.valueY = "literal";
			series.columns.template.tooltipText = "{valueY.value}";
			series.columns.template.tooltipY = 0;
			series.columns.template.strokeOpacity = 0;
			
			series.columns.template.adapter.add("fill", function(fill, target) {
			return chart.colors.getIndex(target.dataItem.index);
			});
		}); // end am4core.ready()
	};//fn_ScoreChart end
	
	/* Ranking Chart */
	function drawRankingChart(scriptRankingList){
		html="";
		var sumCnt = 0;
		
		for(var i=0; i<scriptRankingList.length; i++){
			html += '<tr class="scriptRank">';
			html += '	<td>'+scriptRankingList[i].rank+'</td>';
			html += '	<td class="scriptContentTitle">'+scriptRankingList[i].scriptContent+'</td>';
			html += '	<td>'+scriptRankingList[i].totCnt+'</td>';
			html += '</tr>';
			
			sumCnt += scriptRankingList[i].totCnt;
		}
		html += '<tr id="sumCnt">'
		html += '	<td>합  계</td>';
		html += '	<td></td>'
		html += '	<td>'+sumCnt+'</td>';
		html += '</tr>'
		
		$('#rankingList').empty();
		$('#rankingList').append(html);
	}; //fn_drawRankingChart 종료
	
}); //ready function 종료
</script>
</head>

<body>
	<h1>스크립트 통계</h1>
	<div class="scriptGbStatistics">
		<div class="contentBox">
			<ul class="nav nav-tabs">
				<c:forEach items="${scriptGbList }" var="scriptGb">
				    <li>
				    	<a class="scriptGbTab" value="${scriptGb.scriptGbSq }">${scriptGb.scriptGbContent }</a>
				    </li>
				</c:forEach>
			</ul>
			<br>
					
			<div id="Menu" class="tab-pane fade in active">
		    <div class="conditionmenu">
		    	기간 : <input id="start" type="date" value=""> ~ <input id="end" type="date" value="">
		    		<img id="selectBtn" alt="" src="/images/searchBtn.png" style="width:25px;height:25px; display: inline-block; position: relative; top: 4px; left:5px;">
		    </div>
			</div>
		</div>
		
		<div class="tab-content">
			<div class="contentBox">
				<div class="tab-pane fade content in active">
					<div class="tabContent">
				  		<table class="contentList">
					  		<tr class="title">
					  			<th class="rn">순위</th>
					  			<th class="scriptContentTitle">스크립트</th>
					  			<th>테스트 횟수</th>
					  		</tr>
					  		<tbody id="rankingList">
					  		</tbody>
						</table>
					</div>	
					<div id="scoreChart" class="content chart">
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>