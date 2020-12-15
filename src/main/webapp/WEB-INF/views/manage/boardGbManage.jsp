<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<%@ include file="/WEB-INF/views/layout/commonLib.jsp" %>

<script type="text/javascript" language="javascript" defer="defer">
	
	$(document).ready(function() {
	
		$('#boardGbRegBtn').on('click', function() {
			$('#check').empty();
			if($('#boardGbNm').val()==''){
				var html = '내용을 입력해주세요';
				$('#check').append(html);
			}else{
				$('#boardGubunRegistFrm').submit();
			}
		})
		
		$('.categoryMngBtn').on('click', function(){
			boardGbSq= $(this).val();
			console.log(boardGbSq);
			document.location="/category/retrievePagingList.do?boardGbSq="+boardGbSq;
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
    	document.listForm.action = "<c:url value='/boardGubun/retrievePagingList.do'/>";
       	document.listForm.submit();
    }
	 
	/* 검색 */
	function searchList(){
		document.listForm.action = "<c:url value='/boardGubun/retrievePagingList.do'/>";
       	document.listForm.submit();
	}
	
</script>

<style type="text/css">
	
	#boardGbNm, .boardGbNm, .custom-input{
		width: 50%;
		border: 1px solid #000d22;
		border-radius: 5px;
		height: 30px;
		padding: 0px 10px;
	}
	
	#boardGbSt, .custom-select, .boardGbSt{
		border: 1px solid gray;
		border-radius: 5px;
		height: 30px;
		vertical-align: top;
	}
	
	.manageBtn, .updateBtn, .searchBtn{
		display: inline-block;
		vertical-align : top;
		border: 1px solid #000d22;
		border-radius: 5px;
		height: 29px;
		width: 100px;
		text-align: center;
	}
	
	.updateBtn{
		width: 50px;
	}
	
	.manageBtn:hover, .updateBtn:hover, .searchBtn:hover{
	    background-color: #000d22;
	    color: #fff;
	}
		
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
		margin-right: 25%;
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
	
	.updateFrm{
		margin: 10px 0px;
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
	
	
</style>


</head>
<body>
	<h1>게시판 관리</h1>
	
	<div class="contentBox">
		<h3>게시판 등록</h3>
		<div class="registdiv">
			<form id="boardGubunRegistFrm" action="${cp }/boardGubun/create.do" method="post">
				<input type="text" id="boardGbNm" name="boardGbNm" placeholder="게시판 이름" value="">
				<select id="boardGbSt" name="boardGbSt">
					<option value="Y" selected="selected">사용</option>
					<option value="N">미사용</option>
				</select>
				<a id="boardGbRegBtn" class="manageBtn">게시판 등록</a>
				<span style="color:red" id="check"></span>
			</form>
		</div>
	</div>
	
	<div class="contentBox">
		<h3>게시판 목록</h3>

		
		<form:form commandName="boardGubunVO" id="listForm" name="listForm" method="get">
			<div class="blog-main">
				<div class="input-group">
		       		<ul class="button-search" id="uitest">
	        			<li>
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
					<a class="excelBtn" href="${cp }/boardGubun/list/excelDown.do">↓ excel 다운로드</a> 
					<a class="excelBtn" id="massiveCreate">↑ 일괄등록</a>
					<!-- excel file 읽어오기 -->
				    <form id="massiveForm" name="massiveForm" enctype="multipart/form-data" method="post" action="<c:url value="${cp }/boardGubun/massiveCreateProcess.do"/>" >
				        <input type="file" name="excelFile" hidden/>
				    </form>
				</div>
			    
			    <br>
			    
				<div class="table-responsive">
					<c:forEach items="${resultList }" var="boardGubun">
						<form class="updateFrm" action="${cp }/boardGubun/update.do" method="post">
							<input type="hidden" name="boardGbSq" value="${boardGubun.boardGbSq}">
							<input type="text" class="boardGbNm" name="boardGbNm" value="${boardGubun.boardGbNm}">
							<select class="boardGbSt" name="boardGbSt">
									<c:choose>
										<c:when test="${boardGubun.boardGbSt == 'Y' }">
											<option value="Y" selected="selected">사용</option>
											<option value="N">미사용</option>
										</c:when>
										<c:otherwise>
											<option value="Y">사용</option>
											<option value="N" selected="selected">미사용</option>
										</c:otherwise>
									</c:choose>
							</select>
							<a type="submit" class="updateBtn">수정</a>
							<a type="button" class="categoryMngBtn manageBtn" value="${boardGubun.boardGbSq }">말머리 관리</a>
						</form>
					</c:forEach>
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