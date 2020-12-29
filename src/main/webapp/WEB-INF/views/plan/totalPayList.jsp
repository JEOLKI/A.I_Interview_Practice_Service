<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>

<%@ include file="/WEB-INF/views/layout/commonLib.jsp" %>

<script>
	$(document).ready(function(){
		myCashList();
		
	})
function myCashList(){
		
	$.ajax({url : "/plan/cashList.do",
		method : "get",
		dataType : "json",
		success : function(data){
			var html ="";
			for(var i = 0; i< data.cashList.length ; i++){
				var cash = data.cashList[i];
				var start = data.startList[i];
				var end = data.endList[i];
				html += '<tr>'; 
				html += '	<td>'+start+'</td>';
				html += '	<td>'+cash.planNm+'</td>';
				html += '	<td>'+cash.fmtPlanPrice+'원 </td>';
				html += '	<td>'+start+' ~ '+end+'</td>';
				html += '</tr>'
			}
			$("#cashList").html(html);
		}
	})
}
</script>
<style>

	table{
		width: 100%;
		border-collapse: collapse;
	}
	
	td{
		width : 100px;
		height: 50px;
		border-bottom: 1px solid #3b3b46;
	}
	
	th{
		height: 40px;
		border-bottom: 1px solid #3b3b46;
	}
	
 	.term{ 
 		width :220px;
 		padding : 10px;
 	} 	
 	
</style>
</head>
<body>

	<div id="root">
		<div class="PaymentList">
		<%@ include file="/WEB-INF/views/layout/header.jsp" %>
			<div class="body">
				<div class="title">결제 내역</div>
				<div class="sub-message">"${S_MEMBER.memId }"님의 결제 내역입니다. </div>
				<table class="OrdersView">
					<thead>
						<tr>
							<th>구매일</th>
							<th>이용권</th>
							<th>결제 금액</th>
							<th>서비스 기간</th>
						</tr>
					</thead>
					<tbody id="cashList">
						
					</tbody>
					
				</table>
			</div>
			<%@ include file="/WEB-INF/views/layout/semiFooter.jsp" %>
		</div>
	</div>
	
	<%@ include file="/WEB-INF/views/chat/chatImage.jsp" %>
	
</body>
</html>