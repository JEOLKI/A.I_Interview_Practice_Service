<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/WEB-INF/views/layout/commonLib.jsp" %>
<title>AI_INTERVIEW</title>

<style type="text/css">
	#massiveForm input{
		display: none;
	}
	.input-group {
			display: inline-block;
			float: right;
			margin-right: 25%;
	}
	
	body{
		background-color : #f5f7fb;
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
	
	.scriptGbupdBtn, .manageBtn, .searchBtn{
		display: inline-block;
		vertical-align : top;
		border: 1px solid #000d22;
		border-radius: 5px;
		height: 29px;
		width: 100px;
		text-align: center;
	}

	.scriptGbupdBtn{
		width: 50px;
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
	
	.scriptGbupdBtn:hover, .manageBtn:hover, .searchBtn:hover{
	    background-color: #000d22;
	    color: #fff;
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
$(document).ready(function(){
		$('#regBtn').on('click', function() {
			if($('#scriptGbContent').val()==''){
				var html = '내용을 입력해주세요';
				$('#check').empty();
				$('#check').append(html);
			}else{
				$('#regForm').submit();
			}
		});
		
		$('.scriptMngBtn').on('click', function(){
		scriptGbSq= $(this).attr("value");
		console.log(scriptGbSq);
		document.location="/scriptGubun/scriptManage.do?scriptGbSq="+scriptGbSq;
		});

		$('#massiveCreate').on('click',function(){
			$('input[type="file"]').click();
		});

		$('input[type="file"]').on('change',function(){
			$('#massiveForm').submit();
		});
		
		$('.scriptGbupdBtn').on('click', function(){
			$(this).parent('form').submit();
		});
		

// 		$('#sort').on('change',function(){
// 			pageUnit = $(this).val();
// 			document.location="/scriptGubun/retrievePagingList.do?pageUnit="+pageUnit;
// 		})
});
	
/* pagination 페이지 링크 function */
function linkPage(pageNo) {
	//var pageUnit = $('#sort').val() == null ? 10 : $('#sort').val();
	document.listForm.pageIndex.value = pageNo;
	document.listForm.action = "<c:url value='/scriptGubun/retrievePagingList.do'/>";
//	document.listForm.action = "<c:url value='/scriptGubun/retrievePagingList.do?pageUnit="+ pageUnit + "'/>";
	document.listForm.submit();
}

/* 검색 */
function searchList() {
	document.listForm.action = "<c:url value='/scriptGubun/retrievePagingList.do'/>";
	document.listForm.submit();
}
	
</script>
									
									


</head>
<body>
	<h1>스크립트 구분 관리</h1>
	<form:form commandName="scriptGubunVO" id="listForm" name="listForm" method="post">
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
				<span style="color:red" id="check"></span>
			</form>
		</div>
	</div>
						<div class="contentBox">
							<h3>스크립트 구분 목록</h3>
							
								<div class="blog-main">
<!-- 							<select id="sort"> -->
<%-- 								<c:forEach var="value" begin="5" end="20" step="5"> --%>
<%-- 									<c:choose> --%>
<%-- 										<c:when test="${pageUnit == value  }"> --%>
<%-- 											<option value="${value }" selected="selected">${value }개씩</option> --%>
<%-- 										</c:when> --%>
<%-- 										<c:otherwise> --%>
<%-- 											<option value="${value }">${value }개씩</option> --%>
<%-- 										</c:otherwise> --%>
<%-- 									</c:choose> --%>
<%-- 								</c:forEach> --%>
<!-- 							</select> -->

							<div id="search" class="input-group">
								<ul class="button-search" id="uitest">
									<li>
										<form:select class="col-sm-1" path="searchCondition" cssClass="custom-select">
	        								<form:option value="0" label="내용" />
	        							</form:select>
	        							
										<form:input path="searchKeyword" cssClass="custom-input"/>
										<span class="btn">
		        	               			 <a onclick="search()" class="searchBtn">검색</a>
		        	    			   	</span>
									</li>
								</ul>
							</div>
							
						<div id="excelBox">
							<a class="excelBtn" href="/scriptGubun/list/excelDown.do">↓ excel 다운로드</a>
							<span class="excelBtn" id="massiveCreate">↑ 일괄등록</span>
							<form id="massiveForm" name="massiveForm" enctype="multipart/form-data" method="post" action="<c:url value="/scriptGubun/massiveCreateProcess.do"/>">
								<input type="file" name="excelFile"/>
							</form>
						</div>

						<br>

						<div class="table-responsive">
							<c:forEach items="${scriptGbList }" var="scriptGb">
							<form class="scriptGbUpdForm" action="/scriptGubun/updateProcess.do" method="post">
								<input type="hidden" name="scriptGbSq" value="${scriptGb.scriptGbSq }" />
								<input type="text" class="scriptGbContent" name="scriptGbContent" value="${scriptGb.scriptGbContent }"/>
										<select class="scriptGbSt" name="scriptGbSt">
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
		        	    				<a class="scriptGbupdBtn" id="updateBtn">수정</a>
										<a type="button" class="manageBtn scriptMngBtn" value="${scriptGb.scriptGbSq }">스크립트 관리</a>
									</form>
							</c:forEach>
						</div>

						<div class= "paging">
					<ui:pagination  paginationInfo = "${paginationInfo}" type="image" jsFunction="linkPage"></ui:pagination>
					<form:hidden path="pageIndex" />
				</div>
				</div>
			</div>
	</form:form>
</body>
</html>