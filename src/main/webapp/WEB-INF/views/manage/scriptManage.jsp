<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/WEB-INF/views/layout/commonLib.jsp" %>
<title>AI_INTERVIEW</title>
</head>

<style>
body{
		background-color : #f5f7fb;
	}
	
	.updateBtn,  #regBtn, .searchBtn{
		display: inline-block;
		vertical-align : top;
		border: 1px solid #000d22;
		border-radius: 5px;
		height: 29px;
		width: 100px;
		text-align: center;
	}

	#regBtn:hover, .updateBtn:hover, .searchBtn:hover{
	    background-color: #000d22;
	    color: #fff;
	}
	
	.updateBtn{
		width: 50px;
	}
	.updateForm {
		margin: 10px 0px;
	}
	.searchBtn{
		width: 80px;
	}

	.excelBtn{
		display: inline-block;
		border: 1px solid #000d22;
		border-radius: 5px;
		padding: 1px 5px;
	}
	
	.excelBtn:hover{
	    background-color: #22741C;
	    border: 1px solid #22741C;
	    color: #fff;
	}
	
	#scriptContent, .scriptContent, .custom-input{
		width: 50%;
		border: 1px solid #000d22;
		border-radius: 5px;
		height: 30px;
		padding: 0px 10px;
	}
	
	.scriptContent{
		width : 53.5%;
	}
		
	#status, .custom-select, .scriptSt, #sort, .scriptGbSq{
		border: 1px solid gray;
		border-radius: 5px;
		height: 30px;
		vertical-align: top;
	}
	
	.input-group{
		display: inline-block;
		float: right;
		margin-right: 25%;
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
</style>

<script type="text/javascript" language="javascript" defer="defer">
$(document).ready(function() {
	$('#regBtn').on('click', function() {
		if($('#scriptContent').val()==''){
			var html = '⚠  스크립트를 입력해주세요!';
			$('#check').append(html);
		}else{
			$('#regForm').submit();
		}
	});
	
});

	$('#massiveCreate').on('click',function(){
		$('input[type="file"]').click();
	});
	
	$('input[type="file"]').on('change',function(){
		$('#massiveForm').submit();
	});
	
	$('.updateBtn').on('click', function(){
		if($('.scriptContent').val()==""){
			$('.scriptContent').attr("placeholder", "스크립트를 입력해주세요.");
		}else{
			$(this).parent('form').submit();
		}
	});
	
	$('#sort').on('change',function(){
		pageUnit = $(this).val();
		document.location="/script/retrievePagingList.do?pageUnit="+pageUnit;
	});
	
 /* pagination 페이지 링크 function */
function linkPage(pageNo){
	document.listForm.pageIndex.value = pageNo;
	document.listForm.action = "<c:url value='/script/retrievePagingList.do'/>";
   	document.listForm.submit();
}
 
/* 검색 */
function searchList(){
	document.listForm.action = "<c:url value='/script/retrievePagingList.do'/>";
   	document.listForm.submit();
}
</script>
<body>
<h1>스크립트 관리</h1>
<div class="contentBox">
	<h3>스크립트 등록</h3>
	<div class="registdiv">
		<form id="regForm" action="/script/createProcess.do" method="post">
			<input type="text" id="scriptContent" name="scriptContent" placeholder="스크립트" value="">
			<select id="status" name="scriptSt">
				<option value="Y" selected="selected">사용</option>
				<option value="N">미사용</option>
			</select>
			<a id="regBtn" class="manageBtn">스크립트 등록</a>
		</form>
		<span style="color:red" id="check"></span>
	</div>
</div>
	
<div class="contentBox">
	<h3>스크립트 목록</h3>
	<form:form commandName="scriptVO" id="listForm" name="listForm" method="get">
			<div class="blog-main">
				<div class="input-group">
		       		<ul class="button-search" id="uitest">
	        			<li>
	        			
	        			
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
							
							
	        				<form:select class="col-sm-1" path="searchCondition" cssClass="custom-select">
	        					<form:option value="0" label="내용" />
	        				</form:select>
	                        <form:input  path="searchKeyword" cssClass="custom-input"/>
	        	            <span class="btn btn-primary">
	        	                <a class="searchBtn" href="javascript:searchList();">검색</a>
	        	            </span>
	        	        </li>
	                </ul>
		       	</div>
			    
			    <div id="excelBox">
					<a class="excelBtn" href="/script/list/excelDown.do?scriptGbSq=${scriptGbVO.scriptGbSq}">↓ excel 다운로드</a> 
					<a class="excelBtn" id="massiveCreate">↑ 일괄등록</a>
					<!-- excel file 읽어오기 -->
				    <form id="massiveForm" name="massiveForm" enctype="multipart/form-data" method="post" action="<c:url value="script/massiveCreateProcess.do"/>" >
				        <input type="file" name="excelFile" hidden/>
				    </form>
				</div>
			    
			    <br>
			    
				<div class="table-responsive">
					<c:forEach items="${resultList }" var="script">
						<form class="updateFrm" action="/script/updateProcess.do" method="post">
							<input type="hidden" name="scriptSq" value="${script.scriptSq }">
							<input type="text" class="scriptContent" name="scriptContent" value="${script.scriptContent }">
							<select class="scriptGbSq" name="scriptGbSq">
							<c:forEach items="${scriptGbList }" var="scriptGb">
								<c:choose>
									<c:when test="${scriptGbVO.scriptGbSq==scriptGb.scriptGbSq }">
										<option value="${scriptGbVO.scriptGbSq }" selected="selected">${scriptGbVO.scriptGbContent }</option>
									</c:when>
									<c:otherwise>
										<option value="${scriptGb.scriptGbSq }">${scriptGb.scriptGbContent }</option>
									</c:otherwise>
								</c:choose>						
							</c:forEach>
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
							<button type="submit" class="updateBtn">수정</button>
						</form>
					</c:forEach>
				</div>
			
				<div class="paging">
					<ui:pagination  paginationInfo = "${paginationInfo}" type="image" jsFunction="linkPage"></ui:pagination>
					<form:hidden path="pageIndex" />
				</div>
			</div>
		</form:form>
	</div>
</body>
</html>