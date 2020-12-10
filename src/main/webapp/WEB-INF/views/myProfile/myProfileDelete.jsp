<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>AI_Interview</title>
<%@ include file="/WEB-INF/views/layout/commonLib.jsp" %>
<link href="/css/main.8acfb306.chunk.css" rel="stylesheet">
<script>
$(document).ready(function(){
	 $('#deleteBtn').on('click',function(){
		 if($('#check').is(':checked')==true){
			$('.DeletePopUp.PopUp').show();
			$('.content-box').show();
		 }else{
			 alert('안내사항에 동의해야 합니다')
		 }
    });
	 
	 $('#cancelBtn').on('click',function(){
		$('.content-box').hide();
		$('.DeletePopUp.PopUp').hide();
    });
	 
	 $('#okBtn').on('click',function(){
		 alert('탈퇴가 완료되었습니다.')
		 document.location="/member/deleteprocess.do?memId=${S_MEMBER.memId}"
    });
});
</script>
<style type="text/css">/* Chart.js */
@
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
/* .label { */
/*     border-top: 1px solid rgba(59,59,70,.4); */
/*     border-bottom: 1px solid rgba(59,59,70,.4); */
/*     padding: 15px 30px; */
/* } */
.label_custom{
	border-top: 1px solid rgba(59,59,70,.4);
    border-bottom: 1px solid rgba(59,59,70,.4); 
    border-right: 1px solid rgba(59,59,70,.4); 
    padding: 15px 30px;
}
</style>
</head>
<body>
	<noscript>You need to enable JavaScript to run this app.</noscript>
	<div id="root">
		<div class="WithDraw">
		<%@ include file="/WEB-INF/views/layout/header.jsp" %>

			<div class="DeletePopUp PopUp" style="display: none;">
				<div class="content-box" style="display: none;">
					<div class="title">계정 해지 확인</div>
					<img src="/member/profile.do?memId=${S_MEMBER.memId }"alt="" class="profile">
					<div class="name">${S_MEMBER_memId }</div>
					<div class="message">
						정말 계정을 <span>삭제</span>하시겠습니까?<br> <span>삭제한 데이터는 복구할 수
							없습니다.</span>
					</div>
					<div class="BtnFlex">
						<button id="cancelBtn" class="cancel-btn">취소</button>
						<button id="okBtn" class="delete-btn">확인</button>
					</div>
				</div>
			</div>

			<div class="body">
				<div class="title">탈퇴 안내</div>
				<div class="comment">회원탈퇴를 신청하기 전에 안내 사항을 꼭 확인해주세요.</div>
				<div class="sub-message">
					<img src="/images/deletePageCheck.png" alt="" class="check"> 탈퇴 후 회원정보 및 개인형 서비스 이용기록은 모두 삭제됩니다.
				</div>
				<div class="grid">
					<div class="label_custom">면접 정보</div>
					<div class="content">면접 제목, 면접완료 시간, 면접 결과 내역 삭제</div>
					<div class="label_custom">보관함 정보</div>
					<div class="content middle">보관함 제목, 보관함 질문 리스트 내역 삭제</div>
					<div class="label_custom">프로필 정보</div>
					<div class="content">프로필 사진, 사용자 이름, 사용자 정보 삭제</div>
				</div>
				<div class="sub-message">
					<img src="/images/deletePageCheck.png" alt="" class="check"> 탈퇴 후에도 아이엠터뷰 서비스의 개선을 위한 정보는 남아있습니다.
				</div>
				<div class="grid">
					<div class="label_custom">면접 정보</div>
					<div class="content">면접 영상, 면접 음성 (인공지능 러닝 용도로만 사용되며, 아이엠터뷰
						관계자 외에는 절대 열람이 불가능합니다)</div>
				</div>
				<div class="sub-message flex">
					<input type="checkbox" id="check" style="margin-right: 5px;">
					안내사항을 모두 확인했으며 이에 동의합니다.
				</div>
				<button id="deleteBtn" class="delete false">회원탈퇴</button>
				<%@ include file="/WEB-INF/views/layout/myPageFooter.jsp" %>
			</div>
		</div>
	</div>
</body>
</html>