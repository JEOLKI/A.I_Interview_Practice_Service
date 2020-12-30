<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AI_INTERVIEW</title>

<%@ include file="/WEB-INF/views/layout/commonLib.jsp" %>

<style type="text/css">

.aiInterview-logo{
		width: 175px;
		height: 52px;
		margin-top: 5px;
		margin-left: 6px;		
	}
	
/* The Modal (background) */
#questionSearch {
	display: none; /* Hidden by default */
	position: fixed; /* Stay in place */
	z-index: 100; /* Sit on top */
	left: 0;
	top: 0;
	width: 100%; /* Full width */
	height: 100%; /* Full height */
	overflow: auto; /* Enable scroll if needed */
	background-color: rgb(0, 0, 0); /* Fallback color */
	background-color: rgba(0, 0, 0, 0.4); /* Black w/ opacity */
}

.nothing{
	cursor: pointer;
	padding : 13px 40px;
}
</style>
<script>
$(document).ready(function(){
	$('.search-btn').hide();
	$('#complete').hide();
	
	count = 1;
	number = 0;
	
	// 질문 추가
	$('.NullQuestionBox').on('click',function(){
		if(count < 5 ){
			count++;
			$('.NullQuestionBox').before($("<div class='SetQuestionBox'><div draggable='true' class='SetQuestionBoxView false'><div class='label unchecked' style='cursor: pointer'></div><input type='text' id='question' class='text' placeholder='면접 질문을 입력해주세요'value='' name='questionList'><input type='hidden' class='sampQuestSq' value='0' name='sampQuestSqList'> <button type='button' id='complete' class='complete-btn' style='display:none;' >완료</button><button type='button' class='search-btn' style='display:none;'><img src='/images/search.ed51fb59.svg' alt='' class='search-icon'></button><div class='delete-btn' style='' ><img src='/images/close-btn.9663b787.svg' alt='' ></div></div></div>"));
		}else{
			alert('질문 개수 제한은 5개입니다')			
		}
	});
	
	// 질문칸 클릭
	$(document).on('click','.SetQuestionBox',function(e){
		if(!$(e.target).hasClass('complete-btn')){
			$(this).find('button').show();
			$(this).find('.delete-btn').hide();
			$(this).addClass('checked');
			$(this).children().addClass('checked');
		}else{ // 완료 버튼 클릭
			$('.SetQuestionBox button').hide();
			$('.delete-btn').show();
			$('.SetQuestionBox').children().removeClass('checked');
			$('.SetQuestionBox').removeClass('checked');
		}
	});
	
	// 질문삭제
	$(document).on('click','.delete-btn',function(){
		if(count  == 1){
			alert('최소 하나의 질문은 필요합니다')
		}else{
			$(this).parent().parent().remove();
			count--;
		}
	});
	
	// 검색창 열기
	$(document).on('click','.search-btn',function(){
		$('#questionSearch').show();
		number = $('#questionFrm .SetQuestionBox').index($(this).parent().parent($('.SetQuestionBox'))); // 폼안의 몇번째div 인지 인덱스값
		// number전역변수의 값을 index값으로 바꿈
		$.ajax({
			url : "/sampQuest/retrieveRandom.do",
			method : "get",
			success : function(data){
				console.log( data.sampleQuestionVO.sampQuestContent);
				$('#randomQuestion').remove();
				html=""
				html+="<div class='searched-question' id='randomQuestion' data-sq="+data.sampleQuestionVO.sampQuestSq+">"+data.sampleQuestionVO.sampQuestContent+"</div>";
				$('.searched-question.recommend').append(html);
			},
			error : function(data){
				console.log(data.status);
			}
		});
	});
	
	// 닫기 버튼 클릭 시
	$(document).on('click','.close-btn',function(){
		$('#search').val(''); // 검색칸 초기화
		$('.searched-question.recommend').show(); // 추천질문 표시
		$('.recommend-question').show(); // 
		$('.nothing').remove(); // 검색결과 없음 지우기
		$('.result').remove(); // 검색된 결과 지우기
		$('#randomQuestion').remove(); // 검색된 결과 지우기
		$('#questionSearch').hide(); // 모달창 닫기
	});
	
	// 바깥쪽 클릭하여 체크 해제
	$(document).mouseup(function(){
		$('.SetQuestionBox button').hide();
		$('.delete-btn').show();
		$('.SetQuestionBox').children().removeClass('checked');
		$('.SetQuestionBox').removeClass('checked');
	});
	
	// 질문 클릭 시
	$(document).on('click','.search-result .searched-question',function(){
		
		content = $(this).text();
		sq = $(this).data('sq');
		
		$('#questionFrm .SetQuestionBox').eq(number).find($('.text')).val(content);
		$('#questionFrm .SetQuestionBox').eq(number).find($('.sampQuestSq')).val(sq);
		$('#search').val(''); // 검색칸 초기화
		$('.searched-question.recommend').show(); // 추천질문 표시
		$('.recommend-question').show(); // 추천질문 표시
		$('.nothing').remove(); // 검색결과 없음 지우기
		$('.result').remove(); // 검색된 결과 지우기
		$('#randomQuestion').remove(); // 검색된 결과 지우기
		$('#questionSearch').hide();
		
	});
	
	// 랜덤질문을 클릭 시
	$(document).on('click','#randomQuestion',function(){
		content = $(this).text(); 
		sq = $(this).data('sq');
		
		$('#questionFrm .SetQuestionBox').eq(number).find($('.sampQuestSq')).val(sq);
		$('#questionFrm .SetQuestionBox').eq(number).find($('.text')).val(content);
		
		$('#search').val(''); // 검색칸 초기화
		$('.searched-question.recommend').show(); // 추천질문 표시
		$('.recommend-question').show(); // 
		$('.nothing').remove(); // 검색결과 없음 지우기
		$('.result').remove(); // 검색된 결과 지우기
		$('#randomQuestion').remove(); // 검색된 결과 지우기
		$('#questionSearch').hide(); // 모달창 닫기
	});
	
	// 샘플질문을 수정 시 임의 질문으로 변경
	$(document).on('change',$('#questionFrm .SetQuestionBox').eq(number).find($('.text')).val(),function(){
		$('#questionFrm .SetQuestionBox').eq(number).find($('.sampQuestSq')).val(0);
	});
	
	// 키워드 검색 에이잭스
	$("#search").keyup(function(){
		searchKeyword = $('#search').val();
		if(searchKeyword == ''){
			$('.searched-question.result').remove();
		}else{
			$.ajax(
				{url:"/sampQuest/retrieve.do",
				data : {searchKeyword : searchKeyword},
				method : "get",
				success : function(data){
					$('.nothing').remove();
					$('.searched-question.result').remove();
					
					if(data.sampQuestList.length == 0){
						html="";
						html += "<div class='nothing'>결과가 없습니다</div>";
						$('.search-result').append(html);
					}else{
						html = "";
						for(i=0; i< data.sampQuestList.length; i++){
							html += "<div class='searched-question result' id='result' data-sq="+data.sampQuestList[i].sampQuestSq+">" + data.sampQuestList[i].sampQuestContent + "</div>";
						}
						$('.search-result').append(html);
					}
				},
				error : function(data){
					console.log(data.status);
				}
			});
		}
	});
	
	// 랜덤 질문 생성
	$(document).on('click','#random',function(){
		$.ajax({
			url : "/sampQuest/retrieveRandom.do",
			method : "get",
			success : function(data){
				console.log( data.sampleQuestionVO.sampQuestContent);
				$('#randomQuestion').remove();
				html=""
				html+="<div class='searched-question' id='randomQuestion' data-sq="+data.sampleQuestionVO.sampQuestSq+">"+data.sampleQuestionVO.sampQuestContent+"</div>";
				$('.searched-question.recommend').append(html);
			},
			error : function(data){
				console.log(data.status);
			}
		});
	});
});

// submit하는 function
function setting(){
	questionCount = $('.text').length
	for(i=0; i<questionCount; i++){ // 모든 질문들 ,-> .로변경
		var result = $('#questionFrm .SetQuestionBox').eq(i).find($('.text')).val().replace(/,/g, '.');
		$('#questionFrm .SetQuestionBox').eq(i).find($('.text')).val(result);
		console.log($('#questionFrm .SetQuestionBox').eq(i).find($('.text')).val())
	}
	
	for(i=0; i<$('.text').length; i++){
		if($('.text').eq(i).val()==''){
			alert('빈칸인 질문이 있습니다.')
			
			return false;
		}
	}
	$("#questionFrm").submit();
}

</script>
</head>
<body style="overflow: hidden; scroll="no">
	<noscript>You need to enable JavaScript to run this app.</noscript>
	<div id="root">
		<div class="Questions">
			<%@include file="/WEB-INF/views/layout/header.jsp"%>
			<div class="body">
				<div class="NewQuestionSearch">
					<div id="questionSearch" class="modal">
						<form action="" method="post" >
							<div class="content-box" style="margin-left: 23%;">
								<div class="close-btn">
									<img src="/images/close-btn.9663b787.svg" alt="" style="height: 60%;width: 60%;">
								</div>
								<div class="input-bar false">
									<span aria-hidden="true" class="fa fa-search fa undefined">
									</span> 
									<input id="search" type="text" placeholder="회사명, 직무명 등 키워드로 질문을 검색하세요."value="">
								</div>
								<div class="questions-area">
									<div class="search-result">
										
									</div>
									<div class="recommend-question">
										<div class="label">추천 질문</div>
										<div class="searched-question recommend">
											<button  id="random" type="button" class="refresh-btn">
												<span aria-hidden="true" class="fa fa-refresh fa undefined"></span>
											</button>
										</div>
									</div>
								</div>
							</div>
						</form>
					</div>

				</div>
				<div class="QuestionSetBar">
					<div class="title">면접 질문 미리보기</div>

					<form id="questionFrm"
						action="${pageContext.request.contextPath }/interview/setting.do"
						method="get">

						<div class="SetQuestionBox">
							<div draggable="true" class="SetQuestionBoxView">
								<div class="label unchecked" style="cursor: pointer"></div>
								<input type="text" id="question" class="text"
									placeholder="면접 질문을 입력해주세요" value="" name="questionList">
								<input type="hidden" class="sampQuestSq" value="0" name="sampQuestSqList">
								<button type="button" id="complete" class="complete-btn" >완료</button>
								<button type="button" class="search-btn">
									<img src="/images/search.ed51fb59.svg" alt=""
										class="search-icon">
								</button>
								<div class="delete-btn">
									<img src="/images/close-btn.9663b787.svg" alt="">
								</div>
							</div>
						</div>

						<div class="NullQuestionBox">
							<div class="NullQuestionBox__text">
								<div class="wrapper">
									<img src="/images/add.b9b0eddd.svg" alt=""> <span>질문
										추가</span>
								</div>
							</div>
						</div>
						<div class="interview-ready-btn Btn none" onclick="setting();" return false;>면접
							시작</div>

					</form>

				</div>
			</div>
			<footer class="SimpleFooter">
			<div class="logo-area">
				<img src="/images/Ai_Interview 로고.png" class="aiInterview-logo"
				alt="aiInterview-logo">
			</div>
			<div class="aiInterview-message">
				@<b>Ourtech Corp.</b> All Rights Reserved.
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
	
	<%@ include file="/WEB-INF/views/chat/chatImage.jsp" %>
	
</body>
</html>