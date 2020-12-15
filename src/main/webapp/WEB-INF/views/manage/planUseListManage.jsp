<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>AI_INTERVIEW</title>

<%@ include file="/WEB-INF/views/layout/commonLib.jsp" %>

<script type="text/javascript">

/* pagination 페이지 링크 function */
function linkPage(pageNo){
	document.listForm.pageIndex.value = pageNo;
	document.listForm.action = "<c:url value='/plan/retrievePagingList.do'/>";
   	document.listForm.submit();
}
 
/* 검색 */
function searchList(){
	document.listForm.action = "<c:url value='/plan/retrievePagingList.do'/>";
   	document.listForm.submit();
}

</script>
<style>

	body{
		background-color : #f5f7fb;
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
	
	.custom-select{
		border: 1px solid gray;
		border-radius: 5px;
		height: 30px;
		vertical-align: top;
	}
	
	.custom-input{
		width: 50%;
		border: 1px solid #000d22;
		border-radius: 5px;
		height: 30px;
		padding: 0px 10px;
	}
	
	.searchBtn{
		display: inline-block;
		vertical-align : top;
		border: 1px solid #000d22;
		border-radius: 5px;
		height: 29px;
		width: 100px;
		text-align: center;
	}
	
	.searchBtn:hover{
	    background-color: #000d22;
	    color: #fff;
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
	
	.input-group{
		display: inline-block;
		float: right;
	}
	
	.table-responsive{
		margin-top: 30px;
		width: 100%;
	}
	
	.content-table{
		margin: 1%;
		width: 97%;
		border-collapse: collapse; 
	}
	
	.content-table th{
		border-bottom: 2px solid #4374D9;
		font-size: 1.1em;
		height: 50px;
		text-align: center;
	}
		
	.content-table td{
		height: 40px;
		text-align: center;
		border-bottom: 0.5px solid #4374D9;
	}
	
	.content-table td:first-child{
		width: 200px;
	}
	
	.content-table tr:hover{
		background-color: #4374D9;
	    color: #fff;
	}
	
	

</style>
</head>
<body>

	<h1>요금제 관리</h1>
	
	<div class="contentBox">
		<h3>결제 내역</h3>
		<form:form commandName="planUseVO" id="listForm" name="listForm" method="get">
			<div id="root boarding">
				<div class=" blog-main">
					<div class="input-group" >
				     	<ul>
				        	<li>
		        				<form:select cssClass="custom-select"  path="searchCondition">
		        					<form:option value="0" label="이용권" />
		        					<form:option value="1" label="아이디" />
		        					<form:option value="2" label="날짜" />
		        				</form:select>
		                        <form:input path="searchKeyword" cssClass="custom-input" />
		        	            <span class="btn btn-primary">
		        	                <a class="searchBtn"  href="javascript:searchList();">검색</a>
		        	            </span>
		        	        </li>
						</ul>
					</div>
					
					<div id="excelBox">
						<a class="excelBtn" href="/plan/planUseExcel.do">↓ excel 다운로드</a>  
					</div>
							
					<div class="table-responsive">
						<table class="content-table" id="dataTable">
							<thead>
								<tr>
									<th>구매일</th>
									<th>이용권</th>
									<th>회원 아이디</th>
									<th>결제 금액</th>
									<th>기간</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${resultList }" var="planuse">
									<tr>
									<td>${planuse.startDay }</td>	
									<td>${planuse.planNm }</td>
									<td>${planuse.memId } </td>
									<td>${planuse.fmtPlanPrice } </td>
									<td>${planuse.startDay } ~ ${planuse.endDay }</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
					
					<div class = "paging">
						<ui:pagination  paginationInfo = "${paginationInfo}" type="image" jsFunction="linkPage"></ui:pagination>
						<form:hidden path="pageIndex" />
					</div>
				
				</div>
			</div>
		</form:form>
	</div>
	
</body>
</html>