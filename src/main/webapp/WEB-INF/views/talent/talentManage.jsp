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
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">

<%@ include file="/WEB-INF/views/layout/commonLib.jsp" %>
 <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<title>Insert title here</title>
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
	
	.updateBtn, .keywordMngBtn, #talentRegistBtn{
		padding-left: 10px;
		padding-right: 10px;
		padding-top: 2px;
		padding-bottom: 2px;
	}
	
	.talentUpdateFrm {
		margin-top: 10px;
		margin-bottom: 10px;
	}
	
	
	.talentNm{
		width: 400px;
		padding-left: 10px;
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

<script type="text/javascript" language="javascript" defer="defer">
	$(document).ready(function() {

	
	$('#talentRegistBtn').on('click', function() {
		if($('#talentNm').val()==''){
			var html = '<span style="color:red">**내용을 입력해주세요</span><br><br>';
			$('#check').empty();
			$('#check').append(html);
		}else{
			$('#talentRegistFrm').submit();
		}
	})
	
	$('.keywordMngBtn').on('click', function(){
		talentSq= $(this).val();
		console.log(talentSq);
		document.location="/talent/keywordManage.do?talentSq="+talentSq;
	})

		
		$('#massiveCreate').on('click',function(){
			$('input[type="file"]').click();
		})
		
		$('input[type="file"]').on('change',function(){
			$('#massiveForm').submit();
		})
		
		$('#sort').on('change',function(){
		pageUnit = $(this).val();
		document.location="/talent/retrievePagingList.do?pageUnit="+pageUnit;
	})
		
	})
	
	/* pagination 페이지 링크 function */
	function linkPage(pageNo){
		var pageUnit = $('#sort').val()==null? 10 : $('#sort').val();
		document.listForm.pageIndex.value = pageNo;
		document.listForm.action = "<c:url value='/talent/retrievePagingList.do?pageUnit="+pageUnit+"'/>";
	   	document.listForm.submit();
	}
	
	/* 검색 */
	function searchList(){
	document.listForm.action = "<c:url value='/talent/retrievePagingList.do'/>";
		document.listForm.submit();
	}
</script>
</head>
<body>
<form:form commandName="talentVO" id="listForm" name="listForm" method="post">
	<!-- 헤더 -->
	<div id="root">
		<div class="Main false">
			<%@ include file="/WEB-INF/views/layout/header.jsp"%>
			<%@ include file="/WEB-INF/views/manage/managerleft.jsp" %> 
			<div class="w3-container managerbox" style="margin-left: 200px">
			<div class="body">
				<div class="content__title"><h1>인재상 관리</h1></div>

				<div class="registTalent">
					<form id="talentRegistFrm" action="${cp }/talent/createProcess.do" method="post">
						<input type="text" id="talentNm" name="talentNm" value="${param.talentNm }">
						<select id="talentSt" name="talentSt">
							<c:choose>
								<c:when test="${param.talentSt == Y }">
									<option value="Y" selected="selected">사용</option>
									<option value="N">미사용</option>
								</c:when>
								<c:otherwise>
									<option value="Y">사용</option>
									<option value="N" selected="selected">미사용</option>
								</c:otherwise>
							</c:choose>
						</select> 
						<button type="button" id="talentRegistBtn">등록</button>
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
		        	                <img src="<c:url value='/images/egovframework/example/btn_bg_r.gif'/>" alt=""/>
		        	            </span>
		                </ul>
					</div>

					<a href="${cp }/talent/list/excelDown.do">↓ 목록 내려받기</a> 
					<span id="massiveCreate">↑ 일괄등록</span>
					<!-- excel file 읽어오기 -->
				    <form hidden id="massiveForm" name="massiveForm" enctype="multipart/form-data" method="post" action="<c:url value="${cp }/talent/massiveCreateProcess.do"/>" >
				        <input hidden type="file" name="excelFile" />
				    </form>
				</div>
				<div class="existTalent" id="talentList">
					<c:forEach items="${resultList }" var="talent">
						<form class="talentUpdateFrm" action="${cp }/talent/updateProcess.do" method="post">
							<input type="hidden" name="talentSq" value="${talent.talentSq}">
							<input type="text" class="talentNm" name="talentNm" value="${talent.talentNm}">
							<select class="talentSt" name="talentSt">
									<c:choose>
										<c:when test="${talent.talentSt == 'Y' }">
											<option value="Y" selected="selected">사용</option>
											<option value="N">미사용</option>
										</c:when>
										<c:otherwise>
											<option value="Y">사용</option>
											<option value="N" selected="selected">미사용</option>
										</c:otherwise>
									</c:choose>
								</select>
								<button type="submit" class="updateBtn" >수정</button>
							<button type="button" class="keywordMngBtn" value="${talent.talentSq }">키워드 관리</button>	
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