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

// 						$('#massiveCreate').on('click', function() {
// 							$('input[type="file"]').click();
// 						});

						$('input[type="file"]').on('change', function() {
							$('#massiveForm').submit();
						});

// 						$('#sort').on('change',function() {
// 											pageUnit = $(this).val();
// 											document.location = "/scriptGubun/retrievePagingList.do?pageUnit="+ pageUnit;
// 						});

						/* pagination 페이지 링크 function */
// 						function linkPage(pageNo) {
// 							var pageUnit = $('#sort').val() == null ? 10 : $('#sort').val();
// 							document.listForm.pageIndex.value = pageNo;
// 							document.listForm.action = "<c:url value='/scriptGubun/retrievePagingList.do?pageUnit="+ pageUnit + "'/>";
// 							document.listForm.submit();
// 						}

						/* 검색 */
// 						function searchList() {
// 							document.listForm.action = "<c:url value='/scriptGubun/retrievePagingList.do'/>";
// 							document.listForm.submit();
// 						}

						$.ajax({
									url : "/scriptGubun/list.do",
									method : "get",
									dataType : "json",
									success : function(data) {
										console.log(data)
										var html = "";
										for (var i = 0; i < data.scriptGbList.length; i++) {
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
					<form id="regForm" action="/scriptGubun/createProcess.do"
						method="post">
						<label>스크립트 언어 : </label> <input type="text"
							name="scriptGbContent"> <select id="scriptGbSt"
							name="scriptGbSt">
							<option value="Y" selected="selected">사용</option>
							<option value="N">미사용</option>
						</select> <input id="regBtn" type="button" value="등록">
					</form>
				</div>
				<hr>
				<div class="menu">
<!-- 					<select id="sort"> -->
<%-- 						<c:forEach var="value" begin="5" end="20" step="5"> --%>
<%-- 							<c:choose> --%>
<%-- 								<c:when test="${pageUnit == value  }"> --%>
<%-- 									<option value="${value }" selected="selected">${value }개씩</option> --%>
<%-- 								</c:when> --%>
<%-- 								<c:otherwise> --%>
<%-- 									<option value="${value }">${value }개씩</option> --%>
<%-- 								</c:otherwise> --%>
<%-- 							</c:choose> --%>
<%-- 						</c:forEach> --%>
<%--  					</select>--%>
					<input id="keyword" type="text"> 
					<button type="button">검색</button>

					<div id="search">
<!-- 						<ul> -->
<!-- 							<label for="searchKeyword" style="visibility: hidden; display: none;"> -->
<%-- 							<spring:message code="search.keyword" /></label> --%>
<%-- 							<form:input path="searchKeyword" cssClass="txt" /> --%>
<!-- 							<span class="btn_blue_l"> -->
<%-- 							<a href="javascript:searchList();"> <spring:message code="button.search" /> </a> --%>
<%-- 							<img src="<c:url value='/images/egovframework/example/btn_bg_r.gif'/>" alt="" /> --%>
<!-- 							</span> -->
<!-- 						</ul> -->
					</div>

					<a href="/scriptGubun/list/excelDown.do">↓목록 내려받기</a>

				</div>

				<div class="existScript" id="scriptGbList">


					<hr>

				</div>
<!-- 				<span id="massiveCreate">↑ 일괄등록</span> -->
				<!-- excel file 읽어오기 -->
<!-- 				<form id="massiveForm" name="massiveForm" -->
<!-- 					enctype="multipart/form-data" method="post" -->
<%-- 					action="<c:url value="/scriptGubun/massiveCreateProcess.do"/>"> --%>
<!-- 					<input type="file" name="excelFile" hidden /> -->
<!-- 				</form> -->

<!-- 				<div id="paging"> -->
<!-- 					<ul class="pagination boarding"> -->
<%-- 						<ui:pagination paginationInfo="${paginationInfo}" type="image" --%>
<%-- 							jsFunction="linkPage" /> --%>
<%-- 						<form:hidden path="pageIndex" /> --%>
<!-- 					</ul> -->
<!-- 				</div> -->


			</div>
		</div>
	</div>
</body>
</html>