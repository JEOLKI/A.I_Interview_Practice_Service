<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<link href="/css/sb-admin-2.min.css" rel="stylesheet">

<%@ include file="/WEB-INF/views/layout/commonLib.jsp" %>

<style type="text/css">
	
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
 		margin-left: 21%;
 		margin-top: 30px;  
	
	}
	.paging{ 
		text-align: center;
	}
	.write{
		text-align: right;
	}
	
</style>

<script type="text/javascript">
	
	$(document).ready(function(){
		$(".y_board").on("click", function(){
			//console.log("click");
			
			// data-board_sq
			var boardSq = $(this).data("board_sq");
			console.log("boardSq : " + boardSq);
	
			document.location="/board/retrieve.do?boardSq=" + boardSq; 
			
		});
	});
	
	 /* pagination 페이지 링크 function */
    function linkPage(pageNo){
    	document.listForm.pageIndex.value = pageNo;
    	document.listForm.action = "<c:url value='/board/retrievePagingList.do'/>";
       	document.listForm.submit();
    }
	 
	/* 검색 */
	function searchList(){
		document.listForm.action = "<c:url value='/board/retrievePagingList.do'/>";
       	document.listForm.submit();
	}
	
	
</script>



</head>
<body>
<form:form commandName="boardVO" id="listForm" name="listForm" method="get">
	<div id="root boarding">
		<div class="Main false">
			<%@ include file="/WEB-INF/views/layout/header.jsp"%>
			
			<section class="hero contentbox" id="boardGu${boardGbSq }">
				<div class="hero__content" >
					<div class="content__title">${boardGbNm }</div>
				</div>
			</section>
			
			<div class="body" >
			
				<div class="col-sm-10 blog-main">
			
					<div class="input-group " id="search">
		        		<ul  class = "button-search">
		        			<li>
		        			    <label for="searchCondition" style="visibility:hidden;"><spring:message code="search.choose" /></label>
		        				<form:select class="col-sm-1" path="searchCondition" cssClass="use custom-select custom-select-sm form-control form-control-sm col-sm-1">
		        					<form:option value="0" label="제목" />
		        					<form:option value="1" label="작성자" />
		        				</form:select>
		        			<label for="searchKeyword" style="visibility:hidden;display:none;"><spring:message code="search.keyword" /></label>
		                        <form:input  path="searchKeyword" cssClass="txt form-control bg-light border-0 small col-sm-3"/>
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
								<th>번호</th>
								<th>제목</th>
								<th>작성자 아이디</th>
								<th>작성일시</th>
							</tr>
						</thead>
						<tbody id="boardList">
							<c:forEach items="${resultList }" var="board">
								<c:choose>
								<c:when test="${board.boardSt =='N'}">
										<tr>
									</c:when>
									<c:otherwise>
										<tr class="y_board" data-board_sq="${board.boardSq }">
									</c:otherwise>
								</c:choose>
						
								<td>${board.rnum }</td>	
						
								<c:choose>
									<c:when test="${board.boardSt =='N' }">
									<td><c:forEach var="i" begin="1" end="${board.level}" >&nbsp;&nbsp;</c:forEach>
		                           		<c:if test="${board.level == 1 }">└─</c:if>
											[삭제된 게시글 입니다.]
										</td>
									</c:when>
									<c:otherwise>
									<td><c:forEach var="i" begin="1" end="${boardVO.level}" >&nbsp;&nbsp;</c:forEach>
		                           		<c:if test="${board.level != 1 }">└─</c:if>
											[${board.catContent }] ${board.boardTitle }
										</td>
									</c:otherwise>
								</c:choose>
							
								<td>${board.memId } </td>
								<td>${board.boardDate }</td>
						
							</c:forEach>
						</tbody>
					</table>
				</div>
				
				<div class = "paging">
				
				<ul class="pagination boarding">
				<ui:pagination  paginationInfo = "${paginationInfo}" type="image" jsFunction="linkPage"></ui:pagination>
				</ul>
				<a class="btn createBtn write" href="${pageContext.request.contextPath }/board/create.do?boardGbSq=${boardGbSq }&boardGbNm=${boardGbNm}">글쓰기</a>
				<form:hidden path="pageIndex" />
				<input hidden name="boardGbSq" value="${boardGbSq}"/>
				<input hidden name="boardGbNm" value="${boardGbNm}"/>
			
				</div>
			</div>
			</div>
			
			
		</div>
	</div>
</form:form>
<!-- 			<button class= "btn">a</button> -->
<!-- 			<button class= "btn hover" type = "button">b</button> -->
<!-- 			<button class= "btn focus" class= "-moz-focus-inner">c</button> -->
<!-- 			<button class="btn-outline-primary">ㅁㅁ</button> -->
<!-- 			<button class="btn-group">ㅁㅁ</button> -->
<!-- 			<button class=".btn-toolbar">ㅁㅁ</button> -->
<!-- 			<button class="btn-facebook">ㅁㅁ</button> -->
			
			
</body>
</html>