<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

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
				
				var input = '<input class="fileinput" type="file" name="file"/>';
				$('#filediv').append(input)

			}
		})
	});
</script>

</head>
<body>
	
	<form id="boardRegFrm" action="${pageContext.request.contextPath }/board/create.do" method="POST" enctype="multipart/form-data">
		<input class="form-control" type="text" placeholder="글제목" id="board_title" name="boardTitle"><br>
		<textarea id="summernote" name="boardContent"></textarea>
		<input hidden="hidden" type="text" value="${memId }" name="memId" id="memId"/>
		<input hidden="hidden" type="text" value="${parentSq }" name="parentSq" id="parentSq"/>
		<input hidden="hidden" type="text" value="${boardGbSq }" name="boardGbSq" id="boardGbSq"/>
		<input hidden="hidden" type="text" value="${groupNo }" name="groupNo" id="groupNo"/>
		<div id="filediv">
			<button id="atchBtn" type="button">첨부파일추가</button>
		</div>
		<input id="boardRegBtn" type="button" value="저장">
	</form>
	
</body>
</html>