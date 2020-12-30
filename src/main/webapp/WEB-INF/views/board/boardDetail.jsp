<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>AI_INTERVIEW</title>
<%@ include file="/WEB-INF/views/layout/commonLib.jsp" %>


<script type="text/javascript">
	
	$(document).ready(function(){
		
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
			
			code = "<textarea id='newReply' name='replyContent'>"+content+"</textarea>";
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

<style type="text/css">

	#boardGu1{
		background: repeating-linear-gradient(-60deg, rgba(255, 255, 255, 0), rgba(255, 255, 255, 0) 10px, rgba(255, 255, 255, 0.1) 0px, rgba(255, 255, 255, 0.1) 11px),  linear-gradient(-40deg,#1c94c1,#75dfc8);
	}
	
	#boardGu2{
		background: repeating-linear-gradient(-60deg, rgba(255, 255, 255, 0), rgba(255, 255, 255, 0) 10px, rgba(255, 255, 255, 0.1) 0px, rgba(255, 255, 255, 0.1) 11px),  linear-gradient(-40deg,#140d57,#1391aa);
	}
	
	#boardGu3{
		background: repeating-linear-gradient(-60deg, rgba(255, 255, 255, 0), rgba(255, 255, 255, 0) 10px, rgba(255, 255, 255, 0.1) 0px, rgba(255, 255, 255, 0.1) 11px),  linear-gradient(-40deg,#8b1c1c,#2717a3);
	}
	
	#boardGu4{
		background: repeating-linear-gradient(-60deg, rgba(255, 255, 255, 0), rgba(255, 255, 255, 0) 10px, rgba(255, 255, 255, 0.1) 0px, rgba(255, 255, 255, 0.1) 11px), linear-gradient(-40deg, #00b4db, #0083b0);
	}
	
	.contentBox{
		width: 100%;
		margin: 20px auto;
		padding-bottom: 40px;
	}
	
	.table-responsive{
		width: 65%;
		margin: 30px auto;
	}
	
	.content-table{
		width: 98%;
		margin: 0px auto;
		border-collapse: collapse; 
	}
	
	.content-table td{
		height: 50px;
		text-align: center;
		border-top: 1px solid rgba(154,171,186,.3);
		border-bottom: 1px solid rgba(154,171,186,.3);
	}
	
	.menu {
		background-color: #f5f7fb;
	}
	
	#atchMenu {
		text-align: left;
		padding: 20px;
		
	}
	
	.catContent{
		font-size: 0.8em;
		font-weight: bold;
		color : #4374D9;
		display : inline-block;
		border: 1px solid #4374D9;
		border-radius: 3px;
		padding: 1px 10px;
		background-color: #D9E5FF;
	}
	
	#contentMenu{
		height: 300px;
		text-align: left;
		vertical-align: top;
		padding: 20px;
		overflow: auto;
	}
	
	#titleMenu{
		text-align: left;
		padding-left: 10px;
	}
	
	.replyTable{
		width: 100%;
	}
	
	.replyTable td{
		border: 1px solid white;
	}
	
	.replyTable .replyContent{
		text-align: left;
	}
	
	.replyBtnGrp{
		display: inline-block;
		float: right;
		border: 1px solid #000d22;
		border-radius: 5px;
		height: 29px;
		width: 40px;
		text-align: center;
		background: white;
		margin: 0px 3px;
	}
	
	#boardUpdateBtn:hover, #boardDelBtn:hover, #backListBtn:hover, #boardChildBtn:hover, #replyRegBtn:hover, .replyBtnGrp:hover{
	    background-color: #000d22;
	    color: #fff;
	}
	
	#newReply{
		width: 95%;
		height: 95%;
		resize: none;
	}
	
	#replyContent{
		margin: 10px;
		width: 90%;
		height: 100px;
		resize: none;
		float: left;
	}
	
	#replyRegBtn{
		border-radius: 5px;
		font-size: 0.9em;
		margin: 10px;
		float: right;
		width: 6%;
		height: 100px;
		background: white;
		border: 1px solid #000d22;
	}
	
	#boardUpdateBtn, #boardDelBtn, #backListBtn, #boardChildBtn{
		display: inline-block;
		border: 1px solid #000d22;
		border-radius: 5px;
		height: 29px;
		width: 100px;
		text-align: center;
		background: white;
		margin-top: 20px;
		vertical-align: middle;
	}
	
	.btnGrp{
		display: inline-block;
		float: right;
		margin-right: 32px;
	}
	
	.firstTd{
		width: 130px;
	}
</style>


</head>
<body>

	<%@ include file="/WEB-INF/views/layout/header.jsp" %>

	<section class="hero contentbox" id="boardGu${boardGbSq }">
		<div class="hero__content" >
			<div class="content__title">${boardGbNm }</div>
		</div>
	</section>

	<div class="contentBox">
		<div class="table-responsive">
			<table class="content-table">
				<tr>
					<td class="menu firstTd">제 목 :</td>
					<td><div class="catContent">${boardVO.catContent}</div></td>
					<td id="titleMenu">${boardVO.boardTitle }</td>
					<td class="menu">작 성 자 :</td>
					<td>${boardVO.memId }</td>
					<td class="menu">작 성 일 자 :</td>
					<td>${boardVO.boardDate }</td>
				</tr>
			
				<tr>
					<td class="menu">첨 부 파 일 :</td>
					<td colspan='6' id="atchMenu">
						<c:forEach items="${attachmentList }" var="attachment">
							<a href='${pageContext.request.contextPath }/attachment/download?atchSq=${attachment.atchSq }' >${attachment.atchNm }</a> <br>
						</c:forEach>
					</td>
				</tr>
			
				<tr>
					<td class="menu">내 용 :</td>
					<td colspan='6' id="contentMenu">${boardVO.boardContent}</td>
				</tr>
			
				<tr>
					<td class="menu" rowspan="2">댓 글 :</td>
					
					<td id='replyList' colspan='6'>
						
						<form id="newReplyfrm" action="${pageContext.request.contextPath }/reply/update.do" method="GET">
							<table class="replyTable">
								<c:forEach items="${replyList }" var="replyVO">
									<c:if test="${replyVO.replySt == 'Y'}">
										<tr>
											<td class='replyMem' rowspan='1'>${replyVO.memId }</td>
											<td class='replyContent' id='replyContent${replyVO.replySq }' colspan='4' >${replyVO.replyContent }	</td>
											<td class='replyDate'>${replyVO.replyDate }</td>
											<td class='butgroup2' rowspan='1'>
											
											<c:if test="${replyVO.memId == S_MEMBER.memId }">
												<button class='replyBtnGrp replyDelBtn' type='button' data-reply_sq="${replyVO.replySq }" >삭제</button>
												<button class='replyBtnGrp insertUpdate' id="insertUpdate${replyVO.replySq }" data-reply_sq="${replyVO.replySq }" type='button' style="display: none;">등록</button>
												<button class='replyBtnGrp updateReply' data-reply_sq="${replyVO.replySq }" type='button'>수정</button>
											</c:if>
									
											</td>
										</tr>
										<tr>
										</tr>
									</c:if>
								</c:forEach>
							</table>
						
							<input type="hidden" name="boardSq" value="${boardVO.boardSq }">
							<input type="hidden" name="memId" value="${S_MEMBER.memId }">
						
						</form>
						
					</td>
			</tr>
			<tr>
				<td colspan='6'> 
					<form id="replyfrm" action="${pageContext.request.contextPath }/reply/create.do" method="GET">
						<input type="hidden" name="boardSq" value="${boardVO.boardSq }">
						<input type="hidden" name="memId" value="${S_MEMBER.memId }">
						<textarea id="replyContent" name="replyContent"></textarea>
						<button id="replyRegBtn" type="button">댓글등록</button>
					</form>
				</td>
			</tr>
		</table>
		
		<div class='btnGrp'>
			<c:if test="${boardVO.memId == S_MEMBER.memId }">
				<a id="boardUpdateBtn" href="${pageContext.request.contextPath }/board/update.do?boardSq=${boardVO.boardSq }&boardGbSq=${boardGbSq}">수정</a>
				<a id="boardDelBtn" href="${pageContext.request.contextPath }/board/delete.do?boardSq=${boardVO.boardSq }&boardGbSq=${boardGbSq}&boardGbNm=${boardGbNm }">삭제</a>
			</c:if>
			
			<a id="boardChildBtn" href="${pageContext.request.contextPath }/board/create.do?memId=${S_MEMBER.memId }&boardGbSq=${boardVO.boardGbSq }&boardSq=${boardVO.boardSq }&groupNo=${boardVo.groupNo }">답글</a>
			<a id="backListBtn"  href="${cp }/board/retrievePagingList.do?boardGbSq=${boardGbSq }&boardGbNm=${boardGbNm }">목록으로</a>
		</div>
		
	</div>
</div>


</body>
</html>