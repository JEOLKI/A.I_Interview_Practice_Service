<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>  
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>


<%@ include file="/WEB-INF/views/layout/commonLib.jsp" %>

<script type="text/javascript">

/* pagination 페이지 링크 function */
function linkPage(pageNo){
	document.listForm.pageIndex.value = pageNo;
	document.listForm.action = "<c:url value='/plan/retrievePagingList.do'/>";
   	document.listForm.submit();
}
 
/* 검색 */
function searchList(){
	document.listForm.action = "<c:url value='/plan/retrievePagingList.do'/>";
   	document.listForm.submit();
}

</script>

</head>
<body>
<form:form commandName="planUseVO" id="listForm" name="listForm" method="get">
	<div id="root">
		<div class="Main false">
			<%@ include file="/WEB-INF/views/layout/header.jsp"%>
			
			<div class="body" >
			
				<div class="col-sm-8 blog-main">
			
					<div class="input-group" id="search">
		        		<ul>
		        			<li>
		        			    <label for="searchCondition" style="visibility:hidden;"><spring:message code="search.choose" /></label>
		        				<form:select path="searchCondition" cssClass="use custom-select custom-select-sm form-control form-control-sm">
		        					<form:option value="0" label="이름" />
		        					<form:option value="1" label="작성자" />
		        				</form:select>
		        			</li>
		        			<li><label for="searchKeyword" style="visibility:hidden;display:none;"><spring:message code="search.keyword" /></label>
		                        <form:input path="searchKeyword" cssClass="txt form-control bg-light border-0 small"/>
		                    </li>
		        			<li>
		        	            <span class="btn btn-primary">
		        	                <a href="javascript:searchList();"><spring:message code="button.search" /></a>
		        	                <img src="<c:url value='/images/egovframework/example/btn_bg_r.gif'/>" style="margin-left:6px;" alt=""/>
		        	            </span>
		        	        </li>
		                </ul>
		        	</div>
			
			
					<div class="table-responsive">
						<table class="table table-bordered" id="dataTable">
						<thead>
							<tr>
								<th>구매일</th>
								<th>이용권</th>
								<th>회원 아이디</th>
								<th>결제 금액</th>
								<th>시작일</th>
								<th>마지막날</th>
							</tr>
						</thead>
						<tbody id="boardList">
							<c:forEach items="${resultList }" var="planuse">
								<tr>
								<td>${planuse.startDate }</td>	
								<td>${planuse.planNm }</td>
								<td>${planuse.memId } </td>
								<td>${planuse.planPrice } </td>
								<td>${planuse.startDate }</td>
								<td>${planuse.endDate }</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
			
			<ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="linkPage"/>
			<form:hidden path="pageIndex" />
		
			</div>
		</div>
	</div>
</form:form>
</body>
</html>