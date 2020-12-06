<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.bundle.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js"></script>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<%@ include file="/WEB-INF/views/layout/commonLib.jsp" %>
 <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script>
</script>
<style>
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
	
	#content{
		display: inline-block;
		width: 50%;
		
	}
	tbody td{
		width: 300px;
	}
</style>
<script>
$(document).ready(function(){
	
	$('#questGbRegistBtn').on('click', function() {
		if($('#questGbContent').val()==''){
			var html = '<span style="color:red">**내용을 입력해주세요</span><br><br>';
			$('#check').empty();
			$('#check').append(html);
		}else{
			$('#questGbRegistFrm').submit();
		}
	})
	
		
	$('#massiveCreate').on('click',function(){
		$('input[type="file"]').click();
	})
	
	$('input[type="file"]').on('change',function(){
		$('#massiveForm').submit();
	})
	
	$('#sort').on('change',function(){
		pageUnit = $(this).val();
		document.location="/questGb/retrievePagingList.do?pageUnit="+pageUnit;
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
		var startDate = $('#startDate').val();
		var endDate = $('#endDate').val();
		var sum = 0;
		$.ajax({ url : "/plan/totalStatistics.do", 
				 data : {"startDate" : startDate,
					 	 "endDate" 	 : endDate},
				 dataType : "json",
				 success : function(data){
					 console.log("성공");
					 html="성공";
// 					 for(var i=0; i< data.totalUseList.length; i++){
// 						 var planUse = data.totalUseList[i];
// 						 html += '<tr>';
// 						 html += '<td>'+planUse.rn+'</td>';
// 						 html += '<td id="planNm">'+planUse.planNm+'</td>';
// 						 html += '<td id="useCount">'+planUse.useCount+'</td>';
// 						 html += '</tr>';
						 
// 						 sum += planUse.useCount;
// 					 }
// 					 html += '<hr>';
// 					 html += '<tr>';
// 					 html += '<td>합  계</td>';
// 					 html += '<td></td>';
// 					 html += '<td>'+sum+'</td>';
					 $('#content').append(html);
				 }
			
		})
	})
	
	
	
})
</script>
</head>
<body>
<form:form commandName="planVO" id="listForm" name="listForm" method="post">
		<!-- 헤더 -->
		<div id="root">
			<div class="Main false">
				<%@ include file="/WEB-INF/views/layout/header.jsp"%>
				<%@ include file="/WEB-INF/views/manage/managerleft.jsp"%>
				<div class="w3-container managerbox">
					<div class="body">
						<div class="content__title">
							<h1>요금제 통계</h1>
						</div>
						
						<div class="planStatistics">
							<ul class="nav nav-tabs">
							    <li class="active"><a data-toggle="tab" href="#total">전제</a></li>
							    <li><a data-toggle="tab" href="#menu1">Menu 1</a></li>
							    <li><a data-toggle="tab" href="#menu2">Menu 2</a></li>
							    <li><a data-toggle="tab" href="#menu3">Menu 3</a></li>
							</ul>
							
							<div class="tab-content">
							  <div id="total" class="tab-pane fade in active">
							    <h3>전체</h3>
							    <div class="conditionmenu">
							    	<form id="conditionStatisticsFrm" action="${cp }/plan/totalStatistics.do"> 
							    	기간 : 
							    	<input id="start" type="date">
							    	~
							    	<input id="end" type="date">
							    		<input type="hidden" id="startDate" name="startDate" >
							    		<input type="hidden" id="endDate" name="endDate" >
							    		<img id="searchBtn" alt="" src="/images/searchBtn.png" style="width:25px;height:25px; display: inline-block; position: relative; top:-5px; left:5px;">
							    	</form>
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
										<span onclick="search()">검색</span>
									</div>
							    	<a href="${cp }/plan/list/excelDown.do">↓ 목록 내려받기</a> 
									<span id="massiveCreate">↑ 일괄등록</span>
									<!-- excel file 읽어오기 -->
								    <form id="massiveForm" name="massiveForm" enctype="multipart/form-data" method="post" action="<c:url value="${cp }/plan/massiveCreateProcess.do"/>" >
								        <input type="file" name="excelFile" style="display:none;"/>
								    </form>
							    </div>	
							  </div>
							  <div id="menu1" class="tab-pane fade">
							    <h3>Menu 1</h3>
							    <p>Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>
							  </div>
							  <div id="menu2" class="tab-pane fade">
							    <h3>Menu 2</h3>
							    <p>Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam.</p>
							  </div>
							  <div id="menu3" class="tab-pane fade">
							    <h3>Menu 3</h3>
							    <p>Eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.</p>
							  </div>
							  <div id="content">
							  	<table>
							  		<tr>
							  			<th></th>
							  			<th>요 금 제</th>
							  			<th>이용자 수</th>
							  		</tr>
							  		<tbody>
											
							  		</tbody>
							  	</table>
							  </div>
							</div>
						</div>
						<div class="lineChart">
						</div>
						<div class="lineChart">
						</div>
					</div>
				</div>
			</div>
		</div>
</form:form>		
</body>
</html>