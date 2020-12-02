<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>


<%@ include file="/WEB-INF/views/layout/commonLib.jsp" %>


<script>
	$(document).ready(function(){
		$('#summernote').summernote({
				 height: 600
		});

		$('#boardRegBtn').on('click', function(){
			
			$("#boardRegFrm").submit();
			
		});

		$("#atchBtn").on('click', function(){
			if($(".fileinput").length < 5){
				var html = '<input class="fileinput" type="file" name="file"/>';
				$('#filediv').append(html)
			}
		})
		
		
		$(".filelist button[type='button']").on('click', function(){
			atchSq = $(this).data("atch_sq");
			var deleteinput = '<input hidden type="text" name="deletefile" value="'+atchSq+'"/>';
			$('#filediv').append(deleteinput)
			$(this).parents(".filelist").remove();
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
	
	<form id="boardRegFrm" action="${pageContext.request.contextPath }/board/update.do" method="POST" enctype="multipart/form-data">

		말머리 : 
		<select name="catContent">
			<c:forEach items="${categoryList }" var="category">
				<option value="${category.catContent }">${category.catContent }</option>
			</c:forEach>
		</select>
	
		<input class="form-control" type="text" placeholder="글제목" id="boardTitle" name="boardTitle" value="${boardVO.boardTitle }"><br>
		<textarea id="summernote" name="boardContent">${boardVO.boardContent }</textarea>
		<input hidden="hidden" type="text" value="${boardVO.memId }" name="memId" id="memId"/>
		<input hidden="hidden" type="text" value="${boardVO.parentSq }" name="parentSq" id="parentSq"/>
		<input hidden="hidden" type="text" value="${boardVO.boardSq }" name="boardSq" id="boardSq"/>
		<input hidden="hidden" type="text" value="${boardVO.boardGbSq }" name="boardGbSq" id="boardGbSq"/>
		<input hidden="hidden" type="text" value="${boardVO.groupNo }" name="groupNo" id="groupNo"/>
		<input hidden="hidden" type="text" value="${boardVO.boardSt }" name="boardSt" id="boardSt"/>
		
		<label class="control-label">첨부파일</label> 
		<c:forEach items="${attachmentList }" var="attachment">
			<div class="filelist">
				<a href='${pageContext.request.contextPath }/fileDownload?atchSq=${attachment.atchSq }' class="fileinput" >${attachment.atchNm }</a>  
				<button type="button" data-atch_sq=${attachment.atchSq }>X</button>
				<br>
			</div>
		</c:forEach>
		
		<div id="filediv">
			<button id="atchBtn" type="button">첨부파일추가</button> <br>
		</div>
		<input id="boardRegBtn" type="button" value="저장">
	</form>
	
</body>
</html>




