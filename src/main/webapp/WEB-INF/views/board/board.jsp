<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<%@ include file="/WEB-INF/views/layout/commonLib.jsp" %>

<style type="text/css">

	.insertUpdate{
		display: none;
	}

</style>

<script type="text/javascript">
	
	$(document).ready(function(){
		$("#boardDelBtn").on('click', function(){
			document.location="${pageContext.request.contextPath }/board/delete.do?boardSq=${boardVO.boardSq }&boardGbSq=${boardGbSq}&boardGbNm=${boardGbNm }";
		});
		
		$("#BoardUpdateBtn").on('click', function(){
			document.location="${pageContext.request.contextPath }/board/update.do?boardSq=${boardVO.boardSq }&boardGbSq=${boardGbSq}";
		})
		
		$("#boardChildBtn").on('click', function(){
			document.location="${pageContext.request.contextPath }/board/create.do?memId=${S_MEMBER.memId }&boardGbSq=${boardVO.boardGbSq }&boardSq=${boardVO.boardSq }&groupNo=${boardVo.groupNo }";
		})
		
		$("#replyRegBtn").on('click', function(){
			$("#replyfrm").submit();
		});

		$(".replyDelBtn").on('click', function(){
			var reply_sq = $(this).data("reply_sq");
			document.location="${pageContext.request.contextPath }/reply/delete.do?replySq=" + reply_sq +"&boardSq=${boardVO.boardSq }";
		});
		
		// 답변의 수정버튼을 클릭하면
		$('.updateReply').on('click', function() {
			
			replySq = $(this).data('reply_sq');
			
			$(this).hide();
			$('#insertUpdate'+replySq+'').show();
			
			content = $('#replyContent'+replySq+'').html().replace(/<br>/g, "\n");
			
			code = "<textarea id='newReply' rows='5' cols='20' name='replyContent'>"+content+"</textarea>";
			code += '<input HIDDEN type="text" name="replySq" value="'+replySq+'">';
			
			$('#replyContent'+replySq+'').empty();
			$('#replyContent'+replySq+'').append(code);
			
		})
		
		$('.insertUpdate').on('click', function(){
			$("#newReplyfrm").submit();
		})
		
		$('.deleteReply').on('click', function() {
			
			replySq = $(this).data('reply_sq');
			
			document.location="${pageContext.request.contextPath }/reply/delete.do?replySq=" + replySq +"";
			
		})
		
		
	});

</script>



</head>
<body>

	<%@ include file="/WEB-INF/views/layout/header.jsp" %>

	<section class="hero contentbox" id="boardGu${boardGbSq }">
		<div class="hero__content" >
			<div class="content__title">${boardGbNm }</div>
		</div>
	</section>

	<div class="table-responsive ">

		<table class="table table-bordered" id="dataTable">
			<tr id='tr1'>
				<td class='tdMenu'>제목 :</td>
				<td id='boardTitle'>[ ${boardVO.catContent} ] ${boardVO.boardTitle }</td>
				<td class='tdMenu'>작성자 :</td>
				<td id='memId'>${boardVO.memId }</td>
				<td class='tdMenu'>작성일자 :</td>
				<td id='boardDate'>${boardVO.boardDate }</td>
			</tr>
			
			<tr>
				<td class='tdMenu content'>내용 :</td>
				<td id='boardContent' colspan='5'>${boardVO.boardContent}</td>
			</tr>
			
			<tr>
				<td class='tdMenu'>첨부파일 :</td>
				<td colspan='5'>
					<c:forEach items="${attachmentList }" var="attachment">
						<a href='${pageContext.request.contextPath }/attachment/download?atchSq=${attachment.atchSq }' >${attachment.atchNm }</a> <br>
					</c:forEach>
				</td>
			</tr>
			
			<tr>
				<tr id='tr2'>
				<td class='tdMenu' id="reMenu">  댓    글 : </td>
				<td id='replyList' colspan='5'>
					<form id="newReplyfrm" action="${pageContext.request.contextPath }/reply/update.do" method="GET">
					<table class="replyTable table table-bordered" id="dataTable">
						<c:forEach items="${replyList }" var="replyVO">
							<c:if test="${replyVO.replySt == 'Y'}">
								<tr>
									<td class='replyMem' rowspan='2'>${replyVO.memId }</td>
									<td class='replyDate'>${replyVO.replyDate }</td>
									<td class='butgroup2' rowspan='2'>
									
									<c:if test="${replyVO.memId == S_MEMBER.memId }">
										<button class='updateReply' data-reply_sq="${replyVO.replySq }" type='button'>수정</button>
										<button class='insertUpdate' id="insertUpdate${replyVO.replySq }" data-reply_sq="${replyVO.replySq }" type='button'>등록</button>
										<button class='replyDelBtn' type='button' data-reply_sq="${replyVO.replySq }" >삭제</button>
									</c:if>
							
									</td>
								</tr>
								<tr>
									<td class='replyContent' id='replyContent${replyVO.replySq }' colspan='4' >${replyVO.replyContent }</td>
								</tr>
							</c:if>
						</c:forEach>
					</table>
					<input HIDDEN type="text" name="boardSq" value="${boardVO.boardSq }">
					<input HIDDEN type="text" name="memId" value="${S_MEMBER.memId }">
					</form>
				</td>
			</tr>
			<tr>
				<td colspan='6'> 
					<form id="replyfrm" action="${pageContext.request.contextPath }/reply/create.do" method="GET">
						<input HIDDEN type="text" name="boardSq" value="${boardVO.boardSq }">
						<input HIDDEN type="text" name="memId" value="${S_MEMBER.memId }">
						<textarea id="replyContent" name="replyContent" rows="" cols=""></textarea>
						<button id="replyRegBtn" type="button">댓글저장</button>
					</form>
				</td>
			</tr>
		</table>
		
		<div>
			<c:if test="${boardVO.memId == S_MEMBER.memId }">
				<button id="BoardUpdateBtn" type="button" class="btn btn-default" >수정</button>
				<button id="boardDelBtn" type="button" class="btn btn-default" >삭제</button>
			</c:if>
			
			<button id="boardChildBtn" type="button" class="btn btn-default" >답글</button>
		</div>

	</div>



</body>
</html>