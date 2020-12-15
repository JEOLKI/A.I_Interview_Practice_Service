<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%@ include file="/WEB-INF/views/layout/commonLib.jsp" %>
<style>
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
		margin-right: 373px;
	}
	#searchKeyword{
		height: 25px;
	    width: 200px;
	    position: relative;
	    top: 2px;
	}
	.updateBtn{
		padding-left: 10px;
		padding-right: 10px;
		padding-top: 2px;
		padding-bottom: 2px;
	}
	
	.questGbUpdateFrm {
		margin-top: 10px;
		margin-bottom: 10px;
	}
	
	#questGbRegistBtn{
		padding-left: 10px;
		padding-right: 10px;
		padding-top: 2px;
		padding-bottom: 2px;
	}
	
	.questGbContent{
		width: 400px;
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
		padding-left: 10px;
		width: 500px;
	}
	#questGbSt, .questGbSt, #sort{
	    height: 26.5px;
	    border-radius: 5px;
	    border: 1px solid gray;
	    position: relative;
	}
	#questGbSt, .questGbSt{
	    top: -1.5px;
	}
	#questGbRegistBtn, .updateBtn, .keywordMngBtn, .searchBtn{
		display: inline-block;
	    vertical-align: middle;
	    border: 1px solid #000d22;
	    border-radius: 5px;
	    height: 24px;
	    padding: 0px 10px;
	    text-align: center;
	    position: relative;
	    top: -2px;
	}
	.searchBtn{
	    top: 0px;
    	height: 25px;
    }
	#talentRegistBtn:hover, .updateBtn:hover, .keywordMngBtn:hover, .searchBtn:hover{
	    background-color: #000d22;
	    color: #fff;
	}
	.excelBtn{
		margin-top : 5px;
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
</style>
    <script type="text/javaScript" language="javascript" defer="defer">
	$(document).ready(function(){
		
		$('#questGbRegistBtn').on('click', function() {
			if($('#questGbContent').val()==''){
				var html = '<span style="color:red">**내용을 입력해주세요</span>';
				$('#check').empty();
				$('#check').append(html);
			}else{
				$('#questGbRegistFrm').submit();
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
			document.location="/questGb/retrievePagingList.do?pageUnit="+pageUnit;
		})
		
		$('#updateCheck').empty();
		
		$('.updateBtn').on('click',function(){
			questGbContent = $(this).parent().find('.updateContent').val();
			$('#updateCheck').empty();
			if(questGbContent ==''){
				var html = '<span style="color:red">**내용을 입력해주세요</span>';
				$('#updateCheck').append(html);
			}else{
				$('#questGbUpdateFrm').submit();
			}
		})
		
			
	})
	
	 /* pagination 페이지 링크 function */
        function linkPage(pageNo){
			var pageUnit = $('#sort').val()==null? 10 : $('#sort').val();
        	document.listForm.pageIndex.value = pageNo;
        	document.listForm.action = "<c:url value='/questGb/retrievePagingList.do?pageUnit="+pageUnit+"'/>";
           	document.listForm.submit();
        }
	
	/* 검색 */
	function searchList(){
		document.listForm.action = "<c:url value='/questGb/retrievePagingList.do'/>";
       	document.listForm.submit();
	}
	
</script>
</head>
<body>
	<h1>질문 구분 관리</h1>
		<div class="contentBox">
			<h3>직무 등록</h3>
				<div class="registQuestionGubun">
					<form id="questGbRegistFrm" action="${cp }/questGb/createProcess.do" method="post">
						<input  type="text" id="questGbContent" name="questGbContent" value="${param.questGb }">
						<select id="questGbSt" name="questGbSt">
							<c:choose>
								<c:when test="${param.questGbSt == Y }">
									<option value="Y" selected="selected">사용</option>
									<option value="N">미사용</option>
								</c:when>
								<c:otherwise>
									<option value="Y">사용</option>
									<option value="N" selected="selected">미사용</option>
								</c:otherwise>
							</c:choose>
						</select>
						<a id="questGbRegistBtn" >등록</a>
					</form>
					<div id="check">&nbsp;</div>
				</div>
		</div>
		    
		<div class="contentBox">
			<h3>직무 목록</h3>
			<form:form commandName="questionGubunVO" id="listForm" name="listForm" method="post">
				<div class="blog-main">
				    <div class="menu">
					    <div class="excelmenu">
							<a class="excelBtn" href="${cp }/questGb/list/excelDown.do">↓ excel다운로드</a> 
							<span class="excelBtn" id="massiveCreate">↑ 일괄등록</span>
							<!-- excel file 읽어오기 -->
						    <form id="massiveForm" name="massiveForm" enctype="multipart/form-data" method="post" action="<c:url value="${cp }/questGb/massiveCreateProcess.do"/>" >
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
				        			<label for="searchKeyword" style="visibility:hidden;display:none;"><spring:message code="search.keyword" /></label>
				                        <form:input path="searchKeyword" cssClass="txt"/>
				        	            <span class="btn_blue_l">
				        	                <a href="javascript:searchList();" class="searchBtn">검색</a>
				        	            </span>
				                </ul>
							</div>
				    	</div>
			    	</div>
			    	<br>
			    	<br>
					<div class="existQuestGb" id="questGbList">
						<c:forEach items="${resultList }" var="questGb">
							<form class="questGbUpdateFrm" action="${cp }/questGb/updateProcess.do" method="post">
								<input type="hidden" name="questGbSq" value="${questGb.questGbSq}">
								<input type="text" class="updateContent" class="questGbContent" name="questGbContent" value="<c:out value="${questGb.questGbContent}"/>">
								<select class="questGbSt" name="questGbSt">
									<c:choose>
										<c:when test="${questGb.questGbSt == 'Y' }">
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
					
					<div class= "paging">
						<ui:pagination  paginationInfo = "${paginationInfo}" type="image" jsFunction="linkPage"></ui:pagination>
						<form:hidden path="pageIndex" />
					</div>
				</div>
			</form:form>
		</div>
</body>
</html>