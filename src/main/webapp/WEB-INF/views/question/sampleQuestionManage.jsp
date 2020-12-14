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
	
	.sampQuestUpdateFrm {
		margin-top: 10px;
		margin-bottom: 10px;
	}
	
	#sampQuestRegistBtn{
		padding-left: 10px;
		padding-right: 10px;
		padding-top: 2px;
		padding-bottom: 2px;
	}
	
	.sampQuestContent{
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
	
	$('#sampQuestRegistBtn').on('click', function() {
		if($('#sampQuestContent').val()==''){
			var html = '<span style="color:red">**내용을 입력해주세요</span><br><br>';
			$('#check').empty();
			$('#check').append(html);
		}else{
			$('#sampQuestRegistFrm').submit();
		}
	})
	
		
	$('#massiveCreate').on('click',function(){
		$('input[type="file"]').click();
	})
	
	$('input[type="file"]').on('change',function(){
		$('#massiveForm').submit();
	})
	
	$('#sort').on('change',function(){
		pageUnit = $(this).val();
		document.location="/sampQuest/retrievePagingList.do?pageUnit="+pageUnit;
	})
	
		
})

/* pagination 페이지 링크 function */
function linkPage(pageNo){
	var pageUnit = $('#sort').val()==null? 10 : $('#sort').val();
	document.listForm.pageIndex.value = pageNo;
	document.listForm.action = "<c:url value='/sampQuest/retrievePagingList.do?pageUnit="+pageUnit+"'/>";
   	document.listForm.submit();
}

/* 검색 */
function searchList(){
document.listForm.action = "<c:url value='/sampQuest/retrievePagingList.do'/>";
	document.listForm.submit();
}
</script>
</head>
<body>
<!-- 헤더 -->
<form:form commandName="questionGubunVO" id="listForm" name="listForm" method="post">
	<div id="root">
		<div class="Main false">
<div class="w3-container managerbox">
			<div class="body" >
				<div class="content__title"><h1>샘플 질문 관리</h1></div>
				
				<div class="registSampleQuestion">
					<form id="sampQuestRegistFrm" action="${cp }/sampQuest/createProcess.do" method="post">
						<select id="questGbSq" name="questGbSq">
							<c:forEach items="${questGbList }" var="questGb">
								<option value="${questGb.questGbSq }">${questGb.questGbContent }</option>
							</c:forEach>
						</select>
						<input  type="text" id="sampQuestContent" name="sampQuestContent" value="${param.sampQuestContent }">
						<select id="sampQuestSt" name="sampQuestSt">
							<c:choose>
								<c:when test="${param.sampQuestSt == Y }">
									<option value="Y" selected="selected">사용</option>
									<option value="N">미사용</option>
								</c:when>
								<c:otherwise>
									<option value="Y">사용</option>
									<option value="N" selected="selected">미사용</option>
								</c:otherwise>
							</c:choose>
						</select>
						<button type="button" id="sampQuestRegistBtn">등록</button>
				</form>
				<div id="check"></div>
			</div>
				
		<hr>
		
			<div class="menu">
				<select id="sort">
					<c:forEach var="value" begin="5" end="20" step="5">
						<c:choose>
							<c:when test="${pageUnit == value  }">
								<option value="${value }" selected="selected" >${value }개씩</option>
							</c:when>
							<c:otherwise>
								<option value="${value }" >${value }개씩</option>
							</c:otherwise>
						</c:choose>
					</c:forEach>
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
				<a href="${cp }/sampQuest/list/excelDown.do">↓ 목록 내려받기</a> 
				<span id="massiveCreate">↑ 일괄등록</span>
				<!-- excel file 읽어오기 -->
			    <form id="massiveForm" name="massiveForm" enctype="multipart/form-data" method="post" action="<c:url value="${cp }/sampQuest/massiveCreateProcess.do"/>" >
			        <input type="file" name="excelFile" hidden/>
			    </form>
	    	</div>
		
		
		
		
				<div class="existSampQuest" id="sampQuestList">
					<c:forEach items="${resultList }" var="sampQuest">
						<form class="sampQuestUpdateFrm" action="${cp }/sampQuest/updateProcess.do" method="post">
								<select class="questGbSq" name="questGbSq">
									<c:forEach items="${questGbList }" var="questGb">
										<c:choose>
											<c:when test="${sampQuest.questGbSq == questGb.questGbSq }">
												<option value="${questGb.questGbSq }" selected="selected">${questGb.questGbContent }</option>
											</c:when>
											<c:otherwise>
												<option value="${questGb.questGbSq }">${questGb.questGbContent }</option>
											</c:otherwise>
										</c:choose>
									</c:forEach>
								</select>
								<input type="hidden" name="sampQuestSq" value="${sampQuest.sampQuestSq}">
								<input type="text" class="sampQuestContent" name="sampQuestContent" value="<c:out value="${sampQuest.sampQuestContent}"/>">
								<select class="sampQuestSt" name="sampQuestSt">
									<c:choose>
										<c:when test="${sampQuest.sampQuestSt == 'Y' }">
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
					<ul class="pagination boarding">
						<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="linkPage" />
						<form:hidden path="pageIndex" />
					</ul>
				</div>
			</div>
			</div>
		</div>
	</div>	
</form:form>
			
</body>
</html>