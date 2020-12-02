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
	
</script>



</head>
<body>

	<%@ include file="/WEB-INF/views/layout/header.jsp" %>

	<section class="hero" id="boardGu${boardGbSq }">
		<div class="hero__content" >
			<div class="content__title">${boardGbNm }</div>
		</div>
	</section>
	
   <div class="row">
	<div class="col-sm-8 blog-main">
		<div class="table-responsive">
			<table class="table table-striped">
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
		
		<ui:pagination paginationInfo = "${paginationInfo}"  type="image" jsFunction="linkPage"/>

		<a class="btn btn-default pull-right" href="${pageContext.request.contextPath }/board/create.do?boardGbSq=${boardGbSq }&boardGbNm=${boardGbNm}">새글 등록</a>
	
	</div>
</div>
			

			
</body>
</html>