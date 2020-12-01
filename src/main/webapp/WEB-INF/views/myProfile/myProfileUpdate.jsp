<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ include file="/WEB-INF/views/layout/commonLib.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<!-- <meta name="viewport" content="width=device-width,initial-scale=1"> -->
<!-- <title>AI_Interview</title> -->
<!-- <meta name="naver-site-verification" -->
<!-- 	content="94f5ba87b40698d4bc6a88a5e19c99a7d3e1e4c0"> -->
<!-- <meta name="google-site-verification" -->
<!-- 	content="rSYfvWZS1ZnErY0j3In-SemXmy4eYuQXYZcmyXHGY54"> -->
<!-- <meta name="keywords" -->
<!-- 	content="면접, ai면접, 공무원면접, 스피치학원, 면접예상질문, 기업분석, 면접1분자기소개예시, 면접질문, 면접자기소개예시, 스피치, 회사면접질문, 1분자기소개, 모의면접, 면접자기소개, 발음연습, 취업, 화상면접, 실무면접, 자기소개, 인공지능, AI, 취업정보사이트, 취업사이트, PT면접, 비대면, 맞춤, 대기업, 공기업, 공무원"> -->
<!-- <meta property="title" content="iamterview"> -->
<!-- <meta property="og:title" content="iamterview"> -->
<!-- <meta name="description" content="집에서 혼자 하더라도 실전 면접 연습은 iamterview에서!"> -->
<!-- <meta property="og:description" -->
<!-- 	content="집에서 혼자 하더라도 실전 면접 연습은 iamterview에서!"> -->
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
<!-- <link href="/css/main.8acfb306.chunk.css" rel="stylesheet"> -->
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
</style>
<script>
$('#aliasCheck').on('click',function(){
	console.log('클릭')
	if($('#memAlias').val()==''){
		alert('닉네임을 입력하세요');
	}else{
		$('#checkAlias').empty();
		aliasCheck();
	}
});
function aliasCheck(){
	memAlias = $('#memAlias').val();
	
$.ajax({
		url : "/member/aliasCheck.do",
		data : {
			memAlias : memAlias
		},
		method : "post",
		success : function(data) {
			if (data == '') {
				html = '<span style="color:green">사용가능한 닉네임입니다</span><br><br>';
				$('#check').val('Y');
				$('#memAlias').attr('readonly',true);
				$('#checkAlias').append(html);
			} else {
				html = '<span style="color:red">중복된 닉네임입니다</span><br><br>';
				$('#memAlias').val('');
				$('#check').val('N');
				$('#checkAlias').append(html);
			}
		},
		error : function(data) {
			console.log(data.status);
		}
	});
};
</script>
</head>
<body>
	<noscript>You need to enable JavaScript to run this app.</noscript>
	<div id="root">
		<div class="ProfileEdit">
		<%@ include file="/WEB-INF/views/layout/myPageHeader.jsp" %>
			<div class="body">
				<div class="title">프로필 수정</div>
				<div class="ProfileForm">
					<div class="info-flex">
						<div class="label">프로필 사진</div>
						<div class="content profile-area">
							<img
								src="/member/profile.do?memId=${S_MEMBER.memId }"
								alt="" class="profile-img">
						</div>
					</div>
					<div class="info-flex">
						<div class="label">
							별명<span>(필수)</span>
						</div>
						<div class="content name-area">
							<input type="text" placeholder="사용할 별명을 입력하세요" class="name-input"
								value="${S_MEMBER.memAlias }">
							<div class="btn-area">
								<button type="button" class="btn active" id="aliasCheck">중복검사</button>
							</div>
						</div>
<!-- 						<div id="checkAlias" class="check"></div> -->
					</div>
					<div class="info-flex">
						<div class="label">
							경력사항<span>(필수)</span>
						</div>
						<div class="content set-career-flex ">
							<div class="btn new select">신입</div>
							<div class="btn old false">경력</div>
						</div>
					</div>
					<div class="info-flex">
						<div class="label">
							학력<span>(필수)</span>
						</div>
						<div class="content radio-area">
							<div class="CustomRadio grid">
								<div class="radio false">
									<img
										src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACQAAAAkCAYAAADhAJiYAAAABHNCSVQICAgIfAhkiAAAA/tJREFUWEfNWE1ME1EQntkGE7uYcBI4+cuZnxPuEimJLchFFIQLoBUSE0GCAY3x5IkYxYQoHrEoXgigeOGvJlRDV05Cz/7ADfDUBLYmku0z8+ir24Kw7TbYPfXnzbxvv/nmzcxDSPEpL6856XBEKxmDOkSWxxjkIWIJuWGMLSNCmDEMI8KkYUgfFxdnVlPZAq0uVlXPNcZYt9jcqt0OSBwIBudeWbE5EFB5+QWXJEk+RDhJDmXZCaWlxXD+vAIFBflQWFgAhYX5fK+1tQ1YW1uH9fUN+PRJg6WlEOh6hP9HwKJRdmdx8UNgP2D7AlIUtw8Rr5OD/Pzj0NbWArW1HisvGl8zNTUHQ0MjsLHxUwAb1jS/919O9gRUUuLKk+WcdwDocjqPsvb2VmxsvJISkOTFBGp0dIJFIr8QgAV0ffvy8nIgnLxuFyAC43TmzJNWKDyDg/1QVHTGFhhh/PXrd+js7OVhpBBGIttVyaB2AVJV9zwxc/bsaXj+/AkcO5abETDCyebmFty+fRe+fftBygoEg/4q8wYJgIRmiJnx8ZGMgzGDamhoEUwlaCoOiLLJ4ZDmSTMvXjzFTIXpX/RS+Do6erimDCNaJbIvDkhRPCuU2l1dN8GugK3GmITu873hetI0fynZcUCK4r6OiD5K7YmJEav+MrKuvr6FHwmMMa+m+YcFoCXKqgcPelI+Z+yionOqr+9pnCWM1aYVEvLs7Du7/tOyr66+zAVuGNIpFOGqqDgHjx49TMuhXaP79x/CwsJnHjZUFM8kIlz6H+ESL/I3bPCeGAogYuWzZ4+hrKzY7sumZf/lSwi6uu4RQx+JIZ7uY2Ov41U7La82jOhM8npv7fRTquph5GthYdaGS/umFRXV3En2AVIU9yoinsiGkAFAKCtFnXVpz+tY1hyMonTk5sowM/PWfrqk4aGm5gpsbek7pYPsVdWzDADF/+O0Fqc0CToYnCtJaD9orBkff53GO6Zv0tDQysemhPbDzJLX28zHncN4RIMm2Ik3aPRBtLCy7GSDg/2H0sJ2dvYyXY/s3cLGWBoGgGskcDooMz1xCNZp8rh6tZULGQBeBYNzfBhNYEj8IKr/YYxBVN01ze8yy2PPQVGWj9D8XUxM0WyWqQmEqjrNZDFmQrr+23XgoEhoY9PrJPVJpKmmpnq8caPZls5fvnzDR2nSDDETiWzXWRqlzbuqqodrin6jI4Gy7+JFd0rApqf9/LKBUjv2JGgm2Zml6xiHQxqgEJIxhdF8HUPfRUgpJBQO83VMLDxkGjKMaLet6xgz+tgw0C2ApUBTiDE2QDOXFZsDGUp2QrVPkgwXANYBMLrOyzOBpM3DABgGYJPRqCOQ6pXeHyt3D3UGEb31AAAAAElFTkSuQmCC"
										alt="">중 / 고등학교 졸
								</div>
								<div class="radio false">
									<img
										src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACQAAAAkCAYAAADhAJiYAAAABHNCSVQICAgIfAhkiAAAA/tJREFUWEfNWE1ME1EQntkGE7uYcBI4+cuZnxPuEimJLchFFIQLoBUSE0GCAY3x5IkYxYQoHrEoXgigeOGvJlRDV05Cz/7ADfDUBLYmku0z8+ir24Kw7TbYPfXnzbxvv/nmzcxDSPEpL6856XBEKxmDOkSWxxjkIWIJuWGMLSNCmDEMI8KkYUgfFxdnVlPZAq0uVlXPNcZYt9jcqt0OSBwIBudeWbE5EFB5+QWXJEk+RDhJDmXZCaWlxXD+vAIFBflQWFgAhYX5fK+1tQ1YW1uH9fUN+PRJg6WlEOh6hP9HwKJRdmdx8UNgP2D7AlIUtw8Rr5OD/Pzj0NbWArW1HisvGl8zNTUHQ0MjsLHxUwAb1jS/919O9gRUUuLKk+WcdwDocjqPsvb2VmxsvJISkOTFBGp0dIJFIr8QgAV0ffvy8nIgnLxuFyAC43TmzJNWKDyDg/1QVHTGFhhh/PXrd+js7OVhpBBGIttVyaB2AVJV9zwxc/bsaXj+/AkcO5abETDCyebmFty+fRe+fftBygoEg/4q8wYJgIRmiJnx8ZGMgzGDamhoEUwlaCoOiLLJ4ZDmSTMvXjzFTIXpX/RS+Do6erimDCNaJbIvDkhRPCuU2l1dN8GugK3GmITu873hetI0fynZcUCK4r6OiD5K7YmJEav+MrKuvr6FHwmMMa+m+YcFoCXKqgcPelI+Z+yionOqr+9pnCWM1aYVEvLs7Du7/tOyr66+zAVuGNIpFOGqqDgHjx49TMuhXaP79x/CwsJnHjZUFM8kIlz6H+ESL/I3bPCeGAogYuWzZ4+hrKzY7sumZf/lSwi6uu4RQx+JIZ7uY2Ov41U7La82jOhM8npv7fRTquph5GthYdaGS/umFRXV3En2AVIU9yoinsiGkAFAKCtFnXVpz+tY1hyMonTk5sowM/PWfrqk4aGm5gpsbek7pYPsVdWzDADF/+O0Fqc0CToYnCtJaD9orBkff53GO6Zv0tDQysemhPbDzJLX28zHncN4RIMm2Ik3aPRBtLCy7GSDg/2H0sJ2dvYyXY/s3cLGWBoGgGskcDooMz1xCNZp8rh6tZULGQBeBYNzfBhNYEj8IKr/YYxBVN01ze8yy2PPQVGWj9D8XUxM0WyWqQmEqjrNZDFmQrr+23XgoEhoY9PrJPVJpKmmpnq8caPZls5fvnzDR2nSDDETiWzXWRqlzbuqqodrin6jI4Gy7+JFd0rApqf9/LKBUjv2JGgm2Zml6xiHQxqgEJIxhdF8HUPfRUgpJBQO83VMLDxkGjKMaLet6xgz+tgw0C2ApUBTiDE2QDOXFZsDGUp2QrVPkgwXANYBMLrOyzOBpM3DABgGYJPRqCOQ6pXeHyt3D3UGEb31AAAAAElFTkSuQmCC"
										alt="">대학교 재학
								</div>
								<div class="radio select">
									<img
										src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACQAAAAkCAYAAADhAJiYAAAABHNCSVQICAgIfAhkiAAABR9JREFUWEfNWF1MFFcUPmc2SNhhBaktkDStbfWpTfh5orNElqQsPw8tKopNBF01aVN+QqO1xvTBh8ZYqwkRSPqiIJi0RKi0D/xtExbDbnkCNmmftNU0JgutxcVlliCZuc257Gx3dheYEdIybztzzr3ffue75+cimHyKiir2WCxqCWNQjcgyGYNMRMynZRhjM4gQZAyDiDCgKML45OTwIzNboFFju915nDHWom1u1G8VJLZ6vaO3jPhsCKio6D2HIAidiLCHFhRFKxQU5MH+/RLk5GRDbm4O5OZm870CgTkIBGZhdnYO7t3zwfS0H2Q5zL8RMFVln05O/uRZD9i6gCSprBMRT9AC2dmvwKlTdVBV5TTyR6M2g4OjcONGD8zN/akB6/L53K61FkkKKD/fkSmKKXcB0GG1prHTp+vxyJGDpoDEGxOo3t5+Fg4vIQDzyPLKgZkZTzDeLgEQgbFaU8ZIKxSe9varsG/fW5sCoznfv/8bNDae5WGkEIbDK6XxoBIA2e1lY8TM3r1vQlvb12CzpSeA+UNRYWhpGQaXnsOCqsIvKwq3eSfFAhmCAFVpO6AyLRVeswgJvqHQIjQ1fQYPHvxOyvJ4ve7SWCMdIE0zxExfX08CGAJyZUGG78LLhhg7ak2FcxliAjACVVNTpzGl01QUEJ0mi0UYI810dFzD+DARG43zIXjGmCEwmtFORGjPsnHWYh8KX0PDGa4pRVFLtdMXBSRJzod0tJubP4J4AX8bXoam+ZApIPHGbVk2+NCaqntNQu/svM315PO5C+gjByRJZScQsZOOdn9/j85pK8BoC3a/tDOBqUOH6nhKYIy5fD53lwZomk7VhQtndHmGNOOYfWo6TGtRSeHz5OzSaYry1KVL16IsYaQ2PSQhj4zc1a3VMB+CXoMCNhrPWmsqdGTZdObl5Qe4wBVFeAO1cBUXvwuXL1+MGhI7hYF5o/uYspvKzdKxdP78RZiY+JmHDSXJOYAIH8SH65vFJfgiKJvayKjxl5kifJyeFjX/N2zwAzHkQcSS69evQGFhXtTo/b8WwLe8YnQPU3ZSagr8+HJG1Gdqyg/NzeeIoXFiiB/3O3e6o1WbLPMD8/BYUU1tZNSYMrone1fUnHKSy/XJaj9ltzt5ppuYGNGtt/vxE6Prv5Ddk1d36/yKi8v57+0HSJLKHiHi6/9lyN5OscB4kpABgH9binrbHXtex7ZNYtRKR3q6CMPD3/8vpaOi4iAsLsqrpYMQ2O3OGQDIS1ZcS2afQshkD7RWHrAhwvgaxZUE7fWO5uvaDxpr+vq6detRY1b/97MXyjXxTsnaj5qaej426dqPWJZcrmN83Il9tqInWq9B09jhiVHbWGthRdHK2tuvJm1hqR0xGz4KE7UbyVrYxsazTJbDyVvYCEtdAHCcBE6JMn7ioJbkqwXZcI9Evc/nazT5hw/XcyEDwC2vd5QPozqGtBda9d9oDBqMGYN+jYxBlIG1MajKwBhE1d3nczti5ZF0UBTFHTR/5xFTNJtt5aBIM1mEGb8sP3dsOCjy1mN1eh2gPok0VVt7CE+ePLapk3bz5m0+SpNmiJlweKXa0Cgdu6vd7uSaoneUEuj0VVaWmQI2NOTmlw10tCOPTjPxixm6jrFYhFYKITlTGGOvY+i3FlJqtCgcsdcxkfCQq19R1JZNXcfEoo8MAy0aMBM0+RljrTRzGfHZkKH4Raj2CYLiAMBqAEbXeZkxIGnzIAAGAdiAqlo8Zq/0/gGye711zolR2AAAAABJRU5ErkJggg=="
										alt="">대학교 졸업
								</div>
								<div class="radio false">
									<img
										src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACQAAAAkCAYAAADhAJiYAAAABHNCSVQICAgIfAhkiAAAA/tJREFUWEfNWE1ME1EQntkGE7uYcBI4+cuZnxPuEimJLchFFIQLoBUSE0GCAY3x5IkYxYQoHrEoXgigeOGvJlRDV05Cz/7ADfDUBLYmku0z8+ir24Kw7TbYPfXnzbxvv/nmzcxDSPEpL6856XBEKxmDOkSWxxjkIWIJuWGMLSNCmDEMI8KkYUgfFxdnVlPZAq0uVlXPNcZYt9jcqt0OSBwIBudeWbE5EFB5+QWXJEk+RDhJDmXZCaWlxXD+vAIFBflQWFgAhYX5fK+1tQ1YW1uH9fUN+PRJg6WlEOh6hP9HwKJRdmdx8UNgP2D7AlIUtw8Rr5OD/Pzj0NbWArW1HisvGl8zNTUHQ0MjsLHxUwAb1jS/919O9gRUUuLKk+WcdwDocjqPsvb2VmxsvJISkOTFBGp0dIJFIr8QgAV0ffvy8nIgnLxuFyAC43TmzJNWKDyDg/1QVHTGFhhh/PXrd+js7OVhpBBGIttVyaB2AVJV9zwxc/bsaXj+/AkcO5abETDCyebmFty+fRe+fftBygoEg/4q8wYJgIRmiJnx8ZGMgzGDamhoEUwlaCoOiLLJ4ZDmSTMvXjzFTIXpX/RS+Do6erimDCNaJbIvDkhRPCuU2l1dN8GugK3GmITu873hetI0fynZcUCK4r6OiD5K7YmJEav+MrKuvr6FHwmMMa+m+YcFoCXKqgcPelI+Z+yionOqr+9pnCWM1aYVEvLs7Du7/tOyr66+zAVuGNIpFOGqqDgHjx49TMuhXaP79x/CwsJnHjZUFM8kIlz6H+ESL/I3bPCeGAogYuWzZ4+hrKzY7sumZf/lSwi6uu4RQx+JIZ7uY2Ov41U7La82jOhM8npv7fRTquph5GthYdaGS/umFRXV3En2AVIU9yoinsiGkAFAKCtFnXVpz+tY1hyMonTk5sowM/PWfrqk4aGm5gpsbek7pYPsVdWzDADF/+O0Fqc0CToYnCtJaD9orBkff53GO6Zv0tDQysemhPbDzJLX28zHncN4RIMm2Ik3aPRBtLCy7GSDg/2H0sJ2dvYyXY/s3cLGWBoGgGskcDooMz1xCNZp8rh6tZULGQBeBYNzfBhNYEj8IKr/YYxBVN01ze8yy2PPQVGWj9D8XUxM0WyWqQmEqjrNZDFmQrr+23XgoEhoY9PrJPVJpKmmpnq8caPZls5fvnzDR2nSDDETiWzXWRqlzbuqqodrin6jI4Gy7+JFd0rApqf9/LKBUjv2JGgm2Zml6xiHQxqgEJIxhdF8HUPfRUgpJBQO83VMLDxkGjKMaLet6xgz+tgw0C2ApUBTiDE2QDOXFZsDGUp2QrVPkgwXANYBMLrOyzOBpM3DABgGYJPRqCOQ6pXeHyt3D3UGEb31AAAAAElFTkSuQmCC"
										alt="">석 / 박사 이상
								</div>
								<div class="radio false">
									<img
										src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACQAAAAkCAYAAADhAJiYAAAABHNCSVQICAgIfAhkiAAAA/tJREFUWEfNWE1ME1EQntkGE7uYcBI4+cuZnxPuEimJLchFFIQLoBUSE0GCAY3x5IkYxYQoHrEoXgigeOGvJlRDV05Cz/7ADfDUBLYmku0z8+ir24Kw7TbYPfXnzbxvv/nmzcxDSPEpL6856XBEKxmDOkSWxxjkIWIJuWGMLSNCmDEMI8KkYUgfFxdnVlPZAq0uVlXPNcZYt9jcqt0OSBwIBudeWbE5EFB5+QWXJEk+RDhJDmXZCaWlxXD+vAIFBflQWFgAhYX5fK+1tQ1YW1uH9fUN+PRJg6WlEOh6hP9HwKJRdmdx8UNgP2D7AlIUtw8Rr5OD/Pzj0NbWArW1HisvGl8zNTUHQ0MjsLHxUwAb1jS/919O9gRUUuLKk+WcdwDocjqPsvb2VmxsvJISkOTFBGp0dIJFIr8QgAV0ffvy8nIgnLxuFyAC43TmzJNWKDyDg/1QVHTGFhhh/PXrd+js7OVhpBBGIttVyaB2AVJV9zwxc/bsaXj+/AkcO5abETDCyebmFty+fRe+fftBygoEg/4q8wYJgIRmiJnx8ZGMgzGDamhoEUwlaCoOiLLJ4ZDmSTMvXjzFTIXpX/RS+Do6erimDCNaJbIvDkhRPCuU2l1dN8GugK3GmITu873hetI0fynZcUCK4r6OiD5K7YmJEav+MrKuvr6FHwmMMa+m+YcFoCXKqgcPelI+Z+yionOqr+9pnCWM1aYVEvLs7Du7/tOyr66+zAVuGNIpFOGqqDgHjx49TMuhXaP79x/CwsJnHjZUFM8kIlz6H+ESL/I3bPCeGAogYuWzZ4+hrKzY7sumZf/lSwi6uu4RQx+JIZ7uY2Ov41U7La82jOhM8npv7fRTquph5GthYdaGS/umFRXV3En2AVIU9yoinsiGkAFAKCtFnXVpz+tY1hyMonTk5sowM/PWfrqk4aGm5gpsbek7pYPsVdWzDADF/+O0Fqc0CToYnCtJaD9orBkff53GO6Zv0tDQysemhPbDzJLX28zHncN4RIMm2Ik3aPRBtLCy7GSDg/2H0sJ2dvYyXY/s3cLGWBoGgGskcDooMz1xCNZp8rh6tZULGQBeBYNzfBhNYEj8IKr/YYxBVN01ze8yy2PPQVGWj9D8XUxM0WyWqQmEqjrNZDFmQrr+23XgoEhoY9PrJPVJpKmmpnq8caPZls5fvnzDR2nSDDETiWzXWRqlzbuqqodrin6jI4Gy7+JFd0rApqf9/LKBUjv2JGgm2Zml6xiHQxqgEJIxhdF8HUPfRUgpJBQO83VMLDxkGjKMaLet6xgz+tgw0C2ApUBTiDE2QDOXFZsDGUp2QrVPkgwXANYBMLrOyzOBpM3DABgGYJPRqCOQ6pXeHyt3D3UGEb31AAAAAElFTkSuQmCC"
										alt="">기타
								</div>
							</div>
						</div>
					</div>
					<div class="info-flex">
						<div class="label">
							성별<span>(필수)</span>
						</div>
						<div class="content radio-area">
							<div class="CustomRadio grid">
								<div class="radio false">
									<img
										src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACQAAAAkCAYAAADhAJiYAAAABHNCSVQICAgIfAhkiAAAA/tJREFUWEfNWE1ME1EQntkGE7uYcBI4+cuZnxPuEimJLchFFIQLoBUSE0GCAY3x5IkYxYQoHrEoXgigeOGvJlRDV05Cz/7ADfDUBLYmku0z8+ir24Kw7TbYPfXnzbxvv/nmzcxDSPEpL6856XBEKxmDOkSWxxjkIWIJuWGMLSNCmDEMI8KkYUgfFxdnVlPZAq0uVlXPNcZYt9jcqt0OSBwIBudeWbE5EFB5+QWXJEk+RDhJDmXZCaWlxXD+vAIFBflQWFgAhYX5fK+1tQ1YW1uH9fUN+PRJg6WlEOh6hP9HwKJRdmdx8UNgP2D7AlIUtw8Rr5OD/Pzj0NbWArW1HisvGl8zNTUHQ0MjsLHxUwAb1jS/919O9gRUUuLKk+WcdwDocjqPsvb2VmxsvJISkOTFBGp0dIJFIr8QgAV0ffvy8nIgnLxuFyAC43TmzJNWKDyDg/1QVHTGFhhh/PXrd+js7OVhpBBGIttVyaB2AVJV9zwxc/bsaXj+/AkcO5abETDCyebmFty+fRe+fftBygoEg/4q8wYJgIRmiJnx8ZGMgzGDamhoEUwlaCoOiLLJ4ZDmSTMvXjzFTIXpX/RS+Do6erimDCNaJbIvDkhRPCuU2l1dN8GugK3GmITu873hetI0fynZcUCK4r6OiD5K7YmJEav+MrKuvr6FHwmMMa+m+YcFoCXKqgcPelI+Z+yionOqr+9pnCWM1aYVEvLs7Du7/tOyr66+zAVuGNIpFOGqqDgHjx49TMuhXaP79x/CwsJnHjZUFM8kIlz6H+ESL/I3bPCeGAogYuWzZ4+hrKzY7sumZf/lSwi6uu4RQx+JIZ7uY2Ov41U7La82jOhM8npv7fRTquph5GthYdaGS/umFRXV3En2AVIU9yoinsiGkAFAKCtFnXVpz+tY1hyMonTk5sowM/PWfrqk4aGm5gpsbek7pYPsVdWzDADF/+O0Fqc0CToYnCtJaD9orBkff53GO6Zv0tDQysemhPbDzJLX28zHncN4RIMm2Ik3aPRBtLCy7GSDg/2H0sJ2dvYyXY/s3cLGWBoGgGskcDooMz1xCNZp8rh6tZULGQBeBYNzfBhNYEj8IKr/YYxBVN01ze8yy2PPQVGWj9D8XUxM0WyWqQmEqjrNZDFmQrr+23XgoEhoY9PrJPVJpKmmpnq8caPZls5fvnzDR2nSDDETiWzXWRqlzbuqqodrin6jI4Gy7+JFd0rApqf9/LKBUjv2JGgm2Zml6xiHQxqgEJIxhdF8HUPfRUgpJBQO83VMLDxkGjKMaLet6xgz+tgw0C2ApUBTiDE2QDOXFZsDGUp2QrVPkgwXANYBMLrOyzOBpM3DABgGYJPRqCOQ6pXeHyt3D3UGEb31AAAAAElFTkSuQmCC"
										alt="">남성
								</div>
								<div class="radio select">
									<img
										src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACQAAAAkCAYAAADhAJiYAAAABHNCSVQICAgIfAhkiAAABR9JREFUWEfNWF1MFFcUPmc2SNhhBaktkDStbfWpTfh5orNElqQsPw8tKopNBF01aVN+QqO1xvTBh8ZYqwkRSPqiIJi0RKi0D/xtExbDbnkCNmmftNU0JgutxcVlliCZuc257Gx3dheYEdIybztzzr3ffue75+cimHyKiir2WCxqCWNQjcgyGYNMRMynZRhjM4gQZAyDiDCgKML45OTwIzNboFFju915nDHWom1u1G8VJLZ6vaO3jPhsCKio6D2HIAidiLCHFhRFKxQU5MH+/RLk5GRDbm4O5OZm870CgTkIBGZhdnYO7t3zwfS0H2Q5zL8RMFVln05O/uRZD9i6gCSprBMRT9AC2dmvwKlTdVBV5TTyR6M2g4OjcONGD8zN/akB6/L53K61FkkKKD/fkSmKKXcB0GG1prHTp+vxyJGDpoDEGxOo3t5+Fg4vIQDzyPLKgZkZTzDeLgEQgbFaU8ZIKxSe9varsG/fW5sCoznfv/8bNDae5WGkEIbDK6XxoBIA2e1lY8TM3r1vQlvb12CzpSeA+UNRYWhpGQaXnsOCqsIvKwq3eSfFAhmCAFVpO6AyLRVeswgJvqHQIjQ1fQYPHvxOyvJ4ve7SWCMdIE0zxExfX08CGAJyZUGG78LLhhg7ak2FcxliAjACVVNTpzGl01QUEJ0mi0UYI810dFzD+DARG43zIXjGmCEwmtFORGjPsnHWYh8KX0PDGa4pRVFLtdMXBSRJzod0tJubP4J4AX8bXoam+ZApIPHGbVk2+NCaqntNQu/svM315PO5C+gjByRJZScQsZOOdn9/j85pK8BoC3a/tDOBqUOH6nhKYIy5fD53lwZomk7VhQtndHmGNOOYfWo6TGtRSeHz5OzSaYry1KVL16IsYaQ2PSQhj4zc1a3VMB+CXoMCNhrPWmsqdGTZdObl5Qe4wBVFeAO1cBUXvwuXL1+MGhI7hYF5o/uYspvKzdKxdP78RZiY+JmHDSXJOYAIH8SH65vFJfgiKJvayKjxl5kifJyeFjX/N2zwAzHkQcSS69evQGFhXtTo/b8WwLe8YnQPU3ZSagr8+HJG1Gdqyg/NzeeIoXFiiB/3O3e6o1WbLPMD8/BYUU1tZNSYMrone1fUnHKSy/XJaj9ltzt5ppuYGNGtt/vxE6Prv5Ddk1d36/yKi8v57+0HSJLKHiHi6/9lyN5OscB4kpABgH9binrbHXtex7ZNYtRKR3q6CMPD3/8vpaOi4iAsLsqrpYMQ2O3OGQDIS1ZcS2afQshkD7RWHrAhwvgaxZUE7fWO5uvaDxpr+vq6detRY1b/97MXyjXxTsnaj5qaej426dqPWJZcrmN83Il9tqInWq9B09jhiVHbWGthRdHK2tuvJm1hqR0xGz4KE7UbyVrYxsazTJbDyVvYCEtdAHCcBE6JMn7ioJbkqwXZcI9Evc/nazT5hw/XcyEDwC2vd5QPozqGtBda9d9oDBqMGYN+jYxBlIG1MajKwBhE1d3nczti5ZF0UBTFHTR/5xFTNJtt5aBIM1mEGb8sP3dsOCjy1mN1eh2gPok0VVt7CE+ePLapk3bz5m0+SpNmiJlweKXa0Cgdu6vd7uSaoneUEuj0VVaWmQI2NOTmlw10tCOPTjPxixm6jrFYhFYKITlTGGOvY+i3FlJqtCgcsdcxkfCQq19R1JZNXcfEoo8MAy0aMBM0+RljrTRzGfHZkKH4Raj2CYLiAMBqAEbXeZkxIGnzIAAGAdiAqlo8Zq/0/gGye711zolR2AAAAABJRU5ErkJggg=="
										alt="">여성
								</div>
								<div class="radio false">
									<img
										src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACQAAAAkCAYAAADhAJiYAAAABHNCSVQICAgIfAhkiAAAA/tJREFUWEfNWE1ME1EQntkGE7uYcBI4+cuZnxPuEimJLchFFIQLoBUSE0GCAY3x5IkYxYQoHrEoXgigeOGvJlRDV05Cz/7ADfDUBLYmku0z8+ir24Kw7TbYPfXnzbxvv/nmzcxDSPEpL6856XBEKxmDOkSWxxjkIWIJuWGMLSNCmDEMI8KkYUgfFxdnVlPZAq0uVlXPNcZYt9jcqt0OSBwIBudeWbE5EFB5+QWXJEk+RDhJDmXZCaWlxXD+vAIFBflQWFgAhYX5fK+1tQ1YW1uH9fUN+PRJg6WlEOh6hP9HwKJRdmdx8UNgP2D7AlIUtw8Rr5OD/Pzj0NbWArW1HisvGl8zNTUHQ0MjsLHxUwAb1jS/919O9gRUUuLKk+WcdwDocjqPsvb2VmxsvJISkOTFBGp0dIJFIr8QgAV0ffvy8nIgnLxuFyAC43TmzJNWKDyDg/1QVHTGFhhh/PXrd+js7OVhpBBGIttVyaB2AVJV9zwxc/bsaXj+/AkcO5abETDCyebmFty+fRe+fftBygoEg/4q8wYJgIRmiJnx8ZGMgzGDamhoEUwlaCoOiLLJ4ZDmSTMvXjzFTIXpX/RS+Do6erimDCNaJbIvDkhRPCuU2l1dN8GugK3GmITu873hetI0fynZcUCK4r6OiD5K7YmJEav+MrKuvr6FHwmMMa+m+YcFoCXKqgcPelI+Z+yionOqr+9pnCWM1aYVEvLs7Du7/tOyr66+zAVuGNIpFOGqqDgHjx49TMuhXaP79x/CwsJnHjZUFM8kIlz6H+ESL/I3bPCeGAogYuWzZ4+hrKzY7sumZf/lSwi6uu4RQx+JIZ7uY2Ov41U7La82jOhM8npv7fRTquph5GthYdaGS/umFRXV3En2AVIU9yoinsiGkAFAKCtFnXVpz+tY1hyMonTk5sowM/PWfrqk4aGm5gpsbek7pYPsVdWzDADF/+O0Fqc0CToYnCtJaD9orBkff53GO6Zv0tDQysemhPbDzJLX28zHncN4RIMm2Ik3aPRBtLCy7GSDg/2H0sJ2dvYyXY/s3cLGWBoGgGskcDooMz1xCNZp8rh6tZULGQBeBYNzfBhNYEj8IKr/YYxBVN01ze8yy2PPQVGWj9D8XUxM0WyWqQmEqjrNZDFmQrr+23XgoEhoY9PrJPVJpKmmpnq8caPZls5fvnzDR2nSDDETiWzXWRqlzbuqqodrin6jI4Gy7+JFd0rApqf9/LKBUjv2JGgm2Zml6xiHQxqgEJIxhdF8HUPfRUgpJBQO83VMLDxkGjKMaLet6xgz+tgw0C2ApUBTiDE2QDOXFZsDGUp2QrVPkgwXANYBMLrOyzOBpM3DABgGYJPRqCOQ6pXeHyt3D3UGEb31AAAAAElFTkSuQmCC"
										alt="">선택 안함
								</div>
							</div>
						</div>
					</div>
					<div class="info-flex">
						<div class="label">
							목표 회사 / 직무<span>(필수)</span>
						</div>
						<div class="content prospect-area">
							<div class="company">
								회사
								<div class="CompletionInput company-input">
									<input type="text" placeholder="예) 삼성전자" class=""
										maxlength="30" value="">
								</div>
								<div class="CustomRadio null-select">
									<div class="radio select">
										<img
											src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACQAAAAkCAYAAADhAJiYAAAABHNCSVQICAgIfAhkiAAABR9JREFUWEfNWF1MFFcUPmc2SNhhBaktkDStbfWpTfh5orNElqQsPw8tKopNBF01aVN+QqO1xvTBh8ZYqwkRSPqiIJi0RKi0D/xtExbDbnkCNmmftNU0JgutxcVlliCZuc257Gx3dheYEdIybztzzr3ffue75+cimHyKiir2WCxqCWNQjcgyGYNMRMynZRhjM4gQZAyDiDCgKML45OTwIzNboFFju915nDHWom1u1G8VJLZ6vaO3jPhsCKio6D2HIAidiLCHFhRFKxQU5MH+/RLk5GRDbm4O5OZm870CgTkIBGZhdnYO7t3zwfS0H2Q5zL8RMFVln05O/uRZD9i6gCSprBMRT9AC2dmvwKlTdVBV5TTyR6M2g4OjcONGD8zN/akB6/L53K61FkkKKD/fkSmKKXcB0GG1prHTp+vxyJGDpoDEGxOo3t5+Fg4vIQDzyPLKgZkZTzDeLgEQgbFaU8ZIKxSe9varsG/fW5sCoznfv/8bNDae5WGkEIbDK6XxoBIA2e1lY8TM3r1vQlvb12CzpSeA+UNRYWhpGQaXnsOCqsIvKwq3eSfFAhmCAFVpO6AyLRVeswgJvqHQIjQ1fQYPHvxOyvJ4ve7SWCMdIE0zxExfX08CGAJyZUGG78LLhhg7ak2FcxliAjACVVNTpzGl01QUEJ0mi0UYI810dFzD+DARG43zIXjGmCEwmtFORGjPsnHWYh8KX0PDGa4pRVFLtdMXBSRJzod0tJubP4J4AX8bXoam+ZApIPHGbVk2+NCaqntNQu/svM315PO5C+gjByRJZScQsZOOdn9/j85pK8BoC3a/tDOBqUOH6nhKYIy5fD53lwZomk7VhQtndHmGNOOYfWo6TGtRSeHz5OzSaYry1KVL16IsYaQ2PSQhj4zc1a3VMB+CXoMCNhrPWmsqdGTZdObl5Qe4wBVFeAO1cBUXvwuXL1+MGhI7hYF5o/uYspvKzdKxdP78RZiY+JmHDSXJOYAIH8SH65vFJfgiKJvayKjxl5kifJyeFjX/N2zwAzHkQcSS69evQGFhXtTo/b8WwLe8YnQPU3ZSagr8+HJG1Gdqyg/NzeeIoXFiiB/3O3e6o1WbLPMD8/BYUU1tZNSYMrone1fUnHKSy/XJaj9ltzt5ppuYGNGtt/vxE6Prv5Ddk1d36/yKi8v57+0HSJLKHiHi6/9lyN5OscB4kpABgH9binrbHXtex7ZNYtRKR3q6CMPD3/8vpaOi4iAsLsqrpYMQ2O3OGQDIS1ZcS2afQshkD7RWHrAhwvgaxZUE7fWO5uvaDxpr+vq6detRY1b/97MXyjXxTsnaj5qaej426dqPWJZcrmN83Il9tqInWq9B09jhiVHbWGthRdHK2tuvJm1hqR0xGz4KE7UbyVrYxsazTJbDyVvYCEtdAHCcBE6JMn7ioJbkqwXZcI9Evc/nazT5hw/XcyEDwC2vd5QPozqGtBda9d9oDBqMGYN+jYxBlIG1MajKwBhE1d3nczti5ZF0UBTFHTR/5xFTNJtt5aBIM1mEGb8sP3dsOCjy1mN1eh2gPok0VVt7CE+ePLapk3bz5m0+SpNmiJlweKXa0Cgdu6vd7uSaoneUEuj0VVaWmQI2NOTmlw10tCOPTjPxixm6jrFYhFYKITlTGGOvY+i3FlJqtCgcsdcxkfCQq19R1JZNXcfEoo8MAy0aMBM0+RljrTRzGfHZkKH4Raj2CYLiAMBqAEbXeZkxIGnzIAAGAdiAqlo8Zq/0/gGye711zolR2AAAAABJRU5ErkJggg=="
											alt="">입력안함
									</div>
								</div>
							</div>
							<div class="job">
								직무
								<div class="CompletionInput job-input">
									<input type="text" placeholder="예) 제품 개발/기획" class=""
										maxlength="30" value="">
								</div>
								<div class="CustomRadio null-select">
									<div class="radio select">
										<img
											src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACQAAAAkCAYAAADhAJiYAAAABHNCSVQICAgIfAhkiAAABR9JREFUWEfNWF1MFFcUPmc2SNhhBaktkDStbfWpTfh5orNElqQsPw8tKopNBF01aVN+QqO1xvTBh8ZYqwkRSPqiIJi0RKi0D/xtExbDbnkCNmmftNU0JgutxcVlliCZuc257Gx3dheYEdIybztzzr3ffue75+cimHyKiir2WCxqCWNQjcgyGYNMRMynZRhjM4gQZAyDiDCgKML45OTwIzNboFFju915nDHWom1u1G8VJLZ6vaO3jPhsCKio6D2HIAidiLCHFhRFKxQU5MH+/RLk5GRDbm4O5OZm870CgTkIBGZhdnYO7t3zwfS0H2Q5zL8RMFVln05O/uRZD9i6gCSprBMRT9AC2dmvwKlTdVBV5TTyR6M2g4OjcONGD8zN/akB6/L53K61FkkKKD/fkSmKKXcB0GG1prHTp+vxyJGDpoDEGxOo3t5+Fg4vIQDzyPLKgZkZTzDeLgEQgbFaU8ZIKxSe9varsG/fW5sCoznfv/8bNDae5WGkEIbDK6XxoBIA2e1lY8TM3r1vQlvb12CzpSeA+UNRYWhpGQaXnsOCqsIvKwq3eSfFAhmCAFVpO6AyLRVeswgJvqHQIjQ1fQYPHvxOyvJ4ve7SWCMdIE0zxExfX08CGAJyZUGG78LLhhg7ak2FcxliAjACVVNTpzGl01QUEJ0mi0UYI810dFzD+DARG43zIXjGmCEwmtFORGjPsnHWYh8KX0PDGa4pRVFLtdMXBSRJzod0tJubP4J4AX8bXoam+ZApIPHGbVk2+NCaqntNQu/svM315PO5C+gjByRJZScQsZOOdn9/j85pK8BoC3a/tDOBqUOH6nhKYIy5fD53lwZomk7VhQtndHmGNOOYfWo6TGtRSeHz5OzSaYry1KVL16IsYaQ2PSQhj4zc1a3VMB+CXoMCNhrPWmsqdGTZdObl5Qe4wBVFeAO1cBUXvwuXL1+MGhI7hYF5o/uYspvKzdKxdP78RZiY+JmHDSXJOYAIH8SH65vFJfgiKJvayKjxl5kifJyeFjX/N2zwAzHkQcSS69evQGFhXtTo/b8WwLe8YnQPU3ZSagr8+HJG1Gdqyg/NzeeIoXFiiB/3O3e6o1WbLPMD8/BYUU1tZNSYMrone1fUnHKSy/XJaj9ltzt5ppuYGNGtt/vxE6Prv5Ddk1d36/yKi8v57+0HSJLKHiHi6/9lyN5OscB4kpABgH9binrbHXtex7ZNYtRKR3q6CMPD3/8vpaOi4iAsLsqrpYMQ2O3OGQDIS1ZcS2afQshkD7RWHrAhwvgaxZUE7fWO5uvaDxpr+vq6detRY1b/97MXyjXxTsnaj5qaej426dqPWJZcrmN83Il9tqInWq9B09jhiVHbWGthRdHK2tuvJm1hqR0xGz4KE7UbyVrYxsazTJbDyVvYCEtdAHCcBE6JMn7ioJbkqwXZcI9Evc/nazT5hw/XcyEDwC2vd5QPozqGtBda9d9oDBqMGYN+jYxBlIG1MajKwBhE1d3nczti5ZF0UBTFHTR/5xFTNJtt5aBIM1mEGb8sP3dsOCjy1mN1eh2gPok0VVt7CE+ePLapk3bz5m0+SpNmiJlweKXa0Cgdu6vd7uSaoneUEuj0VVaWmQI2NOTmlw10tCOPTjPxixm6jrFYhFYKITlTGGOvY+i3FlJqtCgcsdcxkfCQq19R1JZNXcfEoo8MAy0aMBM0+RljrTRzGfHZkKH4Raj2CYLiAMBqAEbXeZkxIGnzIAAGAdiAqlo8Zq/0/gGye711zolR2AAAAABJRU5ErkJggg=="
											alt="">입력안함
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="info-flex">
						<div class="label">취업 준비 시작시기</div>
						<div class="content year-flex">
							<div class="CustomSelect small">
								<div class="select-value close">
									<div class="txt">2020년</div>
									<span aria-hidden="true" class="fa fa-angle-down fa icon"></span>
								</div>
							</div>
							<div class="half false">상반기</div>
							<div class="half select">하반기</div>
						</div>
					</div>
					<div class="info-flex">
						<div class="label">전공</div>
						<div class="content radio-area">
							<div class="CustomRadio grid">
								<div class="radio false">
									<img
										src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACQAAAAkCAYAAADhAJiYAAAABHNCSVQICAgIfAhkiAAAA/tJREFUWEfNWE1ME1EQntkGE7uYcBI4+cuZnxPuEimJLchFFIQLoBUSE0GCAY3x5IkYxYQoHrEoXgigeOGvJlRDV05Cz/7ADfDUBLYmku0z8+ir24Kw7TbYPfXnzbxvv/nmzcxDSPEpL6856XBEKxmDOkSWxxjkIWIJuWGMLSNCmDEMI8KkYUgfFxdnVlPZAq0uVlXPNcZYt9jcqt0OSBwIBudeWbE5EFB5+QWXJEk+RDhJDmXZCaWlxXD+vAIFBflQWFgAhYX5fK+1tQ1YW1uH9fUN+PRJg6WlEOh6hP9HwKJRdmdx8UNgP2D7AlIUtw8Rr5OD/Pzj0NbWArW1HisvGl8zNTUHQ0MjsLHxUwAb1jS/919O9gRUUuLKk+WcdwDocjqPsvb2VmxsvJISkOTFBGp0dIJFIr8QgAV0ffvy8nIgnLxuFyAC43TmzJNWKDyDg/1QVHTGFhhh/PXrd+js7OVhpBBGIttVyaB2AVJV9zwxc/bsaXj+/AkcO5abETDCyebmFty+fRe+fftBygoEg/4q8wYJgIRmiJnx8ZGMgzGDamhoEUwlaCoOiLLJ4ZDmSTMvXjzFTIXpX/RS+Do6erimDCNaJbIvDkhRPCuU2l1dN8GugK3GmITu873hetI0fynZcUCK4r6OiD5K7YmJEav+MrKuvr6FHwmMMa+m+YcFoCXKqgcPelI+Z+yionOqr+9pnCWM1aYVEvLs7Du7/tOyr66+zAVuGNIpFOGqqDgHjx49TMuhXaP79x/CwsJnHjZUFM8kIlz6H+ESL/I3bPCeGAogYuWzZ4+hrKzY7sumZf/lSwi6uu4RQx+JIZ7uY2Ov41U7La82jOhM8npv7fRTquph5GthYdaGS/umFRXV3En2AVIU9yoinsiGkAFAKCtFnXVpz+tY1hyMonTk5sowM/PWfrqk4aGm5gpsbek7pYPsVdWzDADF/+O0Fqc0CToYnCtJaD9orBkff53GO6Zv0tDQysemhPbDzJLX28zHncN4RIMm2Ik3aPRBtLCy7GSDg/2H0sJ2dvYyXY/s3cLGWBoGgGskcDooMz1xCNZp8rh6tZULGQBeBYNzfBhNYEj8IKr/YYxBVN01ze8yy2PPQVGWj9D8XUxM0WyWqQmEqjrNZDFmQrr+23XgoEhoY9PrJPVJpKmmpnq8caPZls5fvnzDR2nSDDETiWzXWRqlzbuqqodrin6jI4Gy7+JFd0rApqf9/LKBUjv2JGgm2Zml6xiHQxqgEJIxhdF8HUPfRUgpJBQO83VMLDxkGjKMaLet6xgz+tgw0C2ApUBTiDE2QDOXFZsDGUp2QrVPkgwXANYBMLrOyzOBpM3DABgGYJPRqCOQ6pXeHyt3D3UGEb31AAAAAElFTkSuQmCC"
										alt="">인문
								</div>
								<div class="radio false">
									<img
										src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACQAAAAkCAYAAADhAJiYAAAABHNCSVQICAgIfAhkiAAAA/tJREFUWEfNWE1ME1EQntkGE7uYcBI4+cuZnxPuEimJLchFFIQLoBUSE0GCAY3x5IkYxYQoHrEoXgigeOGvJlRDV05Cz/7ADfDUBLYmku0z8+ir24Kw7TbYPfXnzbxvv/nmzcxDSPEpL6856XBEKxmDOkSWxxjkIWIJuWGMLSNCmDEMI8KkYUgfFxdnVlPZAq0uVlXPNcZYt9jcqt0OSBwIBudeWbE5EFB5+QWXJEk+RDhJDmXZCaWlxXD+vAIFBflQWFgAhYX5fK+1tQ1YW1uH9fUN+PRJg6WlEOh6hP9HwKJRdmdx8UNgP2D7AlIUtw8Rr5OD/Pzj0NbWArW1HisvGl8zNTUHQ0MjsLHxUwAb1jS/919O9gRUUuLKk+WcdwDocjqPsvb2VmxsvJISkOTFBGp0dIJFIr8QgAV0ffvy8nIgnLxuFyAC43TmzJNWKDyDg/1QVHTGFhhh/PXrd+js7OVhpBBGIttVyaB2AVJV9zwxc/bsaXj+/AkcO5abETDCyebmFty+fRe+fftBygoEg/4q8wYJgIRmiJnx8ZGMgzGDamhoEUwlaCoOiLLJ4ZDmSTMvXjzFTIXpX/RS+Do6erimDCNaJbIvDkhRPCuU2l1dN8GugK3GmITu873hetI0fynZcUCK4r6OiD5K7YmJEav+MrKuvr6FHwmMMa+m+YcFoCXKqgcPelI+Z+yionOqr+9pnCWM1aYVEvLs7Du7/tOyr66+zAVuGNIpFOGqqDgHjx49TMuhXaP79x/CwsJnHjZUFM8kIlz6H+ESL/I3bPCeGAogYuWzZ4+hrKzY7sumZf/lSwi6uu4RQx+JIZ7uY2Ov41U7La82jOhM8npv7fRTquph5GthYdaGS/umFRXV3En2AVIU9yoinsiGkAFAKCtFnXVpz+tY1hyMonTk5sowM/PWfrqk4aGm5gpsbek7pYPsVdWzDADF/+O0Fqc0CToYnCtJaD9orBkff53GO6Zv0tDQysemhPbDzJLX28zHncN4RIMm2Ik3aPRBtLCy7GSDg/2H0sJ2dvYyXY/s3cLGWBoGgGskcDooMz1xCNZp8rh6tZULGQBeBYNzfBhNYEj8IKr/YYxBVN01ze8yy2PPQVGWj9D8XUxM0WyWqQmEqjrNZDFmQrr+23XgoEhoY9PrJPVJpKmmpnq8caPZls5fvnzDR2nSDDETiWzXWRqlzbuqqodrin6jI4Gy7+JFd0rApqf9/LKBUjv2JGgm2Zml6xiHQxqgEJIxhdF8HUPfRUgpJBQO83VMLDxkGjKMaLet6xgz+tgw0C2ApUBTiDE2QDOXFZsDGUp2QrVPkgwXANYBMLrOyzOBpM3DABgGYJPRqCOQ6pXeHyt3D3UGEb31AAAAAElFTkSuQmCC"
										alt="">사회
								</div>
								<div class="radio select">
									<img
										src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACQAAAAkCAYAAADhAJiYAAAABHNCSVQICAgIfAhkiAAABR9JREFUWEfNWF1MFFcUPmc2SNhhBaktkDStbfWpTfh5orNElqQsPw8tKopNBF01aVN+QqO1xvTBh8ZYqwkRSPqiIJi0RKi0D/xtExbDbnkCNmmftNU0JgutxcVlliCZuc257Gx3dheYEdIybztzzr3ffue75+cimHyKiir2WCxqCWNQjcgyGYNMRMynZRhjM4gQZAyDiDCgKML45OTwIzNboFFju915nDHWom1u1G8VJLZ6vaO3jPhsCKio6D2HIAidiLCHFhRFKxQU5MH+/RLk5GRDbm4O5OZm870CgTkIBGZhdnYO7t3zwfS0H2Q5zL8RMFVln05O/uRZD9i6gCSprBMRT9AC2dmvwKlTdVBV5TTyR6M2g4OjcONGD8zN/akB6/L53K61FkkKKD/fkSmKKXcB0GG1prHTp+vxyJGDpoDEGxOo3t5+Fg4vIQDzyPLKgZkZTzDeLgEQgbFaU8ZIKxSe9varsG/fW5sCoznfv/8bNDae5WGkEIbDK6XxoBIA2e1lY8TM3r1vQlvb12CzpSeA+UNRYWhpGQaXnsOCqsIvKwq3eSfFAhmCAFVpO6AyLRVeswgJvqHQIjQ1fQYPHvxOyvJ4ve7SWCMdIE0zxExfX08CGAJyZUGG78LLhhg7ak2FcxliAjACVVNTpzGl01QUEJ0mi0UYI810dFzD+DARG43zIXjGmCEwmtFORGjPsnHWYh8KX0PDGa4pRVFLtdMXBSRJzod0tJubP4J4AX8bXoam+ZApIPHGbVk2+NCaqntNQu/svM315PO5C+gjByRJZScQsZOOdn9/j85pK8BoC3a/tDOBqUOH6nhKYIy5fD53lwZomk7VhQtndHmGNOOYfWo6TGtRSeHz5OzSaYry1KVL16IsYaQ2PSQhj4zc1a3VMB+CXoMCNhrPWmsqdGTZdObl5Qe4wBVFeAO1cBUXvwuXL1+MGhI7hYF5o/uYspvKzdKxdP78RZiY+JmHDSXJOYAIH8SH65vFJfgiKJvayKjxl5kifJyeFjX/N2zwAzHkQcSS69evQGFhXtTo/b8WwLe8YnQPU3ZSagr8+HJG1Gdqyg/NzeeIoXFiiB/3O3e6o1WbLPMD8/BYUU1tZNSYMrone1fUnHKSy/XJaj9ltzt5ppuYGNGtt/vxE6Prv5Ddk1d36/yKi8v57+0HSJLKHiHi6/9lyN5OscB4kpABgH9binrbHXtex7ZNYtRKR3q6CMPD3/8vpaOi4iAsLsqrpYMQ2O3OGQDIS1ZcS2afQshkD7RWHrAhwvgaxZUE7fWO5uvaDxpr+vq6detRY1b/97MXyjXxTsnaj5qaej426dqPWJZcrmN83Il9tqInWq9B09jhiVHbWGthRdHK2tuvJm1hqR0xGz4KE7UbyVrYxsazTJbDyVvYCEtdAHCcBE6JMn7ioJbkqwXZcI9Evc/nazT5hw/XcyEDwC2vd5QPozqGtBda9d9oDBqMGYN+jYxBlIG1MajKwBhE1d3nczti5ZF0UBTFHTR/5xFTNJtt5aBIM1mEGb8sP3dsOCjy1mN1eh2gPok0VVt7CE+ePLapk3bz5m0+SpNmiJlweKXa0Cgdu6vd7uSaoneUEuj0VVaWmQI2NOTmlw10tCOPTjPxixm6jrFYhFYKITlTGGOvY+i3FlJqtCgcsdcxkfCQq19R1JZNXcfEoo8MAy0aMBM0+RljrTRzGfHZkKH4Raj2CYLiAMBqAEbXeZkxIGnzIAAGAdiAqlo8Zq/0/gGye711zolR2AAAAABJRU5ErkJggg=="
										alt="">공학
								</div>
								<div class="radio false">
									<img
										src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACQAAAAkCAYAAADhAJiYAAAABHNCSVQICAgIfAhkiAAAA/tJREFUWEfNWE1ME1EQntkGE7uYcBI4+cuZnxPuEimJLchFFIQLoBUSE0GCAY3x5IkYxYQoHrEoXgigeOGvJlRDV05Cz/7ADfDUBLYmku0z8+ir24Kw7TbYPfXnzbxvv/nmzcxDSPEpL6856XBEKxmDOkSWxxjkIWIJuWGMLSNCmDEMI8KkYUgfFxdnVlPZAq0uVlXPNcZYt9jcqt0OSBwIBudeWbE5EFB5+QWXJEk+RDhJDmXZCaWlxXD+vAIFBflQWFgAhYX5fK+1tQ1YW1uH9fUN+PRJg6WlEOh6hP9HwKJRdmdx8UNgP2D7AlIUtw8Rr5OD/Pzj0NbWArW1HisvGl8zNTUHQ0MjsLHxUwAb1jS/919O9gRUUuLKk+WcdwDocjqPsvb2VmxsvJISkOTFBGp0dIJFIr8QgAV0ffvy8nIgnLxuFyAC43TmzJNWKDyDg/1QVHTGFhhh/PXrd+js7OVhpBBGIttVyaB2AVJV9zwxc/bsaXj+/AkcO5abETDCyebmFty+fRe+fftBygoEg/4q8wYJgIRmiJnx8ZGMgzGDamhoEUwlaCoOiLLJ4ZDmSTMvXjzFTIXpX/RS+Do6erimDCNaJbIvDkhRPCuU2l1dN8GugK3GmITu873hetI0fynZcUCK4r6OiD5K7YmJEav+MrKuvr6FHwmMMa+m+YcFoCXKqgcPelI+Z+yionOqr+9pnCWM1aYVEvLs7Du7/tOyr66+zAVuGNIpFOGqqDgHjx49TMuhXaP79x/CwsJnHjZUFM8kIlz6H+ESL/I3bPCeGAogYuWzZ4+hrKzY7sumZf/lSwi6uu4RQx+JIZ7uY2Ov41U7La82jOhM8npv7fRTquph5GthYdaGS/umFRXV3En2AVIU9yoinsiGkAFAKCtFnXVpz+tY1hyMonTk5sowM/PWfrqk4aGm5gpsbek7pYPsVdWzDADF/+O0Fqc0CToYnCtJaD9orBkff53GO6Zv0tDQysemhPbDzJLX28zHncN4RIMm2Ik3aPRBtLCy7GSDg/2H0sJ2dvYyXY/s3cLGWBoGgGskcDooMz1xCNZp8rh6tZULGQBeBYNzfBhNYEj8IKr/YYxBVN01ze8yy2PPQVGWj9D8XUxM0WyWqQmEqjrNZDFmQrr+23XgoEhoY9PrJPVJpKmmpnq8caPZls5fvnzDR2nSDDETiWzXWRqlzbuqqodrin6jI4Gy7+JFd0rApqf9/LKBUjv2JGgm2Zml6xiHQxqgEJIxhdF8HUPfRUgpJBQO83VMLDxkGjKMaLet6xgz+tgw0C2ApUBTiDE2QDOXFZsDGUp2QrVPkgwXANYBMLrOyzOBpM3DABgGYJPRqCOQ6pXeHyt3D3UGEb31AAAAAElFTkSuQmCC"
										alt="">자연
								</div>
								<div class="radio false">
									<img
										src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACQAAAAkCAYAAADhAJiYAAAABHNCSVQICAgIfAhkiAAAA/tJREFUWEfNWE1ME1EQntkGE7uYcBI4+cuZnxPuEimJLchFFIQLoBUSE0GCAY3x5IkYxYQoHrEoXgigeOGvJlRDV05Cz/7ADfDUBLYmku0z8+ir24Kw7TbYPfXnzbxvv/nmzcxDSPEpL6856XBEKxmDOkSWxxjkIWIJuWGMLSNCmDEMI8KkYUgfFxdnVlPZAq0uVlXPNcZYt9jcqt0OSBwIBudeWbE5EFB5+QWXJEk+RDhJDmXZCaWlxXD+vAIFBflQWFgAhYX5fK+1tQ1YW1uH9fUN+PRJg6WlEOh6hP9HwKJRdmdx8UNgP2D7AlIUtw8Rr5OD/Pzj0NbWArW1HisvGl8zNTUHQ0MjsLHxUwAb1jS/919O9gRUUuLKk+WcdwDocjqPsvb2VmxsvJISkOTFBGp0dIJFIr8QgAV0ffvy8nIgnLxuFyAC43TmzJNWKDyDg/1QVHTGFhhh/PXrd+js7OVhpBBGIttVyaB2AVJV9zwxc/bsaXj+/AkcO5abETDCyebmFty+fRe+fftBygoEg/4q8wYJgIRmiJnx8ZGMgzGDamhoEUwlaCoOiLLJ4ZDmSTMvXjzFTIXpX/RS+Do6erimDCNaJbIvDkhRPCuU2l1dN8GugK3GmITu873hetI0fynZcUCK4r6OiD5K7YmJEav+MrKuvr6FHwmMMa+m+YcFoCXKqgcPelI+Z+yionOqr+9pnCWM1aYVEvLs7Du7/tOyr66+zAVuGNIpFOGqqDgHjx49TMuhXaP79x/CwsJnHjZUFM8kIlz6H+ESL/I3bPCeGAogYuWzZ4+hrKzY7sumZf/lSwi6uu4RQx+JIZ7uY2Ov41U7La82jOhM8npv7fRTquph5GthYdaGS/umFRXV3En2AVIU9yoinsiGkAFAKCtFnXVpz+tY1hyMonTk5sowM/PWfrqk4aGm5gpsbek7pYPsVdWzDADF/+O0Fqc0CToYnCtJaD9orBkff53GO6Zv0tDQysemhPbDzJLX28zHncN4RIMm2Ik3aPRBtLCy7GSDg/2H0sJ2dvYyXY/s3cLGWBoGgGskcDooMz1xCNZp8rh6tZULGQBeBYNzfBhNYEj8IKr/YYxBVN01ze8yy2PPQVGWj9D8XUxM0WyWqQmEqjrNZDFmQrr+23XgoEhoY9PrJPVJpKmmpnq8caPZls5fvnzDR2nSDDETiWzXWRqlzbuqqodrin6jI4Gy7+JFd0rApqf9/LKBUjv2JGgm2Zml6xiHQxqgEJIxhdF8HUPfRUgpJBQO83VMLDxkGjKMaLet6xgz+tgw0C2ApUBTiDE2QDOXFZsDGUp2QrVPkgwXANYBMLrOyzOBpM3DABgGYJPRqCOQ6pXeHyt3D3UGEb31AAAAAElFTkSuQmCC"
										alt="">예체능
								</div>
								<div class="radio false">
									<img
										src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACQAAAAkCAYAAADhAJiYAAAABHNCSVQICAgIfAhkiAAAA/tJREFUWEfNWE1ME1EQntkGE7uYcBI4+cuZnxPuEimJLchFFIQLoBUSE0GCAY3x5IkYxYQoHrEoXgigeOGvJlRDV05Cz/7ADfDUBLYmku0z8+ir24Kw7TbYPfXnzbxvv/nmzcxDSPEpL6856XBEKxmDOkSWxxjkIWIJuWGMLSNCmDEMI8KkYUgfFxdnVlPZAq0uVlXPNcZYt9jcqt0OSBwIBudeWbE5EFB5+QWXJEk+RDhJDmXZCaWlxXD+vAIFBflQWFgAhYX5fK+1tQ1YW1uH9fUN+PRJg6WlEOh6hP9HwKJRdmdx8UNgP2D7AlIUtw8Rr5OD/Pzj0NbWArW1HisvGl8zNTUHQ0MjsLHxUwAb1jS/919O9gRUUuLKk+WcdwDocjqPsvb2VmxsvJISkOTFBGp0dIJFIr8QgAV0ffvy8nIgnLxuFyAC43TmzJNWKDyDg/1QVHTGFhhh/PXrd+js7OVhpBBGIttVyaB2AVJV9zwxc/bsaXj+/AkcO5abETDCyebmFty+fRe+fftBygoEg/4q8wYJgIRmiJnx8ZGMgzGDamhoEUwlaCoOiLLJ4ZDmSTMvXjzFTIXpX/RS+Do6erimDCNaJbIvDkhRPCuU2l1dN8GugK3GmITu873hetI0fynZcUCK4r6OiD5K7YmJEav+MrKuvr6FHwmMMa+m+YcFoCXKqgcPelI+Z+yionOqr+9pnCWM1aYVEvLs7Du7/tOyr66+zAVuGNIpFOGqqDgHjx49TMuhXaP79x/CwsJnHjZUFM8kIlz6H+ESL/I3bPCeGAogYuWzZ4+hrKzY7sumZf/lSwi6uu4RQx+JIZ7uY2Ov41U7La82jOhM8npv7fRTquph5GthYdaGS/umFRXV3En2AVIU9yoinsiGkAFAKCtFnXVpz+tY1hyMonTk5sowM/PWfrqk4aGm5gpsbek7pYPsVdWzDADF/+O0Fqc0CToYnCtJaD9orBkff53GO6Zv0tDQysemhPbDzJLX28zHncN4RIMm2Ik3aPRBtLCy7GSDg/2H0sJ2dvYyXY/s3cLGWBoGgGskcDooMz1xCNZp8rh6tZULGQBeBYNzfBhNYEj8IKr/YYxBVN01ze8yy2PPQVGWj9D8XUxM0WyWqQmEqjrNZDFmQrr+23XgoEhoY9PrJPVJpKmmpnq8caPZls5fvnzDR2nSDDETiWzXWRqlzbuqqodrin6jI4Gy7+JFd0rApqf9/LKBUjv2JGgm2Zml6xiHQxqgEJIxhdF8HUPfRUgpJBQO83VMLDxkGjKMaLet6xgz+tgw0C2ApUBTiDE2QDOXFZsDGUp2QrVPkgwXANYBMLrOyzOBpM3DABgGYJPRqCOQ6pXeHyt3D3UGEb31AAAAAElFTkSuQmCC"
										alt="">기타
								</div>
							</div>
						</div>
					</div>
					<div class="info-flex">
						<div class="label">제 3자 정보 제공 동의</div>
						<div class="content radio-area">
							<div class="CustomRadio grid two">
								<div class="radio select">
									<img
										src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACQAAAAkCAYAAADhAJiYAAAABHNCSVQICAgIfAhkiAAABR9JREFUWEfNWF1MFFcUPmc2SNhhBaktkDStbfWpTfh5orNElqQsPw8tKopNBF01aVN+QqO1xvTBh8ZYqwkRSPqiIJi0RKi0D/xtExbDbnkCNmmftNU0JgutxcVlliCZuc257Gx3dheYEdIybztzzr3ffue75+cimHyKiir2WCxqCWNQjcgyGYNMRMynZRhjM4gQZAyDiDCgKML45OTwIzNboFFju915nDHWom1u1G8VJLZ6vaO3jPhsCKio6D2HIAidiLCHFhRFKxQU5MH+/RLk5GRDbm4O5OZm870CgTkIBGZhdnYO7t3zwfS0H2Q5zL8RMFVln05O/uRZD9i6gCSprBMRT9AC2dmvwKlTdVBV5TTyR6M2g4OjcONGD8zN/akB6/L53K61FkkKKD/fkSmKKXcB0GG1prHTp+vxyJGDpoDEGxOo3t5+Fg4vIQDzyPLKgZkZTzDeLgEQgbFaU8ZIKxSe9varsG/fW5sCoznfv/8bNDae5WGkEIbDK6XxoBIA2e1lY8TM3r1vQlvb12CzpSeA+UNRYWhpGQaXnsOCqsIvKwq3eSfFAhmCAFVpO6AyLRVeswgJvqHQIjQ1fQYPHvxOyvJ4ve7SWCMdIE0zxExfX08CGAJyZUGG78LLhhg7ak2FcxliAjACVVNTpzGl01QUEJ0mi0UYI810dFzD+DARG43zIXjGmCEwmtFORGjPsnHWYh8KX0PDGa4pRVFLtdMXBSRJzod0tJubP4J4AX8bXoam+ZApIPHGbVk2+NCaqntNQu/svM315PO5C+gjByRJZScQsZOOdn9/j85pK8BoC3a/tDOBqUOH6nhKYIy5fD53lwZomk7VhQtndHmGNOOYfWo6TGtRSeHz5OzSaYry1KVL16IsYaQ2PSQhj4zc1a3VMB+CXoMCNhrPWmsqdGTZdObl5Qe4wBVFeAO1cBUXvwuXL1+MGhI7hYF5o/uYspvKzdKxdP78RZiY+JmHDSXJOYAIH8SH65vFJfgiKJvayKjxl5kifJyeFjX/N2zwAzHkQcSS69evQGFhXtTo/b8WwLe8YnQPU3ZSagr8+HJG1Gdqyg/NzeeIoXFiiB/3O3e6o1WbLPMD8/BYUU1tZNSYMrone1fUnHKSy/XJaj9ltzt5ppuYGNGtt/vxE6Prv5Ddk1d36/yKi8v57+0HSJLKHiHi6/9lyN5OscB4kpABgH9binrbHXtex7ZNYtRKR3q6CMPD3/8vpaOi4iAsLsqrpYMQ2O3OGQDIS1ZcS2afQshkD7RWHrAhwvgaxZUE7fWO5uvaDxpr+vq6detRY1b/97MXyjXxTsnaj5qaej426dqPWJZcrmN83Il9tqInWq9B09jhiVHbWGthRdHK2tuvJm1hqR0xGz4KE7UbyVrYxsazTJbDyVvYCEtdAHCcBE6JMn7ioJbkqwXZcI9Evc/nazT5hw/XcyEDwC2vd5QPozqGtBda9d9oDBqMGYN+jYxBlIG1MajKwBhE1d3nczti5ZF0UBTFHTR/5xFTNJtt5aBIM1mEGb8sP3dsOCjy1mN1eh2gPok0VVt7CE+ePLapk3bz5m0+SpNmiJlweKXa0Cgdu6vd7uSaoneUEuj0VVaWmQI2NOTmlw10tCOPTjPxixm6jrFYhFYKITlTGGOvY+i3FlJqtCgcsdcxkfCQq19R1JZNXcfEoo8MAy0aMBM0+RljrTRzGfHZkKH4Raj2CYLiAMBqAEbXeZkxIGnzIAAGAdiAqlo8Zq/0/gGye711zolR2AAAAABJRU5ErkJggg=="
										alt="">동의
								</div>
								<div class="radio false">
									<img
										src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACQAAAAkCAYAAADhAJiYAAAABHNCSVQICAgIfAhkiAAAA/tJREFUWEfNWE1ME1EQntkGE7uYcBI4+cuZnxPuEimJLchFFIQLoBUSE0GCAY3x5IkYxYQoHrEoXgigeOGvJlRDV05Cz/7ADfDUBLYmku0z8+ir24Kw7TbYPfXnzbxvv/nmzcxDSPEpL6856XBEKxmDOkSWxxjkIWIJuWGMLSNCmDEMI8KkYUgfFxdnVlPZAq0uVlXPNcZYt9jcqt0OSBwIBudeWbE5EFB5+QWXJEk+RDhJDmXZCaWlxXD+vAIFBflQWFgAhYX5fK+1tQ1YW1uH9fUN+PRJg6WlEOh6hP9HwKJRdmdx8UNgP2D7AlIUtw8Rr5OD/Pzj0NbWArW1HisvGl8zNTUHQ0MjsLHxUwAb1jS/919O9gRUUuLKk+WcdwDocjqPsvb2VmxsvJISkOTFBGp0dIJFIr8QgAV0ffvy8nIgnLxuFyAC43TmzJNWKDyDg/1QVHTGFhhh/PXrd+js7OVhpBBGIttVyaB2AVJV9zwxc/bsaXj+/AkcO5abETDCyebmFty+fRe+fftBygoEg/4q8wYJgIRmiJnx8ZGMgzGDamhoEUwlaCoOiLLJ4ZDmSTMvXjzFTIXpX/RS+Do6erimDCNaJbIvDkhRPCuU2l1dN8GugK3GmITu873hetI0fynZcUCK4r6OiD5K7YmJEav+MrKuvr6FHwmMMa+m+YcFoCXKqgcPelI+Z+yionOqr+9pnCWM1aYVEvLs7Du7/tOyr66+zAVuGNIpFOGqqDgHjx49TMuhXaP79x/CwsJnHjZUFM8kIlz6H+ESL/I3bPCeGAogYuWzZ4+hrKzY7sumZf/lSwi6uu4RQx+JIZ7uY2Ov41U7La82jOhM8npv7fRTquph5GthYdaGS/umFRXV3En2AVIU9yoinsiGkAFAKCtFnXVpz+tY1hyMonTk5sowM/PWfrqk4aGm5gpsbek7pYPsVdWzDADF/+O0Fqc0CToYnCtJaD9orBkff53GO6Zv0tDQysemhPbDzJLX28zHncN4RIMm2Ik3aPRBtLCy7GSDg/2H0sJ2dvYyXY/s3cLGWBoGgGskcDooMz1xCNZp8rh6tZULGQBeBYNzfBhNYEj8IKr/YYxBVN01ze8yy2PPQVGWj9D8XUxM0WyWqQmEqjrNZDFmQrr+23XgoEhoY9PrJPVJpKmmpnq8caPZls5fvnzDR2nSDDETiWzXWRqlzbuqqodrin6jI4Gy7+JFd0rApqf9/LKBUjv2JGgm2Zml6xiHQxqgEJIxhdF8HUPfRUgpJBQO83VMLDxkGjKMaLet6xgz+tgw0C2ApUBTiDE2QDOXFZsDGUp2QrVPkgwXANYBMLrOyzOBpM3DABgGYJPRqCOQ6pXeHyt3D3UGEb31AAAAAElFTkSuQmCC"
										alt="">거부
								</div>
							</div>
							<a class="third-link-btn" target="_blank"
								href="${cp }/agreement/marketingAgree">내용 보기</a>
						</div>
					</div>
					<div class="submit-area">
						<button class="submit unactive" onclick="location.href='/myProfile/updateComplete'">적용</button>
						<button class="cancel" onclick="location.href='/myProfile/myProfile'">취소</button>
					</div>
				</div>
			</div>
			<%@ include file="/WEB-INF/views/layout/myPageFooter.jsp" %>
		</div>
	</div>
<!-- 	<style data-styled="active" data-styled-version="5.1.1"></style> -->
</body>
</html>