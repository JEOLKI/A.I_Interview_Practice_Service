<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/WEB-INF/views/layout/commonLib.jsp"%>
<title>Insert title here</title>
<script type="text/javascript" language="javascript" defer="defer">
	$(document).ready(function() {

	
	$('#habitRegistBtn').on('click', function() {
		$('#habitRegistFrm').submit();
	})

	$.ajax({url : "/habit/list.do",
			method : "get",
			dataType : "json",
			success : function(data) {
				console.log(data);
				var html = "";
				for (var i = 0; i < data.habitList.length; i++) {
					html += '<form class="habitUpdateFrm" action="${cp }/habit/updateProcess.do" method="post">';
					html += '<input type="hidden" name="habitSq" value="'+data.habitList[i].habitSq+'">';
					html += '<input type="text" name="habitGb" value="'+data.habitList[i].habitGb+'">';
					html += '<select class="habitSt" name="habitSt">';
					if (data.habitList[i].habitSt == "Y") {
						html += '<option value="Y" selected="selected">사용</option>';
						html += '<option value="N">미사용</option>';
					} else {
						html += '<option value="Y">사용</option>';
						html += '<option value="N" selected="selected">미사용</option>';
					}
					html += '</select>';
					html += '<button class="updateBtn" type="submit">수정</button>';
					html += '</form>';
				}
				$('#habitList').append(html);
			}
		})
		
		$('#massiveCreate').on('click',function(){
			$('input[type="file"]').click();
		})
		
		$('input[type="file"]').on('change',function(){
			$('#massiveForm').submit();
		})
	})
</script>
</head>
<body>
	<!-- 헤더 -->
	<div id="root">
		<div class="Main false">
			<%@ include file="/WEB-INF/views/layout/header.jsp"%>
			<section class="hero">
			<div class="hero__content">
				<div class="content__title">습관어 관리</div>
			</div>
			</section>
			<div class="body">

				<div class="registScriptgubun">
					<form id="habitRegistFrm" action="${cp }/habit/createProcess.do"
						method="post">
						<input type="text" id="habitGb" name="habitGb"
							value="${param.habitGb }"> <select id="habitSt"
							name="habitSt">
							<c:choose>
								<c:when test="${param.habitSt == Y }">
									<option value="Y" selected="selected">사용</option>
									<option value="N">미사용</option>
								</c:when>
								<c:otherwise>
									<option value="Y">사용</option>
									<option value="N" selected="selected">미사용</option>
								</c:otherwise>
							</c:choose>
						</select> <input type="button" id="habitRegistBtn" value="등록">
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


					<a href="${cp }/habit/list/excelDown.do">↓ 목록 내려받기</a> 
					<span id="massiveCreate">↑ 일괄등록</span>
					<!-- excel file 읽어오기 -->
					<form id="massiveForm" name="massiveForm"
						enctype="multipart/form-data" method="post"
						action="<c:url value="${cp }/habit/massiveCreateProcess.do"/>">
						<input type="file" name="excelFile" hidden/> 
					</form>	
				</div>
				<div class="existHabit" id="habitList"></div>
			</div>
		</div>
	</div>

</body>
</html>