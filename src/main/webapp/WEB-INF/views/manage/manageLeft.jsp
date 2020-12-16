<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<style>

	a:hover{
	}
	
	a, button{
		border : none;
		cursor : pointer;
		text-decoration: none;
		color: inherit;
		font: inherit;
	}
	.TopBar .navigation-bar .nav a {
		padding: 0 18px;
		font-size: 16px;
		font-weight: 500;
		opacity: .6;
		transition: .2s ease;
	}
	body{
		font-size: 16px;
		font-family: "Noto Sans KR",sans-serif;
	}
	a:-webkit-any-link {
		text-decoration: none;
	}
	.w3-button.w3-block.w3-left-align.w3-bar-item{
		font-size: 16px;
		font-family: "Noto Sans KR",sans-serif;
		font-weight: 500;
		opacity: .6;
		transition: .2s ease;
	}
	.w3-button:hover{
		text-decoration: none;
	}
	.payment-btn{
		text-decoration: none;	
	}
	.profile-btn{
		padding : 0 34px;
/* 		letter-spacing : 0.15em; */
	}
</style>

<div class="w3-sidebar w3-bar-block w3-light-grey w3-card leftbox" style="width: 200px; position: relative;">
	
	<button class="w3-button w3-block w3-left-align" onclick="myAccFunc()">
		회원 관리 <i class="fa fa-caret-down"></i>
	</button>
	<div id="demoAcc" class="w3-hide w3-white w3-card">
		<a href="/member/retrievePagingList.do" class="w3-bar-item w3-button" target="manage_content" >&ensp;&ensp;회원 목록</a>
		<a href="/member/statistic.do" class="w3-bar-item w3-button" target="manage_content" >&ensp;&ensp;회원 통계</a>
		<a href="/member/authorityManage.do" class="w3-bar-item w3-button" target="manage_content" >&ensp;&ensp;관리자 권한 설정</a>
	</div>
	
	<button class="w3-button w3-block w3-left-align" onclick="myAccFunc1()">
		게시판 관리<i class="fa fa-caret-down"></i>
	</button>
	<div id="demoAcc1" class="w3-hide w3-white w3-card">
		<a href="/boardGubun/retrievePagingList.do" class="w3-bar-item w3-button" target="manage_content" >&ensp;&ensp;게시판 등록/목록</a>
		<a href="#" class="w3-bar-item w3-button" target="manage_content" >&ensp;&ensp;게시판 통계</a>
	</div>
	
	<button class="w3-button w3-block w3-left-align" onclick="myAccFunc2()">
		요금제 관리<i class="fa fa-caret-down"></i>
	</button>
	<div id="demoAcc2" class="w3-hide w3-white w3-card">
		<a href="/plan/manage.do" class="w3-bar-item w3-button"  target="manage_content" >&ensp;&ensp;요금제 목록</a>
		<a href="/plan/retrievePagingList.do" class="w3-bar-item w3-button"  target="manage_content" >&ensp;&ensp;결제 내역</a>
		<a href="/plan/statistics.do" class="w3-bar-item w3-button"  target="manage_content" >&ensp;&ensp;요금제 통계</a>
	</div>

	<button class="w3-button w3-block w3-left-align" onclick="myAccFunc3()">
		면접 관리<i class="fa fa-caret-down"></i>
	</button>
	<div id="demoAcc3" class="w3-hide w3-white w3-card">
		<button class="w3-button w3-block w3-left-align" onclick="myAccFunc3_a()">
			&ensp;&ensp;면접 관리<i class="fa fa-caret-down"></i>
		</button>
		<div id="demoAcc3_a" class="w3-hide w3-white w3-card">
			<a href="/interview/retrievePagingList.do" class="w3-bar-item w3-button" target="manage_content">&ensp;&ensp;&ensp;&ensp;면접 목록</a>
			<a href="/interview/statistic.do" class="w3-bar-item w3-button" target="manage_content">&ensp;&ensp;&ensp;&ensp;면접 통계</a>
		</div>
		<button class="w3-button w3-block w3-left-align" onclick="myAccFunc3_b()">
			&ensp;&ensp;인재상 관리<i class="fa fa-caret-down"></i>
		</button>
		<div id="demoAcc3_b" class="w3-hide w3-white w3-card">
			<a href="/talent/retrievePagingList.do" class="w3-bar-item w3-button"  target="manage_content" >&ensp;&ensp;&ensp;&ensp;인재상 관리</a>
			<a href="/talent/statistics.do" class="w3-bar-item w3-button"  target="manage_content" >&ensp;&ensp;&ensp;&ensp;인재상 통계</a>
		</div>
		<button class="w3-button w3-block w3-left-align" onclick="myAccFunc3_c()">
			&ensp;&ensp;질문 관리<i class="fa fa-caret-down"></i>
		</button>
		<div id="demoAcc3_c" class="w3-hide w3-white w3-card">
			<a href="/questGb/retrievePagingList.do" class="w3-bar-item w3-button"  target="manage_content" >&ensp;&ensp;&ensp;&ensp;질문 구분 관리</a>
			<a href="/sampQuest/retrievePagingList.do" class="w3-bar-item w3-button"  target="manage_content" >&ensp;&ensp;&ensp;&ensp;샘플 질문 관리</a>
			<a href="/sampQuest/statistics.do" class="w3-bar-item w3-button" target="manage_content" >&ensp;&ensp;&ensp;&ensp;질문 통계</a>
		</div>
		<button class="w3-button w3-block w3-left-align" onclick="myAccFunc3_d()">
			&ensp;&ensp;습관어 관리<i class="fa fa-caret-down" target="manage_content"></i>
		</button>
		<div id="demoAcc3_d" class="w3-hide w3-white w3-card">
			<a href="/habit/retrievePagingList.do" class="w3-bar-item w3-button" target="manage_content" >&ensp;&ensp;&ensp;&ensp;습관어 관리</a>
			<a href="/habit/statistics.do" class="w3-bar-item w3-button" target="manage_content" >&ensp;&ensp;&ensp;&ensp;습관어 통계</a>
		</div>
	</div>
	
	<button class="w3-button w3-block w3-left-align" onclick="myAccFunc4()">
		스크립트 관리<i class="fa fa-caret-down"></i>
	</button>
	<div id="demoAcc4" class="w3-hide w3-white w3-card">
		<a href="/scriptGubun/retrievePagingList.do" class="w3-bar-item w3-button"  target="manage_content">&ensp;&ensp;스크립트 목록</a>
		<a href="/script/statistics.do" class="w3-bar-item w3-button" target="manage_content">&ensp;&ensp;스크립트 통계</a>
	</div>
</div>


<script>

	/* 회원 관리 */
	function myAccFunc() {
		var x = document.getElementById("demoAcc");
		if (x.className.indexOf("w3-show") == -1) {
			x.className += " w3-show";
			x.previousElementSibling.className += " w3-blue";
		} else {
			x.className = x.className.replace(" w3-show", "");
			x.previousElementSibling.className = x.previousElementSibling.className
					.replace(" w3-blue", "");
		}
	}
	
	/* 게시판 관리 */
	function myAccFunc1() {
		var x = document.getElementById("demoAcc1");
		if (x.className.indexOf("w3-show") == -1) {
			x.className += " w3-show";
			x.previousElementSibling.className += " w3-blue";
		} else {
			x.className = x.className.replace(" w3-show", "");
			x.previousElementSibling.className = x.previousElementSibling.className
					.replace(" w3-blue", "");
		}
	}
	
	/* 요금제 관리 */
	function myAccFunc2() {
		var x = document.getElementById("demoAcc2");
		if (x.className.indexOf("w3-show") == -1) {
			x.className += " w3-show";
			x.previousElementSibling.className += " w3-blue";
		} else {	
			x.className = x.className.replace(" w3-show", "");
			x.previousElementSibling.className = x.previousElementSibling.className
					.replace(" w3-blue", "");
		}
	}
	
	/* 면접 관리 */
	function myAccFunc3() {
		var x = document.getElementById("demoAcc3");
		if (x.className.indexOf("w3-show") == -1) {
			x.className += " w3-show";
			x.previousElementSibling.className += " w3-blue";
		} else {
			x.className = x.className.replace(" w3-show", "");
			x.previousElementSibling.className = x.previousElementSibling.className
					.replace(" w3-blue", "");
		}
	}

	/* 면접 관리  - 면접 관리 */
	function myAccFunc3_a() {
		var x = document.getElementById("demoAcc3_a");
		if (x.className.indexOf("w3-show") == -1) {
			x.className += " w3-show";
			x.previousElementSibling.className += " w3-pale-blue";
		} else {
			x.className = x.className.replace(" w3-show", "");
			x.previousElementSibling.className = x.previousElementSibling.className
					.replace(" w3-pale-blue", "");
		}
	}
	
	/* 면접 관리  - 인재상 관리 */
	function myAccFunc3_b() {
		var x = document.getElementById("demoAcc3_b");
		if (x.className.indexOf("w3-show") == -1) {
			x.className += " w3-show";
			x.previousElementSibling.className += " w3-pale-blue";
		} else {
			x.className = x.className.replace(" w3-show", "");
			x.previousElementSibling.className = x.previousElementSibling.className
					.replace(" w3-pale-blue", "");
		}
	}
	
	/* 면접 관리  - 질문 관리 */
	function myAccFunc3_c() {
		var x = document.getElementById("demoAcc3_c");
		if (x.className.indexOf("w3-show") == -1) {
			x.className += " w3-show";
			x.previousElementSibling.className += " w3-pale-blue";
		} else {
			x.className = x.className.replace(" w3-show", "");
			x.previousElementSibling.className = x.previousElementSibling.className
					.replace(" w3-pale-blue", "");
		}
	}
	
	/* 면접 관리  - 습관어 관리 */
	function myAccFunc3_d() {
		var x = document.getElementById("demoAcc3_d");
		if (x.className.indexOf("w3-show") == -1) {
			x.className += " w3-show";
			x.previousElementSibling.className += " w3-pale-blue";
		} else {
			x.className = x.className.replace(" w3-show", "");
			x.previousElementSibling.className = x.previousElementSibling.className
					.replace(" w3-pale-blue", "");
		}
	}
	
	/* 면접 관리  - 스크립트 관리 */
	function myAccFunc3_e() {
		var x = document.getElementById("demoAcc3_e");
		if (x.className.indexOf("w3-show") == -1) {
			x.className += " w3-show";
			x.previousElementSibling.className += " w3-pale-blue";
		} else {
			x.className = x.className.replace(" w3-show", "");
			x.previousElementSibling.className = x.previousElementSibling.className
					.replace(" w3-pale-blue", "");
		}
	}
	
	/* 스크립트 관리 */
	function myAccFunc4() {
		var x = document.getElementById("demoAcc4");
		if (x.className.indexOf("w3-show") == -1) {
			x.className += " w3-show";
			x.previousElementSibling.className += " w3-blue";
		} else {
			x.className = x.className.replace(" w3-show", "");
			x.previousElementSibling.className = x.previousElementSibling.className
					.replace(" w3-blue", "");
		}
	}
	
</script>

