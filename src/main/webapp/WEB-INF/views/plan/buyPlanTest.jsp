<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<jsp:include page="/WEB-INF/views/layout/commonLib.jsp"></jsp:include>
<script>


$(document).ready(function() {
	buyPlanAjax();
	
	$(".box").on('click', function(){
		var a = this.value();
		console.log(a)
		console.log(1)
	})
	
});

function buyPlanAjax(){
	
	$.ajax({url : "/plan/buyplanajax.do",
		method : "get",
		dataType : "json",
		success : function(data){
			console.log(data)
			var html = "";
			for(var i = 0; i< data.planList.length ; i++){
				var plan = data.planList[i];                                                    
			html +=	' <div class="box">                                                             '        ;
			html +=	' <div class="PaymentBox">                                                     '        ;
			html +=	'	<img src="/images/요금제이미지.png" alt="" class="bg">                         '           ;
			html +=	'	<div class="content-body">                                                  '        ;
			html +=	'		<div class="title sprint">이용권</div>                                  '          ;
			html +=	'		<div class="price-area">                                                '        ;
			html +=	'			<div class="date-num">                                              '        ;
			html +=	'				<span>'+plan.planPeriod+'</span>일 이용권                                    '    ;
			html +=	'			</div>                                                              '        ;
			html +=	'			<div class="price-num"> ₩'+ plan.planPrice+'/'+plan.planPeriod +'<br>';
			
			
			html +=	'					 <span class="price">'+plan.fmtPlanPrice+'</span>                   '     ;
			
			html +=	'				<span class="original-price"></span>                              '        ;
			html +=	'			</div>                                                              '        ;
			html +=	'			<div class="func-message">무제한 면접 연습, 분석 제공</div>                 '           ;
			html +=	'		</div>                                                                  '        ;
			html +=	'		<div class="marketing-message">                                         '        ;
			html +=	'			<div class="point"></div>                                           '        ;
			html +=	'			<div class="txt">'+plan.planExplain+' </div>                                '    ;
			html +=	'		</div>                                                                  '        ;
			html +=	'	</div>                                                                      '        ;
			html +=	' </div>                                                                        '        ;
			html +=	"<button class='sprint' value="+plan.planSq+ " onclick=\"location.href='/plan/payPlan.do?planSq="+plan.planSq+"'\">구매하기</button>";
			html += '</div>                                                                         ';
					
			};
		$("#listajax").html(html);
		}
		})
	}


</script>
<body>
Test

<fmt:formatNumber type="number" maxFractionDigits="3" value="5000" />

<div class="payment-flex" id = "listajax">
				
				</div>		
</body>
</html>