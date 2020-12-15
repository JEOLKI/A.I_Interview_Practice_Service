<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<%@ include file="/WEB-INF/views/layout/commonLib.jsp" %>
 <meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>
<style type="text/css">
	#search{
		display: inline-block; 
	}
	
	.menu{
		margin-top : 20px;
		margin-bottom: 20px;
		display : block;
	}
	.listmenu, .excelmenu{
		display: inline-block; 
	}
	.excelmenu{
		float: left;
	}
	.listmenu{
		float: right;
		margin-right: 486px;
	}
	
	#registBtn, .updateBtn, #talentUpdateBtn, .deleteBtn, .searchBtn{
		display: inline-block;
	    vertical-align: middle;
	    border: 1px solid #000d22;
	    border-radius: 5px;
	    height: 23px;
	    padding: 0px 10px;
	    text-align: center;
	    position: relative;
	    top: -2px;
	}
	
	#registBtn:hover, .searchBtn:hover, .updateBtn:hover, #talentUpdateBtn:hover, .deleteBtn:hover{
	    background-color: #000d22;
	    color: #fff;
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
	.page{
		display: inline-block;
		margin: 5px;
	}
	.contentBox{
		width: 70%;
		padding: 20px 30px;
		background-color: white;
		border-radius: 10px;
		margin: 10px 0px;
		box-shadow: 5px 5px #EAEAEA;
		display: inline-block;
		float: left;
	}
	input{
		border-radius: 5px;
		border : 1px solid black;
	}
	#talentSt, #sort{
		height: 26px;
	    position: relative;
	    top: -2px;
	    border-radius: 5px;
	}
	#sort{
		float:left;
		top: -1px;
    	margin-right: 3px;
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
	input[type="file"]{
		display: none; 
	}
	.excelBtn{
		display: inline-block;
		border: 1px solid #000d22;
		border-radius: 5px;
		padding:0px 5px;
	}
	.excelBtn:hover{
	    background-color: #22741C;
	    border: 1px solid #22741C;
	    color: #fff;
	}
</style>

<script type="text/javascript" language="javascript" defer="defer">
	$(document).ready(function() {

	
		$('#talentUpdateBtn').on('click', function() {
			if($('#talentNm').val()==''){
				var html = '<span style="color:red">**내용을 입력해주세요</span>';
				$('#talentCheck').empty();
				$('#talentCheck').append(html);
			}else{
				$('#talentUpdateFrm').submit();
			}
		})
	
		$('#searchBtn').on('click', function(){
			searchKeyword = $('#searchKeyword').val();
			document.location = "/talent/keywordManage.do?talentSq=${talentVO.talentSq }&pageUnit="+pageUnit+"&searchKeyword="+searchKeyword;
		})
		$('#massiveCreate').on('click',function(){
			$('input[type="file"]').click();
		})
		
		$('input[type="file"]').on('change',function(){
			$('#massiveForm').submit();
		})
		
		$('#sort').on('change',function(){
			pageUnit = $(this).val();
			document.location="/talent/keywordManage.do?talentSq=${talentVO.talentSq }&pageUnit="+pageUnit;
		})
	
		$('#registBtn').on('click',function(){
			if($('#keywordContent').val()==''){
				var html = '<span style="color:red">**내용을 입력해주세요</span>';
				$('#keywordCheck').empty();
				$('#keywordCheck').append(html);
			}else{
				$('#keywordRegistFrm').submit();
			}
		})
		
		$('.deleteBtn').on('click',function(){
			$(this).parent().submit();
		})

	})
	
	
	
	/* pagination 페이지 링크 function */
	function linkPage(pageNo){
		var pageUnit = $('#sort').val()==null? 10 : $('#sort').val();
		document.location = "/talent/keywordManage.do?pageIndex="+pageNo+"&talentSq=${talentVO.talentSq }&pageUnit="+pageUnit;
	}
	
	/* 검색 */
	function search(){
		var searchKeyword = $('#searchKeyword').val();
		var pageUnit = $('#sort').val()==null? 10 : $('#sort').val();
		document.location = "/talent/keywordManage.do?talentSq=${talentVO.talentSq }&pageUnit="+pageUnit+"&searchKeyword="+searchKeyword;
	
	}
	
</script>
</head>
<body>
<h1>인재상 관리</h1>
	<div class="contentBox">
		<div class="updateTalent">
			<h3>인재상</h3>
			<form id="talentUpdateFrm" action="${cp }/talent/update.do" method="post">
				<input type="hidden" class="talentSq" name="talentSq" value="${talentVO.talentSq }">
				<input type="text" id="talentNm" class="talentNm" name="talentNm" value="${talentVO.talentNm }">
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
				<a id="talentUpdateBtn">수정</a>
			</form>
			<div id="talentCheck">&nbsp;</div>
		</div>
	</div>
	<div class="contentBox">
		<div class="keyword">
		<h3>키워드 등록</h3>
		<form id="keywordRegistFrm" action="/keyword/create.do" method="post">
			<input type="hidden" class="talentSq" name="talentSq" value="${talentVO.talentSq }">
			<input type="text" id="keywordContent" name="keywordContent">
			<a id="registBtn">등록</a>
		</form>
		<div id="keywordCheck">&nbsp;</div>
		<br>
		<h3>키워드 목록</h3>
		<div class="menu">
			<div class="excelmenu">
				<a class="excelBtn" href="${cp }/keyword/list/excelDown.do?talentSq=${talentVO.talentSq}">↓ excel다운로드</a> 
				<span class="excelBtn" id="massiveCreate">↑ 일괄등록</span>
				<!-- excel file 읽어오기 -->
			    <form id="massiveForm" name="massiveForm" enctype="multipart/form-data" method="post" action="<c:url value="${cp }/keyword/massiveCreateProcess.do?talentSq=${talentVO.talentSq}"/>" >
			        <input type="file" name="excelFile" />
			    </form>
			</div>
			<div class="listmenu">
				<select id="sort">
					<c:forEach var="value" begin="5" end="20" step="5">
						<c:choose>
							<c:when test="${pageUnit == value  }">
								<option value="${value }" selected="selected" >${value }개씩</option>
							</c:when>
							<c:otherwise>
								<option value="${value }" >${value }개씩</option>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</select> 
				<div id="search">
					<input type="text" id="searchKeyword" >
					<span class="btn btn-primary">
		        	 	<a class="searchBtn" href="javascript:search();">검색</a>
		            </span>
				</div>
			</div>
		</div>
		<br>
		<br>
		<div class="existKeyword" id="keywordList">
			<c:forEach items="${resultList }" var="keyword">
				<form class="talentUpdateFrm" action="${cp }/keyword/delete.do" method="post">
					<input type="hidden" name="talentSq" value="${talentVO.talentSq}">
					<input type="hidden" name="keywordSq" value="${keyword.keywordSq}">
					<input type="text" class="keywordContent" name="keywordContent" value="${keyword.keywordContent}">
					<a class="deleteBtn">삭제</a>
				</form>
			</c:forEach>
		</div>
		<div id="paging">
			<!-- 페이지번호 -->
			<ul>
				<c:forEach var="i" begin="${paginationInfo.firstPageNoOnPageList }" end="${paginationInfo.lastPageNoOnPageList }">
					<li class="page">
						<c:choose>
							<c:when test="${paginationInfo.currentPageNo == i }">
								<span style="font-weight:bold;">${i }</span>
							</c:when>
							<c:otherwise>
								<span onclick="linkPage(${i})">${i }</span>
							</c:otherwise>
						</c:choose>
					</li>
				</c:forEach>
			</ul>
				</div>
			</div>
	</div>
</body>
</html>