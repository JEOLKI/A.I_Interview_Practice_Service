<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
table {
	border-collapse: collapse;
}

a {
	text-decoration: none;
}
</style>
<%@ include file="/WEB-INF/views/layout/commonLib.jsp"%>

<script type="text/javascript" language="javascript" defer="defer">
 $(document).ready(function() {
	
	$("#regBtn").on("click", function() {
		$("#regForm").submit();
	});

	$.ajax({url : "/scriptGubun/list.do",
		method : "get",
		dataType : "json",
		success : function(data){
			console.log(data)
			var html="";
			for(var i=0; i<data.scriptGbList.length; i++){
				html += '<form class="scriptGbUpdForm" action="/scriptGubun/updateProcess.do" method="post">';
				html += '	<input type="hidden" name="scriptGbSq" value="'+data.scriptGbList[i].scriptGbSq+'">';
				html += '	<label>스크립트 언어  : </label><input type="text" name="scriptGbContent" value="'+data.scriptGbList[i].scriptGbContent+'">';
				html += '	<select class="scriptGbSt" name="scriptGbSt">';
				if (data.scriptGbList[i].scriptGbSt == "Y") {
					html += '<option value="Y" selected="selected">사용</option>';
					html += '<option value="N">미사용</option>';
				} else {
					html += '<option value="Y">사용</option>';
					html += '<option value="N" selected="selected">미사용</option>';
				}
				html += '</select>';
				html += '<button class="scriptGbupdBtn" type="submit">수정</button>';
				html += '</form>';
			}
		$('#scriptGbList').append(html);
		}
	});
});
</script>
</head>
<body>

	<!-- 헤더 -->
	<div id="root">
		<div class="Main false">
			<%@ include file="/WEB-INF/views/layout/header.jsp"%>
			<section class="hero">
			<div class="hero__content">
				<div class="content__title">스크립트 언어 관리</div>
			</div>
			</section>
			<div class="body">
				<div class="registScriptgubun">
					<form id="regForm" action="/scriptGubun/createProcess.do" method="post">
						<label>스크립트 언어 : </label> <input type="text" name="scriptGbContent">
						<select id="scriptGbSt" name="scriptGbSt">
							<option value="Y" selected="selected">사용</option>
							<option value="N">미사용</option>
						</select>
					<input id="regBtn" type="button" value="등록">
					</form>
				</div>
				<hr>
				<div class="menu">
					<select id="sort">
						<option value="">정렬</option>
						<option value="">5개씩</option>
						<option value="">10개씩</option>
						<option value="">15개씩</option>
						<option value="">20개씩</option>
					</select> <input id="keyword" type="text">
					<button type="button">검색</button>

					<a href="#">↓목록 내려받기</a>

				</div>

				<div class="existScript" id="scriptGbList">
				
					<%-- 		<c:forEach items="${categoryList }" var="category"> --%>
					<!-- 			<label></label> -->
					<%-- 			<input type="text" value="${category.말머리 내용 }"> --%>
					<!-- 			<input type="button" value="수정">  -->
					<!-- 			<input type="button" value="삭제"> 				 -->
					<%-- 		</c:forEach> --%>

			
				<hr>
				
				</div>
				<a href="#">↑ 일괄등록</a>
			</div>
		</div>
	</div>
</body>
</html>