<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>



<style>

table{
	border-collapse: collapse;
}

a{
	text-decoration: none;
}
</style>

<!-- 헤더 -->
	
<%@ include file="/WEB-INF/views/layout/commonLib.jsp" %>

</head>
<body>
   <noscript>You need to enable JavaScript to run this app.</noscript>
   <div id="root">
      <div class="Main false">

           <%@ include file="/WEB-INF/views/layout/header.jsp" %>
           <main>
 	<section class="hero">
			<div class="hero__content">
				<div class="content__title">게시판 관리</div>
			</div>
		</section>
	<div class="body">
		<div class="menu">
			<label>게시판 : </label>
			<input type="text">
			<select id="status">
				<option value="Y">활성화</option>
				<option value="N">비활성화</option>
			</select> 
			<input type="button" value="등록">  
			<br>
			<select id="sort">
				<option value="">정렬</option>
				<option value="">5개씩</option>
				<option value="">10개씩</option>
				<option value="">15개씩</option>
				<option value="">20개씩</option>
			</select> 
			<select id="searchType">
				<option value="">검색조건</option>
				<option value="">이름</option>
				<option value="">등록일</option>
			</select> <input id="keyword" type="text">
			<button type="button">검색</button>
			<br>
			<a href="#">↓목록 내려받기</a>
		</div>
		<br>
		<div class="list">
			<div class="table">
				<table border="1">
					<tr>
						<th>게시판</th>
						<th>사용여부</th>
						<th>등록일</th>
						<!-- yyyy-MM-dd  -->
					</tr>
					<tbody id="boardList">
							<tr data-board_sq="">
								<td>공지게시판</td>
								<td>Y</td>
								<td>2020-11-20</td>
							</tr>
						<c:forEach items="${boardList }" var="board">
							<tr data-board_seq="${board.board_seq }">
								<td>${board.boardnm }</td>
								<td>${board.status }</td>
								<td><fmt:formatDate value="${board.reg_dt }" pattern="yyyy-MM-dd" /></td>
							</tr>
						</c:forEach>
							</tbody>
				</table>
			</div>
		</div>
	</div>
</main>
</div>
</div>

        
</body>
</html>































