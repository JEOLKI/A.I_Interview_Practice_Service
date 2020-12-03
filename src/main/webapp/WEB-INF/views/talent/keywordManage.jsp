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
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<%@ include file="/WEB-INF/views/layout/commonLib.jsp" %>
<style type="text/css">
	#search{
		display: inline-block; 
	}
	
	.menu{
		margin-bottom: 20px;
	}
	.body{
		margin : 30px;
	}
	#massiveCreate{
		margin-left: 20px;
	}
	
	.updateBtn{
		padding-left: 10px;
		padding-right: 10px;
		padding-top: 2px;
		padding-bottom: 2px;
	}
	
	.keywordUpdateFrm {
		margin-top: 10px;
		margin-bottom: 10px;
	}
	
	#keywordRegistBtn{
		padding-left: 10px;
		padding-right: 10px;
		padding-top: 2px;
		padding-bottom: 2px;
	}
	
	.keywordContent{
		width: 400px;
		margin-bottom: 10px;
	}
	
	.content__title{
		margin-bottom: 30px;
	}
	h1{
		font-weight:bold;
	}
	#check{
		display: inline-block; 
		height: 20px;
	}
</style>
<script type="text/javaScript" language="javascript" defer="defer">
$(document).ready(function(){
	
	$('#keywordRegistBtn').on('click', function() {
		if($('#keywordContent').val()==''){
			var html = '<span style="color:red">**내용을 입력해주세요</span><br><br>';
			$('#check').empty();
			$('#check').append(html);
		}else{
			$('#keywordRegistFrm').submit();
		}
	})
	
		
	$('#massiveCreate').on('click',function(){
		$('input[type="file"]').click();
	})
	
	$('input[type="file"]').on('change',function(){
		$('#massiveForm').submit();
	})
	
		
})

/* pagination 페이지 링크 function */
function linkPage(pageNo){
	document.listForm.pageIndex.value = pageNo;
	document.listForm.action = "<c:url value='/keyword/retrievePagingList.do'/>";
   	document.listForm.submit();
}

/* 검색 */
function searchList(){
document.listForm.action = "<c:url value='/keyword/retrievePagingList.do'/>";
	document.listForm.submit();
}
</script>
</head>
<body>
<!-- 헤더 -->
<form:form commandName="keywordVO" id="listForm" name="listForm" method="post">
	<div id="root">
		<div class="Main false">
			<%@ include file="/WEB-INF/views/layout/header.jsp"%>
			<%@ include file="/WEB-INF/views/manage/managerleft.jsp" %> 
<div class="w3-container" style="margin-left: 200px">
			<div class="body" >
				<div class="content__title"><h1>키워드 관리</h1></div>
				
				<div class="registKeyword">
					<form id="keywordRegistFrm" action="${cp }/keyword/createProcess.do" method="post">
						<select id="talentdSq" name="talentSq">
							<c:forEach items="${talentList }" var="talent">
								<option value="${talent.talentSq }">${talent.talentNm }</option>
							</c:forEach>
						</select>
						<input  type="text" id="keywordContent" name="keywordContent" value="${param.keywordContent }">
						<select id="keywordSt" name="keywordSt">
							<c:choose>
								<c:when test="${param.keywordSt == Y }">
									<option value="Y" selected="selected">사용</option>
									<option value="N">미사용</option>
								</c:when>
								<c:otherwise>
									<option value="Y">사용</option>
									<option value="N" selected="selected">미사용</option>
								</c:otherwise>
							</c:choose>
						</select>
						<button type="button" id="keywordRegistBtn">등록</button>
				</form>
				<div id="check"></div>
			</div>
				
		<hr>
		
			<div class="menu">
				<select id="sort">
					<option value="">정렬</option>
					<option value="">5개씩</option>
					<option value="">10개씩</option>
					<option value="">15개씩</option>
					<option value="">20개씩</option>
				</select> 
			<div id="search">
				<ul>
        			<label for="searchKeyword" style="visibility:hidden;display:none;"><spring:message code="search.keyword" /></label>
                        <form:input path="searchKeyword" cssClass="txt"/>
                    
        	            <span class="btn_blue_l">
        	                <a href="javascript:searchList();"><spring:message code="button.search" /></a>
        	                <img src="<c:url value='/images/egovframework/example/btn_bg_r.gif'/>"  alt=""/>
        	            </span>
                </ul>
			</div>
				<a href="${cp }/keyword/list/excelDown.do">↓ 목록 내려받기</a> 
				<span id="massiveCreate">↑ 일괄등록</span>
				<!-- excel file 읽어오기 -->
			    <form id="massiveForm" name="massiveForm" enctype="multipart/form-data" method="post" action="<c:url value="${cp }/keyword/massiveCreateProcess.do"/>" >
			        <input type="file" name="excelFile" hidden/>
			    </form>
	    	</div>
		
				<div class="existKeyword" id="keywordList">
					<c:forEach items="${resultList }" var="keyword">
						<form class="keywordUpdateFrm" action="${cp }/keyword/updateProcess.do" method="post">
								<select class="talentSq" name="talentSq">
									<c:forEach items="${talentList }" var="talent">
										<c:choose>
											<c:when test="${talent.talentSq == talent.talentSq }">
												<option value="${talent.talentSq }" selected="selected">${talent.talentNm }</option>
											</c:when>
											<c:otherwise>
												<option value="${talent.talentSq }">${talent.talentNm }</option>
											</c:otherwise>
										</c:choose>
									</c:forEach>
								</select>
								<input type="hidden" name="keywordSq" value="${keyword.skeywordSq}">
								<input type="text" class="keywordContent" name="keywordContent" value="<c:out value="${keyword.keywordContent}"/>">
								<select class="keywordSt" name="keywordSt">
									<c:choose>
										<c:when test="${keyword.keywordSt == 'Y' }">
											<option value="Y" selected="selected">사용</option>
											<option value="N">미사용</option>
										</c:when>
										<c:otherwise>
											<option value="Y">사용</option>
											<option value="N" selected="selected">미사용</option>
										</c:otherwise>
									</c:choose>
								</select>
								<button type="submit" class="updateBtn">수정</button>
						</form>
					</c:forEach>
				</div>
				<div id="paging">
					<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="linkPage" />
					<form:hidden path="pageIndex" />
				</div>
			</div>
			</div>
		</div>
	</div>	
</form:form>
			
</body>
</html>