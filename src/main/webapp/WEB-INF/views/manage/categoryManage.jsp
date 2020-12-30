<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<%@ include file="/WEB-INF/views/layout/commonLib.jsp" %>

<script type="text/javascript">

	$(document).ready(function() {
		
		$('#categoryRegBtn').on('click', function() {
			if($('#catContent').val()==''){
				var html = '<span style="color:red">**내용을 입력해주세요</span><br><br>';
				$('#check').empty();
				$('#check').append(html);
			}else{
				$('#categoryRegistFrm').submit();
			}
		})

		
		$('#massiveCreate').on('click',function(){
			$('input[type="file"]').click();
		})
		
		$('input[type="file"]').on('change',function(){
			$('#massiveForm').submit();
		})
		
	})
	
	/* pagination 페이지 링크 function */
	function linkPage(pageNo){
		document.listForm.pageIndex.value = pageNo;
		document.listForm.action = "<c:url value='${cp }/category/retrievePagingList.do'/>";
	   	document.listForm.submit();
	}
	
	/* 검색 */
	function searchList(){
	document.listForm.action = "<c:url value='${cp }/category/retrievePagingList.do'/>";
		document.listForm.submit();
	}
	
	/* 수정 */
	function updateList(){
		document.listForm.action = "<c:url value='${cp }/category/update.do'/>";
       	document.listForm.submit();
	}


</script>

<style type="text/css">

	body{
		background-color : #f5f7fb;
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
	
	.input-group{
		display: inline-block;
		float: right;
		margin-right: 33%;
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
	
	#catContent, .catContent, .custom-input{
		width: 50%;
		border: 1px solid #000d22;
		border-radius: 5px;
		height: 30px;
		padding: 0px 10px;
	}
	
	.custom-select{
		border: 1px solid gray;
		border-radius: 5px;
		height: 30px;
		vertical-align: top;
	}
	
	#categoryRegBtn, .updateBtn, .searchBtn{
		display: inline-block;
		vertical-align : top;
		border: 1px solid #000d22;
		border-radius: 5px;
		height: 29px;
		width: 100px;
		text-align: center;
		background: white;
	}
	
	.updateBtn{
		display: inline-block;
		width: 50px;
		background: white;
		float: right;
		margin-right: 30%;
	}
	
	#categoryRegBtn:hover, .updateBtn:hover, .searchBtn:hover{
	    background-color: #000d22;
	    color: #fff;
	}
	
	.table-responsive{
		margin-top: 20px;
	}
	
	.inputBox{
		margin-top: 5px; 
	}

</style>

</head>
<body>

	<h1>말머리 관리</h1>
	
	<div class="contentBox">
		<h3>말머리 등록</h3>
		<div class="registdiv">
			<form id="categoryRegistFrm" action="${cp }/category/create.do" method="post">
				<input type="text" id="catContent" name="catContent" placeholder="말머리 이름" value="">
				<input type="hidden" name="boardGbSq" value="${boardGbSq }">
				<select id="catSt" name="catSt" class="custom-select">
					<option value="Y" selected="selected">사용</option>
					<option value="N">미사용</option>
				</select>
				<a id="categoryRegBtn" >말머리 등록</a>
				<span style="color:red" id="check"></span>
			</form>
		</div>
	</div>

	<div class="contentBox">
		<h3>말머리 목록</h3>
		
		<div id="excelBox">
			<a class="excelBtn" href="${cp }/category/list/excelDown.do?boardGbSq=${boardGbSq }">↓ excel 다운로드</a> 
			<a class="excelBtn" id="massiveCreate">↑ 일괄등록</a>
			<!-- excel file 읽어오기 -->
		    <form id="massiveForm" name="massiveForm" enctype="multipart/form-data" method="post" action="<c:url value="${cp }/category/massiveCreateProcess.do?boardGbSq=${boardGbSq }"/>" >
		        <input type="file" name="excelFile" hidden/>
		    </form>
		</div>
		
		<form:form commandName="categoryVO" id="listForm" name="listForm" method="get">
			<div class="blog-main">
				<div class="input-group">
		       		<ul class="button-search" id="uitest">
	        			<li>
	        				<form:select path="searchCondition" cssClass="custom-select">
	        					<form:option value="0" label="내용" />
	        				</form:select>
	                        <form:input  path="searchKeyword" cssClass="custom-input"/>
	        	            <span class="btn btn-primary">
	        	                <a class="searchBtn" href="javascript:searchList();">검색</a>
	        	            </span>
	        	        </li>
	                </ul>
		       	</div>
			    
			    <br>
			    
				<div class="table-responsive">
					<c:forEach var="i" begin="0" end="${ resultList.size()==0? resultList.size() : resultList.size()-1 }" step="1">
						<div class="inputBox">
							<c:choose>
								<c:when test="${ resultList.size()==0 }">
									게시판에 등록된 말머리가 없습니다.
								</c:when>
								<c:otherwise>
									<input type="hidden" name="catSqArr[${i }]" value="${resultList[i].catSq}">
									<input class="catContent" name="catContentArr[${i }]" value="${resultList[i].catContent}">
									<select class="catSt custom-select" name="catStArr[${i }]">
											<c:choose>
												<c:when test="${resultList[i].catSt == 'Y' }">
													<option value="Y" selected="selected">사용</option>
													<option value="N">미사용</option>
												</c:when>
												<c:otherwise>
													<option value="Y">사용</option>
													<option value="N" selected="selected">미사용</option>
												</c:otherwise>
											</c:choose>
									</select>
								</c:otherwise>
							</c:choose>
						</div>
					</c:forEach>
					<br>
					<input type="hidden" name="boardGbSq" value="${boardGbSq }">
					<a class="updateBtn" href="javascript:updateList();">수정</a>
				</div>
			
				<div class= "paging">
					<ui:pagination  paginationInfo = "${paginationInfo}" type="image" jsFunction="linkPage"></ui:pagination>
					<form:hidden path="pageIndex" />
				</div>
			</div>
		</form:form>
	</div>
</body>
</html>