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
	#RankingChart {
	  width: 50%;
	  height: 400px;
	}
	
	#detailScoreChart{
	 width: 50%;
	 height: 400px;
	}

 	#search{ 
 		display: inline-block; 
 	} 
	
 	#searchBtn{ 
 		display: inline-block; AA
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
	
 	input{ 
 		border-radius: 5px; 
 		border : 1px solid black; 
 	} 
	
 	.scriptGbRankingList{
 		margin-top: 50px;
 	}
 	
 	.scriptContentTitle{
 		width : 50%;
 	}
 	
 	#tabContent{
 		display : inline;
 		float : center;
 	}
</style>

<script>
var startDate;
var endDate;
var scriptGbSq;
var scriptRankingList=[];
var scriptScoreList=[];

$(document).ready(function(){
	startDate = $('#start').val() == ''?  today : $('#start').val();
	endDate = $('#end').val() == ''? today : $('#end').val();
	console.log("startDate : "+startDate);
	console.log("endDate : "+endDate);
	
	// 탭 토글 클릭 시
	$('.scriptGbTab').on('click', function(){
		scriptGbSq = $(this).attr('value');
		
		//랭킹 테이블
	 	$.ajax({url : "/scriptGubun/retrieveRankingList.do", 
				data : {"startDate" : '20201101', //->startDate,
					 	 "endDate" 	 : '20201219', //->endDate,
					 	 "scriptGbSq": scriptGbSq},
				dataType : "json",
				success : function(data){
					scriptRankingList = data.scriptRankingList;
					//console.log("scriptRankingList : "+scriptRankingList);
					drawRankingChart(scriptRankingList);
					}	//sucess 종료	 
		}); //ranking ajax 종료
		
		//score chart
		$.ajax({url : "/scriptGubun/retrieveScoreList.do",
				data : {"startDate" : '20201101', 	//->startDate,
						"endDate" : '20201219', 	//->endDate,
						"scriptGbSq" : scriptGbSq},
				dataType : "json",
				success : function(data){
					scriptScoreList = data.scriptScoreList;
					console.log("scriptScoreList : "+scriptScoreList);
					drawScoreChart(scriptScoreList);
				}//success 종료
		}); //score ajax 종료
	});// tab click 종료
	
	
	/* Score Chart */
	function drawScoreChart(scriptScoreList){
		
		am4core.ready(function() {
			// Themes begin
			am4core.useTheme(am4themes_kelly);
			am4core.useTheme(am4themes_animated);
			// Themes end
				 
			var chart = am4core.create("scoreChart", am4charts.XYChart);
			chart.hiddenState.properties.opacity = 0; // this creates initial fade-in
			
			var chartData = [];
			var scoreList = [0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100];
			var zero=0, one=0, two=0, three=0, four=0, five=0, six=0, seven=0, eight=0, nine=0, ten=0;
			var score;

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
					console.log("ten : " + ten);
				}
			}//for문 종료
//			var cntNumList = [Number(zero), Number(one), Number(two), Number(three), Number(four), Number(five), Number(six), Number(seven), Number(eight), Number(nine), Number(ten)];
			var cntNumList = [zero, one, two, three, four, five, six, seven, eight, nine, ten];
			console.log("cntNumList :"+cntNumList);

			for(var i=0; i<scoreList.length; i++){
				calScore = cntNumList[i];//바 그릴 데이터
				score = scoreList[i]; 	//x축에 찍을 데이터
				
			    chartData.push({calScore:calScore, score:score}); 
			 }
			
			var categoryAxis = chart.xAxes.push(new am4charts.CategoryAxis());
			categoryAxis.renderer.grid.template.location = 0;
			categoryAxis.dataFields.category = "calScore";
			categoryAxis.renderer.minGridDistance = 40;
			categoryAxis.fontSize = 11;

			var valueAxis = chart.yAxes.push(new am4charts.ValueAxis());
			valueAxis.min = 0;
			valueAxis.max = 100;
			valueAxis.strictMinMax = true;
			valueAxis.renderer.minGridDistance = 30;
			// axis break
			var axisBreak = valueAxis.axisBreaks.create();

			// fixed axis break
			var d = (axisBreak.endValue - axisBreak.startValue) / (valueAxis.max - valueAxis.min);
			axisBreak.breakSize = 0.05 * (1 - d) / d; //0.05 means that the break will take 5% of the total value axis height

			// make break expand on hover
			var hoverState = axisBreak.states.create("hover");
			hoverState.properties.breakSize = 1;
			hoverState.properties.opacity = 0.1;
			hoverState.transitionDuration = 1500;

			axisBreak.defaultState.transitionDuration = 1000;

			var series = chart.series.push(new am4charts.ColumnSeries());
			series.dataFields.categoryX = "calScore";
			series.dataFields.valueY = "score";
			series.columns.template.tooltipText = "{valueY.value}";
			series.columns.template.tooltipY = 0;
			series.columns.template.strokeOpacity = 0;

			// as by default columns of the same series are of the same color, we add adapter which takes colors from chart.colors color set
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
		    		<img id="selectBtn" alt="" src="/images/searchBtn.png" style="width:25px;height:25px; display: inline-block; position: relative; top:-5px; left:5px;">
		    </div>
			</div>
		</div>
		
		<div class="tab-content">
			<div class="contentBox">
				<div id="tabContent" class="tab-pane fade content in active">
					<div class="tabContent" style="width:60%">
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
					<div id="scoreChart" class="content chart" style="width:40%">
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>