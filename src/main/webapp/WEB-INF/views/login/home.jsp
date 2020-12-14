<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<%@ include file="/WEB-INF/views/layout/commonLib.jsp"%>
<style>
/* The Modal (background) */
	.aiInterview-logo{
		width: 175px;
		height: 52px;
		margin-top: 5px;
		margin-left: 6px;		
	}
	
.modal {
	display: none; /* Hidden by default */
	position: fixed; /* Stay in place */
	z-index: 1; /* Sit on top */
	left: 0;
	top: 0;
	width: 100%; /* Full width */
	height: 100%; /* Full height */
	overflow: auto; /* Enable scroll if needed */
	background-color: rgb(0, 0, 0); /* Fallback color */
	background-color: rgba(0, 0, 0, 0.4); /* Black w/ opacity */
}
/* Modal Content/Box */
.modal-content {
	background-color: #fefefe;
	margin: 15% auto; /* 15% from the top and centered */
	padding: 20px;
	border: 1px solid #888;
	width: 17%; /* Could be more or less, depending on screen size */
}

#searchModal {
	display: none; /* Hidden by default */
	position: fixed; /* Stay in place */
	z-index: 1; /* Sit on top */
	left: 0;
	top: 0;
	width: 100%; /* Full width */
	height: 100%; /* Full height */
	overflow: auto; /* Enable scroll if needed */
	background-color: rgb(0, 0, 0); /* Fallback color */
	background-color: rgba(0, 0, 0, 0.4); /* Black w/ opacity */
}
/* Modal Content/Box */
#searchModal-content {
	background-color: #fefefe;
	margin: 15% auto; /* 15% from the top and centered */
	padding: 20px;
	border: 1px solid #888;
	width: 30%; /* Could be more or less, depending on screen size */
}

.input-left {
	width: 70%;
	float: left;
}

.input {
	display: inline-block;
	margin-bottom: 12px;
	width: 60%;
}

.inputname {
	display: inline-block;
	width: 35%;
}

#loginbtn {
	width: 70px;
	height: 70px;
	margin-left: 3%;
}

.search {
	text-align: center;
}
#searchbtn{
	width: 70px;
	height: 70px;
	margin-left: 3%;
}
</style>
<script>
$(document).ready(function() {
    $('#login').on('click',function(){
		 $('#myModal').show();
    });
    $('#join').on('click',function(){
    	document.location="/login/join"
    });
    $('.search').on('click',function(){
		 $('#searchModal').show();
    });
    $('#ready').on('click',function(){
    	if(${S_MEMBER.memId !=null}){
    		document.location="/interview/ready.do";
    	}else{
		 $('#myModal').show();
    	}
    });
});
//팝업 Close 기능
function close_pop(flag) {
 $('#myModal').hide();
};
function search_close_pop(flag) {
 $('#searchModal').hide();
};
</script>
</head>
<body>
	<noscript>You need to enable JavaScript to run this app.</noscript>
	<div id="root">
		<div class="Main false" style="overflow-y: hidden; overflow-x:hidden; ">

			<%@ include file="/WEB-INF/views/layout/header.jsp"%>

			<div class="my-bar false" style="position: fixed;">
				<div class="title">내 면접</div>
			</div>
			<div class="MainView">
				<div class="box">
					<div class="interface">
						<div class="title">
							모의면접을<br>시작해 보세요!
						</div>
						<div class="sub-title">인공지능의 다양한 분석과 함께 면접 능력을 향상시켜 보세요.</div>
						<div class="start-area BtnArea">
							<button id="ready" class="start-btn Btn">첫 면접 시작하기</button>
							<div class="Shadow"></div>
						</div>
					</div>
					<img src="/images/illust.139cb872.svg" alt="" class="illust">
				</div>
			</div>
			<footer class="SimpleFooter">
			<div class="logo-area">
				<img src="/images/Ai_Interview 로고.png" class="aiInterview-logo"
				alt="aiInterview-logo">
			</div>
			<div class="aiInterview-message">
				@<b>Ourthec Corp.</b> All Rights Reserved.
			</div>
			<div class="nav-flex">
				<div class="user-agreement">
					<a href="/agreement/user-agree">회원이용약관</a>
				</div>
				<div class="personal-info">
					<a href="/agreement/personal-agree">개인정보처리방침</a>
				</div>
				<div class="about-us">ABOUT US</div>
			</div>
			</footer>
		</div>
	</div>
   <style data-styled="active" data-styled-version="5.1.1"></style>
   </body>
</html>