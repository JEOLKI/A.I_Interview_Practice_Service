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
			<div class="hero__content">
				<div class="content__title">회원 관리</div>
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
			</select> 
			<select id="searchType">
				<option value="">검색조건</option>
				<option value="userid">아이디</option>
				<option value="usernm">이름</option>
				<option value="addr">주소</option>
			</select> <input id="keyword" type="text">
			<button type="button">검색</button>
			<a href="#">↓목록 내려받기</a>
		</div>
		<br>
		<div class="list">
			<div class="table">
				<table border="1">
					<tr>
						<th>아이디</th>
						<th>이름</th>
						<th>별명</th>
						<th>연락처</th>
						<th>요금제</th>
						<th>주소</th>
						<!-- yyyy-MM-dd  -->
					</tr>
					<tbody id="memberList">
							<tr data-userid="brown">
								<td>brown</td>
								<td>브라운</td>
								<td>곰</td>
								<td>010-1234-5678</td>
								<td>1일권</td>
								<td>주소</td>
							</tr>
					</tbody>
				</table>
				<a href="#">↑ 일괄등록</a>
			</div>
		</div>
	</div>
</div>
</div>
</body>
</html>