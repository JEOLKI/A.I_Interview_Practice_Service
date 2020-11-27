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
}
</style>
<%@ include file="/WEB-INF/views/layout/commonLib.jsp" %>

</head>
<body>
<!-- 헤더 -->
	<div id="root">
      <div class="Main false">
  <%@ include file="/WEB-INF/views/layout/header.jsp" %>
	 <section class="hero">
			<div class="hero__content" >
				<div class="content__title">스크립트 관리</div>
			</div>
	</section>
	<div class="body">
		<div class="registScript">
			<label>스크립트 : </label>
			<input type="text" >
			<select id="gb">
				<option value="ko" selected>한국어</option>
				<option value="en">영어</option>
			</select> 
			<select id="status">
				<option value="Y" selected>활성화</option>
				<option value="N">비활성화</option>
			</select> 
			<input type="button" value="등록">  
		</div>
		<hr>
		<div class="menu">
			<select id="sort">
				<option value="">정렬</option>
				<option value="">5개씩</option>
				<option value="">10개씩</option>
				<option value="">15개씩</option>
				<option value="">20개씩</option>
			</select> 
			<input id="keyword" type="text">
			<button type="button">검색</button>
			
			<a href="#">↓목록 내려받기</a>
		</div>
		<div class="existScript">
		<label>스크립트 : </label>
		<input type="text" value="동해물과 백두산이 마르고 닳도록">
		<select id="gb">
				<option value="ko" selected>한국어</option>
				<option value="en">영어</option>
			</select> 
			<select id="status">
				<option value="Y" selected>활성화</option>
				<option value="N">비활성화</option>
			</select> 
			<input type="button" value="수정">  <%-- 		<c:forEach items="${categoryList }" var="category"> --%>
<!-- 			<label></label> -->
<%-- 			<input type="text" value="${category.말머리 내용 }"> --%>
<!-- 			<input type="button" value="수정">  -->
<!-- 			<input type="button" value="삭제"> 				 -->
<%-- 		</c:forEach> --%>
		</div>
		<a href="#">↑ 일괄등록</a>
	</div>
	</div>
	</div>
</body>
</html>