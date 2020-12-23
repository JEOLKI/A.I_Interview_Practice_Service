<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<%@ include file="/WEB-INF/views/layout/commonLib.jsp" %>
<title>AI_INTERVIEW</title>

<script>
/* yyyyMMdd 포맷으로 반환  */
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
 	
 	#contentBox{
   		display: table; 
 	}
 	
 	.tabContent{
 		width : 51%;
  		height : 100px; 
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
 		width : 70%;
 	}

 	#rankingList{
 		position: absolute;
 		width : 33%;
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
	
	//최초 노출 score chart
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
	
	//최초 노출 ranking table
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
		
		var stackDataset=[];
		var dataset = [];
		console.log
		for(var i in scriptScoreList){
// 			console.log("scriptScoreList[i]"+scriptScoreList[i].scriptTestScore);
				var radius;
				if(scriptScoreList[i].scriptTestScore=="100"){
					var x = 10; var y = 10; radius = 10;
					
					for(var j in dataset){
					console.log("100 - dataset[j] : "+dataset[j].data);
						if(scriptScoreList[i].scriptTestScore == JSON.stringify(dataset[j])){
							radius += 5;
						}
					}
					dataset.push({x:x, y:y, r:radius});
				}else{
					radius = 10;
					var x = scriptScoreList[i].scriptTestScore.charAt(0);
					var y = scriptScoreList[i].scriptTestScore.charAt(1);
					
					for(var j in dataset){
						console.log("100 - dataset[j] : "+dataset[j].data);
						if(scriptScoreList[i].scriptTestScore == JSON.stringify(dataset[j])){
							radius += 5;
						}
					}
					dataset.push({x:x, y:y, r:radius});
				}
		}// i - for 종료
		
		function dynamicColors(){
		        var r = Math.floor(Math.random() * 255);
		        var g = Math.floor(Math.random() * 255);
		        var b = Math.floor(Math.random() * 255);
		        return "rgba(" + r + "," + g + "," + b + ", 0.2)";
		};
		
		var colorChart = dynamicColors();
		var bubbleData = {datasets :
							[{	label : "점수 분포",
							    backgroundColor: colorChart,
							    data: dataset
						  	}]
						 }; //bubbleData exit
	
		var ctx = document.getElementById('scoreChartCanvas').getContext('2d');
		var scoreChart 	= new Chart(ctx, {
				  showTooltips : true,
				  type  	: 'bubble',
				  data		: bubbleData,
				  options	: {
		      		responsive	: true,
				  	scales 		: { xAxes	: [{
							                display		: true,
							                ticks		: { display  : true,
							                				autoSkip : false,
															beginAtZero : true,
							                				maxTicksLimit: 11,
											                max: 10,
											                stepSize: 1 }}],
						            yAxes	: [{
							            	display		: true,
							                ticks 		: { display  : true,
							                				autoSkip : false,
															beginAtZero : true,
							                				maxTicksLimit: 11,
										                    max: 10,
										                    stepSize: 1 }}]
								}//scales종료
				  }//option exit
		}); //scoreChart exit
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
			<div id="contentBox" class="contentBox">
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
						<canvas id="scoreChartCanvas"></canvas>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>