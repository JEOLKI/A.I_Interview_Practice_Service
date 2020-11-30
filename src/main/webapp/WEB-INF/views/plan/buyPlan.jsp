<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>AI_Interview</title>

<link href="/css/main.8acfb306.chunk.css" rel="stylesheet">

<%@ include file="/WEB-INF/views/layout/commonLib.jsp" %>

<style>
	#notice{
		padding-right: 300px;
	
	}
</style>
<script>


$(document).ready(function() {
	buyPlanAjax();
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
			html +=	"<button class=sprint 'onclick=location.href=/plan/payPlan.do&planSq='"+plan.planSq+">구매하기</button>";
			html += '</div>                                                                         ';
					
			};
		$("#listajax").html(html);
		}
		})
	}



</script>
</head>


<body>
	<noscript>You need to enable JavaScript to run this app.</noscript>
	<div id="root">
		<div class="Payment">
			<%@ include file="/WEB-INF/views/layout/header.jsp" %>
			<div class="body">
			
				<div class="title-message">
					<b>하루 커피 한 잔</b> <img src="#" alt="" class="coffee"> 가격으로 <b>무제한
						면접</b>을 이용해 보세요!
				</div>

				<div class="payment-flex" id = "listajax">
				
				</div>			
				</div>
				

<!-- 								<div class="discount-percent half">-17%</div> -->
				
<!-- 						<button class="half" -->
<%-- 							onclick="location.href='${cp }/plan/payPlan'">구매하기</button> --%>
					
					
<!-- 						<button class="marathon" -->
<%-- 							onclick="location.href='${cp }/plan/payPlan'">구매하기</button> --%>

					<div class="notice" id = "notice">
						<div class="title">이용권 유의사항</div>
						<div class="notice-list">
							- 해당 이용권은 PC에서 무제한으로 면접을 수행할 수 있는 이용권입니다.<br>
							- 녹화 및 분석된 면접영상은 인터넷이 연결된 환경에서 얼마든지 볼 수 있습니다.<br>
							- 구입하신 이용권은 마이 페이지에서 확인할수 있습니다.<br>
							- 본 이용권의 금액은 부가세 10%가 포함되어 있는 금액입니다.<br>
							- 본이용권은 이용 시작일(구매일) 기준 7일 이내 청약철회 가능한 이용권입니다.<br>
							&ensp;단, 이용내역이 있는 경우 이용 금액 공제 후 환불합니다.<br>
							- 이용 시작일(구매일) 기준 7일 경과 후에는*이용 금액 공제 후 해지 가능합니다.<br>
							*이용 금액은 이미 경과된 시간(실제 사용 여부 불문)에 상응하는 금액을 말합니다.<br>
							- 미성년자가 법정대리인 동의 없이 구매를 한 경우, 미성년자 또는 법정대리인이 이를 취소할 수 있습니다.<br>
						</div>
					</div>
				<footer class="SemiFooter --undefined">
			</footer>
		</div>
	</div>
	
</body>
</html>