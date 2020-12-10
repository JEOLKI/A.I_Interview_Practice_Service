<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<%@ include file="/WEB-INF/views/layout/commonLib.jsp"%>
<style>
/* The Modal (background) */
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
		<div class="Main false">

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
				<img
					src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADcAAAAQCAYAAACycufIAAAABHNCSVQICAgIfAhkiAAAAvJJREFUSEvdVs1O20AQnrGTCiWHhido6Qs03MIatUHFVk8FpF6rkmsvTS+VeipVq16bPgGoTxBuKEbCHLLkVvMGeQQ4JEgE71QTe+naMf/hgm9rz3r3m++bbwbhgT1CuO8Q8Q/DwgeGDVLghHADRCATJBEeAUAIoEIpd7evSkCt9vopYrSCiBVEqmfjieAQALYQ4Rd/47WUfjMbJ4T3FoDe8PuzM/WjULA+IMJzXkeR3ej1dvqTe9yWjul2/aXFxVfPoggXx8w5jpcCNgmEjpTCxsFBp539Vq3WK+Xyo68AMHHRdLJoXynasG1rLwZH+1L6E0lwHPcnAH6J90YviKzviPgyXlPAl88BF+iYbreTUuI1wOnfqU/d7m5LrxhYqVTcQ8TqVcwymLuDGzP+TcrOhnlerLw4AReCM7PJF5+ZKVQty2oiwso5PAVrmkEhvLb+RkTHANhSSgW93m6g47UqpgUuYX1eSj/UZ9wYnJkZx1luAli6VvpSduaEcKuI+Dc57BgA6uaB9wwuHA5HS2EYsC+wgdyMuct0TUTzALCOiB8TcA0p/a08aU6TOSLYNpTyWxvSFMB5G4jAxgFKwRoiNbXOo8iay3Mxjp0muMHgdLZUKoaI+CR2T7XEJXBncGlpUiNhLreI05KOnXgaNcdmUast17XjAtDRYDCaK5WK7RsZSlZijuOx7N7rjNm2ta7XzGRem5g2c9oJheC+pksC2gA0e2twWfOQ0q8I4XLNbSashFL6XIcTzzRladq843jsluPmzgwCYOXarUDfcmHBW7Us2tSbzT4jhNvX+ucGmzdB3Bc4M+FmRi9p4pwBHrnOn6oGlbw5HAxO64YFc/NmG36sdxBBH5GMEQnHU0hOzYVE6anm5GR0WC4XP180oWQvbvqAPv9WEwpfbjgcrWpg+mecwSzAPHlmweXFsPvZNnrXBcf/MJ3yUllmD0ymjkAp1TKnjmxcPF8W1olw9f8cmI66L3A8sFtWxO1hrJ4sc/8Az8CsuRK8Ou8AAAAASUVORK5CYII="
					class="doodlin-logo" alt="doodlin-logo">
			</div>
			<div class="doodlin-message">
				@<b>Doodlin Corp.</b> All Rights Reserved.
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