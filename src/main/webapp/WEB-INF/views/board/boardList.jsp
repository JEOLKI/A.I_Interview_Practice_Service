<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<%@ include file="/WEB-INF/views/layout/commonLib.jsp" %>

<style type="text/css">
	
	#boardGu1{
		background: repeating-linear-gradient(-60deg, rgba(255, 255, 255, 0), rgba(255, 255, 255, 0) 10px, rgba(255, 255, 255, 0.1) 0px, rgba(255, 255, 255, 0.1) 11px),  linear-gradient(-40deg,#1c94c1,#75dfc8);
	}
	
	#boardGu2{
		background: repeating-linear-gradient(-60deg, rgba(255, 255, 255, 0), rgba(255, 255, 255, 0) 10px, rgba(255, 255, 255, 0.1) 0px, rgba(255, 255, 255, 0.1) 11px),  linear-gradient(-40deg,#140d57,#1391aa);
	}
	
	#boardGu3{
		background: repeating-linear-gradient(-60deg, rgba(255, 255, 255, 0), rgba(255, 255, 255, 0) 10px, rgba(255, 255, 255, 0.1) 0px, rgba(255, 255, 255, 0.1) 11px),  linear-gradient(-40deg,#8b1c1c,#2717a3);
	}
	
	#boardGu4{
		background: repeating-linear-gradient(-60deg, rgba(255, 255, 255, 0), rgba(255, 255, 255, 0) 10px, rgba(255, 255, 255, 0.1) 0px, rgba(255, 255, 255, 0.1) 11px), linear-gradient(-40deg, #00b4db, #0083b0);
	}
	
	.body{
		display: flex;
		justify-content: center;
		align-items: center;
		margin-top: 50px;
	}
	
	.blog-main{
		width: 70%
	}
	
	.table-responsive, #dataTable{
		width: 100%;		
	}
	
	 #dataTable{
	 	text-align: center;
	 }
	 
	 tr{
	 	border : 1px solid black;
	 }
	 
	 
	
	#catContent{
		font-size: 0.8em;
		font-weight: bold;
		display : inline-block;
		border: 1px solid black;
		border-radius: 3px;
		padding: 1px 10px;
		background-color: white;
		margin-left: 30px;
		background-color: #D9E5FF;
		float: left;
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
			
			<div class="body">
			
				<div class="blog-main">
			
					<div class="input-group">
		        		<ul class ="button-search">
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
		        	            </span>
		        	        </li>
		                </ul>
		        	</div>
			
			
					<div class="table-responsive">
						<table class="table blogmain table-hover" id="dataTable">
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
											<div id="catContent">${board.catContent }</div> ${board.boardTitle }
										</td>
									</c:otherwise>
								</c:choose>
							
								<td>${board.memId } </td>
								<td>${board.boardDate }</td>
						
							</c:forEach>
						</tbody>
					</table>
				</div>
				
				<div class ="paging">
				<br>
				<ui:pagination  paginationInfo = "${paginationInfo}" type="image" jsFunction="linkPage"></ui:pagination>
				<form:hidden path="pageIndex" />
				<input type="hidden" name="boardGbSq" value="${boardGbSq}"/>
				<input type="hidden" name="boardGbNm" value="${boardGbNm}"/>
				</div>
				<a class="btn createBtn write" href="${pageContext.request.contextPath }/board/create.do?boardGbSq=${boardGbSq }&boardGbNm=${boardGbNm}">글쓰기</a>
			</div>
			</div>
			
			
		</div>
	</div>
</form:form>
			
</body>
</html>