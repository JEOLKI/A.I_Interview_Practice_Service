<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/WEB-INF/views/layout/commonLib.jsp" %>
<title>AI_INTERVIEW</title>

<style type="text/css">
	input[type=file]{
		display : none;
	}
	body{
		background-color : #f5f7fb;
		margin : 30px;
	}
	.listmenu, .excelmenu{
		display: inline-block; 
	}
	.excelmenu{
		float: left;
	}
	.listmenu{
		float: right;
		margin-right: 33%;
	}
	#sort{
		float:left;
		top: -1px;
    	margin-right: 3px;
	}
	#search{
		display: inline-block; 
	}
	#scriptGbContent, .scriptGbContent, .custom-input{
		width: 50%;
		border: 1px solid #000d22;
		border-radius: 5px;
		height: 30px;
		padding: 0px 10px;
	}
	
	.excelBtn{
		display: inline-block;
		border: 1px solid #000d22;
		border-radius: 5px;
		padding: 1px 5px;
		float: left;
	}
		
	.excelBtn:hover{
	    background-color: #22741C;
	    border: 1px solid #22741C;
	    color: #fff;
	}
	
	#status, .custom-select, .scriptGbSt{
		border: 1px solid gray;
		border-radius: 5px;
		height: 30px;
		vertical-align: top;
	}
	
	.updateBtn{
		width: 70px;
		float: right;
		margin-right: 33%;
    	margin-top: 10px;
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
	
	.scriptGbUpdForm {
	margin: 10px 0px;
	}
	
	.searchBtn{
		width: 80px;
	}

	.updateBtn, .manageBtn, .searchBtn{
		display: inline-block;
		vertical-align : top;
		border: 1px solid #000d22;
		border-radius: 5px;
		height: 29px;
		width: 100px;
		text-align: center;
	}
	
	.updateBtn:hover, .manageBtn:hover, .searchBtn:hover{
	    background-color: #000d22;
	    color: #fff;
	}
	
	.paging{
		text-align: center;
		margin-top: 60px;
	    position: relative;
	    right: 20%;
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
	.list{
		margin : 10px 0px;
	}
</style>

<script type="text/javascript" language="javascript" defer="defer">
$(document).ready(function(){
		$('#regBtn').on('click', function() {
			if($('#scriptGbContent').val()==''){
				var html = '⚠  스크립트 구분명을 입력해주세요!';
				$('#check').append(html);
			}else{
				$('#regForm').submit();
			}
		});
		
		$('.scriptMngBtn').on('click', function(){
			scriptGbSq= $(this).attr("value");
			document.location="/scriptGubun/scriptManage.do?scriptGbSq="+scriptGbSq;
			});
		
		$('#massiveCreate').on('click',function(){
			$('input[type="file"]').click();
		});
		
		$('input[type="file"]').on('change',function(){
			$('#massiveForm').submit();
		});
		
		$('.scriptGbupdBtn').on('click', function(){ 
			$('.updateCheck').empty();
			if($(this).parent().find('.scriptGbContent').val()==""){
				$(this).parent().find('.updateCheck').append('<span style="color:red">스크립트 구분명을 입력해주세요.</span>');
			}else{
				$(this).parent('form').submit();
			}
		});
		
		$('#sort').on('change',function(){
			pageUnit = $(this).val();
			document.listForm.pageIndex.value = '1';
			document.listForm.action = "<c:url value='/scriptGubun/retrievePagingList.do?pageUnit="+pageUnit+"'/>";
			document.listForm.submit();
		});
})

/* pagination 페이지 링크 function */
function linkPage(pageNo) {
	var pageUnit = $('#sort').val() == null ? 10 : $('#sort').val();
	document.listForm.pageIndex.value = pageNo;
	document.listForm.action = "<c:url value='/scriptGubun/retrievePagingList.do?pageUnit="+ pageUnit + "'/>";
	document.listForm.submit();
}

/* 검색 */
function searchList() {
	var pageUnit = $('#sort').val()==null? 10 : $('#sort').val();
	document.listForm.searchUseYn.value = 'Y';
	document.listForm.pageIndex.value = '1';
	document.listForm.action = "<c:url value='/scriptGubun/retrievePagingList.do?pageUnit="+pageUnit+"'/>";
	document.listForm.submit();
}

/* 수정 */
function updateList() {
	document.listForm.action = "<c:url value='/scriptGubun/updateProcess.do'/>";
	document.listForm.submit();
}
</script>
</head>
<body>

<h1>스크립트 구분 관리</h1>
	<div class="contentBox">
		<h3>스크립트 구분 등록</h3>
			<div class="registScriptGubun">
				<form id="regForm" action="/scriptGubun/createProcess.do" method="post">
					<input type="text" id="scriptGbContent" name="scriptGbContent" placeholder="스크립트 구분" value="">
					<select id="status" name="scriptGbSt">
						<option value="Y" selected="selected">사용</option>
						<option value="N">미사용</option>
					</select>
					<a id="regBtn" class="manageBtn">등록</a>	
				</form>
				<span style="color:red" id="check"></span>
			</div>
		</div>
		
		<div class="contentBox">
		<h3>스크립트 구분 목록</h3>
		<div class="blog-main">
			<div class="excelmenu">
				<a class="excelBtn" href="/scriptGubun/list/excelDown.do">↓ excel 다운로드</a>
				<span class="excelBtn" id="massiveCreate">↑ 일괄등록</span>
				<form id="massiveForm" name="massiveForm" enctype="multipart/form-data" method="post" action="<c:url value="/scriptGubun/massiveCreateProcess.do"/>">
					<input type="file" name="excelFile"/>
				</form>
			</div>
			<form:form commandName="scriptGubunVO" id="listForm" name="listForm" method="post">
			<div class="listmenu">
				<select id="sort" class="custom-select">
					<c:forEach var="value" begin="5" end="20" step="5">
						<c:choose>
							<c:when test="${pageUnit == value  }">
								<option value="${value }" selected="selected">${value }개씩</option>
							</c:when>
							<c:otherwise>
								<option value="${value }">${value }개씩</option>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</select>
				<div id="search">
        			<label for="searchKeyword" style="visibility:hidden;display:none;"></label>
                        <form:input path="searchKeyword" cssClass="txt"/>
                     <span class="btn btn-primary">
        	        	<a class="searchBtn" href="javascript:searchList();">검색</a>
        	        	<form:hidden path="searchUseYn" />
        	         </span>
				</div>
			</div>
		</div>
		<br>
		<br>

		<div class="table-responsive">
			<c:forEach items="${scriptGbList }" var="scriptGb">
				<div class="list">
				<input type="hidden" name="scriptGbSqs" value="${scriptGb.scriptGbSq }" />
				<input type="text" class="scriptGbContent" name="scriptGbContents" value="${scriptGb.scriptGbContent }"/>
				<select class="scriptGbSt" name="scriptGbSts">
					<c:choose>
						<c:when test="${scriptGb.scriptGbSt=='Y'}">
							<option value="Y" selected="selected">사용</option>
							<option value="N">미사용</option>
						</c:when>
						<c:otherwise>
							<option value="Y">사용</option>
							<option value="N" selected="selected">미사용</option>
						</c:otherwise>
					</c:choose>
				</select>
				<a type="button" class="manageBtn scriptMngBtn" value="${scriptGb.scriptGbSq }">스크립트 관리</a>
				<div class="updateCheck" style="display: inline-block;">&nbsp;</div>
				</div>	
		</c:forEach>
		<a class="updateBtn" onclick="updateList()" >수정</a>
		<br>
		<div class= "paging">
			<ui:pagination  paginationInfo = "${paginationInfo}" type="image" jsFunction="linkPage"></ui:pagination>
			<form:hidden path="pageIndex" />
		</div>
		</form:form>
	</div>
</div>
</body>
</html>