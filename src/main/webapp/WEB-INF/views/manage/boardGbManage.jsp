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
	
		$('#boardGbRegBtn').on('click', function() {
			$('#check').empty();
			if($('#boardGbNm').val()==''){
				var html = '내용을 입력해주세요';
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
    	document.listForm.pageIndex.value = pageNo;
    	document.listForm.action = "<c:url value='/boardGubun/retrievePagingList.do'/>";
       	document.listForm.submit();
    }
	 
	/* 검색 */
	function searchList(){
		document.listForm.action = "<c:url value='/boardGubun/retrievePagingList.do'/>";
       	document.listForm.submit();
	}
	
</script>

<style type="text/css">
	.registdiv{
	}
	
	#boardGbNm{
		width: 50%;
	}
	
</style>


</head>
<body>

	<h1>게시판 관리</h1>
	<h3>게시판 등록</h3>
	
	<div class="registdiv">
		<form id="boardGubunRegistFrm" action="${cp }/boardGubun/create.do" method="post">
			<label>게시판 이름 : </label>
			<input type="text" id="boardGbNm" name="boardGbNm" value="">
			<select id="boardGbSt" name="boardGbSt">
				<option value="Y" selected="selected">사용</option>
				<option value="N">미사용</option>
			</select>
			<a id="boardGbRegBtn">등록</a>
			<span style="color:red" id="check"></span>
		</form>
	</div>
	<br>
	<hr>
	<br>
	<h3>게시판 목록</h3>
	<form:form commandName="boardGubunVO" id="listForm" name="listForm" method="get">
		<div class="blog-main">
			<div class="input-group">
	       		<ul class="button-search" id="uitest">
        			<li>
        				<form:select class="col-sm-1" path="searchCondition" cssClass="use custom-select custom-select-sm form-control form-control-sm col-sm-1">
        					<form:option value="0" label="내용" />
        				</form:select>
                        <form:input  path="searchKeyword" cssClass="txt form-control bg-light border-0 small col-sm-2"/>
        	            <span class="btn btn-primary">
        	                <a href="javascript:searchList();"><spring:message code="button.search" /></a>
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
		
			<div class= "paging">
			<br>
			<ul class="pagination">
				<ui:pagination  paginationInfo = "${paginationInfo}" type="image" jsFunction="linkPage"></ui:pagination>
			</ul>
			<form:hidden path="pageIndex" />
			</div>
		</div>
	</form:form>
</body>
</html>