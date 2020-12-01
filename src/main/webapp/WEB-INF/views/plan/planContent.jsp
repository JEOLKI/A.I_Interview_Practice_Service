<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">


<title>AI_Interview</title>
<%@ include file="/WEB-INF/views/layout/commonLib.jsp" %>


<script>

$(document).ready(function() {
	payPlanAjax("${pvContent.planSq}");

});

function payPlanAjax(p){
	
	$.ajax({url : "/plan/payPlanAjax.do",
		method : "get",
		data : {planSq : p},
		dataType : "json",
		success : function(data){
		console.log(data)
		var html = "";                                              
		var plan = data.pvContent              
		
		html += '	<div class="PaymentTicket">                                 ';
		html += '	<img src="/images/ticket_sprint.png" alt="" class="bg-img"> ';
		html += '	<div class="date">                                          ';
		html += '		<span>'+plan.planPeriod+'</span>일 이용권                                     ';
		html += '	</div>                                                      ';
		html += '	<div class="price-section">                                 ';
		html += '		₩ '+plan.fmtPlanPrice+' / 1일                                            ';
		html += '		<div class="price">'+plan.fmtPlanPrice+'</div>                        ';
		html += '		무제한 면접 연습, 분석 제공<br>                            ';
		html += '	</div>                                                      ';
		html += '</div>                                                          ';
        html += '                                                                ';
		html += '<div class="flex">                                              ';
		html += '	<div class="pay-info">                                      ';
		html += '		<div class="message">                                   ';
		html += '			총 결제금액 <span>(부가가치세 포함)</span>                      ';
		html += '		</div>                                                  ';
		html += '		<div class="price">                                     ';
		html += '			<span>'+plan.fmtPlanPrice+'</span>원                                 ';
		html += '		</div>                                                  ';
		html += '		<div class="detail-info">                               ';
		html += '			<div class="original price">                        ';
		html += '				<div class="name">이용권 금액</div>                  ';
		html += '				'+plan.fmtPlanPrice+'원                                         ';
		html += '			</div>                                              ';
		html += '		</div>                                                  ';
		html += '	</div>                                                      ';
		html += '</div> 		                                                    ';
		html += '<br>';
		html += '<br>';
		html +=	"<button class='payment-btn' onclick=\"location.href='/plan/planUseCreate.do?planSq="+plan.planSq+"'\">구매하기</button>";
		$("#ContentAjax").html(html)
		}
		})
	}

</script>

<link href="/css/main.8acfb306.chunk.css" rel="stylesheet">



</head>
<body>
	<noscript>You need to enable JavaScript to run this app.</noscript>
	<div id="root">
		<div class="PaymentDetail sprint">
		<%@ include file="/WEB-INF/views/layout/header.jsp" %>
		
			<div class="head-section sprint"></div>
			<div class="head-repeat-line"></div>
			<div class="body">
				<div class="PaymentForm sprint">
					<div class="white-message" >구매 이용권</div>
					<div id = "ContentAjax" >
					
					</div>
					
					
					
				</div>
				
				<div class="lower">
					<div class="notice">
						<div class="title">이용권 유의사항</div>
						<div class="notice-list">
							- 해당 이용권은 PC에서 무제한으로 면접을 수행할 수 있는 이용권입니다.<br>- 녹화 및 분석된 면접
							영상은 인터넷이 연결된 환경에서 얼마든지 볼 수 있습니다.<br>- 구입하신 이용권은 마이 페이지에서 확인할
							수 있습니다.<br>- 본 이용권의 금액은 부가세 10%가 포함되어 있는 금액입니다.<br>- 본
							이용권은 이용 시작일(구매일) 기준 7일 이내 청약철회 가능한 이용권입니다.<br>&ensp;단, 이용
							내역이 있는 경우 이용 금액 공제 후 환불합니다.<br>- 이용 시작일(구매일) 기준 7일 경과 후에는
							*이용 금액 공제 후 해지 가능합니다.<br>*이용 금액은 이미 경과된 시간(실제 사용 여부 불문)에
							상응하는 금액을 말합니다.<br>- 미성년자가 법정대리인 동의 없이 구매를 한 경우, 미성년자 또는
							법정대리인이 이를 취소할 수 있습니다.<br>
						</div>
					</div>
				</div>
			</div>
			<footer class="SemiFooter --undefined">
			</footer>
		</div>
	</div>
	
</body>
</html>