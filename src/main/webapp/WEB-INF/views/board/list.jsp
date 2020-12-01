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
		<h2 class="sub-header">${param.gubun_nm }</h2>
		<div class="table-responsive">
			<table class="table table-striped">
				<thead>
					<tr>
						<th>게시글 번호</th>
						<th>제목</th>
						<th>작성자 아이디</th>
						<th>작성일시</th>
					</tr>
				</thead>
				<tbody id="boardList">
					<c:forEach items="${resultList }" var="board">
						<c:choose>
							<c:when test="${board.boardSt =='y'}">
								<tr>
							</c:when>
							<c:otherwise>
								<tr class="y_board" data-board_sq="${board.boardSq }">
							</c:otherwise>
						</c:choose>
						
							<td>${board.boardSq }</td>	
						
						<c:choose>
							<c:when test="${board.boardSt =='n' }">
								<td>[삭제된 게시글 입니다.]</td>
							</c:when>
							<c:otherwise>
								<td>${board.boardTitle } </td>
							</c:otherwise>
						</c:choose>
						
							<td>${board.memId } </td>
							<td>${board.boardDate }</td>
						
						</tr>
						
					</c:forEach>
					
				</tbody>
			</table>
		</div>

		<a class="btn btn-default pull-right" href="${cp }/board/regist?gubun_sq=${param.gubun_sq }&userid=${S_MEMBER.userid }">새글 등록</a>
	</div>
</div>
			

			
</body>
</html>