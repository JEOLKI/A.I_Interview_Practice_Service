<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
table{
	border-collapse: collapse;
}
a{
	text-decoration: none;
	color: black;
}
</style>
<%@ include file="/WEB-INF/views/layout/commonLib.jsp" %>
</head>
<body>
<div id="root">
      <div class="">

           <%@ include file="/WEB-INF/views/layout/header.jsp" %>
	<!-- 헤더 -->
	 <section class="hero">
			<div class="hero__content" >
				<div class="content__title">면접 관리</div>
			</div>
		</section>
	<div class="body">
		<div class="menu">
			<select id="sort">
				<option value="">정렬</option>
				<option value="">5개씩</option>
				<option value="">10개씩</option>
				<option value="">15개씩</option>
				<option value="">20개씩</option>
			</select> <select id="searchType">
				<option value="">검색조건</option>
				<option value="usernm">면접 제목</option>
				<option value="userid">아이디</option>
				<option value="usernm">목표 직무</option>
				<option value="usernm">등록시간</option>
			</select> <input id="keyword" type="text">
			<button type="button">검색</button>
			<a href="#">↓목록 내려받기</a>
		</div>
		<br>
		<div class="list">
			<div class="table">
				<table border="1">
					<tr>
						<th>번호</th>
						<th>면접 제목</th>
						<th>아이디</th>
						<th>목표 직무</th>
						<th>등록시간</th>
						<!-- yyyy-MM-dd  -->
					</tr>
					<tbody id="memberList">
							<tr data-userid="brown">
								<td>1</td>
								<td>삼성전자 마케팅</td>
								<td>brown</td>
								<td>마케팅</td>
								<td>2020-11-20</td>
							</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</div>
</div>
</body>
</html>