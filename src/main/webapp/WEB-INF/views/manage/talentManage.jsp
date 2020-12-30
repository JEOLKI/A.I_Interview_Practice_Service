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
	body{
		background-color : #f5f7fb;
		padding: 30px;
	}
	
	#search{
		display: inline-block; 
	}
	
	.menu{
		margin-bottom: 80px;
	}
	.listmenu, .excelmenu{
		display: inline-block; 
	}
	.excelmenu{
		float: left;
	}
	.listmenu{
		float: right;
	    margin-right: 40.2%;
	}
	#talentRegistBtn, .updateBtn, .keywordMngBtn, .searchBtn{
		display: inline-block;
	    vertical-align: middle;
	    border: 1px solid #000d22;
	    border-radius: 5px;
	    height: 23px;
	    padding: 0px 10px;
	    text-align: center;
	    position: relative;
	    top: -2px;
	}
	
	#talentRegistBtn:hover, .updateBtn:hover, .keywordMngBtn:hover, .searchBtn:hover{
	    background-color: #000d22;
	    color: #fff;
	}
	.talentUpdateFrm {
		margin-top: 10px;
		margin-bottom: 10px;
	}
	
	
	.talentNm{
        width: 500px;
		padding-left: 10px;
	}
	
	.content__title{
		margin-bottom: 30px;
	}
	h1{
		font-weight:bold; 
	}
	#check{
		display: inline-block; 
		height: 20px;
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
	input{
		border-radius: 5px;
		border : 1px solid black;
	}
	.paging{
		text-align: center;
		margin-top: 30px;
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
	#sort{
		float:left;
		height: 25px;
	    border-radius: 5px;
	    border: 1px solid black;
	    margin-right: 3px;
	}
	#talentSt, .talentSt{
		height: 26px;
	    border-radius: 5px;
	    border: 1px solid gray;
	    position: relative;
	    top: -2px;
	}
	.excelBtn{
		display: inline-block;
		border: 1px solid #000d22;
		border-radius: 5px;
		padding:0px 5px;
	}
	.excelBtn:hover{
	    background-color: #22741C;
	    border: 1px solid #22741C;
	    color: #fff;
	}
	.list{
		margin : 10px 0px;
	}
	.updateBtn{
		width: 70px;
		float: right;
	 	margin-right: 40.3%;
	}
</style>

<script type="text/javascript" language="javascript" defer="defer">
	$(document).ready(function() {

	
		$('#talentRegistBtn').on('click', function() {
			if($('#talentNm').val()==''){
				var html = '<span style="color:red">**내용을 입력해주세요</span>';
				$('#check').empty();
				$('#check').append(html);
			}else{
				$('#talentRegistFrm').submit();
			}
		})
	
		$('.keywordMngBtn').on('click', function(){
			talentSq = $(this).attr("value");
			document.location="/talent/keywordManage.do?talentSq="+talentSq;
		})

		
		$('#massiveCreate').on('click',function(){
			$('input[type="file"]').click();
		})
		
		$('input[type="file"]').on('change',function(){
			$('#massiveForm').submit();
		})
		
		$('#sort').on('change',function(){
			pageUnit = $(this).val();
			document.location="/talent/retrievePagingList.do?pageUnit="+pageUnit;
		})
	
		$('.updateBtn').on('click',function(){
			talentNm = $(this).parent().find('.talentNm').val();
			$('.updateCheck').empty();
			if(talentNm ==''){
				var html = '<span style="color:red">**내용을 입력해주세요</span>';
				$(this).parent().find('.updateCheck').append(html);
			}else{
				$(this).parent().submit();
			}
		})
		
	})
	
	/* pagination 페이지 링크 function */
	function linkPage(pageNo){
		var pageUnit = $('#sort').val()==null? 10 : $('#sort').val();
		document.listForm.pageIndex.value = pageNo;
		document.listForm.action = "<c:url value='/talent/retrievePagingList.do?pageUnit="+pageUnit+"'/>";
	   	document.listForm.submit();
	}
	
	/* 검색 */
	function searchList(){
	document.listForm.action = "<c:url value='/talent/retrievePagingList.do'/>";
		document.listForm.submit();
	}
	
	/* 수정 */
	function updateList() {
		document.listForm.action = "<c:url value='/talent/updateProcess.do'/>";
		document.listForm.submit();
	}
</script>
</head>
<body>
	<h1>인재상 관리</h1>
		<div class="contentBox">
			<h3>인재상 등록</h3>
			<div class="registTalent">
				<form id="talentRegistFrm" action="${cp }/talent/createProcess.do" method="post">
					<input type="text" id="talentNm" name="talentNm" value="${param.talentNm }">
					<select id="talentSt" name="talentSt">
						<c:choose>
							<c:when test="${param.talentSt == Y }">
								<option value="Y" selected="selected">사용</option>
								<option value="N">미사용</option>
							</c:when>
							<c:otherwise>
								<option value="Y">사용</option>
								<option value="N" selected="selected">미사용</option>
							</c:otherwise>
						</c:choose>
					</select> 
					<a id="talentRegistBtn">등록</a>
				</form>
				<div id="check">&nbsp;</div>
			</div>
		</div>

		<div class="contentBox">
		<h3>인재상 목록</h3>
		<div class="menu">
			<div class="excelmenu">
				<a class="excelBtn" href="${cp }/talent/list/excelDown.do">↓ excel다운로드</a> 
				<span class="excelBtn" id="massiveCreate">↑ 일괄등록</span>
				<!-- excel file 읽어오기 -->
			    <form hidden id="massiveForm" name="massiveForm" enctype="multipart/form-data" method="post" action="<c:url value="${cp }/talent/massiveCreateProcess.do"/>" >
			        <input hidden type="file" name="excelFile" />
			    </form>
			</div>
			<form:form commandName="talentVO" id="listForm" name="listForm" method="post">
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
				<ul>
        			<label for="searchKeyword" style="visibility:hidden;display:none;"><spring:message code="search.keyword" /></label>
                        <form:input path="searchKeyword" cssClass="txt"/>
                     <span class="btn btn-primary">
        	         <a class="searchBtn" href="javascript:searchList();">검색</a>
        	         </span>
                </ul>
			</div>
			
		    </div>
		</div>
		<div class="existTalent" id="talentList">
			<c:forEach items="${resultList }" var="talent">
				<div class="list">
					<input type="hidden" name="talentSqs" value="${talent.talentSq}">
					<input type="text" class="talentNm" name="talentNms" value="${talent.talentNm}">
					<select class="talentSt" name="talentSts">
							<c:choose>
								<c:when test="${talent.talentSt == 'Y' }">
									<option value="Y" selected="selected">사용</option>
									<option value="N">미사용</option>
								</c:when>
								<c:otherwise>
									<option value="Y">사용</option>
									<option value="N" selected="selected">미사용</option>
								</c:otherwise>
							</c:choose>
						</select>
					<a class="keywordMngBtn" value="${talent.talentSq }">키워드 관리</a>
					<div class="updateCheck" style="display: inline-block;">&nbsp;</div>	
				</div>
			</c:forEach>
			<a class="updateBtn" onclick="updateList()">수정</a>
			<br>
		</div>
			<div id="paging"  class="paging">
				<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="linkPage" />
				<form:hidden path="pageIndex" />
			</div>
		</form:form>
		</div>	
</body>
</html>