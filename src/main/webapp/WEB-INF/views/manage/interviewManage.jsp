<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<%@ include file="/WEB-INF/views/layout/commonLib.jsp" %>

<script type="text/javascript" language="javascript" defer="defer">
	
	 /* pagination 페이지 링크 function */
    function linkPage(pageNo){
    	document.listForm.pageIndex.value = pageNo;
    	document.listForm.action = "<c:url value='/interview/retrievePagingList.do'/>";
       	document.listForm.submit();
    }
	 
	/* 검색 */
	function searchList(){
		document.listForm.action = "<c:url value='/interview/retrievePagingList.do'/>";
       	document.listForm.submit();
	}
	
</script>

<style type="text/css">
	
	#excelBtn{
		border: 1px solid #22741C;
		background-color: #22741C;
		border-radius: 30px;
		color: white;
		padding: 1px 10px;
		margin: 100px 5px;
	}
	
	.table-responsive table{
		width: 75%;
		border-collapse: collapse;
	}
	
	.table-responsive td, .table-responsive th{
		height: 40px;
		text-align: center;
		border-bottom: 1px solid black;
	}
	
	.table-responsive th{
		background: #D9E5FF;
	}
	
</style>

</head>

<body>
	
	<h1>면접 관리</h1>
	
	<form:form commandName="interviewVO" id="listForm" name="listForm" method="get">
		<div class="blog-main">
			<div>
	       		<ul>
        			<li>
        			    <label for="searchCondition" style="visibility:hidden;"><spring:message code="search.choose" /></label>
        				<form:select id="searchCondition" class="col-sm-1" path="searchCondition"><!-- 
        				cssClass="use custom-select custom-select-sm form-control form-control-sm col-sm-1" -->
        					<form:option value="0" label="면접이름" />
        					<form:option value="1" label="회원아이디" />
        				</form:select>
        			<label for="searchKeyword" style="visibility:hidden;display:none;"><spring:message code="search.keyword" /></label>
                        <form:input id="searchKeyword" path="searchKeyword" />
                       <!--  cssClass="txt form-control col-sm-2" -->
        	            <span class="btn btn-primary">
        	                <a href="javascript:searchList();"><spring:message code="button.search" /></a>
        	                <img src="<c:url value='/images/egovframework/example/btn_bg_r.gif'/>" style="margin-left:6px;" alt=""/>
        	            </span>
        	        </li>
                </ul>
				<a id="excelBtn" href="${cp }/interview/list/excelDown.do">excel 다운로드</a> 
	       	</div>
	       	
		    
			<div class="table-responsive">
			 	<table class="table blogmain table-hover" id="dataTable">
					<thead>
						<tr>
							<th>번호</th>
							<th>면접 제목</th>
							<th>면접 등록 일자</th>
							<th>회원 아이디</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${resultList }" var="interview">
							<tr>
								<td>${interview.interviewSq }</td>	
								<td>${interview.interviewNm } </td>
								<td>${interview.interviewDate }</td>
								<td>${interview.memId }</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
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