<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<%@ include file="/WEB-INF/views/layout/commonLib.jsp" %>

<title>Insert title here</title>

<style type="text/css">
	#search{
		display: inline-block; 
	}
	
	.menu{
		margin-bottom: 20px;
	}
	.body{
		margin : 30px;
	}
	#massiveCreate{
		margin-left: 20px;
	}
	
	.updateBtn{
		padding-left: 10px;
		padding-right: 10px;
		padding-top: 2px;
		padding-bottom: 2px;
	}
	
	.habitUpdateFrm {
		margin-top: 10px;
		margin-bottom: 10px;
	}
	
	#habitRegistBtn{
		padding-left: 10px;
		padding-right: 10px;
		padding-top: 2px;
		padding-bottom: 2px;
	}
	
	.habitGb{
		width: 400px;
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
</style>

<script type="text/javascript" language="javascript" defer="defer">
	$(document).ready(function() {

	
	$('#habitRegistBtn').on('click', function() {
		if($('#habitGb').val()==''){
			var html = '<span style="color:red">**내용을 입력해주세요</span><br><br>';
			$('#check').empty();
			$('#check').append(html);
		}else{
			$('#habitRegistFrm').submit();
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
			document.location="/habit/retrievePagingList.do?pageUnit="+pageUnit;
		})
		
	})
	
	 /* pagination 페이지 링크 function */
	function linkPage(pageNo){
	var pageUnit = $('#sort').val()==null? 10 : $('#sort').val();
		document.listForm.pageIndex.value = pageNo;
		document.listForm.action = "<c:url value='/habit/retrievePagingList.do?pageUnit="+pageUnit+"'/>";
	   	document.listForm.submit();
	}
		
	/* 검색 */
	function searchList(){
		document.listForm.action = "<c:url value='/habit/retrievePagingList.do'/>";
       	document.listForm.submit();
	}
</script>
</head>
<body>
<form:form commandName="habitVO" id="listForm" name="listForm" method="post">
	<!-- 헤더 -->
	<div id="root">
		<div class="Main false">
			<div class="w3-container managerbox">
			<div class="body">
				<div class="content__title"><h1>습관어 관리</h1></div>

				<div class="registHabitGubun">
					<form id="habitRegistFrm" action="${cp }/habit/createProcess.do"
						method="post">
						<input type="text" id="habitGb" name="habitGb"
							value="${param.habitGb }">
						<select id="habitSt" name="habitSt">
							<c:choose>
								<c:when test="${param.habitSt == Y }">
									<option value="Y" selected="selected">사용</option>
									<option value="N">미사용</option>
								</c:when>
								<c:otherwise>
									<option value="Y">사용</option>
									<option value="N" selected="selected">미사용</option>
								</c:otherwise>
							</c:choose>
						</select> 
						<button type="button" id="habitRegistBtn">등록</button>
					</form>
					<div id="check"></div>
				</div>


				<hr>

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
					<div id="search">
						<ul>
		        			<label for="searchKeyword" style="visibility:hidden;display:none;"><spring:message code="search.keyword" /></label>
		                        <form:input path="searchKeyword" cssClass="txt"/>
		                    
		        	            <span class="btn_blue_l">
		        	                <a href="javascript:searchList();"><spring:message code="button.search" /></a>
		        	                <img src="<c:url value='/images/egovframework/example/btn_bg_r.gif'/>" alt=""/>
		        	            </span>
		                </ul>
					</div>

					<a href="${cp }/habit/list/excelDown.do">↓ 목록 내려받기</a> 
					<span id="massiveCreate">↑ 일괄등록</span>
					<!-- excel file 읽어오기 -->
				    <form hidden id="massiveForm" name="massiveForm" enctype="multipart/form-data" method="post" action="<c:url value="${cp }/sampQuest/massiveCreateProcess.do"/>" >
				        <input hidden type="file" name="excelFile" />
				    </form>
				</div>
				<div class="existHabit" id="habitList">
					<c:forEach items="${resultList }" var="habit">
						<form class="habitUpdateFrm" action="${cp }/habit/updateProcess.do" method="post">
							<input type="hidden" name="habitSq" value="${habit.habitSq}">
							<input type="text" class="habitGb" name="habitGb" value="${habit.habitGb}">
							<select class="habitSt" name="habitSt">
									<c:choose>
										<c:when test="${habit.habitSt == 'Y' }">
											<option value="Y" selected="selected">사용</option>
											<option value="N">미사용</option>
										</c:when>
										<c:otherwise>
											<option value="Y">사용</option>
											<option value="N" selected="selected">미사용</option>
										</c:otherwise>
									</c:choose>
								</select>
								<button type="submit" class="updateBtn" >수정</button>
							</form>	
					</c:forEach>
				</div>
				<div id="paging">
					<ul class="pagination boarding">
						<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="linkPage" />
						<form:hidden path="pageIndex" />
					</ul>
				</div>
			</div>
</div>
		</div>
	</div>
	</form:form>
</body>
</html>