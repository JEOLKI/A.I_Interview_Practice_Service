	<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix ="c" uri ="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<%@ include file="/WEB-INF/views/layout/commonLib.jsp" %>
<script>
$(document).ready(function(){
	console.log("${param.ticket }")
	var info = "${param.ticket }"
	
	if(info=="info"){
		window.scrollTo( 0, 850 );
	}
	
	PlanUse();
})

function PlanUse(){
	$.ajax({url : "/member/myPlanAjax.do",
		method : "get",
		dataType : "json",
		success : function(data){
			var html = "";
			var plan = data.planUse
			var check = data.planUseCheck
			
			if(check.term!="0"){
				
				html += '<div class="ticket-area"> ';
				html += `<div class="PaymentForm sprint" >`;
				html += `	<div class="PaymentTicket" style="background-image:url('/images/ticket_sprint.png')"  >                                 `;
// 				html += '	<img src="/images/ticket_sprint.png" alt="" class="bg-img"> ';
				html += '	<div class="date">                                          ';
				html += '		<span>'+check.term+'</span>일 남았습니다.                                    ';
				html += '	</div>                                                      ';
				html += '	<div class="price-section">                                 ';
				html += '		₩ '+plan.fmtPlanPrice+' / '+plan.planPeriod+'일                                            ';
				html += '		<div class="price">'+plan.fmtPlanPrice+'</div>                        ';
				html += '		무제한 면접 연습, 분석 제공<br>                            ';
				html += '	</div>                                                      ';
				html += '</div>                                                          ';
		        html += '                                                                ';
				html += '<br>';
				html += '		</div>';
				html += 	'</div>';
				
			}else{
				html += '<div class="ticket-area">                                                 ';
				html += '	<div class="PaymentTicket">                                            ';
				html += '		<img                                                               ';
				html += '			src="/images/구매전.png"                                          ';
				html += '			alt="" class="bg-img">                                         ';
				html += '			                                                               ';
				html += '		<div class="null-content">                                         ';
				html += '		                                                                   ';
				html += '			<div class="sub-message">현재 사용 중인 이용권이 없습니다.</div>             ';
				html += '			<a class="payment-link" href="/plan/planList.do">이용권 구매하기</a>  ';
				html += '			                                                               ';
				html += '		</div>                                                             ';
				html += '		                                                                   ';
				html += '	</div>                                                                 ';
				html += '</div>                                                                    ';
			}
			$("#useInfo").html(html);
		}
	})
}

</script>
<style type="text/css">/* Chart.js */

keyframes chartjs-render-animation {from { opacity:0.99;
	
}

to {
	opacity: 1;
}

}
.chartjs-render-monitor {
	animation: chartjs-render-animation 0.001s;
}

.chartjs-size-monitor, .chartjs-size-monitor-expand,
	.chartjs-size-monitor-shrink {
	position: absolute;
	direction: ltr;
	left: 0;
	top: 0;
	right: 0;
	bottom: 0;
	overflow: hidden;
	pointer-events: none;
	visibility: hidden;
	z-index: -1;
}

.chartjs-size-monitor-expand>div {
	position: absolute;
	width: 1000000px;
	height: 1000000px;
	left: 0;
	top: 0;
}

.chartjs-size-monitor-shrink>div {
	position: absolute;
	width: 200%;
	height: 200%;
	left: 0;
	top: 0;
}
.value{
	float: right;
	text-align: right;
}


</style>
</head>
<body>
	<noscript>You need to enable JavaScript to run this app.</noscript>
	<div id="root">
		<div class="PersonalInfo">
			<%@ include file="/WEB-INF/views/layout/header.jsp"%>
			<div class="body">
				<div class="MyProfile" style="height: 530px;">
					<div class="title">내 프로필</div>
					<div class="flex">
						<img
							src="/member/profile.do?memId=${S_MEMBER.memId }"alt="" class="profile">
						<div class="info-area">
							<div class="name">
								<div class='label' style="display: inline;
														    padding: .2em .6em .3em;
														    font-size: 75%;
														    font-weight: 700;
														    line-height: 1;
														    font-size : 15px;
														    color: black;
														    text-align:left;
														    white-space: nowrap;
														    vertical-align: baseline;
														     border-radius: .25em;">별명</div>
								<div class="value">${S_MEMBER.memAlias }</div>
							</div>
							<div class="info">
								<div class="label"style="display: inline;
														    padding: .2em .6em .3em;
														    font-size: 75%;
														    font-weight: 700;
														    line-height: 1;
														    font-size : 15px;
														    color: black;
														    text-align:left;
														    white-space: nowrap;
														    vertical-align: baseline;
														     border-radius: .25em;">경력사항</div>
								<div class="value">${S_MEMBER.memCareer }</div>
							</div>
							<div class="info">
								<div class="label"style="display: inline;
														    padding: .2em .6em .3em;
														    font-size: 75%;
														    font-weight: 700;
														    line-height: 1;
														    font-size : 15px;
														    color: black;
														    text-align:left;
														    white-space: nowrap;
														    vertical-align: baseline;
														     border-radius: .25em;">학력</div>
								<div class="value">${S_MEMBER.memEduc }</div>
							</div>
							<div class="info">
								<div class="label"style="display: inline;
														    padding: .2em .6em .3em;
														    font-size: 75%;
														    font-weight: 700;
														    line-height: 1;
														    font-size : 15px;
														    color: black;
														    text-align:left;
														    white-space: nowrap;
														    vertical-align: baseline;
														     border-radius: .25em;">성별</div>
								<div class="value">
									<c:if test="${S_MEMBER.memGender=='F' }">여성</c:if>
									<c:if test="${S_MEMBER.memGender=='M' }">남성</c:if>
								</div>
							</div>
							<div class="info">
								<div class="label"style="display: inline;
														    padding: .2em .6em .3em;
														    font-size: 75%;
														    font-weight: 700;
														    line-height: 1;
														    font-size : 15px;
														    color: black;
														    text-align:left;
														    white-space: nowrap;
														    vertical-align: baseline;
														     border-radius: .25em;">목표 회사</div>
								<div class="value">${S_MEMBER.memTargetCompany }</div>
							</div>
							<div class="info">
								<div class="label"style="display: inline;
														    padding: .2em .6em .3em;
														    font-size: 75%;
														    font-weight: 700;
														    line-height: 1;
														    font-size : 15px;
														    color: black;
														    text-align:left;
														    white-space: nowrap;
														    vertical-align: baseline;
														     border-radius: .25em;">목표 직무</div>
								<div class="value">${S_MEMBER.memTargetJob }</div>
							</div>
							<div class="info">
								<div class="label"style="display: inline;
														    padding: .2em .6em .3em;
														    font-size: 75%;
														    font-weight: 700;
														    line-height: 1;
														    font-size : 15px;
														    color: black;
														    text-align:left;
														    white-space: nowrap;
														    vertical-align: baseline;
														     border-radius: .25em;">취업 준비 시작시기</div>
								<div class="value">${S_MEMBER.searchJobDate }</div>
							</div>
							<div class="info">
								<div class="label"style="display: inline;
														    padding: .2em .6em .3em;
														    font-size: 75%;
														    font-weight: 700;
														    line-height: 1;
														    font-size : 15px;
														    color: black;
														    text-align:left;
														    white-space: nowrap;
														    vertical-align: baseline;
														     border-radius: .25em;">전공</div>
								<div class="value">${S_MEMBER.memMajor }</div>
							</div>
						</div>
					</div>
					<a class="edit-btn" href="/member/updateview.do">수정</a>
				</div>
				
				<div class="MyOrder">
					<div class="title">이용권 정보</div>
					<div id = "useInfo"></div>
					
					
					
					<div class="sub-message">무제한 모의면접, 지금 바로 경험해 보세요!</div>
					<a class="edit-btn" href="/plan/totalPayList.do">결제내역 확인</a>
				</div>
				
				<div class="withdraw-message">
					아이엠터뷰를 더 이상 이용하지 않는다면<a class="withdraw-btn"
						href="/member/deleteview.do">회원탈퇴 바로가기<span aria-hidden="true"
						class="fa fa-caret-right fa undefined"></span>
					</a>
				</div>
				<%@ include file="/WEB-INF/views/layout/myPageFooter.jsp"%>
			</div>
		</div>
	</div>
	<!-- 	<style data-styled="active" data-styled-version="5.1.1"></style> -->
</body>
</html>