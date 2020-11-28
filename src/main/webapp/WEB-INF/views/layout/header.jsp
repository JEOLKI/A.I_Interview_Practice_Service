<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
 	#header{
 		position: static;
 	}
 	/* The Modal (background) */
	#myModal {
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
	#modal-content {
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
	#changeModal {
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
	#changeModal-content {
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
	
	.inputname{
		display: inline-block;
		width: 35%;
	}
	
	#searchbtn {
		width: 70px;
		height: 70px;
		margin-left: 3%;
	}
	.search{
		text-align:center;
	}
	#searchbtn{
		width: 70px;
		height: 70px;
		margin-left: 3%;
	}
	#changebtn{
		width: 70px;
		height: 70px;
		margin-left: 3%;
	}
</style>
<script>
$(document).ready(function() {
		 $('#changeModal').show();
    $('#login').on('click',function(){
		 $('#myModal').show();
    });
    $('#join').on('click',function(){
    	document.location="/login/join"
    });
    $('#experience').on('click',function(){
    	document.location="/login/experience"
    });
    $('.search').on('click',function(){
		 $('#searchModal').show();
    });
});
//팝업 Close 기능
function close_pop(flag) {
 $('#myModal').hide();
};
function search_close_pop(flag) {
 $('#searchModal').hide();
};
function change_close_pop(flag) {
 $('#changeModal').hide();
};
</script>
<!-- header -->
<div class="TopBar undefined" id  ="header">
	<div class="navigation-bar">
		<a class="iam-logo" href="/"><img
			src="/static/media/black-long.c5df35b3.svg" alt="iam-logo"
			class="iam-img"></a>
		<div class="nav">
			<a class="main false" href="/main">내 면접</a><a class="lecture false"
				href="/lecture">게시판</a>
			<a class="service-intro false" href="/service-intro">서비스 소개</a><a
				class="help-info false" href="/help-info">도움말</a>
		</div>
	</div>
	<button id="login" class="login">로그인</button>
	<button id="join" class="login">회원가입</button>
</div>
<div id="myModal" class="modal">

		<!-- Modal content -->
		<div id="modal-content">
			<p style="text-align: center;">
				<span style="font-size: 14pt;"><b><span
						style="font-size: 24pt;">당신 옆의<br>면접 트레이너
					</span></b></span>
			</p>
			<p style="text-align: center; line-height: 1.5;">
				<br />
			<form action="">
				<div class="input-left">
					<span class="inputname">아이디</span> <input class="input" type="text"><br>
					<span class="inputname">비밀번호</span> <input class="input" type="password"><br>
				</div>
				<div class="input-right">
					<button id="loginbtn" type="button">로그인</button>
				</div>
				<br>
				<div class="search">
					<a>아이디/비밀번호 찾기</a>
				</div>
			</form>
			<p>
				<br />
			</p>
			<div
				style="cursor: pointer; background-color: #DDDDDD; text-align: center; padding-bottom: 10px; padding-top: 10px;"
				onClick="close_pop();">
				<span class="pop_bt" style="font-size: 13pt;"> 닫기 </span>
			</div>
		</div>
	</div>
	
	<!-- search Modal content -->
	<div id="searchModal" class="modal">

		<!-- searchModal content -->
		<div id="searchModal-content">
			<p style="text-align: left;">
				<span style="font-size: 14pt;"><b><span
						style="font-size: 24pt;">[아이디찾기]
					</span></b></span>
			</p>
			<p style="text-align: center; line-height: 1.5;">
			<form action="">
				<div class="input-left">
					<span class="inputname">이름 </span> <input class="input" type="text"><br>
					<span class="inputname">연락처</span> <input class="input" type="text"><br>
				</div>
				<div class="input-right">
					<button id="searchbtn" type="button">찾기</button>
				</div>
			</form>
			<br>
			<br>
			<br>
			
			<p style="text-align: left;">
				<span style="font-size: 14pt;"><b><span
						style="font-size: 24pt;">[비밀번호찾기]
					</span></b></span>
			</p>
			<form action="">
				<div class="input-left">
					<span class="inputname">아이디 </span> <input class="input" type="text"><br>
					<span class="inputname">이름 </span> <input class="input" type="text"><br>
					<span class="inputname">연락처</span> <input class="input" type="text"><br>
				</div>
				<div class="input-right">
					<button id="searchbtn" type="button">찾기</button>
				</div>
			</form>
			<p>
				<br />
			</p>
			<br>
			<br>
			<div
				style="cursor: pointer; background-color: #DDDDDD; text-align: center; padding-bottom: 10px; padding-top: 10px;"
				onClick="search_close_pop();">
				<span class="pop_bt" style="font-size: 13pt;"> 닫기 </span>
			</div>
		</div>
	</div>
	
	<!-- change Modal content -->
	<div id="changeModal" class="modal">

		<!-- changeModal content -->
		<div id="changeModal-content">
			<p style="text-align: left;">
				<span style="font-size: 14pt;"><b><span
						style="font-size: 24pt;">[비밀번호 변경]
					</span></b></span>
			</p>
			<p style="text-align: center; line-height: 1.5;">
			<form action="">
				<div class="input-left">
					<span class="inputname">새 비밀번호 </span> <input class="input" type="text"><br>
					<span class="inputname">새 비밀번호 확인</span> <input class="input" type="text"><br>
				</div>
				<div class="input-right">
					<button id="changebtn" type="button">변경</button>
				</div>
			</form>
			<br>
			<br>
			<div
				style="cursor: pointer; background-color: #DDDDDD; text-align: center; padding-bottom: 10px; padding-top: 10px;"
				onClick="change_close_pop();">
				<span class="pop_bt" style="font-size: 13pt;"> 닫기 </span>
			</div>
		</div>
	</div>