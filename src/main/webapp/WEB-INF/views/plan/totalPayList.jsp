<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<jsp:include page="/WEB-INF/views/layout/commonLib.jsp"></jsp:include>

<script>
	$(document).ready(function(){
		
	})
function myCashList(){
		
		
	}
</script>
</head>
<body>

	<div id="root">
		<div class="PaymentList">
		<%@ include file="/WEB-INF/views/layout/myPageHeader.jsp" %>
			<div class="body">
				<div class="title">결제 내역</div>
				<div class="sub-message">"${S_MEMBER.memId }"님의 결제 내역입니다. </div>
				<div class="OrdersView">
					<div class="nav-bar">
						<div class="label date">구매 일시</div>
						<div class="label menu">이용권</div>
						<div class="label duration">서비스 기간</div>
						<div class="label method">결제 수단</div>
						<div class="label price">결제 금액</div>
					</div>
					<div class="list">
						<table>
							<thead></thead>
							<thead></thead>
							<thead></thead>
							<thead></thead>
							<thead></thead>
						</table>
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