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
<link href="/css/sb-admin-2.min.css" rel="stylesheet">

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
<style>
	#search{
		display: inline-block;
	}
	
	#table, table{
		width:1000px;
	}
	
	table, th, td{
		border: solid 1px black;
	}
	
	#boardGu1{
		background-color: #56c0ce;
	}
	.boarding{
		display: inline-block;
	}
	.button-search{
		text-align: right;
 		margin-right: 15%;
 		margin-top: 30px;  
	
	}
	.paging{ 
		text-align: center;
	}
	.write{
		text-align: right;
	}
		
	.blogmain{
		width: 70%;
		margin: auto;
		
	}
</style>
</head>
<body>
<form:form commandName="planUseVO" id="listForm" name="listForm" method="get">
	<div id="root boarding">
		<div class="Main false">
			
			<div class="body" >
			
				<div class=" blog-main">
			
					<div class="input-group boarding" >
		        		<ul class = "button-search">
		        			<li>
		        			    <label for="searchCondition" style="visibility:hidden;"><spring:message code="search.choose" /></label>
		        				<form:select class="col-sm-1" path="searchCondition" cssClass="use custom-select custom-select-sm form-control form-control-sm col-sm-1">
		        					<form:option value="0" label="이용권" />
		        					<form:option value="1" label="아이디" />
		        					<form:option value="2" label="날짜" />
		        				</form:select>
		        			<label for="searchKeyword" style="visibility:hidden;display:none;"><spring:message code="search.keyword" /></label>
		                        <form:input path="searchKeyword" cssClass="txt form-control bg-light border-0 small col-sm-2"/>
		        	            <span class="btn btn-primary">
		        	                <a href="javascript:searchList();"><spring:message code="button.search" /></a>
		        	                <img src="<c:url value='/images/egovframework/example/btn_bg_r.gif'/>" style="margin-left:6px;" alt=""/>
		        	            </span>
		        	        </li>
		        	        <li class = "down">
		        	        <a  href="/plan/planUseExcel.do">↓ 목록 내려받기</a>
		        	        </li>
		                </ul>
		        	
					</div>
					
					<div class="table-responsive">
						<table class="table blogmain" id="dataTable">
						<thead>
							<tr>
								<th class="label menu">구매일</th>
								<th class="label menu">이용권</th>
								<th class="label menu">회원 아이디</th>
								<th class="label menu">결제 금액</th>
								<th class="label menu">기간</th>
							</tr>
						</thead>
						<tbody id="boardList">
							<c:forEach items="${resultList }" var="planuse">
								<tr>
								<td>${planuse.startDay }</td>	
								<td>${planuse.planNm }</td>
								<td>${planuse.memId } </td>
								<td>${planuse.fmtPlanPrice } </td>
								<td>${planuse.startDay }~${planuse.endDay }</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
						
				</div>
			<br>
			<div class = "paging">
				
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