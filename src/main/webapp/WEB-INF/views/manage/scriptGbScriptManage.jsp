<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<%@ include file="/WEB-INF/views/layout/commonLib.jsp" %>
<title>Insert title here</title>
<style>
#search{
		display: inline-block; 
	}
	
	.menu{
		margin-bottom: 20px;
	}
	.body{
		margin : 30px;
	}
	#massiveCreate{
		margin-left: 20px;
	}

.updateBtn,  #regBtn{
		padding-left: 10px;
		padding-right: 10px;
		padding-top: 2px;
		padding-bottom: 2px;
	}
	
	.updateForm {
		margin-top: 10px;
		margin-bottom: 10px;
	}
	
	#scriptContent{
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
</style>
<script type="text/javascript" language="javascript" defer="defer">
$(document).ready(function() {
	
	
	$('#regBtn').on('click', function() {
		if($('#scriptContent').val()==''){
			var html = '<span style="color:red">**내용을 입력해주세요</span><br><br>';
			$('#check').empty();
			$('#check').append(html);
		}else{
			$('#regForm').submit();
		}
	});
	
	$('#searchBtn').on('click', function(){
		searchKeyword = $('#searchKeyword').val();
			document.location = "/scriptGubun/scriptManage.do?scriptGbSq=${scriptGbVO.scriptGbSq }&pageUnit="+pageUnit+"&searchKeyword="+searchKeyword;
		})
		$('#massiveCreate').on('click',function(){
			$('input[type="file"]').click();
		})
		
		$('input[type="file"]').on('change',function(){
			$('#massiveForm').submit();
		})
		
		$('#sort').on('change',function(){
			pageUnit = $(this).val();
			document.location="/scriptGubun/scriptManage.do?scriptGbSq=${scriptGbVO.scriptGbSq }&pageUnit="+pageUnit;
		})
});




/* pagination 페이지 링크 function */
function linkPage(pageNo){
	var pageUnit = $('#sort').val()==null? 10 : $('#sort').val();
	document.location = "/scriptGubun/scriptManage.do?pageIndex="+pageNo+"&scriptGbSq=${scriptGbVO.scriptGbSq }&pageUnit="+pageUnit;
}
	
	/* 검색 */
	function searchList(){
		var searchKeyword = $('#searchKeyword').val();
		var pageUnit = $('#sort').val()==null? 10 : $('#sort').val();
		document.location = "/scriptGubun/scriptManage.do?scriptGbSq=${scriptGbVO.scriptGbSq }&pageUnit="+pageUnit+"&searchKeyword="+searchKeyword;
	
	}
</script>
</head>
<body>
	<!-- 헤더 -->
	<div id="root">
		<div class="Main false">
			<%@ include file="/WEB-INF/views/layout/header.jsp"%>
			<%@ include file="/WEB-INF/views/manage/manageLeft.jsp" %> 
			<div class="w3-container managerbox" style="margin-left: 200px">
			<div class="body">
				<div class="content__title"><h1>스크립트</h1></div>
				
				<div class="registScript">
					<form id="regForm" action="/script/createProcess.do" method="post" enctype="utf-8">
						<input type="text" id="scriptContent" name="scriptContent">
						<select id="scriptGbSq" name="scriptGbSq">
							<c:forEach items="${scriptGbList }" var="scriptGb">
								<option value="${scriptGb.scriptGbSq }">${scriptGb.scriptGbContent }</option>
							</c:forEach>
						</select>
						<select id="status" name="scriptSt">
							<option value="Y" selected>활성화</option>
							<option value="N">비활성화</option>
						</select>
						<input id="regBtn" type="button" value="등록">
					</form>
					<div id="check"></div>
				</div>
				
				
				<hr>
				
				
				<div class="menu">
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
						<span onclick="search()">검색</span>
					</div>
					<a href="/script/list/excelDown.do?scriptGbSq=${scriptGbVO.scriptGbSq}">↓ 목록 내려받기</a> 
					<span id="massiveCreate">↑ 일괄등록</span>
					<!-- excel file 읽어오기 -->
				    <form hidden id="massiveForm" name="massiveForm" enctype="multipart/form-data" method="post" action="<c:url value="/script/massiveCreateProcess.do?scriptGbSq=${scriptGbVO.scriptGbSq}"/>" >
				        <input hidden type="file" name="excelFile" />
				    </form>
				</div>
			
			<div class="existScript" id="scriptList">
			<c:forEach items="${scriptList }" var="script">
				<form class="updateForm" action="/script/updateProcess.do" method="post" enctype="utf-8">
					<input type="hidden" name="scriptSq" value="${script.scriptSq }">
 					<input type="text" name="scriptContent" value="${script.scriptContent }">
					<select class="scriptGb" name="scriptGbSq">
						<option value="${scriptGbVO.scriptGbSq }" selected="selected">${scriptGbVO.scriptGbContent }</option>
					</select>
					
					<select class="scriptSt" name="scriptSt">
						<c:choose>
							<c:when test="${script.scriptSt=='Y' }">
								<option value="Y" selected="selected">사용</option>
 								<option value="N">미사용</option>
							</c:when>
							<c:otherwise>
								<option value="Y">사용</option>
 								<option value="N" selected="selected">미사용</option>
							</c:otherwise>
						</c:choose>
					</select>
					<button class="updateBtn" type="submit">수정</button>
				</form>
			</c:forEach>
			
			
			
			</div>
				<div id="paging">
							<ul id="pagination" class="pagination boarding">
								<!--  << -->
								<li class="page">
									<c:choose>
										<c:when test="${paginationInfo.currentPageNo == 1}">
											<span>&lt;&lt;</span>
										</c:when>
										<c:when test="${paginationInfo.currentPageNo > 1 }">
											<span onclick="linkPage(1)">&lt;&lt;</span>
										</c:when>
									</c:choose>
								</li>
								<!--  < -->
								<li class="page">
									<c:choose>
										<c:when test="${paginationInfo.currentPageNo == 1 }">
											<span >&lt;</span>
										</c:when>
										<c:when test="${paginationInfo.currentPageNo > 1}">
											<span onclick="linkPage(${paginationInfo.currentPageNo-1})">&lt;</span>
										</c:when>
									</c:choose>
								</li>
								<!-- 페이지번호 -->
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
									<!-- > -->
							<li class="page">
									<c:choose>
										<c:when test="${paginationInfo.currentPageNo == paginationInfo.totalPageCount }">
											<span >&gt;</span>
										</c:when>
										<c:when test="${paginationInfo.currentPageNo < paginationInfo.totalPageCount }">
											<span onclick="linkPage(${paginationInfo.currentPageNo+1})">&gt;</span>
										</c:when>
									</c:choose>
								</li>
								
								<!--  >> -->
								<li class="page">
							
									<c:choose>
										<c:when test="${paginationInfo.currentPageNo == paginationInfo.totalPageCount }">
											<span >&gt;&gt;</span>
										</c:when>
										<c:when test="${paginationInfo.currentPageNo < paginationInfo.totalPageCount }">
											<span onclick="linkPage(${paginationInfo.totalPageCount})">&gt;&gt;</span>
										</c:when>
									</c:choose>
								</li>
							</ul>
						</div>
			</div>
		</div>
		</div>
	</div>
</body>
</html>