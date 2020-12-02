<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>AI_Interview</title>
<!-- <meta property="og:image" content="/iam.ico"> -->
<!-- <meta name="theme-color" content="#000000"> -->
<!-- <link rel="icon" href="/iam.ico"> -->
<!-- <link rel="manifest" href="/manifest.json"> -->
<!-- <link rel="stylesheet" -->
<!-- 	href="https://cdn.jsdelivr.net/npm/animate.css@3.5.2/animate.min.css"> -->
<!-- <script async="" src="https://www.google-analytics.com/analytics.js"></script> -->
<!-- <script async="" src="https://www.google-analytics.com/analytics.js"></script> -->
<!-- <script async="" src="https://www.google-analytics.com/analytics.js"></script> -->
<!-- <script async="" src="https://www.google-analytics.com/analytics.js"></script> -->
<!-- <script async="" src="https://www.google-analytics.com/analytics.js"></script> -->
<!-- <script async="" src="https://www.google-analytics.com/analytics.js"></script> -->
<!-- <script async="" src="https://www.google-analytics.com/analytics.js"></script> -->
<!-- <script async="" src="https://www.google-analytics.com/analytics.js"></script> -->
<!-- <script async="" src="https://www.google-analytics.com/analytics.js"></script> -->
<!-- <script async="" src="https://www.google-analytics.com/analytics.js"></script> -->
<!-- <script async="" src="https://www.google-analytics.com/analytics.js"></script> -->
<!-- <script async="" src="https://www.google-analytics.com/analytics.js"></script> -->
<!-- <script async="" src="https://www.google-analytics.com/analytics.js"></script> -->
<!-- <script async="" src="https://www.google-analytics.com/analytics.js"></script> -->
<!-- <script type="text/javascript" async="" -->
<!-- 	src="https://cdn.channel.io/plugin/ch-plugin-web.js" charset="UTF-8"></script> -->
<!-- <script type="text/javascript" async="" -->
<!-- 	src="https://testcpay.payple.kr/js/cpay.payple.1.0.1.js" -->
<!-- 	charset="UTF-8"></script> -->
<!-- <script -->
<!-- 	src="https://connect.facebook.net/signals/config/943528292826757?v=2.9.29&amp;r=stable" -->
<!-- 	async=""></script> -->
<!-- <script async="" src="https://connect.facebook.net/en_US/fbevents.js"></script> -->
<!-- <script -->
<!-- 	src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script> -->
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
		 alert('${S_MEMBER.memId}')
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
    padding: 15px 30px;
}
</style>
</head>
<body>
	<noscript>You need to enable JavaScript to run this app.</noscript>
	<div id="root">
		<div class="WithDraw">
		<%@ include file="/WEB-INF/views/layout/myPageHeader.jsp" %>

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
					<img
						src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACoAAAAfCAYAAACRdF9FAAAABHNCSVQICAgIfAhkiAAAAi1JREFUWEfN1r1rFEEYBvDnSQIhH2rYbUIgRfA2zd1iI4iNooKCpLBUECNoAv5FihFFBcXKzhBFkioIFsIuNrdapb49G41EsyN78XTc3NzMfox3x3b3zru/nXfmnSGG7OcE0X1BfGj73l2ZxmFypkgSK6kpgbjT9hfvdX1DA5WRXZyMHQpoL2QWO3BoP6SMHSjUBJliBbEyMKgbRo8B3Oi3mQUgQKzGDe/BQKCmyARY/uJ7T9OP+e/QIsje0J2dCczP79ror04YrRG4rcstyNW4UVtTN/woGnd38UpQ7McN7zLIn7qkpv8XncnDDf83EsT5zk6DeBOP/FhCvb5nilHFlUX+LX0GKb1wqzWyd6kMtgrkAVSN7HoLY6tCdqBuGL0EcEVT3s2WO7WEublvpsvACZqPSN7UxQvgVux7D3VxnAmis6PEBoBxTfPdjqfHLmBh4bsuqRM2nxO8qmvmcp/U5ez00SqxNpD/9NFc2OTIRZyY/ZqdBVvIQw3fFAuI963k6DkZaxPZ82QqgrWNVJ71M0HzzCi4DmKy74YQeEfiE4Drus0AcrnVqD3RxikClJcSJ4hOE3gLYqJo8oMTLn14LfZrL8rk6Xt7KoutCqksvfzlRbFVIo2gaVBebNVIY+gfLMVrgNO6E6eKNZl9R64b/rHw88kx7G+qsDZmsgvOBU0HqbA2kblKL5cii7WNLAyVZ1aAUzbWZKk1mh3sfmyeSoDj7friszLN3GTsL4BbMnr0509+AAAAAElFTkSuQmCC"
						alt="" class="check"> 탈퇴 후 회원정보 및 개인형 서비스 이용기록은 모두 삭제됩니다.
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
					<img
						src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACoAAAAfCAYAAACRdF9FAAAABHNCSVQICAgIfAhkiAAAAi1JREFUWEfN1r1rFEEYBvDnSQIhH2rYbUIgRfA2zd1iI4iNooKCpLBUECNoAv5FihFFBcXKzhBFkioIFsIuNrdapb49G41EsyN78XTc3NzMfox3x3b3zru/nXfmnSGG7OcE0X1BfGj73l2ZxmFypkgSK6kpgbjT9hfvdX1DA5WRXZyMHQpoL2QWO3BoP6SMHSjUBJliBbEyMKgbRo8B3Oi3mQUgQKzGDe/BQKCmyARY/uJ7T9OP+e/QIsje0J2dCczP79ror04YrRG4rcstyNW4UVtTN/woGnd38UpQ7McN7zLIn7qkpv8XncnDDf83EsT5zk6DeBOP/FhCvb5nilHFlUX+LX0GKb1wqzWyd6kMtgrkAVSN7HoLY6tCdqBuGL0EcEVT3s2WO7WEublvpsvACZqPSN7UxQvgVux7D3VxnAmis6PEBoBxTfPdjqfHLmBh4bsuqRM2nxO8qmvmcp/U5ez00SqxNpD/9NFc2OTIRZyY/ZqdBVvIQw3fFAuI963k6DkZaxPZ82QqgrWNVJ71M0HzzCi4DmKy74YQeEfiE4Drus0AcrnVqD3RxikClJcSJ4hOE3gLYqJo8oMTLn14LfZrL8rk6Xt7KoutCqksvfzlRbFVIo2gaVBebNVIY+gfLMVrgNO6E6eKNZl9R64b/rHw88kx7G+qsDZmsgvOBU0HqbA2kblKL5cii7WNLAyVZ1aAUzbWZKk1mh3sfmyeSoDj7friszLN3GTsL4BbMnr0509+AAAAAElFTkSuQmCC"
						alt="" class="check"> 탈퇴 후에도 아이엠터뷰 서비스의 개선을 위한 정보는 남아있습니다.
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
<!-- 	<script src="/static/js/2.f1e4c4b1.chunk.js"></script>
	<script src="/static/js/main.a74e6755.chunk.js"></script> -->
</body>
</html>