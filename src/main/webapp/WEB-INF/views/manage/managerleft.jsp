<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>



<div class="w3-sidebar w3-bar-block w3-light-grey w3-card" style="width: 160px;">
	
	<button class="w3-button w3-block w3-left-align" onclick="myAccFunc()">
		Accordion <i class="fa fa-caret-down"></i>
	</button>
	<div id="demoAcc" class="w3-hide w3-white w3-card">
		<a href="#" class="w3-bar-item w3-button">Link</a>
		<a href="#" class="w3-bar-item w3-button">Link</a>
	</div>
	
	<button class="w3-button w3-block w3-left-align" onclick="myAccFunc1()">
		Accordion <i class="fa fa-caret-down"></i>
	</button>
	<div id="demoAcc1" class="w3-hide w3-white w3-card">
		<a href="#" class="w3-bar-item w3-button">Link</a>
		<a href="#" class="w3-bar-item w3-button">Link</a>
	</div>
	
	<button class="w3-button w3-block w3-left-align" onclick="myAccFunc2()">
		Accordion <i class="fa fa-caret-down"></i>
	</button>
	<div id="demoAcc2" class="w3-hide w3-white w3-card">
		<a href="#" class="w3-bar-item w3-button">Link</a>
		<a href="#" class="w3-bar-item w3-button">Link</a>
	</div>

</div>


<script>

	function myAccFunc() {
		var x = document.getElementById("demoAcc");
		if (x.className.indexOf("w3-show") == -1) {
			x.className += " w3-show";
			x.previousElementSibling.className += " w3-green";
		} else {
			x.className = x.className.replace(" w3-show", "");
			x.previousElementSibling.className = x.previousElementSibling.className
					.replace(" w3-green", "");
		}
	}
	
	function myAccFunc1() {
		var x = document.getElementById("demoAcc1");
		if (x.className.indexOf("w3-show") == -1) {
			x.className += " w3-show";
			x.previousElementSibling.className += " w3-green";
		} else {
			x.className = x.className.replace(" w3-show", "");
			x.previousElementSibling.className = x.previousElementSibling.className
					.replace(" w3-green", "");
		}
	}
	
	function myAccFunc2() {
		var x = document.getElementById("demoAcc2");
		if (x.className.indexOf("w3-show") == -1) {
			x.className += " w3-show";
			x.previousElementSibling.className += " w3-green";
		} else {
			x.className = x.className.replace(" w3-show", "");
			x.previousElementSibling.className = x.previousElementSibling.className
					.replace(" w3-green", "");
		}
	}
	
</script>
