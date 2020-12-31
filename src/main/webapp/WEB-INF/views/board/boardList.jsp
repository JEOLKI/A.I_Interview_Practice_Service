<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>AI_INTERVIEW</title>

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
	
	.catContent{
		font-size: 0.8em;
		font-weight: bold;
		color : #4374D9;
		display : inline-block;
		border: 1px solid #4374D9;
		border-radius: 3px;
		padding: 1px 10px;
		background-color: #D9E5FF;
	}
	
	.paging{
		text-align: center;
		margin-top: 30px;
	}
	
	.paging a, .paging strong{
		display: inline-block;
		border: 1px solid #4374D9;
		border-radius: 5px;
		width: 25px;
		padding: 1px;
	}
	
	.paging strong{
		background-color: #4374D9;
	    color: #fff;
	}
	
	.paging a:hover{
		background-color: #4374D9;
	    color: #fff;
	}
	
	.contentBox{
		width: 100%;
		margin: 20px auto;
	}
	
	.table-responsive{
		width: 65%;
		margin: 30px auto;
	}
	
	.content-table{
		width: 98%;
		margin: 0px auto;
		border-collapse: collapse; 
	}
	
	.content-table th{
		border-top: 2px solid rgba(154,171,186,.3);
		font-size: 1.1em;
		height: 50px;
		text-align: center;
	}
		
	.content-table td{
		height: 40px;
		text-align: center;
		border-top: 1px solid rgba(154,171,186,.3);
	}
	
	.content-table td:first-child{
		width: 50px;
	}
	
	.content-table tr:hover{
		background-color: #4374D9;
	    color: #fff;
	}
	
	.searchBtn, .createBtn{
		display: inline-block;
		vertical-align : top;
		border: 1px solid #000d22;
		border-radius: 5px;
		height: 29px;
		width: 100px;
		text-align: center;
	}
	
	.searchBtn:hover, .createBtn:hover{
	    background-color: #000d22;
	    color: #fff;
	}
	
	.createBtn{
		display: inline-block;
		float: right;
		margin-top: 15px;
		margin-right: 10px;
	}
	
	.custom-select{
		border: 1px solid gray;
		border-radius: 5px;
		height: 30px;
		vertical-align: top;
	}
	
	.custom-input{
		width: 50%;
		border: 1px solid #000d22;
		border-radius: 5px;
		height: 30px;
		padding: 0px 10px;
	}
	
	.input-group{
		display: inline-block;
		float: right;
		margin-bottom: 20px;
	}
	
</style>

<script type="text/javascript">
	
	$(document).ready(function(){
		$(".y_board").on("click", function(){
			// data-board_sq
			var boardSq = $(this).data("board_sq");
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
	<%@ include file="/WEB-INF/views/layout/header.jsp"%>
	<section class="hero contentbox" id="boardGu${boardGbSq }">
		<div class="hero__content" >
			<div class="content__title">${boardGbNm }</div>
		</div>
	</section>
	
	<div class="contentBox">
		<form:form commandName="boardVO" id="listForm" name="listForm" method="get">
			
			<div class="table-responsive">
			
				<div class="input-group">
			    	<ul>
			   			<li>
	        				<form:select path="searchCondition" cssClass="custom-select">
	        					<form:option value="0" label="제목" />
	        					<form:option value="1" label="작성자" />
	        				</form:select>
	                        <form:input  path="searchKeyword" cssClass="custom-input"/>
		        	            <span class="btn btn-primary">
		        	                <a class="searchBtn" href="javascript:searchList();">검색</a>
		        	            </span>
			        	</li>
					</ul>
				</div>
				
				<table class="content-table" id="dataTable">
					<thead>
						<tr>
							<th>번호</th>
							<th colspan='2'>제목</th>
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
				
						<td><div class="catContent">${board.catContent }</div></td>
						<c:choose>
							<c:when test="${board.boardSt =='N' }">
								<td style="text-align: left;"><c:forEach var="i" begin="1" end="${board.level}" >&nbsp;&nbsp;</c:forEach>
	                           		<c:if test="${board.level != 1 }">└─</c:if>
									[ 삭제된 게시글 입니다. ]
								</td>
							</c:when>
							<c:otherwise>
								<td style="text-align: left;"><c:forEach var="i" begin="1" end="${board.level}" >&nbsp;&nbsp;</c:forEach>
	                           		<c:if test="${board.level != 1 }">└─</c:if>
										 ${board.boardTitle }
								</td>
							</c:otherwise>
						</c:choose>
					
						<td>${board.memId } </td>
						<td>${board.boardDate }</td>
				
					</c:forEach>
				</tbody>
			</table>
				
				<c:choose>
					<c:when test="${boardGbSq =='1' }">
						<c:if test="${S_MEMBER.memAuth != 'N' }">
							<a class="createBtn" href="${pageContext.request.contextPath }/board/create.do?boardGbSq=${boardGbSq }&boardGbNm=${boardGbNm}">글쓰기</a>
						</c:if>
					</c:when>
					<c:otherwise>
						<a class="createBtn" href="${pageContext.request.contextPath }/board/create.do?boardGbSq=${boardGbSq }&boardGbNm=${boardGbNm}">글쓰기</a>
					</c:otherwise>
				</c:choose>
				
				
				<div class ="paging">
					<ui:pagination  paginationInfo = "${paginationInfo}" type="image" jsFunction="linkPage"></ui:pagination>
					<form:hidden path="pageIndex" />
					<input type="hidden" name="boardGbSq" value="${boardGbSq}"/>
					<input type="hidden" name="boardGbNm" value="${boardGbNm}"/>
					
				</div>
				
			
				</div>
		</form:form>
	</div>	
	
	<%@ include file="/WEB-INF/views/chat/chatImage.jsp" %>
	
</body>
</html>