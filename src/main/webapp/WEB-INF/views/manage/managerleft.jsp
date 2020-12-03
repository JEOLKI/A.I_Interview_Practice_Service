<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<style>
	a{
		text-decoration: none;
		padding-left: 20px;
	}
	a:hover{
		text-decoration: none;
	}
</style>

<div class="w3-sidebar w3-bar-block w3-light-grey w3-card" style="width: 200px; position: relative;">
	
	<button class="w3-button w3-block w3-left-align" onclick="myAccFunc()">
		회원 관리 <i class="fa fa-caret-down"></i>
	</button>
	<div id="demoAcc" class="w3-hide w3-white w3-card">
		<a href="#" class="w3-bar-item w3-button">&ensp;&ensp;회원 목록</a>
		<a href="#" class="w3-bar-item w3-button">&ensp;&ensp;회원 관리</a>
		<a href="#" class="w3-bar-item w3-button">&ensp;&ensp;회원 통계</a>
		<a href="#" class="w3-bar-item w3-button">&ensp;&ensp;관리자 권한 설정</a>
	</div>
	
	<button class="w3-button w3-block w3-left-align" onclick="myAccFunc1()">
		게시판 관리<i class="fa fa-caret-down"></i>
	</button>
	<div id="demoAcc1" class="w3-hide w3-white w3-card">
		<a href="#" class="w3-bar-item w3-button">&ensp;&ensp;게시판 관리</a>
		<a href="#" class="w3-bar-item w3-button">&ensp;&ensp;말머리 관리</a>
		<a href="#" class="w3-bar-item w3-button">&ensp;&ensp;게시판 통계</a>
	</div>
	
	<button class="w3-button w3-block w3-left-align" onclick="myAccFunc2()">
		요금제 관리<i class="fa fa-caret-down"></i>
	</button>
	<div id="demoAcc2" class="w3-hide w3-white w3-card">
		<a href="#" class="w3-bar-item w3-button">&ensp;&ensp;요금제 관리</a>
		<a href="#" class="w3-bar-item w3-button">&ensp;&ensp;요금제 통계</a>
	</div>

	<button class="w3-button w3-block w3-left-align" onclick="myAccFunc3()">
		면접 관리<i class="fa fa-caret-down"></i>
	</button>
	<div id="demoAcc3" class="w3-hide w3-white w3-card">
		<button class="w3-button w3-block w3-left-align" onclick="myAccFunc3_a()">
			&ensp;&ensp;면접 관리<i class="fa fa-caret-down"></i>
		</button>
		<div id="demoAcc3_a" class="w3-hide w3-white w3-card">
			<a href="#" class="w3-bar-item w3-button">&ensp;&ensp;&ensp;&ensp;면접 목록</a>
			<a href="#" class="w3-bar-item w3-button">&ensp;&ensp;&ensp;&ensp;면접 통계</a>
		</div>
		<button class="w3-button w3-block w3-left-align" onclick="myAccFunc3_b()">
			&ensp;&ensp;인재상 관리<i class="fa fa-caret-down"></i>
		</button>
		<div id="demoAcc3_b" class="w3-hide w3-white w3-card">
			<a href="/talent/retrievePagingList.do" class="w3-bar-item w3-button">&ensp;&ensp;&ensp;&ensp;인재상 관리</a>
			<a href="#" class="w3-bar-item w3-button">&ensp;&ensp;&ensp;&ensp;인재상 통계</a>
		</div>
		<button class="w3-button w3-block w3-left-align" onclick="myAccFunc3_c()">
			&ensp;&ensp;키워드 관리<i class="fa fa-caret-down"></i>
		</button>
		<div id="demoAcc3_c" class="w3-hide w3-white w3-card">
			<a href="#" class="w3-bar-item w3-button">&ensp;&ensp;&ensp;&ensp;키워드 관리</a>
			<a href="#" class="w3-bar-item w3-button">&ensp;&ensp;&ensp;&ensp;키워드 통계</a>
		</div>
		<button class="w3-button w3-block w3-left-align" onclick="myAccFunc3_d()">
			&ensp;&ensp;질문 관리<i class="fa fa-caret-down"></i>
		</button>
		<div id="demoAcc3_d" class="w3-hide w3-white w3-card">
			<a href="/questGb/retrievePagingList.do" class="w3-bar-item w3-button">&ensp;&ensp;&ensp;&ensp;질문 구분 관리</a>
			<a href="/sampQuest/retrievePagingList.do" class="w3-bar-item w3-button">&ensp;&ensp;&ensp;&ensp;샘플 질문 관리</a>
			<a href="#" class="w3-bar-item w3-button">&ensp;&ensp;&ensp;&ensp;질문 통계</a>
		</div>
		<button class="w3-button w3-block w3-left-align" onclick="myAccFunc3_e()">
			&ensp;&ensp;습관어 관리<i class="fa fa-caret-down"></i>
		</button>
		<div id="demoAcc3_e" class="w3-hide w3-white w3-card">
			<a href="/habit/retrievePagingList.do" class="w3-bar-item w3-button">&ensp;&ensp;&ensp;&ensp;습관어 관리</a>
			<a href="#" class="w3-bar-item w3-button">&ensp;&ensp;&ensp;&ensp;습관어 통계</a>
		</div>
		<button class="w3-button w3-block w3-left-align" onclick="myAccFunc3_f()">
			&ensp;&ensp;스크립트 관리<i class="fa fa-caret-down"></i>
		</button>
		<div id="demoAcc3_f" class="w3-hide w3-white w3-card">
			<a href="#" class="w3-bar-item w3-button">&ensp;&ensp;&ensp;&ensp;스크립트 구분 관리</a>
			<a href="#" class="w3-bar-item w3-button">&ensp;&ensp;&ensp;&ensp;스크립트 관리</a>
			<a href="#" class="w3-bar-item w3-button">&ensp;&ensp;&ensp;&ensp;스크립트 통계</a>
		</div>
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
	
	/* 면접 관리  - 키워드 관리 */
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
	
	/* 면접 관리  - 키워드 관리 */
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
	
	/* 면접 관리  - 질문 관리 */
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
	
	/* 면접 관리  - 스크립트 관리 */
	function myAccFunc3_f() {
		var x = document.getElementById("demoAcc3_f");
		if (x.className.indexOf("w3-show") == -1) {
			x.className += " w3-show";
			x.previousElementSibling.className += " w3-pale-blue";
		} else {
			x.className = x.className.replace(" w3-show", "");
			x.previousElementSibling.className = x.previousElementSibling.className
					.replace(" w3-pale-blue", "");
		}
	}
</script>

