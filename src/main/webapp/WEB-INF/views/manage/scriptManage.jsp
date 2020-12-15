<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/WEB-INF/views/layout/commonLib.jsp" %>
<title>AI_INTERVIEW</title>
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
<script type="text/javascript" language="javascript">
$(document).ready(function() {
	$('#regBtn').on('click', function() {
		if($('#scriptContent').val()==''){
			var html = '내용을 입력해주세요';
			$('#check').append(html);
		}else{
			$('#regForm').submit();
		}
	});
	
	$('#searchBtn').on('click', function(){
		searchKeyword = $('#searchKeyword').val();
			document.location = "/scriptGubun/scriptManage.do?scriptGbSq=${scriptGbVO.scriptGbSq }&pageUnit="+pageUnit+"&searchKeyword="+searchKeyword;
		});
		$('#massiveCreate').on('click',function(){
			$('input[type="file"]').click();
		});
		
		$('input[type="file"]').on('change',function(){
			$('#massiveForm').submit();
		});
		
		$('#sort').on('change',function(){
			pageUnit = $(this).val();
			document.location="/scriptGubun/scriptManage.do?scriptGbSq=${scriptGbVO.scriptGbSq }&pageUnit="+pageUnit;
		});
		
		$('.updateBtn').on('click', function(){
			$(this).parent('form').submit();
		});
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

<h1>스크립트 관리</h1>
	
	<div class="contentBox">
		<h3>스크립트 등록</h3>
		<div class="registdiv">
			<form id="regForm" action="/script/createProcess.do" method="post" enctype="utf-8">
				<input type="text" id="scriptContent" name="scriptContent" placeholder="스크립트" value="">
				<select class ="scriptGbSq" id="scriptGbSq" name="scriptGbSq">
					<c:forEach items="${scriptGbList }" var="scriptGb">
						<option value="${scriptGb.scriptGbSq }">${scriptGb.scriptGbContent }</option>
					</c:forEach>
				</select>
				<select id="status" name="scriptSt">
					<option value="Y" selected="selected">사용</option>
					<option value="N">미사용</option>
				</select>
				<a id="regBtn" class="manageBtn">스크립트 등록</a>
				<span style="color:red" id="check"></span>
			</form>
		</div>
	</div>

	<div class="contentBox">
		<h3>스크립트 목록</h3>
		
		
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
					
					
					
					
				<div class="input-group">
		       		<ul class="button-search" id="uitest">
	        			<li>
		        			<select class="col-sm-1 custom-select">
		        				<option value="0">내용</option>
		        			</select>
							<input type="text" id="searchKeyword" class="custom-input"/>
							<span class="btn">
		        	                <a onclick="search()" class="searchBtn">검색</a>
		        	       	</span>
					    </li>
	                </ul>
		       	</div>
				<a class="excelBtn" href="/script/list/excelDown.do?scriptGbSq=${scriptGbVO.scriptGbSq}" style="position: relative;">↓ excel 다운로드</a> 
				<span id="massiveCreate" class="excelBtn">↑ 일괄등록</span>
				<!-- excel file 읽어오기 -->
			    <form hidden id="massiveForm" name="massiveForm" enctype="multipart/form-data" method="post" action="<c:url value="/script/massiveCreateProcess.do?scriptGbSq=${scriptGbVO.scriptGbSq}"/>" >
			        <input hidden type="file" name="excelFile" />
			    </form>
				<br>
				<br>
					
				
			
			
			<div class="table-responsive">
				<c:forEach items="${scriptList }" var="script">
					<form class="updateForm" action="/script/updateProcess.do" method="post" enctype="utf-8">
						<input type="hidden" name="scriptSq" value="${script.scriptSq }">
	 					<input type="text" class="scriptContent" name="scriptContent" value="${script.scriptContent }">
						<select class="scriptGbSq" name="scriptGbSq">
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
		        	    <a class="updateBtn">수정</a>
					</form>
				</c:forEach>
			</div>
			<div class= "paging">
					<ui:pagination  paginationInfo = "${paginationInfo}" type="image" jsFunction="linkPage"></ui:pagination>
			</div>
		</div>
	</div>
</body>
</html>