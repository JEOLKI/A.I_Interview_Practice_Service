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
#zipcodeBtn {
    height: 28px;
    width : 100px;
    text-align: center;
    position: absolute;
    margin-left: 10px;
    background: #3b3b46;
    color : white;
    font-size: 12px;
}
.addr{
	width: 400px;
}
.adddrNm{
	display: inline-block;
}
#memAddr1,#memAddr2,#memZipcode{
	width:280px;
}

</style>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	if($('#memAlias').val()=='${S_MEMBER.memAlias}'){
		html = '<span style="color:green; font-size:11px;">사용가능한 닉네임입니다</span>';
		$('#checkAlias').append(html);
	}
	if($('#memPwOne').val()==$('#memPwTwo').val()){
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

function readURL(value){
	if(value.files && value.files[0]){
		var reader = new FileReader(); 
		reader.onload = function(e){
			$('.profile-img').attr('src',e.target.result);
		}
		reader.readAsDataURL(value.files[0]);
	}
}
	
	$(document).ready(function(){
		$('.memPw').on('input',function(){
			if($('#memPwOne').val()!='' && $('#memPwTwo').val()!=''){
				if($('#memPwOne').val()!=$('#memPwTwo').val()){
					if(!/^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$/.test($("#memPwOne").val()) || !/^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$/.test($("#memPwTwo").val())){
						$('#checkPw').empty();
						$('#checkPw').append('<span style="color:red">최소 하나의 문자, 숫자로 최소 8자리 입력가능합니다</span><br><br>');
						$('#check').val('N');
					}else{
						$('#checkPw').empty();
						$('#checkPw').append('<span style="color:red">비밀번호가 일치하지 않습니다</span><br><br>');
						$('#check').val('N');
					}
				}else if($('#memPwOne').val()==$('#memPwTwo').val()){
					if(!/^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$/.test($("#memPwOne").val()) || !/^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$/.test($("#memPwTwo").val())){
						$('#checkPw').empty();
						$('#checkPw').append('<span style="color:red">최소 하나의 문자, 숫자로 최소 8자리 입력가능합니다</span><br><br>');
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
		if(		$('#memPwOne').val()=='' ||
				$('#memPwTwo').val()=='' ||
				$('#memAlias').val()=='' ||
				$('#memCareer').val()==''||
				$('#memAddr1').val()==''
				){
			console.log($('#memPwOne').val());
			console.log($('#memPwTwo').val());
			console.log($('#memAlias').val());
			console.log($('#memCareer').val());
			console.log($('#memAddr1').val());
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
	
     $("#file").on('change', function(){
         readURL(this);
     });
});
	
function aliasCheck(){
	memAlias = $('#memAlias').val();
	if(memAlias == '${S_MEMBER.memAlias}'){
		html = '<span style="color:green; font-size:11px;">기존 닉네임을 유지합니다</span>';
		$('#check').val('Y');
		$('#memAlias').attr('readonly',true);
		$('#checkAlias').append(html);
	}else{
		$.ajax({
				url : "/member/aliasCheck.do",
				data : {
					memAlias : memAlias
				},
				method : "post",
				success : function(data) {
					if (data.memberList.length == 0) {
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
	}
};
</script>
</head>
<body>
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
								<c:choose>
									<c:when test="${S_MEMBER.memProfileNm == null }">
										<img alt="" src="/images/defaultImage.jpg" class="profile-img">
									</c:when>
									<c:otherwise>
										<img src="/member/profile.do?memId=${S_MEMBER.memId }"alt="" class="profile-img">
									</c:otherwise>
								</c:choose>
									<input type="file" id="file" name="profile">
									<input type="hidden" name="memId" value="${S_MEMBER.memId }">
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
									<button type="button" class="btn active" id="aliasCheck" style="opacity: 1">중복검사</button><br>
								</div>
							</div>
							<br>
						</div>
						<div class="info-flex">
							<div class="label">
								비밀번호<span>(필수)</span>
							</div>
							<div class="content name-area" style="flex-direction: column">
								<input type="password" name="memPw" placeholder="변경할 비밀번호를 입력하세요" class="memPw" value="${S_MEMBER.memPw}" id="memPwOne"   style="height: 44px; width: 350px;"maxlength="20"><br>
								<input type="password" placeholder="변경할 비밀번호를 입력하세요" class="memPw" value="${S_MEMBER.memPw}" id="memPwTwo" style="height: 44px; width: 350px;"maxlength="20">
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
											<option value="<c:out value="${yearStart+1 - result}" />"
												<c:if test="${(yearStart+1 - result) == (S_MEMBER.searchJobDate).substring(0,4)}"> selected="selected"</c:if>>
												<c:out value="${yearStart+1 - result}" /></option>
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
							<div class="label">주소<span>(필수)</span></div>
							<div class="content radio-area">
								<div class="CustomRadio grid two">
									<br>
									<div class="company addr" >
										<span class="adddrNm">주&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;소</span>
										<div style="display: inline;">
											<input type="text" class="form-control" id="memAddr1"
												name="memAddr1" value="${S_MEMBER.memAddr1 }" placeholder="사용자 주소" style="margin-left: 24px;" READONLY>
											<button type="button" id="zipcodeBtn" class="btn new select"
												>우편번호 찾기</button>
										</div>
									</div>
									<br>
									<div class="company addr">
										<span class="adddrNm"></span>상세주소
										<div style="display: inline;"> 
											<input type="text" class="form-control" id="memAddr2"
												name="memAddr2" value="${S_MEMBER.memAddr2 }" placeholder="사용자 상세주소" style="margin-left: 20px;">
										</div>
									</div>
									<br>
									<div class="company addr">
										<span class="adddrNm"></span>우편번호
										<div style="display: inline;">
											<input type="text" class="form-control" id="memZipcode"
												name="memZipcode" value="${S_MEMBER.memZipcode }"  placeholder="사용자 우편번호" style="margin-left: 20px;" READONLY>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="submit-area" style="display: flex;">
							<button class="cancel" type="submit" id="editBtn">적용</button>
							<button class="cancel" type="button" id="cancelBtn" >취소</button>
						</div>
					</div>
				</div>
				<%@ include file="/WEB-INF/views/layout/semiFooter.jsp" %>
			</div>
		</div>
	</form>
</body>
</html>