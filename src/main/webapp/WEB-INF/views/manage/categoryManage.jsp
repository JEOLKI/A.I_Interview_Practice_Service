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
			<div class="hero__content">
				<div class="content__title">게시판 관리</div>
			</div>
	</section>
	<div class="body">
		<div class="board">
			<label>게시판 : </label>
			<input type="text" value="스터디게시판">
			<select id="status">
				<option value="Y" selected>활성화</option>
				<option value="N">비활성화</option>
			</select> 
			<input type="button" value="수정">  
		</div>
		<hr>
		<div class="category">
		<label>말머리 : </label>
		<input type="text" value="서울">
		<input type="button" value="수정"> 
		<input type="button" value="삭제">
<%-- 		<c:forEach items="${categoryList }" var="category"> --%>
<!-- 			<label></label> -->
<%-- 			<input type="text" value="${category.말머리 내용 }"> --%>
<!-- 			<input type="button" value="수정">  -->
<!-- 			<input type="button" value="삭제"> 				 -->
<%-- 		</c:forEach> --%>
		</div>
	</div>
	</div>
	</div>
</body>
</html>