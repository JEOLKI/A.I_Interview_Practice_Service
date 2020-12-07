<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<%@ include file="/WEB-INF/views/layout/commonLib.jsp" %>

<script type="text/javascript">

	$(document).ready(function() {

		$('#categoryRegistFrm').on('click', function() {
			if($('#catGbContent').val()==''){
				var html = '<span style="color:red">**내용을 입력해주세요</span><br><br>';
				$('#check').empty();
				$('#check').append(html);
			}else{
				$('#categoryRegistFrm').submit();
			}
		})
		
		$('.categoryMngBtn').on('click', function(){
			catGbSq= $(this).val();
			console.log(catGbSq);
			//document.location="/talent/keywordManage.do?talentSq="+talentSq;
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
<form:form commandName="categoryGubunVO" id="listForm" name="listForm" method="get">
	<div id="root boarding">
		<div class="Main false">
			<%@ include file="/WEB-INF/views/layout/header.jsp"%>
			
			<%@ include file="/WEB-INF/views/manage/managerleft.jsp" %>
			
			<div class="body paging managerbox">
				
				<div class="registdiv">
					<form id="categoryRegistFrm" action="${cp }/categoryGubun/create.do" method="post">
						<label>게시판 이름 : </label>
						<input type="text" id="catGbContent" name="catGbContent" value="">
						<select id="catGbSt" name="catGbSt">
							<option value="Y" selected="selected">사용</option>
							<option value="N">미사용</option>
						</select> 
						<select id="boardGbSq" name="boardGbSq">
							<option value="Y" selected="selected">사용</option>
							<option value="N">미사용</option>
						</select> 
						<button type="button" id="categoryGbRegBtn">등록</button>
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
			
			
					<div class="table-responsive">
						<c:forEach items="${resultList }" var="categoryGubun">
							<form class="talentUpdateFrm" action="${cp }/categoryGubun/update.do" method="post">
								<input type="hidden" name="catGbSq" value="${categoryGubun.catGbSq}">
								<input type="text" class="catGbContent" name="catGbContent" value="${categoryGubun.catGbContent}">
								<select class="catGbSt" name="catGbSt">
										<c:choose>
											<c:when test="${categoryGubun.catGbSt == 'Y' }">
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
								<button type="button" class="categoryMngBtn" value="${categoryGubun.catGbSq }">말머리 관리</button>
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
			</div>
			
			
		</div>
	</div>
</form:form>
</body>
</html>