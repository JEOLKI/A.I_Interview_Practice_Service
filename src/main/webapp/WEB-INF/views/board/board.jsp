<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">

	$(document).ready(function(){

		$("#replyRegBtn").on('click', function(){
			$("#replyfrm").submit();
		});

		$(".replyDelBtn").on('click', function(){
			var reply_sq = $(this).data("reply_sq");
			document.location="${cp }/reply/delete?reply_sq=" + reply_sq +"&board_sq=${boardVo.board_sq }";
		});

		$("#boardDelBtn").on('click', function(){
			document.location="${cp }/board/delete?board_sq=${boardVo.board_sq }&gubun_sq=${boardVo.gubun_sq}&gubun_nm=${param.gubun_nm}";
		});

		$("#boardChildBtn").on('click', function(){
			document.location="${cp }/board/regist?userid=${S_MEMBER.userid }&gubun_sq=${boardVo.gubun_sq }&board_sq=${boardVo.board_sq }&group_no=${boardVo.group_no }";
		})

		$("#BoardUpdateBtn").on('click', function(){
			document.location="${cp }/board/update?board_sq=${boardVo.board_sq }";
		})

		$('#reply_content').on('keyup', function(){
		    var reply_content = $(this).val();
		    $('#counter').html("("+reply_content.length+" / 최대 500자)");    //글자수 실시간 카운팅

		    if (reply_content.length > 500){
		        alert("최대 500자까지 입력 가능합니다.");
		        $(this).val(reply_content.substring(0, 500));
		        $('#counter').html("(500 / 최대 500자)");
		    }
		});

	});
</script>

		
<div class="form-group">
	<label for="board_title" class="col-sm-2 control-label">제목</label>
	<div class="col-sm-10">
		<label class="control-label">${boardVo.board_title }</label>
	</div>
</div>

<div class="form-group">
	<label for="userid" class="col-sm-2 control-label">작성자</label>
	<div class="col-sm-10">
		<label class="control-label">${boardVo.userid }</label>
	</div>
</div>

<div class="form-group">
	<label for="board_date" class="col-sm-2 control-label">등록일자</label>
	<div class="col-sm-10">
		<label class="control-label"><fmt:formatDate value="${boardVo.board_date }" pattern="YYYY-MM-dd"/></label>
	</div>
</div>

<div class="form-group">
	<label for="board_content" class="col-sm-2 control-label">글 내용</label>
	<div class="col-sm-10">
		<label class="control-label">${boardVo.board_content }</label>
	</div>
</div>

<div class="form-group">
	<label for="board_content" class="col-sm-2 control-label">첨부파일</label>
	<div class="col-sm-10">
	
		<c:forEach items="${atchFileList }" var="atchfile">
			<a href='${cp }/file/download?atch_sq=${atchfile.atch_sq }' >${atchfile.atch_filename }</a> <br>
		</c:forEach>
	</div>
</div>

<c:if test="${boardVo.userid == S_MEMBER.userid }">
	<div class="form-group">
		<div class="col-sm-offset-2 col-sm-10">
			<button id="BoardUpdateBtn" type="button" class="btn btn-default" data-userid="${boardVo.board_sq }">수정</button>
			<button id="boardDelBtn" type="button" class="btn btn-default" data-board_sq="${boardVo.board_sq }">삭제</button>
			<button id="boardChildBtn" type="button" class="btn btn-default" data-board_sq="${boardVo.board_sq }">답글</button>
		</div>
	</div>
</c:if>



<div class="form-group">
	<label for="zipcode" class="col-sm-2 control-label">댓글</label>
	<div class="col-sm-10">
		<c:forEach items="${replyList }" var="reply">
		
			<c:choose>
				<c:when test="${reply.reply_yn == 'n' }">
					<label class="control-label">[삭제된 댓글 입니다.]</label>
				</c:when>
				<c:otherwise>
					<label class="control-label">
					<span>${reply.reply_content }</span> [${reply.userid } / <fmt:formatDate value="${reply.reply_date }" pattern="YYYY-MM-dd"/>]
					</label>
					<c:if test="${reply.userid == S_MEMBER.userid }">
						<button class="replyDelBtn" data-reply_sq="${reply.reply_sq }">삭제</button>
					</c:if>
				</c:otherwise>
			</c:choose>
			
			<br>
		</c:forEach>
		<br>
		
		<form id="replyfrm" action="${cp }/reply/regist" method="get">
			<input HIDDEN type="text" name="board_sq" value="${boardVo.board_sq }">
			<input HIDDEN type="text" name="userid" value="${S_MEMBER.userid }">
			<textarea id="reply_content" name="reply_content" rows="" cols=""></textarea>
			<span style="color:#aaa;" id="counter">(500 / 최대 500자)</span>
			<button id="replyRegBtn" type="button">댓글저장</button>
		</form>
		
	</div>
</div>


