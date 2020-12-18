<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<%@ include file="/WEB-INF/views/layout/commonLib.jsp" %>

<script type="text/javascript" language="javascript" defer="defer">
	 /* pagination 페이지 링크 function */
    function linkPage(pageNo){
    	var pageUnit = $('#sort').val()==null? 10 : $('#sort').val();
    	document.listForm.pageIndex.value = pageNo;
    	document.listForm.action = "<c:url value='/member/authorityManage.do'/>";
       	document.listForm.submit();
    }
	 
	/* 검색 */
	function searchList(){
		document.listForm.action = "<c:url value='/member/authorityManage.do'/>";
       	document.listForm.submit();
	}
	
	$(document).ready(function(){
		// 정렬 값에 따라 회원 출력개수 변경
		$('#sort').on('change',function(){
			pageUnit = $(this).val();
			document.location="/member/authorityManage.do?pageUnit="+pageUnit;
		})
	})
	
</script>

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
		width : 100px;
	}
	
	
</style>


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
						<form class="updateFrm" action="/member/authorityChange.do" method="post">
							<c:choose>
								<c:when test="${member.memId != S_MEMBER.memId }">
									<input type="text" class="memId" name="memId" value="${member.memId}" readonly="readonly">
									<select class="memAuth" name="memAuth">
											<c:choose>
												<c:when test="${member.memAuth == 'Y' }">
													<option value="N" selected="selected">일반회원</option>
													<option value="Y">관리자</option>
												</c:when>
												<c:otherwise>
													<option value="Y" selected="selected">관리자</option>
													<option value="N">일반회원</option>
												</c:otherwise>
											</c:choose>
									</select>
									<button type="submit" class="updateBtn">권한 수정</button>
								</c:when>
							</c:choose>
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