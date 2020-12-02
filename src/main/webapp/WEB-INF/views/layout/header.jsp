<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
 <%@ include file="/WEB-INF/views/layout/commonLib.jsp" %>
<style>

 	#header{
 		position: fixed;
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
	
	#loginbtn{
		width: 70px;
		height: 70px;
		margin-left: 3%;
	
	}
	
	#searchIdBtn{
		width: 70px;
		height: 70px;
		margin-left: 3%;
	}
	
	#searchPwBtn{
		width: 70px;
		height: 70px;
		margin-left: 3%;
	}
	
	#changebtn{
		width: 70px;
		height: 70px;
		margin-left: 3%;
	}
	.input-right{
		margin-bottom: 10%;
	}
	.dropbtn {
  background-color: #ea2129;
  color: white;
  padding: 16px;
  font-size: 16px;
  border: none;
}

.dropdown {
  position: relative;
  display: inline-block;
}

.dropdown-content {
  display: none;
  position: absolute;
  background-color: #f1f1f1;
  min-width: 160px;
  box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
  z-index: 1;
}

.dropdown-content a {
  color: black;
  padding: 12px 16px;
  text-decoration: none;
  display: block;
}

.dropdown-content a:hover {background-color: #ddd;}

.dropdown:hover .dropdown-content {display: block;}

.dropdown:hover {background-color: #3e8e41;}

.user-popup{
	display: none;
}

</style>

<script>

$(document).ready(function() {
    $('#login').on('click',function(){
		 $('#myModal').show();
    });
    $('#join').on('click',function(){
    	document.location="/login/join.do"
    });
    $('#myProfile').on('click',function(){
    	document.location="/member/myprofileview.do"
    });
    $('#experience').on('click',function(){
    	document.location="/login/experience.do"
    });
    $('.search').on('click',function(){
		 $('#searchModal').show();
    });
    
    $('#searchIdBtn').on('click',function(){
    	retrieveId();
    });
    $('#searchPwBtn').on('click',function(){
    	retrievePw();
    });
    $('#changebtn').on('click',function(){
    	if($('#memPw1').val()== $('#memPw2').val()){
    		updatePw();
    	}else{
    		alert('비밀번호가 일치 하지 않습니다.');
    	}
    });
    
    $('.profile-btn.false').on('click',function(){
    	$('.user-popup').toggle();
    });
    
    $('.logout').on('click',function(){
    	alert('로그아웃 되었습니다')
    	document.location="/login/logout.do";
    });
    
    boardGubunList();
});
   	function retrieveId(){
   		memNm = $('#searchIdName').val();
    	memTel = $('#searchIdTel').val();
    	
   		$.ajax(
   			{url:"/member/retrieveid.do",
   			data : {memNm : memNm, memTel :memTel},
   			method : "get",
   			success : function(data){
   				console.log(data);
   				html = '아이디는 ' +data +'입니다.';
   				if(data==''){
   					html = '일치하는 아이디가 존재하지 않습니다.';
   				}
   				$('#findId').html(html);
   			},
   			error: function(data){
   				console.log(data.status);
   			}
   		});
   	}
   	function retrievePw(){
   		memId = $('#searchPwId').val();
    	memNm = $('#searchPwName').val();
    	memTel = $('#searchPwTel').val();
    	
   		$.ajax(
   			{url:"/member/retrievepw.do",
   			data : {memNm : memNm, memTel :memTel, memId : memId},
   			method : "get",
   			success : function(data){
   				if(data==''){
   					html = '일치하는 비밀번호가 존재하지 않습니다.';
   					$('#findPw').html(html);
   				}else{
	   				$('#changeModal').show();
   				}
   			},
   			error: function(data){
   				console.log(data.status);
   			}
   		});
   	}
   	function updatePw(){
   		memId = $('#searchPwId').val();
    	memPw = $('#memPw1').val();
    	
   		$.ajax(
   			{url:"/member/updatepw.do",
   			data : {memId :memId, memPw : memPw},
   			method : "get",
   			success : function(data){
   				alert("비밀번호 변경이 완료되었습니다.");
   				document.location = '/login/main.do';
   			},
   			error: function(data){
   				console.log(data.status);
   			}
   		});
   	}
//팝업 Close 기능
function close_pop(flag) {
 $('#myModal').hide();
};
function search_close_pop(flag) {
	$('#searchModal').hide();
	$('#searchIdName').val("");
	$('#searchIdTel').val("");
	$('#changeModal').hide();
	$('#searchPwId').val("");
	$('#searchPwName').val("");
	$('#searchPwTel').val("");
	$('#findId').html("");
	$('#findPw').html("");
};
function change_close_pop(flag) {
	$('#changeModal').hide();
};

function boardGubunList(){
	$.ajax({url : "/boardGubun/retrieveList.do",
		method : "get",
		success : function(data){
			var html = "";
			for(var i = 0; i< data.boardGubunList.length ; i++){
				var gubun = data.boardGubunList[i];
				if(gubun.boardGbSt == "Y"){
					
					html += '<a href="/board/retrievePagingList.do?boardGbSq='+ gubun.boardGbSq +'&boardGbNm='+gubun.boardGbNm+'">'+gubun.boardGbNm+'</a>';

				}
			};
			$('#boardGubunList').append(html);
		}
	});	
}

</script>
<!-- header -->
<div class="TopBar undefined" id  ="header" style="position: relative;">
	<div class="navigation-bar">
		<a class="iam-logo" href="/login/main.do"><img
			src="/images/Ai_Interview 로고.png" alt="iam-logo"
			class="iam-img"></a>
		<div class="nav">
			<c:choose>
				<c:when test="${S_MEMBER.memId == null }">
					<a class="main false" href="/login/home.do">내 면접</a>
				</c:when>
				<c:otherwise>
					<a class="main false" href="/analysisresult/main.do">내 면접</a>
				</c:otherwise>
			</c:choose>
			<div class="dropdown">
				<button class="lecture false dropbtn">게시판</button>
				<div class="dropdown-content" id="boardGubunList">
				</div>
			</div>
			<a class="service-intro false" href="/service-intro">서비스 소개</a>
			<a class="help-info false" href="/help-info">도움말</a>
			<c:choose>
				<c:when test="${S_MEMBER.memAuth == 'Y'}">
					<a class="managepage false" href="/login/manage.do">관리자 페이지</a>
				</c:when>
			</c:choose>
		</div>
	</div>
	<div style="justify-content: flex-end;">
		<c:choose>
			<c:when test="${S_MEMBER == null }">
				<button id="login" class="login" style="margin-left: 0px;">로그인</button>
				<button id="join" class="login"  style="margin-left: 0px;">회원가입</button>
			</c:when>
		</c:choose>
	<%-- 	<c:choose> --%>
	<%-- 		<c:when test="${S_MEMBER != null }"> --%>
	<!-- 			<button id="myProfile" class="login" style="margin-left: 0px;">내 프로필</button> -->
	<%-- 		</c:when> --%>
	<%-- 	</c:choose> --%>
	</div>
		<c:choose>
			<c:when test="${S_MEMBER != null }">
				<div class="user-tool">
					<a class="payment-btn" href="/plan/buyPlan">이용권 구매</a>
					<div class="profile-btn false">
						<img src="/member/profile.do?memId=${S_MEMBER.memId }" alt="profile-icon" class="profile-icon">${S_MEMBER.memAlias }
			<!-- 				<span aria-hidden="true" class="fa fa-angle-down fa undefined"></span> -->
					</div>
					
					<div class="user-popup">
						<div class="profile-area">
							<img src="/member/profile.do?memId=${S_MEMBER.memId }" alt="profile-icon" class="profile-icon">${S_MEMBER.memAlias }
						</div>
						<div class="profile-link-area">
							<a id="myProfile" class="personal-info btn">내 프로필</a>
						</div>
						<div class="link-area">
							<a class="profile-edit btn" href="/member/updateview.do">프로필 수정</a><a
								class="ticket-info btn" href="/personal-info#ticket">이용권 정보</a><a
								class="payment-list btn" href="/payment-list">결제 내역</a>
						</div>
						<div class="logout">로그아웃</div>
					</div>
					
					
				</div>
			</c:when>
		</c:choose>
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
			<form action="/login/process.do" method="post">
				<div class="input-left">
					<span class="inputname">아이디</span> <input class="input" type="text" name="memId" value="TEST_ID"><br>
					<span class="inputname">비밀번호</span> <input class="input" type="password" name="memPw" value="TEST_PW"><br>
				</div>
				<div class="input-right">
					<button id="loginbtn" type="submit">로그인</button>
				</div>
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
			<form action="/member/idSearch" method="get">
				<div class="input-left">
					<span class="inputname">이름 </span> <input id="searchIdName" name="memNm" class="input" type="text" value="TEST_NAME"><br>
					<span class="inputname">연락처</span> <input id="searchIdTel" name="memTel" class="input" type="text" value="010-1234-5678"><br>
				</div>
				<div class="input-right">
					<button id="searchIdBtn" type="button">찾기</button>
				</div>
			</form>
			<div>
				<span style="color: red" id="findId"></span>
			</div>
			
			<p style="text-align: left;">
				<span style="font-size: 14pt;"><b><span
						style="font-size: 24pt;">[비밀번호찾기]
					</span></b></span>
			</p>
			<form action="">
				<div class="input-left">
					<span class="inputname">아이디 </span> <input id="searchPwId" class="input" type="text" value="TEST_ID"><br>
					<span class="inputname">이름 </span> <input id="searchPwName" class="input" type="text" value="TEST_NAME"><br>
					<span class="inputname">연락처</span> <input id="searchPwTel" class="input" type="text" value="010-1234-5678"><br>
				</div>
				<div class="input-right">
					<button id="searchPwBtn" type="button">찾기</button>
				</div>
			</form>
			<div>
				<span style="color: red" id="findPw"></span>
			</div>
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
					<span class="inputname">새 비밀번호 </span> <input id="memPw1" class="input" type="password"><br>
					<span class="inputname">새 비밀번호 확인</span> <input id="memPw2" class="input" type="password"><br>
				</div>
				<div class="input-right">
					<button id="changebtn" type="button">변경</button>
				</div>
			</form>
			<div
				style="cursor: pointer; background-color: #DDDDDD; text-align: center; padding-bottom: 10px; padding-top: 10px;"
				onClick="change_close_pop();">
				<span class="pop_bt" style="font-size: 13pt;"> 닫기 </span>
			</div>
		</div>
	</div>