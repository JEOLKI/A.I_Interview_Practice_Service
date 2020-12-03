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
		console.log("aa")
		myCashList();
		window.scrollTo( 200, 300 );
	})
function myCashList(){
		
	$.ajax({url : "/plan/cashList.do",
		method : "get",
		dataType : "json",
		success : function(data){
			console.log(data)
			var html ="";
			for(var i = 0; i< data.cashList.length ; i++){
				var cash = data.cashList[i];
				var start = data.startList[i];
				var end = data.endList[i];
				html += '<table>';
				html += '<tr>'; 
				html += '	<td>'+start+'</td>         ';
				html += '	<td>'+cash.planNm+'</td>            ';
				html += '	<td></td>                       ';
				html += '	<td>'+cash.fmtPlanPrice+'</td>      ';
				html += '	<td class = "term">'+start+'~'+end+'</td> ';
				html += '</tr>'
				html += '</table>';
			}
			$("#cashList").html(html);
		}
	})
}
</script>
<style>
	table{
		border: 1px solid black;
	}
	td{
/* 		border: 1px solid black; */
		width : 180px;
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
				<div class="OrdersView">
					<div class="nav-bar">
						<div class="label menu">구매일</div>
						<div class="label menu">이용권</div>
						<div class="label menu">결제 수단</div>
						<div class="label price">결제 금액</div>
						<div class="label menu">서비스 기간</div>
					</div>
					<div id="cashList">
						
					</div>
					
				</div>
			</div>
			<footer class="SemiFooter --undefined">
				<%@ include file="/WEB-INF/views/layout/myPageFooter.jsp" %>
			</footer>
		</div>
	</div>
	
</body>
</html>