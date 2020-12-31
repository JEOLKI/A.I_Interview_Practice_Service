<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>AI_INTERVIEW</title>

<%@ include file="/WEB-INF/views/layout/commonLib.jsp" %>
<%@ include file="/WEB-INF/views/layout/boardLib.jsp" %>


<script>
	$(document).ready(function(){

		$('#summernote').summernote({
				 height: 350,
				 width : 1210
		});

		$('#boardRegBtn').on('click', function(){
			
			$("#boardRegFrm").submit();
			
		});

		$("#atchBtn").on('click', function(){
			if($(".fileinput").length < 5){
				var html = '<input class="fileinput" type="file" name="file"/><br>';
				$('#filediv').append(html)
			}
		})
		
		
		$(".filelist button[type='button']").on('click', function(){
			atchSq = $(this).data("atch_sq");
			var deleteinput = '<input hidden type="text" name="deleteAtchSq" value="'+atchSq+'"/>';
			$('#filediv').append(deleteinput)
			$(this).parents(".filelist").remove();
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
		margin: 30px auto;
		padding-bottom: 30px;
	}
	
	.create-content{
		width: 65%;
		margin: 30px auto;
	}
	
	.custom-select{
		border: 1px solid gray;
		border-radius: 5px;
		height: 31px;
		vertical-align: top;
	}
	
	.custom-input{
		width: 89%;
		border: 1px solid #000d22;
		border-radius: 5px;
		height: 30px;
		padding: 0px 10px;
		margin-bottom: 20px;
	}
	
	#backListBtn, #atchBtn, #boardRegBtn{
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
	
	#backListBtn:hover, .fileDelBtn:hover, #boardRegBtn:hover{
	    background-color: #000d22;
	    color: #fff;
	}
	
	.btnGrp{
		display: inline-block;
		float: right;
		margin-right: 32px;
	}
	
	.fileinput{
		display: inline-block;
		border: 1px solid #000d22;
		border-radius: 5px;
		height: 27px;
		text-align: center;
		background: white;
		margin-top: 5px;
	}

	.fileinput:hover, #atchBtn:hover{
		background-color: #4374D9;
		border: 1px solid white;
	    color: #fff;
	}
	
	.fileDelBtn{
		border: 1px solid #000d22;
		border-radius: 5px;
		text-align: center;
		background: white;
		width: 40px;
		margin-left: 10px;
	}
	
	h4{
		margin-bottom: 1px;
	}
	
	.filelist{
		margin-bottom: 5px;
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
		<div class="create-content">
			<form id="boardRegFrm" action="${pageContext.request.contextPath }/board/update.do" method="POST" enctype="multipart/form-data">
				
				<select class="custom-select" name="catContent">
					<c:forEach items="${categoryList }" var="category">
						<option value="${category.catContent }">${category.catContent }</option>
					</c:forEach>
				</select>
			
				<input class="custom-input" type="text" placeholder="글제목" id="boardTitle" name="boardTitle" value="${boardVO.boardTitle }"><br>
				<textarea id="summernote" name="boardContent">${boardVO.boardContent }</textarea>
				<input hidden="hidden" type="text" value="${boardVO.memId }" name="memId" id="memId"/>
				<input hidden="hidden" type="text" value="${boardVO.parentSq }" name="parentSq" id="parentSq"/>
				<input hidden="hidden" type="text" value="${boardVO.boardSq }" name="boardSq" id="boardSq"/>
				<input hidden="hidden" type="text" value="${boardVO.boardGbSq }" name="boardGbSq" id="boardGbSq"/>
				<input hidden="hidden" type="text" value="${boardVO.groupNo }" name="groupNo" id="groupNo"/>
				<input hidden="hidden" type="text" value="${boardVO.boardSt }" name="boardSt" id="boardSt"/>
				
				<h4>첨부파일목록</h4> 
				<c:forEach items="${attachmentList }" var="attachment">
					<div class="filelist">
						<a href='${pageContext.request.contextPath }/attachment/download?atchSq=${attachment.atchSq }'>${attachment.atchNm }</a>  
						<button class="fileDelBtn" type="button" data-atch_sq=${attachment.atchSq }>삭제</button>
						<br>
					</div>
				</c:forEach>
				
				<div id="filediv">
					<button id="atchBtn" type="button">첨부파일추가</button><br>
				</div>
				
				<div class='btnGrp'>
					<a id="backListBtn"  href="${cp }/board/retrievePagingList.do?boardGbSq=${boardGbSq }&boardGbNm=${boardGbNm }">목록으로</a>
					<a id="boardRegBtn">글 등록</a>
				</div>
			
			</form>
		</div>
	</div>

	
</body>
</html>




