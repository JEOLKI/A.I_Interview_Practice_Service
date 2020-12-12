<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">


<title>AI_Interview</title>
<%@ include file="/WEB-INF/views/layout/commonLib.jsp" %>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>


<script>

// onclick=\"location.href='/plan/planUseCreate.do?planSq="+plan.planSq+"'\
		
$(document).ready(function() {
	payPlanAjax("${pvContent.planSq}");

	console.log("d")
	$('#payment').on('click', function(){
		var check =  "${planUseCheck.term }"
		if(check>0){
			alert("아직 이용권 기간이 남아 있습니다.");
		}else{
			var IMP = window.IMP; // 생략가능
			IMP.init('imp67005883'); 	//가맹점 식별코드
			IMP.request_pay({
			    pg : 'html5_inicis',
			    pay_method : 'card',
			    merchant_uid : 'merchant_' + new Date().getTime(),
			    name : '${pvContent.planNm}',
			    amount : '${pvContent.planPrice}',
			  	buyer_email : 'Enter your E-mail',
			    buyer_name : '${S_MEMBER.memId}'
			}, function(rsp) {
			    if ( rsp.success ) {
			    	 var msg = '결제가 완료되었습니다.';
	        /*          msg += '\n고유ID : ' + rsp.imp_uid;
	                 msg += '\n상점 거래ID : ' + rsp.merchant_uid;
	                 msg += '\결제 금액 : ' + rsp.paid_amount;
	                 msg += '카드 승인번호 : ' + rsp.apply_num; */
	                 
	                alert(msg);

			    	$.ajax({
			    		url: "/plan/planUseCreate.do",
			    		type: 'POST',
			    		dataType: 'json',
			    		data: {//기타 필요한 데이터가 있으면 추가 전달
				    			imp_uid : rsp.imp_uid,
				    			merchant_uid : rsp.merchant_uid},
				    	success : function(data){
			    		
				    	}
			    	 });
			    	 //결제 완료 페이지
			    	location.href = "/plan/planUseCreate.do?planSq="+"${pvContent.planSq}"
			    } else {
			        var msg = '결제에 실패하였습니다.';
			        msg += '에러내용 : ' + rsp.error_msg;

			        alert(msg);
			    }
			});
		}
	})
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
		html += '		₩ '+plan.fmtPlanPrice+' / '+plan.planPeriod+'일                                            ';
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
					<button class='payment-btn' id='payment'>구매하기</button>
					
					
					
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