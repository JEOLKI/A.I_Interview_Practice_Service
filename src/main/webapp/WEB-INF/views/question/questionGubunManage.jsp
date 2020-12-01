<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%@ include file="/WEB-INF/views/layout/commonLib.jsp" %>
<script>
	$(document).ready(function(){
		
		$('#questGbRegistBtn').on('click', function() {
			$('#questGbRegistFrm').submit();
		})

		
		$.ajax({url : "/questGb/list.do",
			method : "get",
			dataType : "json",
			success : function(data){
				console.log(data);
				var html="";
				for(var i=0; i<data.questGbList.length; i++){
					html += '<form class="questGbUpdateFrm" action="${cp }/questGb/updateProcess.do" method="post">';
					html += '<input type="hidden" name="questGbSq" value="'+data.questGbList[i].questGbSq+'">';
					html += '<input type="text" name="questGbContent" value="'+data.questGbList[i].questGbContent+'">';
					html += '<select class="questGbSt" name="questGbSt">';
					if (data.questGbList[i].questGbSt == "Y") {
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
				$('#questGbList').append(html);
			}
			})
		
	
			
		$('#massiveCreate').on('click',function(){
			$('input[type="file"]').click();
		})
		
		$('input[type="file"]').on('change',function(){
			$('#massiveForm').submit();
		})
		
		$('#searchBtn').on('click', function(){
			var keyword = $('#keyword').val();
			$.ajax({url : "/questGb/searchlist.do",
				method : "get",
				data : {"keyword" : keyword},
				dataType : "json",
				success : function(data){
					var html="";
					for(var i=0; i<data.questGbSearchList.length; i++){
// 						html += '<form class="questGbUpdateFrm" action="${cp }/questGb/updateProcess.do" method="post">';
// 						html += '<input type="hidden" name="questGbSq" value="'+data.questGbSearchList[i].questGbSq+'">';
// 						html += '<label id="rownum"><c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * searchVO.pageSize + status.count)}"/></label>';
// 						html += '<input type="text" name="questGbContent" value="<c:out value="${result.questGbContent}"/>">';
// 						html += '<select class="questGbSt" name="questGbSt">';
// 						if (<c:out value="${result.questGbContent}"/> == "Y") {
// 							html += '<option value="Y" selected="selected">사용</option>';
// 							html += '<option value="N">미사용</option>';
// 						} else {
// 							html += '<option value="Y">사용</option>';
// 							html += '<option value="N" selected="selected">미사용</option>';
// 						}
// 						html += '</select>';
// 						html += '<button class="updateBtn" type="submit">수정</button>';
// 						html += '</form>';
					}
					$('#questGbList').empty();
					$('#questGbList').append(html);
				}
			})
		})
			
	})
	
// 	 /* pagination 페이지 링크 function */
//         function fn_egov_link_page(pageNo){
//         	document.listForm.pageIndex.value = pageNo;
//         	document.listForm.action = "<c:url value='/questGb/retrievePagingList.do'/>";
//            	document.listForm.submit();
//         }
	
</script>
</head>
<body>
<!-- 헤더 -->
	<div id="root">
		<div class="Main false">
			<%@ include file="/WEB-INF/views/layout/header.jsp"%>
			<section class="hero">
			<div class="hero__content">
				<div class="content__title">질문 구분 관리</div>
			</div>
			</section>
			<div class="body">
			<form:form commandName="questionGubunVO" id="listForm" name="listForm" method="post">
			<div class="registQuestionGubun">
				<form id="questGbRegistFrm" action="${cp }/questGb/createProcess.do" method="post">
					<input  type="text" id="questGbContent" name="questGbContent" value="${param.questGb }">
					<select id="questGbSt" name="questGbSt">
						<c:choose>
							<c:when test="${param.questGbSt == Y }">
								<option value="Y" selected="selected">사용</option>
								<option value="N">미사용</option>
							</c:when>
							<c:otherwise>
								<option value="Y">사용</option>
								<option value="N" selected="selected">미사용</option>
							</c:otherwise>
						</c:choose>
					</select>
					<input type="button" id="questGbRegistBtn" value="등록">
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
				<button type="button" id="searchBtn">검색</button>
		    	
		    	<a href="${cp }/questGb/list/excelDown.do">↓ 목록 내려받기</a> 
				<span id="massiveCreate">↑ 일괄등록</span>
				<!-- excel file 읽어오기 -->
			    <form id="massiveForm" name="massiveForm" enctype="multipart/form-data" method="post" action="<c:url value="${cp }/questGb/massiveCreateProcess.do"/>" >
			        <input type="file" name="excelFile" hidden/>
			    </form>
			</div>				
			
			<!-- 
					html += '<select class="questGbSt" name="questGbSt">';
						if (<c:out value="${result.questGbContent}"/> == "Y") {
							html += '<option value="Y" selected="selected">사용</option>';
							html += '<option value="N">미사용</option>';
						} else {
							html += '<option value="Y">사용</option>';
							html += '<option value="N" selected="selected">미사용</option>';
						}
						html += '</select>';
						html += '<button class="updateBtn" type="submit">수정</button>';
						html += '</form>';
			 -->
			<div class="existQuestGb" id="questGbList">
				<c:forEach var="result" items="${resultList}">
<%--             				<label id="rownum"><c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * searchVO.pageSize + status.count)}"/></label> --%>
            				<input type="text" name="questGbContent" value="<c:out value="${result.questGbContent}"/>">
            				<select class="questGbSt" name="questGbSt">
            				<c:choose>
            					<c:when test="<c:out value='${result.questGbSt}'/> == 'Y' ">
            						<option value="Y" selected="selected">사용</option>
            						<option value="N">미사용</option>
            					</c:when>
            					<c:otherwise>
            						<option value="Y">사용</option>
            						<option value="N" selected="selected">미사용</option>
            					</c:otherwise>
            				</c:choose>
            				<button class="updateBtn" type="submit">수정</button>
            				</select>
        			</c:forEach>
			</div>
			
<!-- 			<div id="paging"> -->
<%-- 				<c:if test="${not empty paginationInfo}">  --%>
<%-- 					<ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="linkPage"/>  --%>
<%-- 				</c:if> --%>
<%--         		<form:hidden path="pageIndex" /> --%>
<!--         	</div> -->
			
			</form:form>
		</div>
	</div>
</div>

	
</body>
</html>