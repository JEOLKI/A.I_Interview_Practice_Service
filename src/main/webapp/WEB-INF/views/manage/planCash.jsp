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
		CashList();
		
		CashList("${page }", "${pageSize }")
	})
function CashList(pA, pS){
		
	$.ajax({url : "/plan/manageCashajax.do",
		method : "get",
		dataType : "json",
		data : {page : pA, pageSize : pS},
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
				html += '	<td>'+cash.memId+'</td>                       ';
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
		width : 100%;
	}
	td{
/* 		border: 1px solid black; */
		width : 180px;
		padding : 10px;
	}
 	.term{ 
 		width :255px;
 		padding : 10px;
 	}
 	.down{
 		text-align: right;
 	} 	
</style>
</head>
<body>

	<div id="root">
		<div class="PaymentList">
		<%@ include file="/WEB-INF/views/layout/header.jsp" %>
			<div class="body">
				<div class="title">결제 내역</div>
				<div class="sub-message">회원 결제 내역입니다. </div>
				<br>
				<div class = "down">
				<a class = "down" href="/plan/planUseExcel.do">↓ 목록 내려받기</a>
				
				</div>
				<div class="OrdersView">
					<div class="nav-bar">
						<div class="label menu">구매일</div>
						<div class="label menu">이용권</div>
						<div class="label menu">회원아이디</div>
						<div class="label price">결제 금액</div>
						<div class="label menu">서비스 기간</div>
					</div>
					<div id="cashList">
						
					</div>
					
				</div>
				
								
								
									<a class="page-link" href="/plan/manageCash.do?page=1">＜＜</a>
									
									
									&nbsp&nbsp
									<c:choose>
									<c:when test="${page == 1}">
										<a class="page-link" href="${pageContext.request.contextPath }/plan/manageCash.do?page=${page}"  >
										＜  </a>
									</c:when>
									<c:when test="${page != 1}">
										<a class="page-link" href="${pageContext.request.contextPath }/plan/manageCash.do?page=${page-1}" >
										＜ </a>
									</c:when>
								</c:choose>
									&nbsp&nbsp
									
									<a class="page-link" href="#">${page }</a>
									
									&nbsp&nbsp
									<c:choose>
									<c:when test="${page != pages}">
										<a class="page-link" href="${pageContext.request.contextPath }/plan/manageCash.do?page=${page+1}"  >
										＞</a>
									</c:when>
									<c:when test="${page == pages}">
										<a class="page-link" href="${pageContext.request.contextPath }/plan/manageCash.do?page=${page}"  >                         
										＞</a>
									</c:when>
								</c:choose>			
									&nbsp&nbsp
									<a class="page-link" href="/plan/manageCash.do?page=${pages }">＞＞</a>

			</div>
			<footer class="SemiFooter --undefined">
				<%@ include file="/WEB-INF/views/layout/myPageFooter.jsp" %>
			</footer>
		</div>
	</div>
	
</body>
</html>