<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%@ include file="/WEB-INF/views/layout/commonLib.jsp" %>
<style type="text/css">
	#search{
		display: inline-block; 
	}
	.listmenu, .excelmenu{
		display: inline-block; 
	}
	.excelmenu{
		float: left;
	}
	.listmenu{
		float: right;
	    margin-right: 172px;
	}
	.menu{
		margin-bottom: 20px;
	}
	.body{
		margin : 30px;
	}
	
	.updateBtn{
		padding-left: 10px;
		padding-right: 10px;
		padding-top: 2px;
		padding-bottom: 2px;
	}
	
	.sampQuestUpdateFrm {
		margin-top: 10px;
		margin-bottom: 10px;
	}
	
	#sampQuestRegistBtn{
		padding-left: 10px;
		padding-right: 10px;
		padding-top: 2px;
		padding-bottom: 2px;
	}
	
	.sampQuestContent,#sampQuestContent{
		width: 600px;
		margin-bottom: 10px;
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
	#sampQuestRegistBtn, .updateBtn, .keywordMngBtn, .searchBtn{
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
	
	#sampQuestRegistBtn:hover, .updateBtn:hover, .keywordMngBtn:hover, .searchBtn:hover{
	    background-color: #000d22;
	    color: #fff;
	}
	#sort{
		float:left;
		height: 25px;
	    border-radius: 5px;
	    border: 1px solid black;
	    margin-right: 3px;
	}
	#sampQuestSt, .sampQuestSt, .questGbSq{
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
<script type="text/javaScript" language="javascript" defer="defer">
$(document).ready(function(){
	
	$('#sampQuestRegistBtn').on('click', function() {
		if($('#sampQuestContent').val()==''){
			var html = '<span style="color:red">**내용을 입력해주세요</span><br><br>';
			$('#check').empty();
			$('#check').append(html);
		}else{
			$('#sampQuestRegistFrm').submit();
		}
	})
	
		
	$('#massiveCreate').on('click',function(){
		$('input[type="file"]').click();
	})
	
	$('input[type="file"]').on('change',function(){
		$('#massiveForm').submit();
	})
	
	$('#sort').on('change',function(){
		pageUnit = $(this).val();
		document.location="/sampQuest/retrievePagingList.do?pageUnit="+pageUnit;
	})
	
	$('.updateBtn').on('click',function(){
		sampQuestContent = $(this).parent().find('.sampQuestContent').val();
		$('#updateCheck').empty();
		if(sampQuestContent ==''){
			var html = '<span style="color:red">**내용을 입력해주세요</span>';
			$('#updateCheck').append(html);
		}else{
			$(this).parent().submit();
		}
	})

		
})

/* pagination 페이지 링크 function */
function linkPage(pageNo){
	var pageUnit = $('#sort').val()==null? 10 : $('#sort').val();
	document.listForm.pageIndex.value = pageNo;
	document.listForm.action = "<c:url value='/sampQuest/retrievePagingList.do?pageUnit="+pageUnit+"'/>";
   	document.listForm.submit();
}

/* 검색 */
function searchList(){
document.listForm.action = "<c:url value='/sampQuest/retrievePagingList.do'/>";
	document.listForm.submit();
}
</script>
</head>
<body>
	<h1>샘플 질문 관리</h1>
		<div class="contentBox">
			<h3>샘플 질문 등록</h3>
			<div class="registSampleQuestion">
				<form id="sampQuestRegistFrm" action="${cp }/sampQuest/createProcess.do" method="post">
					<select id="questGbSq" class="questGbSq" name="questGbSq">
						<c:forEach items="${questGbList }" var="questGb">
							<option value="${questGb.questGbSq }">${questGb.questGbContent }</option>
						</c:forEach>
					</select>
					<input  type="text" id="sampQuestContent" name="sampQuestContent" value="${param.sampQuestContent }">
					<select id="sampQuestSt" name="sampQuestSt">
						<c:choose>
							<c:when test="${param.sampQuestSt == Y }">
								<option value="Y" selected="selected">사용</option>
								<option value="N">미사용</option>
							</c:when>
							<c:otherwise>
								<option value="Y">사용</option>
								<option value="N" selected="selected">미사용</option>
							</c:otherwise>
						</c:choose>
					</select>
					<a id="sampQuestRegistBtn">등록</a>
				</form>
				<div id="check"></div>
			</div>
		</div>			
		<div class="contentBox">
			<h3>샘플 질문 목록</h3>
			<form:form commandName="questionGubunVO" id="listForm" name="listForm" method="post">
			<div class="blog-main">
				<div class="menu">
					<div class="excelmenu">
						<a class="excelBtn" href="${cp }/sampQuest/list/excelDown.do">↓ excel다운로드</a> 
						<span  class="excelBtn" id="massiveCreate">↑ 일괄등록</span>
						<!-- excel file 읽어오기 -->
					    <form id="massiveForm" name="massiveForm" enctype="multipart/form-data" method="post" action="<c:url value="${cp }/sampQuest/massiveCreateProcess.do"/>" >
					        <input type="file" name="excelFile" hidden/>
					    </form>
					</div>
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
			        			<label for="searchKeyword" style="visibility:hidden;display:none;"></label>
			                        <form:input path="searchKeyword" cssClass="txt"/>
			                     <span class="btn btn-primary">
			        	        	<a class="searchBtn" href="javascript:searchList();">검색</a>
			        	         </span>
			                </ul>
						</div>
					</div>	
		    	</div>
		    	<br><br>
				<div class="existSampQuest" id="sampQuestList">
					<c:forEach items="${resultList }" var="sampQuest">
						<form class="sampQuestUpdateFrm" action="${cp }/sampQuest/updateProcess.do" method="post">
								<select class="questGbSq" name="questGbSq">
									<c:forEach items="${questGbList }" var="questGb">
										<c:choose>
											<c:when test="${sampQuest.questGbSq == questGb.questGbSq }">
												<option value="${questGb.questGbSq }" selected="selected">${questGb.questGbContent }</option>
											</c:when>
											<c:otherwise>
												<option value="${questGb.questGbSq }">${questGb.questGbContent }</option>
											</c:otherwise>
										</c:choose>
									</c:forEach>
								</select>
								<input type="hidden" name="sampQuestSq" value="${sampQuest.sampQuestSq}">
								<input type="text" class="sampQuestContent" name="sampQuestContent" value="<c:out value="${sampQuest.sampQuestContent}"/>">
								<select class="sampQuestSt" name="sampQuestSt">
									<c:choose>
										<c:when test="${sampQuest.sampQuestSt == 'Y' }">
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
								<div id="updateCheck" style="display: inline-block;">&nbsp;</div>
						</form>
					</c:forEach>
				</div>
				<div id="paging">
					<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="linkPage" />
					<form:hidden path="pageIndex" />
				</div>
			</div>	
			</form:form>
		</div>
</body>
</html>