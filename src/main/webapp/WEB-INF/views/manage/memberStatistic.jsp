<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<script src="https://cdn.amcharts.com/lib/4/core.js"></script>
<script src="https://cdn.amcharts.com/lib/4/charts.js"></script>
<script src="https://cdn.amcharts.com/lib/4/themes/kelly.js"></script>
<script src="https://cdn.amcharts.com/lib/4/themes/animated.js"></script>

<%@ include file="/WEB-INF/views/layout/commonLib.jsp" %>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="/css/bootstrap.min.css?v=2">
<style>
	body{
      background-color : #f5f7fb;
      padding: 30px;
      font-family: "Noto Sans KR",sans-serif;
	  font-size: 16px;
	  color: #000d22;
   }
	#search{
		display: inline-block; 
	}
	a{
		color: black;
	}
	a:hover{
		text-decoration: none;
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
	.educationList, .majorList, .careerList, .genderList, .searchJobDateList{
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
	#registBtn, .updateBtn, #talentUpdateBtn, .deleteBtn, #searchBtn {
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
	
	#registBtn:hover, #saleSearchBtn:hover, #useSearchBtn:hover,.updateBtn:hover, #talentUpdateBtn:hover, .deleteBtn:hover{
	    background-color: #000d22;
	    color: #fff;
	}
	.excelBtn{
		display: inline-block;
		border: 1px solid #000d22;
		border-radius: 5px;
		padding:0px 5px;
	}
	.excelBtn:hover{
	    background-color: #22741C;
	    border: 1px solid #22741C;
	    color: #fff;
	}
	.fade{
		margin-bottom : 60px;
	}
</style>
<script>

$(document).ready(function(){
	$('#education').css('display', 'none');
	$('#searchJobDate').css('display', 'none');
	$('#career').css('display', 'none');
	$('#gender').css('display', 'none');
	// 첫페이지(전공별)
	$.ajax({ url : "/member/majorStatistic.do", 
		 dataType : "json",
		 success : function(data){
			 $('#education').css('display', 'none');
			 $('#gender').css('display', 'none');
			 $('#career').css('display', 'none');
			 $('#searchJobdate').css('display', 'none');
			 html="";
		
			 // Themes begin
			am4core.useTheme(am4themes_kelly);
			am4core.useTheme(am4themes_animated);
			// Themes end
			
				 
			 var chart = am4core.create("majorChart", am4charts.XYChart);
				chart.hiddenState.properties.opacity = 0; // this creates initial fade-in
				chart.logo.disabled = true;
				
		    var sum = 0;
			var chartData2 = [];
			var major = "";
			var majorCount =0;
			for(var i=0; i< data.memberMajorList.length; i++){
				major = data.memberMajorList[i].memMajor;
				majorCount = Number.parseInt(data.memberMajorList[i].count);
				
			    chartData2.push({major:major, majorCount: majorCount}); 
					
				 html += '<tr class="major">';
				 html += '<td>'+(i+1)+'</td>';
				 html += '<td class="majorNm">'+major+'</td>';
				 html += '<td class="majorCount" value="'+majorCount+'">'+numberWithCommas(majorCount)+'</td>';
				 html += '</tr>';
				 
				 sum +=majorCount;
			 }
			 html += '<tr id="sum">';
			 html += '<td>합  계</td>';
			 html += '<td></td>';
			 html += '<td id="sumCount" value="'+sum+'">'+numberWithCommas(sum)+'</td>';
			 $('#majorList').empty();
			 $('#majorList').append(html);
			chartData2.push({major:"Total", majorCount:sum})
			chart.data =  chartData2;

			var categoryAxis = chart.xAxes.push(new am4charts.CategoryAxis());
			categoryAxis.renderer.grid.template.location = 0;
			categoryAxis.dataFields.category = "major";
			categoryAxis.renderer.minGridDistance = 40;
			categoryAxis.fontSize = 11;

			var valueAxis = chart.yAxes.push(new am4charts.ValueAxis());
			valueAxis.min = 0;
			valueAxis.max = sum+1;
			valueAxis.strictMinMax = true;
			valueAxis.renderer.minGridDistance = 30;
			// axis break
			var axisBreak = valueAxis.axisBreaks.create();

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
			series.dataFields.categoryX = "major";
			series.dataFields.valueY = "majorCount";
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

	// 학력별 이용자 수
	$('#educationTab' ).on('click', function() {
		$.ajax({ url : "/member/educationStatistic.do", 
			dataType : "json",
			 success : function(data){
				 $('#major').css('display', 'none');
				 $('#gender').css('display', 'none');
				 $('#career').css('display', 'none');
				 $('#searchJobdate').css('display', 'none');
				 html="";
			
				 // Themes begin
				am4core.useTheme(am4themes_kelly);
				am4core.useTheme(am4themes_animated);
				// Themes end
				
					 
				 var chart = am4core.create("educationChart", am4charts.XYChart);
					chart.hiddenState.properties.opacity = 0; // this creates initial fade-in
					chart.logo.disabled = true;
					
			    var sum = 0;
				var chartData2 = [];
				var education = "";
				var educationCount =0;
				for(var i=0; i< data.memberEducationList.length; i++){
					education = data.memberEducationList[i].memEduc;
					educationCount = Number.parseInt(data.memberEducationList[i].count);
				    chartData2.push({education : education, educationCount : educationCount}); 
						
					 html += '<tr class="education">';
					 html += '<td>'+(i+1)+'</td>';
					 html += '<td class="educationNm">'+education+'</td>';
					 html += '<td class="educationCount" value="'+educationCount+'">'+numberWithCommas(educationCount)+'</td>';
					 html += '</tr>';
					 
					 sum +=educationCount;
				 }
				 html += '<tr id="sum">';
				 html += '<td>합  계</td>';
				 html += '<td></td>';
				 html += '<td id="sumCount" value="'+sum+'">'+numberWithCommas(sum)+'</td>';
				 $('#educationList').empty();
				 $('#educationList').append(html);
				chartData2.push({education:"Total", educationCount:sum})
				chart.data =  chartData2;

				var categoryAxis = chart.xAxes.push(new am4charts.CategoryAxis());
				categoryAxis.renderer.grid.template.location = 0;
				categoryAxis.dataFields.category = "education";
				categoryAxis.renderer.minGridDistance = 40;
				categoryAxis.fontSize = 11;

				var valueAxis = chart.yAxes.push(new am4charts.ValueAxis());
				valueAxis.min = 0;
				valueAxis.max = sum+1;
				valueAxis.strictMinMax = true;
				valueAxis.renderer.minGridDistance = 30;
				// axis break
				var axisBreak = valueAxis.axisBreaks.create();

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
				series.dataFields.categoryX = "education";
				series.dataFields.valueY = "educationCount";
				series.columns.template.tooltipText = "{valueY.value}";
				series.columns.template.tooltipY = 0;
				series.columns.template.strokeOpacity = 0;

				// as by default columns of the same series are of the same color, we add adapter which takes colors from chart.colors color set
				series.columns.template.adapter.add("fill", function(fill, target) {
				  return chart.colors.getIndex(target.dataItem.index);
				// end am4core.ready()
				});
			}	 
		});
	});
	
	// 구직시작기간별 이용자 수
	$('#searchJobDateTab' ).on('click', function() {
		$.ajax({ url : "/member/searchJobDateStatistic.do", 
			dataType : "json",
			 success : function(data){
				 $('#major').css('display', 'none');
				 $('#gender').css('display', 'none');
				 $('#career').css('display', 'none');
				 $('#education').css('display', 'none');
				 html="";
			
				 // Themes begin
				am4core.useTheme(am4themes_kelly);
				am4core.useTheme(am4themes_animated);
				// Themes end
				
					 
				 var chart = am4core.create("searchJobDateChart", am4charts.XYChart);
					chart.hiddenState.properties.opacity = 0; // this creates initial fade-in
					chart.logo.disabled = true;
					
			    var sum = 0;
				var chartData2 = [];
				var searchJobDate = "";
				var searchJobDateCount =0;
				for(var i=0; i< data.membersearchJobDateList.length; i++){
					searchJobDate = data.membersearchJobDateList[i].searchJobDate;
					searchJobDateCount = Number.parseInt(data.membersearchJobDateList[i].count);
				    chartData2.push({searchJobDate : searchJobDate, searchJobDateCount : searchJobDateCount}); 
						
					 html += '<tr class="searchJobDate">';
					 html += '<td>'+(i+1)+'</td>';
					 html += '<td class="searchJobDateNm">'+searchJobDate+'</td>';
					 html += '<td class="searchJobDateCount" value="'+searchJobDateCount+'">'+numberWithCommas(searchJobDateCount)+'</td>';
					 html += '</tr>';
					 
					 sum +=searchJobDateCount;
				 }
				 html += '<tr id="sum">';
				 html += '<td>합  계</td>';
				 html += '<td></td>';
				 html += '<td id="sumCount" value="'+sum+'">'+numberWithCommas(sum)+'</td>';
				 $('#searchJobDateList').empty();
				 $('#searchJobDateList').append(html);
				chartData2.push({searchJobDate:"Total", searchJobDateCount:sum})
				chart.data =  chartData2;

				var categoryAxis = chart.xAxes.push(new am4charts.CategoryAxis());
				categoryAxis.renderer.grid.template.location = 0;
				categoryAxis.dataFields.category = "searchJobDate";
				categoryAxis.renderer.minGridDistance = 40;
				categoryAxis.fontSize = 11;

				var valueAxis = chart.yAxes.push(new am4charts.ValueAxis());
				valueAxis.min = 0;
				valueAxis.max = sum+1;
				valueAxis.strictMinMax = true;
				valueAxis.renderer.minGridDistance = 30;
				// axis break
				var axisBreak = valueAxis.axisBreaks.create();

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
				series.dataFields.categoryX = "searchJobDate";
				series.dataFields.valueY = "searchJobDateCount";
				series.columns.template.tooltipText = "{valueY.value}";
				series.columns.template.tooltipY = 0;
				series.columns.template.strokeOpacity = 0;

				// as by default columns of the same series are of the same color, we add adapter which takes colors from chart.colors color set
				series.columns.template.adapter.add("fill", function(fill, target) {
				  return chart.colors.getIndex(target.dataItem.index);
				// end am4core.ready()
				});
			}	 
		});
	});
	
	// 경력별 이용자 수
	$('#careerTab' ).on('click', function() {
		$.ajax({ url : "/member/careerStatistic.do", 
			dataType : "json",
			 success : function(data){
				 $('#major').css('display', 'none');
				 $('#gender').css('display', 'none');
				 $('#searchJobDate').css('display', 'none');
				 $('#education').css('display', 'none');
				 html="";
			
				 // Themes begin
				am4core.useTheme(am4themes_kelly);
				am4core.useTheme(am4themes_animated);
				// Themes end
				
					 
				 var chart = am4core.create("careerChart", am4charts.XYChart);
					chart.hiddenState.properties.opacity = 0; // this creates initial fade-in
					chart.logo.disabled = true;
					
			    var sum = 0;
				var chartData2 = [];
				var career = "";
				var careerCount =0;
				for(var i=0; i< data.memberCareerList.length; i++){
					career = data.memberCareerList[i].memCareer;
					careerCount = Number.parseInt(data.memberCareerList[i].count);
				    chartData2.push({career : career, careerCount : careerCount}); 
						
					 html += '<tr class="career">';
					 html += '<td>'+(i+1)+'</td>';
					 html += '<td class="careerNm">'+career+'</td>';
					 html += '<td class="careerCount" value="'+careerCount+'">'+numberWithCommas(careerCount)+'</td>';
					 html += '</tr>';
					 
					 sum +=careerCount;
				 }
				 html += '<tr id="sum">';
				 html += '<td>합  계</td>';
				 html += '<td></td>';
				 html += '<td id="sumCount" value="'+sum+'">'+numberWithCommas(sum)+'</td>';
				 $('#careerList').empty();
				 $('#careerList').append(html);
				chartData2.push({career:"Total", careerCount : careerCount})
				chart.data =  chartData2;

				var categoryAxis = chart.xAxes.push(new am4charts.CategoryAxis());
				categoryAxis.renderer.grid.template.location = 0;
				categoryAxis.dataFields.category = "career";
				categoryAxis.renderer.minGridDistance = 40;
				categoryAxis.fontSize = 11;

				var valueAxis = chart.yAxes.push(new am4charts.ValueAxis());
				valueAxis.min = 0;
				valueAxis.max = sum+1;
				valueAxis.strictMinMax = true;
				valueAxis.renderer.minGridDistance = 30;
				// axis break
				var axisBreak = valueAxis.axisBreaks.create();

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
				series.dataFields.categoryX = "career";
				series.dataFields.valueY = "careerCount";
				series.columns.template.tooltipText = "{valueY.value}";
				series.columns.template.tooltipY = 0;
				series.columns.template.strokeOpacity = 0;

				// as by default columns of the same series are of the same color, we add adapter which takes colors from chart.colors color set
				series.columns.template.adapter.add("fill", function(fill, target) {
				  return chart.colors.getIndex(target.dataItem.index);
				// end am4core.ready()
				});
			}	 
		});
	});
	
	// 성별 이용자 수
	$('#genderTab' ).on('click', function() {
		$.ajax({ url : "/member/genderStatistic.do", 
			dataType : "json",
			 success : function(data){
				 $('#major').css('display', 'none');
				 $('#career').css('display', 'none');
				 $('#searchJobDate').css('display', 'none');
				 $('#education').css('display', 'none');
				 html="";
			
				 // Themes begin
				am4core.useTheme(am4themes_kelly);
				am4core.useTheme(am4themes_animated);
				// Themes end
				
					 
				 var chart = am4core.create("genderChart", am4charts.XYChart);
					chart.hiddenState.properties.opacity = 0; // this creates initial fade-in
					chart.logo.disabled = true;
					
			    var sum = 0;
				var chartData2 = [];
				var gender = "";
				var genderCount =0;
				for(var i=0; i< data.memberGenderList.length; i++){
					gender = data.memberGenderList[i].memGender;
					genderCount = Number.parseInt(data.memberGenderList[i].count);
				    chartData2.push({gender : gender, genderCount : genderCount}); 
						
					 html += '<tr class="gender">';
					 html += '<td>'+(i+1)+'</td>';
					 html += '<td class="genderNm">'+gender+'</td>';
					 html += '<td class="genderCount" value="'+genderCount+'">'+numberWithCommas(genderCount)+'</td>';
					 html += '</tr>';
					 
					 sum +=genderCount;
				 }
				 html += '<tr id="sum">';
				 html += '<td>합  계</td>';
				 html += '<td></td>';
				 html += '<td id="sumCount" value="'+sum+'">'+numberWithCommas(sum)+'</td>';
				 $('#genderList').empty();
				 $('#genderList').append(html);
				chartData2.push({gender:"Total", genderCount : genderCount})
				chart.data =  chartData2;

				var categoryAxis = chart.xAxes.push(new am4charts.CategoryAxis());
				categoryAxis.renderer.grid.template.location = 0;
				categoryAxis.dataFields.category = "gender";
				categoryAxis.renderer.minGridDistance = 40;
				categoryAxis.fontSize = 11;

				var valueAxis = chart.yAxes.push(new am4charts.ValueAxis());
				valueAxis.min = 0;
				valueAxis.max = sum+1;
				valueAxis.strictMinMax = true;
				valueAxis.renderer.minGridDistance = 30;
				// axis break
				var axisBreak = valueAxis.axisBreaks.create();

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
				series.dataFields.categoryX = "gender";
				series.dataFields.valueY = "genderCount";
				series.columns.template.tooltipText = "{valueY.value}";
				series.columns.template.tooltipY = 0;
				series.columns.template.strokeOpacity = 0;

				// as by default columns of the same series are of the same color, we add adapter which takes colors from chart.colors color set
				series.columns.template.adapter.add("fill", function(fill, target) {
				  return chart.colors.getIndex(target.dataItem.index);
				// end am4core.ready()
				});
			}	 
		});
	});
	
	// 검색
	$('#searchBtn').on('click',function(){
		if($('#searchKeyword').val()==''){
			alert('검색 키워드를 입력해주세요');
			return false; // 펑션 탈출
		}
		if($("#major").css("display") != "none"){ // major 검색 시
			var searchKeyword = $('#searchKeyword').val();
			
			$.ajax({ url : "/member/majorStatistic.do", 
				 data : {
					 	 "searchKeyword" :searchKeyword},
				 dataType : "json",
				 success : function(data){
				 $('#education').css('display', 'none');
				 $('#gender').css('display', 'none');
				 $('#career').css('display', 'none');
				 $('#searchJobdate').css('display', 'none');
				 html="";
			
				 // Themes begin
				am4core.useTheme(am4themes_kelly);
				am4core.useTheme(am4themes_animated);
				// Themes end
				
					 
				 var chart = am4core.create("majorChart", am4charts.XYChart);
					chart.hiddenState.properties.opacity = 0; // this creates initial fade-in
					chart.logo.disabled = true;
					
			    var sum = 0;
				var chartData2 = [];
				var major = "";
				var majorCount =0;
				for(var i=0; i< data.memberMajorList.length; i++){
					major = data.memberMajorList[i].memMajor;
					majorCount = Number.parseInt(data.memberMajorList[i].count);
					
				    chartData2.push({major:major, majorCount: majorCount}); 
						
					 html += '<tr class="major">';
					 html += '<td>'+(i+1)+'</td>';
					 html += '<td class="majorNm">'+major+'</td>';
					 html += '<td class="majorCount" value="'+majorCount+'">'+numberWithCommas(majorCount)+'</td>';
					 html += '</tr>';
					 
					 sum +=majorCount;
				 }
				 html += '<tr id="sum">';
				 html += '<td>합  계</td>';
				 html += '<td></td>';
				 html += '<td id="sumCount" value="'+sum+'">'+numberWithCommas(sum)+'</td>';
				 $('#majorList').empty();
				 $('#majorList').append(html);
				chartData2.push({major:"Total", majorCount:sum})
				chart.data =  chartData2;

				var categoryAxis = chart.xAxes.push(new am4charts.CategoryAxis());
				categoryAxis.renderer.grid.template.location = 0;
				categoryAxis.dataFields.category = "major";
				categoryAxis.renderer.minGridDistance = 40;
				categoryAxis.fontSize = 11;

				var valueAxis = chart.yAxes.push(new am4charts.ValueAxis());
				valueAxis.min = 0;
				valueAxis.max = sum+1;
				valueAxis.strictMinMax = true;
				valueAxis.renderer.minGridDistance = 30;
				// axis break
				var axisBreak = valueAxis.axisBreaks.create();

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
				series.dataFields.categoryX = "major";
				series.dataFields.valueY = "majorCount";
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
	}else if($("#education").css("display") != "none"){ // education 검색 시
		var searchKeyword = $('#searchKeyword').val();

		$.ajax({ url : "/member/educationStatistic.do", 
			dataType : "json",
			data : {
			 	 "searchKeyword" :searchKeyword},
			 success : function(data){
				 $('#major').css('display', 'none');
				 $('#gender').css('display', 'none');
				 $('#career').css('display', 'none');
				 $('#searchJobdate').css('display', 'none');
				 html="";
			
				 // Themes begin
				am4core.useTheme(am4themes_kelly);
				am4core.useTheme(am4themes_animated);
				// Themes end
				
					 
				 var chart = am4core.create("educationChart", am4charts.XYChart);
					chart.hiddenState.properties.opacity = 0; // this creates initial fade-in
					chart.logo.disabled = true;
					
			    var sum = 0;
				var chartData2 = [];
				var education = "";
				var educationCount =0;
				for(var i=0; i< data.memberEducationList.length; i++){
					education = data.memberEducationList[i].memEduc;
					educationCount = Number.parseInt(data.memberEducationList[i].count);
				    chartData2.push({education : education, educationCount : educationCount}); 
						
					 html += '<tr class="education">';
					 html += '<td>'+(i+1)+'</td>';
					 html += '<td class="educationNm">'+education+'</td>';
					 html += '<td class="educationCount" value="'+educationCount+'">'+numberWithCommas(educationCount)+'</td>';
					 html += '</tr>';
					 
					 sum +=educationCount;
				 }
				 html += '<tr id="sum">';
				 html += '<td>합  계</td>';
				 html += '<td></td>';
				 html += '<td id="sumCount" value="'+sum+'">'+numberWithCommas(sum)+'</td>';
				 $('#educationList').empty();
				 $('#educationList').append(html);
				chartData2.push({education:"Total", educationCount:sum})
				chart.data =  chartData2;

				var categoryAxis = chart.xAxes.push(new am4charts.CategoryAxis());
				categoryAxis.renderer.grid.template.location = 0;
				categoryAxis.dataFields.category = "education";
				categoryAxis.renderer.minGridDistance = 40;
				categoryAxis.fontSize = 11;

				var valueAxis = chart.yAxes.push(new am4charts.ValueAxis());
				valueAxis.min = 0;
				valueAxis.max = sum+1;
				valueAxis.strictMinMax = true;
				valueAxis.renderer.minGridDistance = 30;
				// axis break
				var axisBreak = valueAxis.axisBreaks.create();

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
				series.dataFields.categoryX = "education";
				series.dataFields.valueY = "educationCount";
				series.columns.template.tooltipText = "{valueY.value}";
				series.columns.template.tooltipY = 0;
				series.columns.template.strokeOpacity = 0;

				// as by default columns of the same series are of the same color, we add adapter which takes colors from chart.colors color set
				series.columns.template.adapter.add("fill", function(fill, target) {
				  return chart.colors.getIndex(target.dataItem.index);
				// end am4core.ready()
				});
			}	 
		});
	}else if($("#searchJobDate").css("display") != "none"){ // searchJobDate 검색 시
		var searchKeyword = $('#searchKeyword').val();
		
		$.ajax({ url : "/member/searchJobDateStatistic.do", 
			dataType : "json",
			data : {
			 	 "searchKeyword" :searchKeyword},
			 success : function(data){
				 $('#major').css('display', 'none');
				 $('#gender').css('display', 'none');
				 $('#career').css('display', 'none');
				 $('#education').css('display', 'none');
				 html="";
			
				 // Themes begin
				am4core.useTheme(am4themes_kelly);
				am4core.useTheme(am4themes_animated);
				// Themes end
				
					 
				 var chart = am4core.create("searchJobDateChart", am4charts.XYChart);
					chart.hiddenState.properties.opacity = 0; // this creates initial fade-in
					chart.logo.disabled = true;
					
			    var sum = 0;
				var chartData2 = [];
				var searchJobDate = "";
				var searchJobDateCount =0;
				for(var i=0; i< data.membersearchJobDateList.length; i++){
					searchJobDate = data.membersearchJobDateList[i].searchJobDate;
					searchJobDateCount = Number.parseInt(data.membersearchJobDateList[i].count);
				    chartData2.push({searchJobDate : searchJobDate, searchJobDateCount : searchJobDateCount}); 
						
					 html += '<tr class="searchJobDate">';
					 html += '<td>'+(i+1)+'</td>';
					 html += '<td class="searchJobDateNm">'+searchJobDate+'</td>';
					 html += '<td class="searchJobDateCount" value="'+searchJobDateCount+'">'+numberWithCommas(searchJobDateCount)+'</td>';
					 html += '</tr>';
					 
					 sum +=searchJobDateCount;
				 }
				 html += '<tr id="sum">';
				 html += '<td>합  계</td>';
				 html += '<td></td>';
				 html += '<td id="sumCount" value="'+sum+'">'+numberWithCommas(sum)+'</td>';
				 $('#searchJobDateList').empty();
				 $('#searchJobDateList').append(html);
				chartData2.push({searchJobDate:"Total", searchJobDateCount:sum})
				chart.data =  chartData2;

				var categoryAxis = chart.xAxes.push(new am4charts.CategoryAxis());
				categoryAxis.renderer.grid.template.location = 0;
				categoryAxis.dataFields.category = "searchJobDate";
				categoryAxis.renderer.minGridDistance = 40;
				categoryAxis.fontSize = 11;

				var valueAxis = chart.yAxes.push(new am4charts.ValueAxis());
				valueAxis.min = 0;
				valueAxis.max = sum+1;
				valueAxis.strictMinMax = true;
				valueAxis.renderer.minGridDistance = 30;
				// axis break
				var axisBreak = valueAxis.axisBreaks.create();

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
				series.dataFields.categoryX = "searchJobDate";
				series.dataFields.valueY = "searchJobDateCount";
				series.columns.template.tooltipText = "{valueY.value}";
				series.columns.template.tooltipY = 0;
				series.columns.template.strokeOpacity = 0;

				// as by default columns of the same series are of the same color, we add adapter which takes colors from chart.colors color set
				series.columns.template.adapter.add("fill", function(fill, target) {
				  return chart.colors.getIndex(target.dataItem.index);
				// end am4core.ready()
				});
			}	 
		});
		
	}else if($("#career").css("display") != "none"){ // career 검색 시
		var searchKeyword = $('#searchKeyword').val();
	
		$.ajax({ url : "/member/careerStatistic.do", 
			dataType : "json",
			data : {
			 	 "searchKeyword" :searchKeyword},
			 success : function(data){
				 $('#major').css('display', 'none');
				 $('#gender').css('display', 'none');
				 $('#searchJobDate').css('display', 'none');
				 $('#education').css('display', 'none');
				 html="";
			
				 // Themes begin
				am4core.useTheme(am4themes_kelly);
				am4core.useTheme(am4themes_animated);
				// Themes end
				
					 
				 var chart = am4core.create("careerChart", am4charts.XYChart);
					chart.hiddenState.properties.opacity = 0; // this creates initial fade-in
					chart.logo.disabled = true;
					
			    var sum = 0;
				var chartData2 = [];
				var career = "";
				var careerCount =0;
				for(var i=0; i< data.memberCareerList.length; i++){
					career = data.memberCareerList[i].memCareer;
					careerCount = Number.parseInt(data.memberCareerList[i].count);
				    chartData2.push({career : career, careerCount : careerCount}); 
						
					 html += '<tr class="career">';
					 html += '<td>'+(i+1)+'</td>';
					 html += '<td class="careerNm">'+career+'</td>';
					 html += '<td class="careerCount" value="'+careerCount+'">'+numberWithCommas(careerCount)+'</td>';
					 html += '</tr>';
					 
					 sum +=careerCount;
				 }
				 html += '<tr id="sum">';
				 html += '<td>합  계</td>';
				 html += '<td></td>';
				 html += '<td id="sumCount" value="'+sum+'">'+numberWithCommas(sum)+'</td>';
				 $('#careerList').empty();
				 $('#careerList').append(html);
				chartData2.push({career:"Total", careerCount : careerCount})
				chart.data =  chartData2;

				var categoryAxis = chart.xAxes.push(new am4charts.CategoryAxis());
				categoryAxis.renderer.grid.template.location = 0;
				categoryAxis.dataFields.category = "career";
				categoryAxis.renderer.minGridDistance = 40;
				categoryAxis.fontSize = 11;

				var valueAxis = chart.yAxes.push(new am4charts.ValueAxis());
				valueAxis.min = 0;
				valueAxis.max = sum+1;
				valueAxis.strictMinMax = true;
				valueAxis.renderer.minGridDistance = 30;
				// axis break
				var axisBreak = valueAxis.axisBreaks.create();

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
				series.dataFields.categoryX = "career";
				series.dataFields.valueY = "careerCount";
				series.columns.template.tooltipText = "{valueY.value}";
				series.columns.template.tooltipY = 0;
				series.columns.template.strokeOpacity = 0;

				// as by default columns of the same series are of the same color, we add adapter which takes colors from chart.colors color set
				series.columns.template.adapter.add("fill", function(fill, target) {
				  return chart.colors.getIndex(target.dataItem.index);
				// end am4core.ready()
				});
			}	 
		});
	}else if($("#gender").css("display") != "none"){ // gender 검색 시
		var searchKeyword = $('#searchKeyword').val();
		
		$.ajax({ url : "/member/genderStatistic.do", 
			dataType : "json",
			data : {
			 	 "searchKeyword" :searchKeyword},
			 success : function(data){
				 $('#major').css('display', 'none');
				 $('#career').css('display', 'none');
				 $('#searchJobDate').css('display', 'none');
				 $('#education').css('display', 'none');
				 html="";
			
				 // Themes begin
				am4core.useTheme(am4themes_kelly);
				am4core.useTheme(am4themes_animated);
				// Themes end
				
					 
				 var chart = am4core.create("genderChart", am4charts.XYChart);
					chart.hiddenState.properties.opacity = 0; // this creates initial fade-in
					chart.logo.disabled = true;
					
			    var sum = 0;
				var chartData2 = [];
				var gender = "";
				var genderCount =0;
				for(var i=0; i< data.memberGenderList.length; i++){
					gender = data.memberGenderList[i].memGender;
					genderCount = Number.parseInt(data.memberGenderList[i].count);
				    chartData2.push({gender : gender, genderCount : genderCount}); 
						
					 html += '<tr class="gender">';
					 html += '<td>'+(i+1)+'</td>';
					 html += '<td class="genderNm">'+gender+'</td>';
					 html += '<td class="genderCount" value="'+genderCount+'">'+numberWithCommas(genderCount)+'</td>';
					 html += '</tr>';
					 
					 sum +=genderCount;
				 }
				 html += '<tr id="sum">';
				 html += '<td>합  계</td>';
				 html += '<td></td>';
				 html += '<td id="sumCount" value="'+sum+'">'+numberWithCommas(sum)+'</td>';
				 $('#genderList').empty();
				 $('#genderList').append(html);
				chartData2.push({gender:"Total", genderCount : genderCount})
				chart.data =  chartData2;

				var categoryAxis = chart.xAxes.push(new am4charts.CategoryAxis());
				categoryAxis.renderer.grid.template.location = 0;
				categoryAxis.dataFields.category = "gender";
				categoryAxis.renderer.minGridDistance = 40;
				categoryAxis.fontSize = 11;

				var valueAxis = chart.yAxes.push(new am4charts.ValueAxis());
				valueAxis.min = 0;
				valueAxis.max = sum+1;
				valueAxis.strictMinMax = true;
				valueAxis.renderer.minGridDistance = 30;
				// axis break
				var axisBreak = valueAxis.axisBreaks.create();

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
				series.dataFields.categoryX = "gender";
				series.dataFields.valueY = "genderCount";
				series.columns.template.tooltipText = "{valueY.value}";
				series.columns.template.tooltipY = 0;
				series.columns.template.strokeOpacity = 0;

				// as by default columns of the same series are of the same color, we add adapter which takes colors from chart.colors color set
				series.columns.template.adapter.add("fill", function(fill, target) {
				  return chart.colors.getIndex(target.dataItem.index);
				// end am4core.ready()
				});
			}	 
		});
	}
})


	$('.nav-tabs>li>a').on('click', function(){
		target = $(this).data("target");
		$('.content').removeClass('in');
		$('.content').removeClass('active');
		if(target == 'major'){
			$('#major').addClass('in');
			$('#major').addClass('active');
			$('#major').css('display', '');
			
		} else if(target == 'education'){
			$('#education').addClass('in');
			$('#education').addClass('active');
			$('#education').css('display', '');
			
		} else if(target == 'searchJobDate'){
			$('#searchJobDate').addClass('in');
			$('#searchJobDate').addClass('active');
			$('#searchJobDate').css('display', '');
			
		} else if(target == 'career'){
			$('#career').addClass('in');
			$('#career').addClass('active');
			$('#career').css('display', '');
			
		} else if(target == 'gender'){
			$('#gender').addClass('in');
			$('#gender').addClass('active');
			$('#gender').css('display', '');
			
		}
	})

})
function numberWithCommas(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}


</script>
</head>
<body>
	<h1>회원 통계</h1>
		<form:form commandName="memberVO" id="listForm" name="listForm" method="post">
			<div class="planStatistics">
				<div class="contentBox">
					<ul class="nav nav-tabs">
					    <li class="active"><a id="majorTab" data-target="major" data-toggle="tab" href="#sale">전공</a></li>
					    <li><a id="educationTab" data-target="education" data-toggle="tab" href="#sale">학력</a></li>
					    <li><a id="searchJobDateTab" data-target="searchJobDate" data-toggle="tab" href="#use">구직시작시기</a></li>
					    <li><a id="careerTab" data-target="career" data-toggle="tab" href="#sale">경력</a></li>
					    <li><a id="genderTab" data-target="gender" data-toggle="tab" href="#sale">성별</a></li>
					</ul>
					<br><br>
				 <div class="tab-pane fade in active">
				    <div class="listmenu">
						<div id="search">
							<input type="text" id="searchKeyword" >
							<span id="searchBtn">검색</span>
						</div>
				    </div>
				 </div>
				<div class="tab-content">
					 <!-- 전공별 탭 -->
					  <div id="major" class="tab-pane fade content in active">
					    <div class="major">
						  	<table class="majorList">
						  		<tr class="title">
						  			<th></th>
						  			<th>전공</th>
						  			<th>회원 수</th>
						  		</tr>
						  		<tbody id="majorList">
						  		</tbody>
						  	</table>
						  </div>	
						<div id="majorChart" class="major chart"></div>
					</div>
					
					<!-- 학력별 탭 -->
					 <div id="education" class="tab-pane fade content">
					  <div class="education">
					  	<table class="educationList">
						  	<tr class="title">
					  			<th></th>
					  			<th>학력</th>
					  			<th>회원 수</th>
						  	</tr>
						  	<tbody id="educationList">
						  	</tbody>
						</table>
					  </div>
					  <div id="educationChart" class="education chart"></div>
					</div>
					
					<!-- 구직시작시기별 탭 -->
					 <div id="searchJobDate" class="tab-pane fade content">
					  <div class="searchJobDate">
					  	<table class="searchJobDateList">
						  	<tr class="title">
						  			<th></th>
						  			<th>시기</th>
						  			<th>회원 수</th>
						  	</tr>
						  	<tbody id="searchJobDateList">
						  	</tbody>
						</table>
					  </div>
					  <div id="searchJobDateChart" class="searchJobDate chart"></div>
					</div>
					
					<!-- 경력별 탭 -->
					 <div id="career" class="tab-pane fade content">
					  <div class="career">
					  	<table class="careerList">
						  	<tr class="title">
						  			<th></th>
						  			<th>경력</th>
						  			<th>회원 수</th>
						  	</tr>
						  	<tbody id="careerList">
						  	</tbody>
						</table>
					  </div>
					  <div id="careerChart" class="career chart"></div>
					</div>
					
					<!-- 성별 탭 -->
					 <div id="gender" class="tab-pane fade content">
					  <div class="gender">
					  	<table class="genderList">
						  	<tr class="title">
						  			<th></th>
						  			<th>성별</th>
						  			<th>회원 수 </th>
						  	</tr>
						  	<tbody id="genderList">
						  	</tbody>
						</table>
					  </div>
					  <div id="genderChart" class="gender chart"></div>
					</div>
				</div>
			</div>
		</div>
	</form:form>		
</body>
</html>