<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html5>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<%@ include file="/WEB-INF/views/layout/commonLib.jsp" %>
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>

<style type="text/css">
	
	.memId, .mem, .custom-input{
		width: 50%;
		border: 1px solid #000d22;
		border-radius: 5px;
		height: 30px;
		padding: 0px 10px;
	}
	.memId{
/* 		margin-left : 55px; */
	}
	
	#memAuth, .custom-select, .memAuth{
		border: 1px solid gray;
		border-radius: 5px;
		height: 30px;
		vertical-align: top;
	}
	
	.manageBtn, .updateBtn, .searchBtn{
		display: inline-block;
		background-color : white;
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
		padding: 30px;
	}
	
	.contentBox{
		width: 55%;
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
		margin-right: 21%;
		width: 600px;
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
	.updateBtn{
		width: 70px;
		float: right;
		margin-right: 32%;
    	margin-top: 10px;
	}
	.list{
		margin : 10px 0px;
	}
	#info{
		color:red;
	}
	
	
</style>

<script type="text/javascript" language="javascript" defer="defer">
	$(document).ready(function(){
		// 정렬 값에 따라 회원 출력개수 변경
		$('#sort').on('change',function(){
			pageUnit = $(this).val();
			document.location="/member/authorityManage.do?pageUnit="+pageUnit;
		})
		
		$('.updateBtn').on('click', function(){
			$(this).parent().submit();
		});
	})
	 /* pagination 페이지 링크 function */
    function linkPage(pageNo){
    	var pageUnit = $('#sort').val()==null? 10 : $('#sort').val();
    	console.log(pageUnit)
    	document.listForm.pageIndex.value = pageNo;
    	document.listForm.action = "<c:url value='/member/authorityManage.do?pageUnit="+pageUnit+"'/>";
       	document.listForm.submit();
    }
	 
	/* 검색 */
	function searchList(){
		document.listForm.action = "<c:url value='/member/authorityManage.do'/>";
       	document.listForm.submit();
	}
	
	/* 수정 */
	function updateList() {
		document.listForm.action = "<c:url value='/member/authorityChange.do'/>";
		document.listForm.submit();
	}
	
</script>
</head>
<body>
	<h1>회원 관리</h1>
	
	<div class="contentBox">
		<h3>관리자 권한 설정</h3>

		<form:form commandName="memberVO" id="listForm" name="listForm" method="get">
			<div class="blog-main">
				<div class="input-group">
		       		<ul class="button-search" id="uitest">
	        			<li style="margin-left: 2%;">
	        				<select id="sort" class="custom-select">
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
	        					<form:option value="0" label="아이디" />
	        				</form:select>
	                        <form:input  path="searchKeyword" cssClass="custom-input"/>
	        	            <span class="btn btn-primary">
	        	                <a class="searchBtn" href="javascript:searchList();">검색</a>
	        	            </span>
	        	        </li>
	                </ul>
		       	</div>
		       	
		       	<br>
			    <br>
			    
				<div class="table-responsive">
					<c:forEach items="${resultList }" var="member">
						<div class="list">
							<c:choose>
								<c:when test="${S_MEMBER.memId == member.memId}">
									<input type="text" class="memId" name="memIds" style="background: #D4F4FA;" value="${member.memId}" readonly="readonly">
								</c:when>
								<c:otherwise>
									<input type="text" class="memId" name="memIds" value="${member.memId}" readonly="readonly">
								</c:otherwise>
							</c:choose>
							<c:choose>
								<c:when test="${S_MEMBER.memId == member.memId}">
									<select class="memAuth" name="memAuths" style="width: 78px;">
										<c:choose>
											<c:when test="${member.memAuth == 'Y' }">
												<option value="Y" selected="selected">관리자</option>
											</c:when>
											<c:when test="${member.memAuth == 'C' }">
												<option value="C" selected="selected">상담사</option>
											</c:when>
											<c:otherwise>
												<option value="N" selected="selected">일반회원</option>
											</c:otherwise>
										</c:choose>
									</select>
								</c:when>
								<c:when test="${S_MEMBER.memId != member.memId}">
									<select class="memAuth" name="memAuths">
										<c:choose>
											<c:when test="${member.memAuth == 'Y' }">
												<option value="Y" selected="selected">관리자</option>
												<option value="C">상담사</option>
												<option value="N">일반회원</option>
											</c:when>
											<c:when test="${member.memAuth == 'C' }">
												<option value="C" selected="selected">상담사</option>
												<option value="N">일반회원</option>
												<option value="Y">관리자</option>
											</c:when>
											<c:otherwise>
												<option value="N" selected="selected">일반회원</option>
												<option value="Y">관리자</option>
												<option value="C">상담사</option>
											</c:otherwise>
										</c:choose>
									</select>
								</c:when>
							</c:choose>
							<div class="updateCheck" style="display: inline-block;">&nbsp;</div>
						</div>
					</c:forEach>
				</div>
				<a class="updateBtn" id="updateBtn" onclick="updateList()">수정</a>
				<br>
				<div class= "paging">
					<ui:pagination  paginationInfo = "${paginationInfo}" type="image" jsFunction="linkPage"/>
					<form:hidden path="pageIndex" />
				</div>
			</div>
		</form:form>
	</div>
</body>
</html>