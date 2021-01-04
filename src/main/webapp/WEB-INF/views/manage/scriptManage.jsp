<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/WEB-INF/views/layout/commonLib.jsp" %>
 <meta name="viewport" content="width=device-width, initial-scale=1">
<title>AI_INTERVIEW</title>

<style>
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
		margin-right: 32.3%;
	}
	#sort{
		float:left;
		top: -1px;
    	margin-right: 3px;
	}
	#search{
		display: inline-block; 
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
		float: left;
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
		width : 54.5%;
	}
	
	#scriptContent{
	    width: 51.5%;
	}
		
	#status, .custom-select, .scriptSt, #sort, .scriptGbSq{
		border: 1px solid gray;
		border-radius: 5px;
		height: 30px;
		vertical-align: top;
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
		position: relative;
    	right: 15%;	
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
	.updateBtn{
		width: 70px;
		float: right;
		margin-right: 32%;
    	margin-top: 10px;
	}
	.list{
		margin : 10px 0px;
	}
	.input-group{
		float : right;
		margin-right: 29%;
	}
	.table-responsive{
		margin-top: 30px;
	}
</style>

<script type="text/javascript" language="javascript" defer="defer">
var pageUnit = '';
$(document).ready(function() {
	$('#regBtn').on('click', function() {
		if($('#scriptContent').val()==''){
			var html = '스크립트를 입력해주세요.';
			$('#check').append(html);
		}else{
			$('#regForm').submit();
		}
	});
	
	$('#massiveCreate').on('click',function(){
		$('input[type="file"]').click();
	});
	
	$('input[type="file"]').on('change',function(){
		$('#massiveForm').submit();
	});
	
	$('.updateBtn').on('click', function(){
		$('.updateCheck').empty();
		if($(this).parent().find('.updateScriptContent').val()==""){
			$(this).parent().find('.updateCheck').append('<span style="color:red">스크립트를 입력해주세요.</span>');
		}else{
			$(this).parent().submit();
		}
	});
	
	$('#sort').on('change',function(){
		pageUnit = $(this).val();
		document.listForm.pageIndex.value = '1';
		document.listForm.action = "<c:url value='/scriptGubun/scriptManage.do?scriptGbSq=${scriptGbSq}&pageUnit="+pageUnit+"'/>";
		document.listForm.submit();
	});
});

 /* pagination 페이지 링크 function */
function linkPage(pageNo){
	var pageUnit = $('#sort').val() == null ? 10 : $('#sort').val();
	document.listForm.pageIndex.value = pageNo;
	document.listForm.action = "<c:url value='/scriptGubun/scriptManage.do?scriptGbSq=${scriptGbSq}&pageUnit="+ pageUnit + "'/>";
   	document.listForm.submit();
}

/* 검색 */
function searchList(){
	var pageUnit = $('#sort').val()==null? 10 : $('#sort').val();
	document.listForm.searchUseYn.value = 'Y';
	document.listForm.pageIndex.value = '1';
	document.listForm.action = "<c:url value='/scriptGubun/scriptManage.do?scriptGbSq=${scriptGbSq}&pageUnit="+pageUnit+"'/>";
	document.listForm.submit();
}
 
/* 수정 */
function updateList() {
	document.listForm.action = "<c:url value='/script/updateProcess.do'/>";
	document.listForm.submit();
}
</script>
</head>
<body>
	
<h1>스크립트 관리</h1>
<div class="contentBox">
	<h3>스크립트 등록</h3>
	<div class="registdiv">
		<form id="regForm" action="/script/createProcess.do" method="post">
			<input type="hidden" name="scriptGbSq" value="${scriptGbSq }">
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
			<div class="blog-main">
			    <div id="excelBox">
					<a class="excelBtn" href="/script/list/excelDown.do?scriptGbSq=${scriptGbVO.scriptGbSq}">↓ excel 다운로드</a> 
					<a class="excelBtn" id="massiveCreate">↑ 일괄등록</a>
					<!-- excel file 읽어오기 -->
					<form hidden id="massiveForm" name="massiveForm" enctype="multipart/form-data" method="post" action="<c:url value="${cp }/script/massiveCreateProcess.do?scriptGbSq=${scriptGbSq }"/>" >
			        	<input hidden type="file" name="excelFile" />
			   		</form>
				</div>
				<form:form commandName="scriptVO" id="listForm" name="listForm" method="post">
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
		        			<label for="searchKeyword" style="visibility:hidden;display:none;"></label>
		                        <form:input path="searchKeyword" cssClass="txt"/>
		                     <span class="btn btn-primary">
		        	        	<a class="searchBtn" href="javascript:searchList();">검색</a>
		        	        	<form:hidden path="searchUseYn" />
		        	         </span>
						</div>
			       	</div>
			    
			    
			    <br>
			    
					<div class="table-responsive">
						<input type="hidden" name="pageScriptGbSq" value="${scriptGbSq }">
						<c:forEach items="${resultList }" var="script">
							<div class="list">
								<input type="hidden" name="scriptSqs" value="${script.scriptSq }">
								<input type="text" class="scriptContent updateScriptContent" name="scriptContents" value="${script.scriptContent }">
								<select class="scriptGbSq" name="scriptGbSqs">
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
							
							<select class="scriptSt" name="scriptSts">
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
								<div class="updateCheck" style="display: inline-block;">&nbsp;</div>
							</div>	
						</c:forEach>
					</div>
					<a class="updateBtn" id="updateBtn" onclick="updateList()">수정</a>
					<br>
			
					<div class="paging">
						<ui:pagination  paginationInfo = "${paginationInfo}" type="image" jsFunction="linkPage"></ui:pagination>
						<form:hidden path="pageIndex" />
					</div>
			</form:form>
		</div>
	</div>
</body>
</html>