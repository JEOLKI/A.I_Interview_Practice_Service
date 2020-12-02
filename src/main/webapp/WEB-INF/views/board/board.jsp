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
	@charset "UTF-8";

	#box{
		margin-top: 3%;
	}

	#boardList{
		min-width: 1000px;
		
	}
	
	#menuBox{
		float: right;
	}
	
	#tr1{
		background: #E6E8E8;
	}
	
	#tr2 {
		background: #E6E8E8;
	}
	
	.list td{
		height: 40px;
		border-bottom: 1px solid #E6E6E6;
	}
	
	.list, #contentTable{
		text-align: center;
		border-top: 1px solid #A4A4A4;
		border-bottom: 1px solid #A4A4A4;
		border-collapse: collapse;
	}
	
	#titleTd {
		width: 700px;
	}
	
	#writerTd {
		width: 400px;
	}
	
	#dateTd {
		width: 400px;
	}
	
	#btngroup1{
		text-align: center;
	}
	
	a:link, a:visited{
 		text-decoration: none;
 		color: black;
 		font-weight: bold;
 	}
	
	.trtab:hover{
		background: #F6F6F6;
	}
	
	.tdMenu{
		width: 100px;
		height: 40px;
	}
	
	#contentTable td{
		border-bottom: 1px solid #E6E6E6;
	}
	
	#board_content, #board_title{
		text-align: left;
	}
	
	#board_title{
		width: 700px;
	}
	
	#writer{
		width: 200px;
	}
	
	#date{
		width: 200px;
	}
	
	#board_content{
		height: 230px;
		vertical-align: top;
		padding-top: 10px;
	}
	
	.content{
		padding-top: 10px;
		vertical-align: top;
	}
	
	#but{
		float: right;
	}
	
	.replyTable{
		text-align: left;
	}
	
	.replyMem{
		width: 100px;
		vertical-align: top;
		padding-top: 10px;
	}
	
	.replyContent{
		width: 1200px;
	}
	
	#replyContent{
		border: none;
		display: inline-block;
		width: 92%;
		height : 100px; 
		padding: 1.1em;
		vertical-align: middle;
	}
	
	#insertReply{
		padding-top: 10px;
		vertical-align: top;
		height: 100px;
		width: 60px;
	}
	
	#atch{
		text-align: left;
	}
	
	#reMenu{
		vertical-align: top;
		padding-top: 10px;
	}
	
	.butgroup2{
		text-align: right;
	}
	
	#firstLine, .inputTitle{
		background: #E6E8E8;
	}
	
	.inputTitle {
		border: none;
		width: 80%;
		vertical-align: middle;
		height: 40px;
	}

	.textareaContent {
		margin-top: 10px;
		border: none;
		vertical-align: top;
		height: 400px;
		width: 80%;
	}
	
	td{
		height: 40px;
	}
	
	#inputTd{
		width: 80%;
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

	});

</script>



</head>
<body>

	<%@ include file="/WEB-INF/views/layout/header.jsp" %>

	<section class="hero" id="boardGu${boardGbSq }">
		<div class="hero__content" >
			<div class="content__title">${boardGbNm }</div>
		</div>
	</section>

	<div class="row">

		<table id='contentTable'>
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
						<a>${attachment.atchNm }</a> <br>
					</c:forEach>
				</td>
			</tr>
			
			<tr>
				<tr id='tr2'>
				<td class='tdMenu' id="reMenu">  댓    글 : </td>
				<td id='replyList' colspan='5'>
					<table class='replyTable'>
						<c:forEach items="${replyList }" var="replyVO">
						<tr>
							<td class='replyMem' rowspan='2'>${replyVO.memId }</td>
							<td class='replyDate'>${replyVO.replyDate }</td>
							<td class='butgroup2' rowspan='2'>
							
							<c:if test="${replyVO.memId == S_MEMBER.memId }">
								<button class='updateReply' type='button'>수정</button>
								<button class='insertUpdate' type='button'>등록</button>
								<button class='deleteReply' type='button'>삭제</button>
							</c:if>
					
							</td>
						</tr>
						
						<tr>
							<td class='replyContent' colspan='4'>${replyVO.replyContent }</td>
						</tr>
					
					</c:forEach>
					</table>
				</td>
			</tr>
			<tr>
				<td colspan='6'> 
					<form id="replyfrm" action="${cp }/reply/create.do" method="post">
						<input HIDDEN type="text" name="boardSq" value="${boardVO.boardSq }">
						<input HIDDEN type="text" name="memId" value="${S_MEMBER.memId }">
						<textarea id="replyContent" name="replyContent" rows="" cols=""></textarea>
						<button id="insertReply" type="button">댓글저장</button>
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