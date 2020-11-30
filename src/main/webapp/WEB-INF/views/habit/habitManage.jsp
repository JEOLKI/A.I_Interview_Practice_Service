<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/WEB-INF/views/layout/commonLib.jsp" %>
<title>Insert title here</title>
<script type="text/javascript" language="javascript" defer="defer">
	/*습관어 등록  function*/
	$(document).ready(function(){
		
		
		$('#habitRegistBtn').on('click', function(){
			$('#habitRegistFrm').submit();
		})	
		
		
		$.ajax({url : "/habit/list.do",
				method : "get",
				dataType : "json",
				success : function(data){
					console.log(data);
					var html="";
					for(var i=0; i<data.habitList.length; i++){
						html += '<form class="habitUpdateFrm" action="${cp }/habit/updateProcess.do" method="post">';
						html += '<input type="hidden" name="habitSq" value="'+data.habitList[i].habitSq+'">';
						html += '<input type="text" name="habitGb" value="'+data.habitList[i].habitGb+'">';
						html += '<select class="habitSt" name="habitSt">';
						if(data.habitList[i].habitSt == "Y"){
							html += '<option value="Y" selected="selected">사용</option>';
							html += '<option value="N">미사용</option>';
						}else{
							html += '<option value="Y">사용</option>';
							html += '<option value="N" selected="selected">미사용</option>';
						}
						html += '</select>';
						html += '<button class="updateBtn" type="submit">수정</button>';
						html += '</form>';
					}
					$('#habitList').append(html);
				}})
	})
</script>
</head>
<body>

	<%@ include file="/WEB-INF/views/layout/header.jsp" %>
	습관어 등록
	아, 어, 그, 저, 음
	<form id="habitRegistFrm" action="${cp }/habit/createProcess.do" method="post">
	<input  type="text" id="habitGb" name="habitGb" value="${param.habitGb }">
	<select id="habitSt" name="habitSt">
		<c:choose>
			<c:when test="${param.habitSt == Y }">
				<option value="Y" selected="selected">사용</option>
				<option value="N">미사용</option>
			</c:when>
				<c:otherwise>
				<option value="Y">사용</option>
				<option value="N" selected="selected">미사용</option>
			</c:otherwise>
		</c:choose>
	</select>
	</form>
	<input type="button" id="habitRegistBtn" value="등록">
	
	<hr>
	
	<div id="habitList">
	
	</div>
	
</body>
</html>