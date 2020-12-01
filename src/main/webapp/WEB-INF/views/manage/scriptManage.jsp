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

<script>

function itemChange(){
	var scriptGbList = "${scriptGbList}";
	var selectItem = $("#scriptGbSelect").val();
	
	var changeItem;
	
	if()
}

	$(document).ready(function() {
		$("#regBtn").on("click", function() {
			$("#regForm").submit();
		});
		

		$.ajax({url : "/script/list.do",
			method : "get",
			dataType : "json",
			success : function(data){
				var html="";
					for (var i = 0; i < data.scriptList.length; i++) {
						html += '<form class="updForm" action="/script/updateProcess.do" method="post" enctype="utf-8">';
						html += '	<input type="hidden" name="scriptSq" value="'+data.scriptList[i].scriptSq+'">';
						html += '	<label>스크립트  : </label><input type="text" name="scriptContent" value="'+data.scriptList[i].scriptContent+'">';
						html += '	<select id="sctiptGbSelect" class="scriptGbSq" name="scriptGbSq" onchange="itemChange()">';
						for(var j=0; j<data.scriptGbList.length; j++){
							if(data.scriptList[i].scriptGbSq == data.scriptGbList[j].scriptGbSq){
								html += '		<option value="'+data.scriptList[i].scriptGbSq+'" selected="selected">';
								html += data.scriptGbList[j].scriptGbContent;
								html += '</option>';
								html += '<option value="'+data.scriptGbList[j].scriptGbSq+'">';
								html += data.scriptGbList[j].scriptGbContent;
								html += '</option>';
							}else{
								html += '<option value="'+data.scriptGbList[j].scriptGbSq+'">';
								html += data.scriptGbList[j].scriptGbContent;
								html += '</option>';
							}
						}
						html +='</select>';
						html += '<select class="scriptSt" name="scriptSt">';
						if (data.scriptList[i].scriptSt == "Y") {
							html += '<option value="Y" selected="selected">사용</option>';
							html += '<option value="N">미사용</option>';
						} else {
							html += '<option value="Y">사용</option>';
							html += '<option value="N" selected="selected">미사용</option>';
						}
						html += '</select>';
						html += '<button class="updBtn" type="submit">수정</button>';
						html += '</form>';
				}
				$('#scripList').append(html);
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
				<div class="content__title">스크립트 관리</div>
			</div>
			</section>
			<div class="body">
				<div class="registScript">
				<form id="regForm" action="/script/createProcess.do" method="post" enctype="utf-8">
					<label>스크립트 : </label> <input type="text" name="scriptContent">
					<select id="scriptGbSq" name="scriptGbSq">
						<c:forEach items="${scriptGbList }" var="scriptGb">
							<option value="${scriptGb.scriptGbSq }">${scriptGb.scriptGbContent }</option>
						</c:forEach>
					</select>
					<select id="status" name="scriptSt">
						<option value="Y" selected>활성화</option>
						<option value="N">비활성화</option>
					</select> <input id="regBtn" type="button" value="등록">
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
				<div class="existScript" id="scripList">
				
					<%-- 		<c:forEach items="${categoryList }" var="category"> --%>
					<!-- 			<label></label> -->
					<%-- 			<input type="text" value="${category.말머리 내용 }"> --%>
					<!-- 			<input type="button" value="수정">  -->
					<!-- 			<input type="button" value="삭제"> 				 -->
					<%-- 		</c:forEach> --%>
				
				</div>
				<a href="#">↑ 일괄등록</a>
			</div>
		</div>
	</div>
</body>
</html>