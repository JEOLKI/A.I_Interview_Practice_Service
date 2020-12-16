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
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
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
	.title th{
		border-bottom: 2px solid black;
	}
	table{
		border-collapse:  collapse;
	}
	td, th{
		width: 250px;
		text-align: center;
	}
	
	tr{
		height: 50px;
	}
	.rn{ 
		width: 50px;
	} 
</style>
</head>
<body>
<form:form commandName="habitAnalysisVO" id="listForm" name="listForm" method="post">
		<h1>습관어 통계</h1>
			<div class="habitStatistics">
				<div class="contentBox">
				    <div class="conditionmenu">
				    	기간 : 
				    	<input id="start" type="date">
				    	~
				    	<input id="end" type="date">
				    		<input type="hidden" id="startDate" name="startDate" >
				    		<input type="hidden" id="endDate" name="endDate" >
				    		<img id="selectBtn" alt="" src="/images/searchBtn.png" style="width:25px;height:25px; display: inline-block; position: relative; top:-5px; left:5px;">
				    </div>
				</div>
					<div class="contentBox">
					    <div class="habit">
					  	<table class="haibtList">
					  		<tr class="title">
					  			<th class="rn"></th>
					  			<th>습관어</th>
					  			<th>사  용</th>
					  		</tr>
					  		<tbody id="habitList">
					  		</tbody>
					  	</table>
					  </div>	
					<div id="habitChart" class="habit chart"></div>
				</div>
			</div>
	</form:form>		
</body>
</html>