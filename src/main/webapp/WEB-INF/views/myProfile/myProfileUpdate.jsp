<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ include file="/WEB-INF/views/layout/commonLib.jsp" %>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
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
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
$(document).ready(function(){
	if($('#memAlias').val()=='${S_MEMBER.memAlias}'){
		html = '<span style="color:green; font-size:11px;">사용가능한 닉네임입니다</span>';
		$('#checkAlias').append(html);
	}
	if($('#memPw1').val()==$('#memPw2').val()){
		$('#check').val('Y');
	}else{
		$('#check').val('N');
	}
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
			if($('#memPw1').val()!=$('#memPw2').val()){
				$('#checkPw').empty();
				$('#checkPw').append('<span style="color:red; font-size:13px;">비밀번호가 일치하지 않습니다</span>');
				$('#check').val('N');
			}else{
				$('#checkPw').empty();
				$('#checkPw').append('<span style="color:green; font-size:13px;">비밀번호가 일치합니다</span>');
				$('#check').val('Y');
			}
		});
		
	$('#aliasCheck').on('click',function(){
		console.log('체크')
		if($('#memAlias').val()==''){
			alert('닉네임을 입력하세요');
		}else{
			$('#checkAlias').empty();
			aliasCheck();
		}
	});
	
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
	
	$('#cancelBtn').on('click',function(){
		document.location="/member/myprofileview.do";	
	});
	
	$('#editBtn').on('click',function(){
		if(		$('#memPw1').val()=='' ||
				$('#memPw2').val()=='' ||
				$('#memAlias').val()=='' ||
				$('#memTel').val()=='' ||
				$('#memCareer').val()==''||
				$('#memAddr1').val()==''
				){
			alert('필수입력사항을 입력해주세요');
			return false;
		}else if($('#check').val()=='N'){
			alert('비밀번호를 확인해주세요');
			return false;
		}else if(
				$('#checkAlias').text()=='<span style="color:red">중복된 닉네임입니다</span><br><br>'||
				$('#checkAlias').text()==''
				){
			alert('중복체크를 확인해주세요');
			return false;
		}else{
			$('#fr').submit();
			return true;
		}
	});
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
				html = '<span style="color:green; font-size:11px;">사용가능한 닉네임입니다</span>';
				$('#check').val('Y');
				$('#memAlias').attr('readonly',true);
				$('#checkAlias').append(html);
			} else {
				html = '<span style="color:red;font-size:11px;">중복된 닉네임입니다</span>';
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
	<form id="fr" action="/member/update.do" method="post"enctype="multipart/form-data">
		<div id="root">
			<div class="ProfileEdit">
			<%@ include file="/WEB-INF/views/layout/header.jsp" %>
				<div class="body">
					<div class="title">프로필 수정</div>
					<div class="ProfileForm">
						<div class="info-flex">
							<div class="label">프로필 사진</div>
							<div class="content profile-area">
								<img
									src="/member/profile.do?memId=${S_MEMBER.memId }"
									alt="" class="profile-img">
									<input type="file" id="file" name="profile">
									<input type="hidden" id="memId" name="memId" value="${S_MEMBER.memId }">
									<input type="hidden" id="memProfileNm" name="memProfileNm" value="${S_MEMBER.memProfileNm }">
									<input type="hidden" id="memProfilePath" name="memProfilePath" value="${S_MEMBER.memProfilePath }">
							</div>
						</div>
						<div class="info-flex">
							<div class="label">
								별명<span>(필수)</span>
								<span id="checkAlias" class="check"></span>
							</div>
							<div class="content name-area">
								<input type="text" placeholder="사용할 별명을 입력하세요" name="memAlias" class="name-input"
									value="${S_MEMBER.memAlias }" id="memAlias" style="height: 44px;">
								<div class="btn-area">
									<input type="hidden" id="check" value="N">
									<button type="button" class="btn active" id="aliasCheck">중복검사</button><br>
								</div>
							</div>
							<br>
						</div>
						<div class="info-flex">
							<div class="label">
								비밀번호<span>(필수)</span>
							</div>
							<div class="content name-area" style="flex-direction: column">
								<input type="password" placeholder="변경할 비밀번호를 입력하세요" class="memPw" value="${S_MEMBER.memPw }" name="memPw" id="memPw1" style="height: 44px;"><br>
								<input type="password" placeholder="변경할 비밀번호를 입력하세요" class="memPw" value="${S_MEMBER.memPw }" id="memPw2" style="height: 44px;">
								<span id="checkPw" class="check"></span>
							</div>
						</div>
						<div class="info-flex">
							<div class="label">
								경력사항<span>(필수)</span>
							</div>
							<div class="content set-career-flex ">
								<div id="newcomer" class="btn new select">신입</div>
								<div id="experienced" class="btn old false">경력</div>
							</div>
							<input type="hidden" id="memCareer" name="memCareer" value="${S_MEMBER.memCareer }">
						</div>
						<div class="info-flex">
							<div class="label">
								학력<span>(필수)</span>
							</div>
							<div class="content radio-area">
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
						</div>
						<div class="info-flex">
							<div class="label">
								성별<span>(필수)</span>
							</div>
							<div class="content radio-area">
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
						</div>
						<div class="info-flex">
							<div class="label">
								목표 회사 / 직무<span>(필수)</span>
							</div>
							<div class="content prospect-area">
								<div class="company">
									목표 회사
									<div class="CompletionInput company-input">
										<input name="memTargetCompany" type="text"
											placeholder="예) 삼성전자" class="" maxlength="30" value="${S_MEMBER.memTargetCompany }">
									</div>
								</div>
								<div class="job">
									목표 직무
									<div class="CompletionInput job-input">
										<input name="memTargetJob" type="text"
											placeholder="예) 제품 개발/기획" class="" maxlength="30" value="${S_MEMBER.memTargetJob }">
									</div>
								</div>
							</div>
						</div>
						<div class="info-flex">
							<div class="label">취업 준비 시작시기</div>
							<c:set var="now" value="<%=new java.util.Date()%>" />
							<c:set var="sysYear">
								<fmt:formatDate value="${now}" pattern="yyyy" />
							</c:set>
							<div class="year-flex">
								<div class="CustomSelect small" style="margin-left: 40px;">
									<select id="selYear" name="selYear"
										style="width: 108px; height: 30px">
										<fmt:formatDate value="${now}" pattern="yyyy" var="yearStart" />
										<c:forEach begin="0" end="10" var="result" step="1">
											<option value="<c:out value="${yearStart - result}" />"
												<c:if test="${(yearStart - result) == searchVO.bsnsYear}"> selected="selected"</c:if>>
												<c:out value="${yearStart - result}" /></option>
										</c:forEach>
									</select>
								</div>
								<div id="firsthalf" class="half select" value="년 상반기">상반기</div>
								<div id="secondhalf" class="half false" value="년 하반기">하반기</div>
							</div>
							<input type="hidden" id="searchJobDate" name="searchJobDate" value="${S_MEMBER.searchJobDate }">
						</div>
						<div class="info-flex">
							<div class="label">전공</div>
							<div class="content radio-area">
								<div class="CustomRadio grid">
									<div>
										<input type="radio" name="memMajor" id="Humanities" value="인문"
											checked="checked"> <label for="Humanities">인문</label>
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
						</div>
						<div class="info-flex">
							<div class="label">주소</div>
							<div class="content radio-area">
								<div class="CustomRadio grid two">
									<div class="company">
										<div>
											<button type="button" id="zipcodeBtn" class="btn new select"
												style="width: 120px; height: 80px;">우편번호 찾기</button>
										</div>
									</div>
									<br>
									<div class="company">
										<div class="bold">
											<span class="red"></span>주소
										</div>
										<div>
											<input type="text" class="form-control" id="memAddr1"
												name="memAddr1" value="${S_MEMBER.memAddr1 }" placeholder="사용자 주소" READONLY>
										</div>
									</div>
									<br>
									<div class="company">
										<div class="bold">
											<span class="red"></span>상세주소
										</div>
										<div>
											<input type="text" class="form-control" id="memAddr2"
												name="memAddr2" value="${S_MEMBER.memAddr2 }" placeholder="사용자 상세주소">
										</div>
									</div>
									<br>
									<div class="company">
										<div class="bold">
											<span class="red"></span>우편번호
										</div>
										<div>
											<input type="text" class="form-control" id="memZipcode"
												name="memZipcode" value="${S_MEMBER.memZipcode }"  placeholder="사용자 우편번호" READONLY>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="submit-area">
							<button class="cancel" type="submit" id="editBtn">적용</button>
							<button class="cancel" type="button" id="cancelBtn" >취소</button>
						</div>
					</div>
				</div>
				<%@ include file="/WEB-INF/views/layout/myPageFooter.jsp" %>
			</div>
		</div>
	</form>
<!-- 	<style data-styled="active" data-styled-version="5.1.1"></style> -->
</body>
</html>