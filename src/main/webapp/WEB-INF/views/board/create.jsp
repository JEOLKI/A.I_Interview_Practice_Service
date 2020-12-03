<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<link href="/css/sb-admin-2.min.css" rel="stylesheet">

<%@ include file="/WEB-INF/views/layout/commonLib.jsp" %>

<script>
	$(document).ready(function(){

		$('#summernote').summernote({
				 height: 600,
				 width : 1000
		});

		$('#boardRegBtn').on('click', function(){
			
			$("#boardRegFrm").submit();
			
		});

		$("#atchBtn").on('click', function(){

			if($(".fileinput").length < 5){
				
				var input = '<input class="fileinput" type="file" name="file"/><br>';
				$('#filediv').append(input)

			}
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
	
	<form id="boardRegFrm" action="${pageContext.request.contextPath }/board/create.do" method="POST" enctype="multipart/form-data">
	말머리 : 
	<select name="catContent">
		<c:forEach items="${categoryList }" var="category">
			<option value="${category.catContent }">${category.catContent }</option>
		</c:forEach>
	</select>
	
		<input class="form-control" type="text" placeholder="글제목" id="board_title" name="boardTitle"><br>
		<textarea id="summernote" name="boardContent"></textarea>
		<input hidden="hidden" type="text" value="${S_MEMBER.memId }" name="memId" id="memId"/>
		<input hidden="hidden" type="text" value="${parentSq }" name="parentSq" id="parentSq"/>
		<input hidden="hidden" type="text" value="${boardGbSq }" name="boardGbSq" id="boardGbSq"/>
		<input hidden="hidden" type="text" value="${groupNo }" name="groupNo" id="groupNo"/>
		<div id="filediv">
			<button id="atchBtn" type="button">첨부파일추가</button><br>
		</div>
		<input id="boardRegBtn" type="button" value="저장">
	</form>
	
</body>
</html>