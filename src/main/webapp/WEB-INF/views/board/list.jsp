<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

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
	<div id="root">
		<div class="Main false">
			<%@ include file="/WEB-INF/views/layout/header.jsp"%>
			
			<section class="hero contentbox" id="boardGu${boardGbSq }">
				<div class="hero__content" >
					<div class="content__title">${boardGbNm }</div>
				</div>
			</section>
			
			<div class="body" >
			
				<div class="col-sm-8 blog-main">
			
					<div class="input-group" id="search">
		        		<ul>
		        			<li>
		        			    <label for="searchCondition" style="visibility:hidden;"><spring:message code="search.choose" /></label>
		        				<form:select path="searchCondition" cssClass="use custom-select custom-select-sm form-control form-control-sm">
		        					<form:option value="0" label="제목" />
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
						
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
			
			<ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="linkPage"/>
			<form:hidden path="pageIndex" />
			<input hidden name="boardGbSq" value="${boardGbSq}"/>
			<input hidden name="boardGbNm" value="${boardGbNm}"/>
		
			<a class="btn createBtn" href="${pageContext.request.contextPath }/board/create.do?boardGbSq=${boardGbSq }&boardGbNm=${boardGbNm}">글쓰기</a>
	
		</div>
	</div>
</form:form>

			
</body>
</html>