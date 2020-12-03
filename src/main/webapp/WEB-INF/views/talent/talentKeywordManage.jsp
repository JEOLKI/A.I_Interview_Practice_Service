<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">

<%@ include file="/WEB-INF/views/layout/commonLib.jsp" %>
 <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<title>Insert title here</title>
<style type="text/css">
	#search{
		display: inline-block; 
	}
	
	.menu{
		margin-top : 20px;
		margin-bottom: 20px;
	}
	.body{
		margin : 30px;
	}
	#massiveCreate{
		margin-left: 20px;
	}
	
	.updateBtn, #talentUpdateBtn, #registBtn, .deleteBtn{
		padding-left: 10px;
		padding-right: 10px;
		padding-top: 2px;
		padding-bottom: 2px;
	}
	
	.talentUpdateFrm {
		margin-top: 10px;
		margin-bottom: 10px;
	}
	
	
	.talentNm{
		width: 400px;
		padding-left: 10px;
	}
	
	.content__title{
		margin-bottom: 30px;
	}
	h1{
		font-weight:bold;
	}
	#check{
		display: inline-block; 
		height: 20px;
	}
	#hr{
		border-bottom: 1px dotted lightgray;
		margin-top: 20px;
	}
	#keywordRegistFrm, #talentUpdateFrm{
		display: inline-block;;
	}
	label{
		width: 100px;
	}
	.menu, #keywordList, #paging{
		margin-left: 100px;
	}
	
</style>

<script type="text/javascript" language="javascript" defer="defer">
	$(document).ready(function() {

	
	$('#talentUpdateBtn').on('click', function() {
		if($('#talentNm').val()==''){
			var html = '<span style="color:red">**내용을 입력해주세요</span><br><br>';
			$('#check').empty();
			$('#check').append(html);
		}else{
			$('#talentUpdateFrm').submit();
		}
	})
	
	$('#searchBtn').on('click', function(){
		searchKeyword = $('#searchKeyword').val();
		$.ajax({url:"/keyword/retrieveSearchList.do",
			    data : {"searchKeyword" : searchKeyword},
			    dataType : "json",
			    success : function(data){
			    	var html = "";
			    	for(var i = 0; i<data.keywordSearchList.length; i++ ){
				    	var keyword = data.keywordSearchList[i];
				    	html += '<form class="keywordUpdateFrm">'
				    	html += '<input type="hidden" value="'+keyword.keywordSq+'">';
				    	html += '<input type="text" name="keywordContent" value="'+keyword.keywordContent+'">';
				    	html += '<input type="hidden" class="deleteBtn" value="'+keyword.keywordSq+'">';
				    	html += '</form>';
			    	}
			    	$('#keywordList').empty();
			    	$('#keywordList').append(html);
			    }
		})
	})
		
		$('#massiveCreate').on('click',function(){
			$('input[type="file"]').click();
		})
		
		$('input[type="file"]').on('change',function(){
			$('#massiveForm').submit();
		})
		
	}
		
	})
</script>
</head>
<body>
	<!-- 헤더 -->
	<div id="root">
		<div class="Main false">
			<%@ include file="/WEB-INF/views/layout/header.jsp"%>
			<%@ include file="/WEB-INF/views/manage/managerleft.jsp" %> 
<div class="w3-container" style="margin-left: 200px">
			<div class="body">
				<div class="content__title"><h1>인재상 관리</h1></div>
				<div class="updateTalent">
					<label>인재상</label>
					<form id="talentUpdateFrm" action="${cp }/talent/update.do" method="post">
						<input type="hidden" class="talentSq" name="talentSq" value="${talentVO.talentSq }">
						<input type="text" class="talentNm" name="talentNm" value="${talentVO.talentNm }">
						<select id="talentSt" name="talentSt">
							<c:choose>
								<c:when test="${talentVO.talentSt == Y }">
									<option value="Y" selected="selected">사용</option>
									<option value="N">미사용</option>
								</c:when>
								<c:otherwise>
									<option value="Y">사용</option>
									<option value="N" selected="selected">미사용</option>
								</c:otherwise>
							</c:choose>
						</select> 
						<button type="button" id="talentUpdateBtn">수정</button>
					</form>
					<div id="check"></div>
				</div>


				<hr>
				<div class="keyword">
				<label>키워드</label>
				<form id="keywordRegistFrm">
					<input type="hidden" class="talentSq" name="talentSq" value="${talentVO.talentSq }">
					<input type="text" id="keywordContent" >
					<button type="submit" id="registBtn">등록</button>
				</form>
				
				<div class="menu">
					<select id="sort">
						<option value="10">10개씩</option>
						<option value="15">15개씩</option>
						<option value="20">20개씩</option>
					</select> 
					<div id="search">
						<input type="text" id="searchKeyword" >
						<span id="searchBtn">검색</span>
					</div>

					<a href="${cp }/talent/list/excelDown.do">↓ 목록 내려받기</a> 
					<span id="massiveCreate">↑ 일괄등록</span>
					<!-- excel file 읽어오기 -->
				    <form hidden id="massiveForm" name="massiveForm" enctype="multipart/form-data" method="post" action="<c:url value="${cp }/talent/massiveCreateProcess.do"/>" >
				        <input hidden type="file" name="excelFile" />
				    </form>
				</div>
				
				<div class="existKeyword" id="keywordList">
					<c:forEach items="${resultList }" var="keyword">
						<form class="talentUpdateFrm" action="${cp }/keyword/delete.do" method="post">
							<input type="hidden" name="talentSq" value="${talentVO.talentSq}">
							<input type="text" class="keywordContent" name="keywordContent" value="${keyword.keywordContent}">
								<button type="submit" class="deleteBtn">삭제</button>
							</form>
					</c:forEach>
				</div>
				<div id="paging"></div>
			</div>
</div>
		</div>
	</div>
</body>
</html>