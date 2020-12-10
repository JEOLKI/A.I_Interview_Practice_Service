<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<%@ include file="/WEB-INF/views/layout/commonLib.jsp" %>

<script type="text/javascript" language="javascript" defer="defer">
	
	$(document).ready(function() {
	
		$('#boardGubunRegistFrm').on('click', function() {
			if($('#boardGbNm').val()==''){
				var html = '<span style="color:red">**내용을 입력해주세요</span><br><br>';
				$('#check').empty();
				$('#check').append(html);
			}else{
				$('#boardGubunRegistFrm').submit();
			}
		})
		
		$('.categoryMngBtn').on('click', function(){
			boardGbSq= $(this).val();
			console.log(boardGbSq);
			document.location="/category/retrievePagingList.do?boardGbSq="+boardGbSq;
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
		var pageUnit = $('#sort').val()==null? 10 : $('#sort').val();
		document.listForm.pageIndex.value = pageNo;
		document.listForm.action = "<c:url value='/boardGubun/retrievePagingList.do?pageUnit="+pageUnit+"'/>";
	   	document.listForm.submit();
	}
	
	/* 검색 */
	function searchList(){
	document.listForm.action = "<c:url value='/boardGubun/retrievePagingList.do'/>";
		document.listForm.submit();
	}
	
</script>

</head>
<body>
	<form:form commandName="boardGubunVO" id="listForm" name="listForm" method="get">
		<div class="registdiv">
			<form id="boardGubunRegistFrm" action="${cp }/boardGubun/create.do" method="post">
				<label>게시판 이름 : </label>
				<input type="text" id="boardGbNm" name="boardGbNm" value="">
				<select id="boardGbSt" name="boardGbSt">
					<option value="Y" selected="selected">사용</option>
					<option value="N">미사용</option>
				</select> 
				<button type="button" id="boardGbRegBtn">등록</button>
			</form>
			<div id="check"></div>
		</div>
		
		<div class="blog-main">
	
			<div class="input-group boarding ">
	       		<ul  class = "button-search ">
	       			<li>
	       			    <label for="searchCondition" style="visibility:hidden;"><spring:message code="search.choose" /></label>
	       				<form:select class="col-sm-1" path="searchCondition" cssClass="use custom-select custom-select-sm form-control form-control-sm col-sm-1">
	       					<form:option value="0" label="제목" />
	       					<form:option value="1" label="작성자" />
	       				</form:select>
	       			<label for="searchKeyword" style="visibility:hidden;display:none;"><spring:message code="search.keyword" /></label>
	                       <form:input  path="searchKeyword" cssClass="txt form-control bg-light border-0 small col-sm-2"/>
	       	            <span class="btn btn-primary">
	       	                <a href="javascript:searchList();"><spring:message code="button.search" /></a>
	       	                <img src="<c:url value='/images/egovframework/example/btn_bg_r.gif'/>" style="margin-left:6px;" alt=""/>
	       	            </span>
	       	        </li>
	               </ul>
	       	</div>
	       	
			<a href="${cp }/boardGubun/list/excelDown.do">↓ 목록 내려받기</a> 
			<span id="massiveCreate">↑ 일괄등록</span>
			<!-- excel file 읽어오기 -->
		    <form id="massiveForm" name="massiveForm" enctype="multipart/form-data" method="post" action="<c:url value="${cp }/boardGubun/massiveCreateProcess.do"/>" >
		        <input type="file" name="excelFile" hidden/>
		    </form>
		    
		    
			<div class="table-responsive">
				<c:forEach items="${resultList }" var="boardGubun">
					<form class="talentUpdateFrm" action="${cp }/boardGubun/update.do" method="post">
						<input type="hidden" name="boardGbSq" value="${boardGubun.boardGbSq}">
						<input type="text" class="boardGbNm" name="boardGbNm" value="${boardGubun.boardGbNm}">
						<select class="boardGbSt" name="boardGbSt">
								<c:choose>
									<c:when test="${boardGubun.boardGbSt == 'Y' }">
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
						<button type="button" class="categoryMngBtn" value="${boardGubun.boardGbSq }">말머리 관리</button>
					</form>
				</c:forEach>
			</div>
		
			<div class = "paging">
			<br>
			<ul class="pagination boarding">
				<ui:pagination  paginationInfo = "${paginationInfo}" type="image" jsFunction="linkPage"></ui:pagination>
			</ul>
			<form:hidden path="pageIndex" />
			</div>
		</div>
	</form:form>
</body>
</html>