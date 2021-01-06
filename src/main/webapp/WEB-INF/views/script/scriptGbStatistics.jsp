<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html5>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="/css/bootstrap.min.css?v=2">
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
      font-family: "Noto Sans KR",sans-serif;
      font-size: 16px;
      color: #000d22;
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

	th .scriptContentTitle, td .scriptContentTitle{
		width : 50%;
	}
	
	th .scriptAvgScore, td .scriptAvgScore, th .scriptTotCnt, td .scriptTotCnt{
		width : 20%;
	}
	
 	table{ 
 		border-collapse: collapse;
 		display : inline-block;
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
  		padding-top : 10%;
  		text-align: center;
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

 	#rankingList{
 		width : 33%;
 	}
 	#alert{
 		margin-top: 20px;
 	}
 	#selectBtn{
 		cursor: pointer;
 	}
</style>

<script>
var scriptGbSq;

$(document).ready(function(){

	var scriptRankingList=[];
	var scriptScoreList=[];
	
	//최초 노출 score chart
	$.ajax({url : "/scriptTest/retrieveScoreList.do",
			data : {"startDate" : '20201002',
					"endDate" : today,
					"scriptGbSq" : scriptGbSq},
			dataType : "json",
			success : function(data){
				scriptScoreList = data.scriptScoreList;
				drawScoreChart(scriptScoreList);
			}//success 종료
	}); //score ajax 종료
	
	//최초 노출 ranking table
 	$.ajax({url : "/scriptTest/retrieveRankingList.do", 
			data : {"startDate" : '20201002',
			 	 	"endDate" 	: today,
			 	 	"scriptGbSq": scriptGbSq},
		dataType : "json",
		success : function(data){
			scriptRankingList = data.scriptRankingList;
			drawRankingChart(scriptRankingList);
			}	//sucess 종료	 
	}); //ranking ajax 종료

	$('.scriptGbTab').on('click', function(){
		$('li').removeClass('active');
	    $(this).parent('li').addClass('active');
		scriptGbSq = $(this).attr('value');
	});
	
	$('#selectBtn').on('click', function(){
		$('#startDate').val($('#start').val());
		$('#endDate').val($('#end').val());
	});
	
	$('#selectBtn, .scriptGbTab').on('click',function(){
		var startDate = $('#startDate').val() == ''? '20201002' : $('#startDate').val();
		var endDate = $('#endDate').val() == ''? today : $('#endDate').val();
	 	//ranking table
		$.ajax({url : "/scriptTest/retrieveRankingList.do", 
				data : {"startDate" : startDate,
					 	 "endDate" 	 : endDate,
					 	 "scriptGbSq": scriptGbSq},
				dataType : "json",
				success : function(data){
					scriptRankingList = data.scriptRankingList;
					
					if(scriptRankingList.length==0){
						$('#rankingList').empty();
						$('#alert').empty();
						
						var html = '<span id="alert" style="color:red; text-align:center; display : inline-block;">해당 기간에 일치하는 결과가 없습니다. 날짜를 재설정해주세요.</span>';
						$('#rankingList').css({"margin":"auto", "text-align":"center"});
						$('.tabContent').append(html);
					}else{
						$('#alert').remove();
						drawRankingChart(scriptRankingList);
					}
					}//sucess 종료	 
		}); //ranking ajax 종료
		
		//score chart
		$.ajax({url : "/scriptTest/retrieveScoreList.do",
				data : {"startDate" : startDate,
						"endDate" : endDate,
						"scriptGbSq" : scriptGbSq},
				dataType : "json",
				success : function(data){
					$('scoreChartCanvas').empty(); //
					scriptScoreList = data.scriptScoreList;
					drawScoreChart(scriptScoreList);
				}//success 종료
		}); //score ajax 종료
	});// searchBtn 종료
	
	/* Ranking Chart */
	function drawRankingChart(scriptRankingList){
		html="";
		var sumCnt = 0;
		
		for(var i=0; i<scriptRankingList.length; i++){
			html += '<tr class="scriptRank">';
			html += '	<td>'+scriptRankingList[i].rank+'</td>';
			html += '	<td class="scriptContentTitle">'+scriptRankingList[i].scriptContent+'</td>';
			html += '	<td class="scriptAvgScore">'+scriptRankingList[i].avgScore+'</td>';
			html += '	<td class="scripptTotCnt">'+scriptRankingList[i].totCnt+'</td>';
			html += '</tr>';
			
			sumCnt += scriptRankingList[i].totCnt;
		}
		html += '<tr id="sumCnt">'
		html += '	<td>합  계</td>';
		html += '	<td></td>'
		html += '	<td></td>'
		html += '	<td>'+sumCnt+'</td>';
		html += '</tr>'
		
		$('#rankingList').empty();
		$('#rankingList').append(html);
	}; //fn_drawRankingChart 종료
	
	/* Score Chart */
	function drawScoreChart(scriptScoreList){
		var sumCnt=0;
		var scoreBoardList = [];
		var totCntList = [];
		var max=0;
		for(i in scriptScoreList){
			var scoreBoard = scriptScoreList[i].scriptTestScore;
			var totCnt = scriptScoreList[i].totCnt;

			sumCnt += scriptScoreList[i].totCnt;
			
			scoreBoardList.push(scoreBoard);
			totCntList.push(totCnt);
			
			if(scriptScoreList[i].totCnt > 0){
				max = scriptScoreList[i].totCnt;	
			}
		}
		
		var barData = {
				labels : scoreBoardList,
				datasets :
			[{	label  : "점수 분포",
				data: totCntList,
			  	backgroundColor: [	'rgba(255, 99, 132, 0.2)',
							        'rgba(54, 162, 235, 0.2)',
							        'rgba(255, 206, 86, 0.2)',
							        'rgba(75, 192, 192, 0.2)',
							        'rgba(153, 102, 255, 0.2)',
							        'rgba(255, 159, 64, 0.2)',
							        'rgba(255, 99, 132, 0.2)',
							        'rgba(54, 162, 235, 0.2)',
							        'rgba(255, 206, 86, 0.2)',
							        'rgba(75, 192, 192, 0.2)',
							        'rgba(153, 102, 255, 0.2)'
			 				 	],
 				borderColor : [	'rgba(255,99,132,1)',
						        'rgba(54, 162, 235, 1)',
						        'rgba(255, 206, 86, 1)',
						        'rgba(75, 192, 192, 1)',
						        'rgba(153, 102, 255, 1)',
						        'rgba(255, 159, 64, 1)',
						        'rgba(255,99,132,1)',
						        'rgba(54, 162, 235, 1)',
						        'rgba(255, 206, 86, 1)',
						        'rgba(75, 192, 192, 1)',
						        'rgba(153, 102, 255, 1)'
			 				],
			   	borderWidth: 1
		  	}]
		 }; //barData exit
		
		var ctx = document.getElementById('scoreChartCanvas').getContext('2d');
		 if(window.bar != undefined)
			 window.bar.destroy();
			 window.bar = new Chart(ctx, {
			   type: "bar",
			   data: barData,
			   options: {
				   legend: {
				        display: false
				    },
				    responsive: true,
				    scales: {
				      xAxes: [{
				        ticks: {
				          maxRotation: 0,
				          minRotation: 0
				        },
				          gridLines: {
				        	display : false,
				         	offsetGridLines: false
				        }
				      },
				      {
				        position: "top",
				        ticks: {
				          maxRotation: 0,
				          minRotation: 0,
				          display :  false,
				          autoSkip : true,
				          max : max+1,
				          stepSize : 1
				        },
				        gridLines: {
				        	display : false,
				         	offsetGridLines: false
				        }
				      }],//xAxes 종료
				      yAxes: [{
				        ticks: {
				          beginAtZero: true,
				          display :  true,
				          autoSkip : true,
				          max : max+1,
				          stepSize : 1
				        }
				      }] //yAxes 종료
				    }
				  }
			});
	}//drawScoreCharat 종료
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
				    	<a class="scriptGbTab" data-toogle="tab" value="${scriptGb.scriptGbSq }">${scriptGb.scriptGbContent }</a>
				    </li>
				</c:forEach>
			</ul>
			<br>
					
			<div id="Menu" class="tab-pane fade in active">
		    <div class="conditionmenu">
		    	기간 : <input id="start" type="date"> ~ <input id="end" type="date">
		    		<input type="hidden" id="startDate" name="startDate" />
					<input type="hidden" id="endDate" name="endDate" />
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
					  			<th class="scriptAvgScore">평균</th>
					  			<th class="scriptTotCnt">횟수</th>
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