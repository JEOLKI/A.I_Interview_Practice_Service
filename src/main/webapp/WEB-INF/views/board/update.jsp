<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<!-- include summernote css/js -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>

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
			atch_sq = $(this).data("atch_sq");
			var deleteinput = '<input hidden type="text" name="deletefile" value="'+atch_sq+'"/>';
			$('#filediv').append(deleteinput)
			$(this).parents(".filelist").remove();
		})
	});
</script>

</head>
<body>

	<form id="boardRegFrm" action="${cp }/board/update" method="POST" enctype="multipart/form-data">
		<input class="form-control" type="text" placeholder="글제목" id="board_title" name="board_title" value="${boardVo.board_title }"><br>
		<textarea id="summernote" name="board_content">${boardVo.board_content }</textarea>
		<input hidden="hidden" type="text" value="${boardVo.userid }" name="userid" id="userid"/>
		<input hidden="hidden" type="text" value="${boardVo.board_p_sq }" name="board_p_sq" id="board_p_sq"/>
		<input hidden="hidden" type="text" value="${boardVo.board_sq }" name="board_sq" id="board_sq"/>
		<input hidden="hidden" type="text" value="${boardVo.gubun_sq }" name="gubun_sq" id="gubun_sq"/>
		<input hidden="hidden" type="text" value="${boardVo.group_no }" name="group_no" id="group_no"/>
		<input hidden="hidden" type="text" value="${boardVo.board_yn }" name="board_yn" id="board_yn"/>
		
		<label class="control-label">첨부파일</label> 
		<c:forEach items="${atchFileList }" var="atchfile">
			<div class="filelist">
				<a href='${cp }/fileDownload?atch_sq=${atchfile.atch_sq }' class="fileinput" >${atchfile.atch_filename }</a>  
				<button type="button" data-atch_sq=${atchfile.atch_sq }>X</button>
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