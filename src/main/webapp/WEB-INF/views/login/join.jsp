<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta name="viewport" content="width=device-width,initial-scale=1">
<meta name="theme-color" content="#000000">
<link href="/css/main.8acfb306.chunk.css" rel="stylesheet">
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<%@ include file="/WEB-INF/views/layout/commonLib.jsp" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<style>
	#zipcodeBtn{
		width: 88px;
		height: 32px;
		text-align: center;
		position:absolute;
		margin-left: 10px;
		background-color: #3b3b46;
		color: white;
		font-size: 12px;
	}
</style>

<script>
	$(document).ready(function(){
	    $('#zipcodeBtn').on('click',function(){
		    new daum.Postcode({
		        oncomplete: function(data) {
			        $("#memAddr1").val(data.roadAddress);
			        $("#memZipcode").val(data.zonecode);
		        }
		    }).open();
		});
	});
	
	$(document).ready(function(){
		$('.memPw').on('input',function(){
			if($('#memPw1').val()!='' && $('#memPw2').val()!=''){
				if($('#memPw1').val()!=$('#memPw2').val()){
					if(!/^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$/.test($("#memPw1").val()) || !/^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$/.test($("#memPw2").val())){
						$('#checkPw').empty();
						$('#checkPw').append('<span style="color:red">비밀번호는 최소 하나의 문자, 숫자로 최소 8자리 입력가능합니다.</span><br><br>');
						$('#check').val('N');
					}else{
						$('#checkPw').empty();
						$('#checkPw').append('<span style="color:red">비밀번호가 일치하지 않습니다</span><br><br>');
						$('#check').val('N');
					}
				}else if($('#memPw1').val()==$('#memPw2').val()){
					if(!/^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$/.test($("#memPw1").val()) || !/^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$/.test($("#memPw2").val())){
						$('#checkPw').empty();
						$('#checkPw').append('<span style="color:red">비밀번호는 최소 하나의 문자, 숫자로 최소 8자리 입력가능합니다.</span><br><br>');
						$('#check').val('N');
					}else{
						$('#checkPw').empty();
						$('#checkPw').append('<span style="color:green">비밀번호가 일치합니다</span><br><br>');
						$('#check').val('Y');
					}
				}
			}else{
				$('#checkPw').empty();
				$('#check').val('N');
			}
		});
		
		$('#idCheck').on('click',function(){
			if($('#memId').val()==''){
				alert('아이디를 입력하세요');
			}else if(!/^[a-zA-Z0-9]{4,20}$/.test($("#memId").val())){
				alert("아이디는 영문/숫자로  4~20자리 입력가능합니다.");
			}else{
				$('#checkId').empty();
				idCheck();
			}
		});
		
		$('#aliasCheck').on('click',function(){
			if($('#memAlias').val()==''){
				alert('닉네임을 입력하세요');
			}else if(!/^[ㄱ-ㅎ|가-힣|a-z|A-Z|0-9|\*]{2,8}$/.test($("#memAlias").val())){
				alert("닉네임은 한글/영문/숫자로 2~8자리 입력 가능합니다.");
			}else{
				$('#checkAlias').empty();
				aliasCheck();
			}
		});
		
		$('#memTel').on('input',function(){
			if(/[^0-9]/.test($("#memTel").val())){
				let str = $('#memTel').val();
				let edit = str.replace(/[^0-9.]/g,'');
				$('#memTel').val(edit);
			}
		})
		
		$('#newcomer').on('click',function(){
			$('#memCareer').val('신입');
			$('#newcomer').removeClass('btn new false');
			$('#newcomer').addClass('btn new select');
			$('#experienced').removeClass('btn old select');
			$('#experienced').addClass('btn old false');
		});
		
		$('#experienced').on('click',function(){
			$('#memCareer').val('경력');
			$('#experienced').removeClass('btn old false');
			$('#experienced').addClass('btn old select');
			$('#newcomer').removeClass('btn new select');
			$('#newcomer').addClass('btn new false');
		});
		
		
		$('#firsthalf').on('click',function(){
			$('#firsthalf').removeClass('half false');
			$('#firsthalf').addClass('half select');
			$('#secondhalf').removeClass('half select');
			$('#secondhalf').addClass('half false');
			$('#searchJobDate').val($('#selYear').val()+'년 상반기')
		});
		
		$('#secondhalf').on('click',function(){
			$('#secondhalf').removeClass('half false');
			$('#secondhalf').addClass('half select');
			$('#firsthalf').removeClass('half select');
			$('#firsthalf').addClass('half false');
			$('#searchJobDate').val($('#selYear').val()+'년 하반기')
		});
		
		$('#selYear').change(function(){
			$('#searchJobDate').val($('#selYear').val()+ $('.half.select').attr('value'));
		});
		
		
		var allCheckStatus;
		$('.all-check-flex').on('click',function(){
			allCheckStatus = !allCheckStatus;
			
			if(allCheckStatus==true){
				$(".all-check-flex img").attr({"src":"/images/select.png", "class":"select"});
				$(".agree img").attr({"src":"/images/select.png", "class":"select"});
			}else{
				$(".all-check-flex img").attr({"src":"data:image/png;base64,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", "class":"false"});
				$(".agree img").attr({"src":"data:image/png;base64,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", "class":"false"});
			}
		});
		
		$('#joinBtn').on('click',function(){
			if($('#memId').val()=='' ||
					$('#memPw1').val()=='' ||
					$('#memPw2').val()=='' ||
					$('#memNm').val()=='' ||
					$('#memAlias').val()=='' ||
					$('#memTel').val()=='' ||
					$('#memCareer').val()==''||
					$('#memAddr1').val()=='' ||
					$('.personal.flex.agree img').attr('class') == 'false' ||
					$('.user.flex.agree img').attr('class') == 'false'
					){
				alert('필수입력사항을 입력해주세요');
				return false;
			}else if($('#check').val()=='N'){
				alert('비밀번호를 확인해주세요');
				return false;
			}else if($('#checkId').text()=='<span style="color:red">중복된 아이디입니다</span><br><br>'||
					$('#checkId').text()==''||
					$('#checkAlias').text()=='<span style="color:red">중복된 닉네임입니다</span><br><br>'||
					$('#checkAlias').text()==''
					){
				alert('중복체크를 확인해주세요');
				return false;
			}else{
				tel = "010-" + ($('#memTel').val()).substr(0,4) + "-" + ($('#memTel').val()).substr(4,4);
				$('#memTel').val(tel);
				$('#fr').submit();
				return true;
			}
		});
		
		$('.agree img').on('click',function(){
			if($(this).attr('class')=='false'){
				$(this).attr({"src":"/images/select.png", "class":"select"});
			}else{
				$(this).attr({"src":"data:image/png;base64,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", "class":"false"});
			}
		});
	});
	
		
	function idCheck(){
		memId = $('#memId').val();
		
	$.ajax({
			url : "/member/idCheck.do",
			data : {
				memId : memId
			},
			method : "post",
			success : function(data) {
				if (data.memberVo == null) {
					html = '<span style="color:green">사용가능한 아이디입니다</span><br><br>';
					$('#check').val('Y');
					$('#memId').attr('readonly',true);
					$('#checkId').append(html);
				}else{
					html = '<span style="color:red">중복된 아이디입니다</span><br><br>';
					$('#memId').val('');
					$('#check').val('N');
					$('#checkId').append(html);
				}
			},
			error : function(data) {
				console.log(data.status);
			}
		});
	};
	
	
	function aliasCheck(){
		memAlias = $('#memAlias').val();
		
	$.ajax({
			url : "/member/aliasCheck.do",
			data : {
				memAlias : memAlias
			},
			method : "post",
			success : function(data) {
				if (data.memberList.length == 0) {
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
	<form id="fr" action="/member/create.do" method="POST" >

		<div id="root">
			<div class="Join false">
<!-- 				<a href="/"><img src="/static/media/black-short.86b77e44.png" -->
<!-- 					alt="" class="logo"></a> -->
				<div class="JoinForm false">
					<div class="title">회원가입</div>
					<div class="label notice">
						정보입력 <span class="red">(* 필수)</span>
					</div>
					<input type="hidden" id="check" value="N">
					<div class="label">
						<span class="red">*</span>사용자 아이디
					</div>
					<div class="name-input" style="margin-bottom: 40px">
						<input type="text" name="memId" id="memId"
							placeholder="사용할 아이디를 입력하세요">
						<div class="btn-area">
							<button type="button" class="btn false" id="idCheck" style="opacity: 1">중복검사</button>
						</div>
					</div>
					<div id="checkId" class="check"></div>
					<br>

					<div class="label">
						<span class="red">*</span>사용자 비밀번호
					</div>
					<div class="name-input"
						style="flex-direction: column; margin-bottom: 40px;">
						<input type="password" name="memPw" id="memPw1" class="memPw"
							style="display: block" placeholder="사용할 비밀번호를 입력하세요" value="" maxlength="20"><br>
						<input type="password"  id="memPw2" class="memPw"
							style="display: block" placeholder="사용할 비밀번호를 입력하세요" value="" maxlength="20">
					</div>
					<div id="checkPw" class="check"></div>

					<div class="label">
						<span class="red">*</span>사용자 이름
					</div>
					<div class="name-input">
						<input type="text" name="memNm" id="memNm" placeholder="사용할 이름을 입력하세요">
					</div>

					<div class="label">
						<span class="red">*</span>사용자 닉네임
					</div>
					<div class="name-input" style="margin-bottom: 40px">
						<input type="text" name="memAlias" id="memAlias"
							placeholder="사용할 닉네임을 입력하세요" value="">
						<div class="btn-area">
							<button type="button" class="btn false" id="aliasCheck" style="opacity: 1">중복검사</button>
						</div>
					</div>
					<div id="checkAlias" class="check"></div>
					<br>

					<div class="label">
						<span class="red">*</span>사용자 연락처
					</div>
					<div class="name-input">
						<input type="text" value="010" readonly="readonly" style="width: 30px;"> 
						<input type="text" name="memTel" id="memTel" placeholder="사용할 연락처를 입력하세요" maxlength="8">
						<div id="checkTel" class="check"></div>
					</div>

					<div class="set-career-flex">
						<div class="label bold">
							<span class="red">*</span>경력사항
						</div>
						<div class="flex">
							<input type="hidden" value="">
							<div id="newcomer" class="btn new select">신입</div>
							<div id="experienced" class="btn old false">경력</div>
						</div>
						<input type="hidden" id="memCareer" name="memCareer" value="신입">
					</div>

					<div class="education-flex radio-area">
						<div class="label bold">
							<span class="red">*</span>학력
						</div>
						<div class="CustomRadio grid">
							<div>
								<input type="radio" name="memEduc" id="middle/high"
									value="중 / 고등학교 졸" checked="checked"> <label
									for="middle/high">중 / 고등학교 졸</label>
							</div>

							<div>
								<input type="radio" name="memEduc" id="University attendance"
									value="대학교 재학"> <label for="University attendance">대학교
									재학</label>
							</div>

							<div>
								<input type="radio" name="memEduc" id="University graduation"
									value="대학교 졸업"> <label for="University graduation">대학교
									졸업</label>
							</div>

							<div>
								<input type="radio" name="memEduc" id="Master/Doctor"
									value="석 / 박사 이상"> <label for="Master/Doctor">석
									/ 박사 이상</label>
							</div>

							<div>
								<input type="radio" name="memEduc" id="etc" value="기타">
								<label for="etc">기타</label>
							</div>
						</div>
					</div>

					<div class="gender-flex radio-area" style="margin-bottom: 40px">
						<div class="label bold">
							<span class="red">*</span>성별
						</div>
						<div class="CustomRadio grid">
							<div>
								<input type="radio" name="memGender" id="male" value="M"
									checked="checked"> <label for="male">남성</label>
							</div>
							<div>
								<input type="radio" name="memGender" id="female" value="F">
								<label for="female">여성</label>
							</div>
						</div>
					</div>

					<div class="content prospect-area">
						<div class="company">
							<div class="label bold">
								<span class="red">*</span>주소
							</div>
							<div>
								<input type="text" class="form-control" id="memAddr1" name="memAddr1" placeholder="사용자 주소" READONLY>
								<button type="button" class="btn false" id="zipcodeBtn" >우편번호 찾기</button>
							</div>
						</div>
						<br>
						<div class="company">
							<div class="label bold">
								<span class="red">*</span>상세주소
							</div>
							<div>
								<input type="text" class="form-control" id="memAddr2" name="memAddr2" placeholder="사용자 상세주소">
							</div>
						</div>
						<br>
						<div class="company">
							<div class="label bold">
								<span class="red">*</span>우편번호
							</div>
							<div>
								<input type="text" class="form-control" id="memZipcode" name="memZipcode" placeholder="사용자 우편번호" READONLY>
							</div>
						</div>
						<br>
					</div>

				<div class="content prospect-area" style="margin-bottom: 20px">
						<div class="company">
							<div class="label bold">
								<span class="red">*</span>목표 회사
							</div>
							<div class="CompletionInput company-input">
								<input name="memTargetCompany" type="text" placeholder="예) 삼성전자"
									class="" maxlength="30" value="">
							</div>
						</div>
						<div class="job" >
							<div class="label bold">
								<span class="red">*</span>목표 직무
							</div>
							<div class="CompletionInput job-input">
								<input name="memTargetJob" type="text" placeholder="예) 제품 개발/기획"
									class="" maxlength="30" value="">
							</div>
						</div>
					</div>

					<div class="label bold year-label" style="margin-top: 40px">취업 준비 시작시기</div>
						<c:set var="now" value="<%=new java.util.Date()%>" />
						<c:set var="sysYear"><fmt:formatDate value="${now}" pattern="yyyy" /></c:set>
					<div class="year-flex">
						<div class="CustomSelect small">
							<select id="selYear" name="selYear" style="width: 108px; height: 30px">
								<fmt:formatDate value="${now}" pattern="yyyy" var="yearStart" />

								<c:forEach begin="0" end="10" var="result" step="1">

									<option value="<c:out value="${yearStart - result}" />"
										<c:if test="${(yearStart - result) == searchVO.bsnsYear}"> selected="selected"</c:if>><c:out
											value="${yearStart - result}" /></option>

								</c:forEach>
							</select>
						</div>
						<div id="firsthalf" class="half select" value="년 상반기">상반기</div>
						<div id="secondhalf" class="half false" value="년 하반기">하반기</div>
					</div>
						<input type="hidden" id="searchJobDate" name="searchJobDate" value="2020년 상반기">

					<div class="major-flex radio-area">
						<div class="label bold">전공</div>
						<div class="CustomRadio grid">
							<div>
								<input type="radio" name="memMajor" id="Humanities" value="인문"checked="checked">
								<label for="Humanities">인문</label>
							</div>
							<div>
								<input type="radio" name="memMajor" id="society" value="사회">
								<label for="society">사회</label>
							</div>
							<div>
								<input type="radio" name="memMajor" id="Engineering" value="공학">
								<label for="Engineering">공학</label>
							</div>
							<div>
								<input type="radio" name="memMajor" id="Nature" value="자연">
								<label for="Nature">자연</label>
							</div>
							<div>
								<input type="radio" name="memMajor" id="Art" value="예체능">
								<label for="Art">예체능</label>
							</div>
							<div>
								<input type="radio" name="memMajor" id="majoretc" value="기타">
								<label for="majoretc">기타</label>
							</div>
						</div>
					</div>

					<div class="label bold">약관동의</div>
						<div class="all-check-flex">
						<img class="false"
							src="data:image/png;base64,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"
							alt="">
						<div class="txt">모든 약관에 동의합니다.</div>
					</div>
					<div class="term-list">
						<div class="personal flex agree">
							<img class="false" src="data:image/png;base64,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"
								alt="">
							<div class="txt">
								개인정보 수집 및 이용에 동의합니다. <span class="red">(필수)</span>
							</div>
							<a class="link" target="_blank" href="/login/personalAgree.do">약관
								전체보기</a>
						</div>
						<div class="user flex agree">
							<img class="false" src="data:image/png;base64,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"
								alt="">
							<div class="txt">
								회원 이용 약관에 동의합니다. <span class="red">(필수)</span>
							</div>
							<a class="link" target="_blank" href="/login/userAgree.do">약관
								전체보기</a>
						</div>
						<div class="third flex agree">
							<img class="false" src="data:image/png;base64,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"
								alt="">
							<div class="txt">제 3자 정보 제공에 동의합니다. (선택)</div>
							<a class="link" target="_blank" href="/member/marketingAgree.do">내용보기</a>
						</div>
					</div>
					<div class="submit-area">
						<button type="submit" id="joinBtn" class="submit-btn false">가입완료!</button>
					</div>
				</div>
				<div class="message">
					AI_INTERVIEW는 회원님의 정보를 보다 나은<br>서비스의 제공을 위해서만 사용하고 있습니다.
				</div>
			</div>
		</div>
	</form>
</body>
</html>