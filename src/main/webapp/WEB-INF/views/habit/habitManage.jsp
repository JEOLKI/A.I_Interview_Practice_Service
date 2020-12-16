<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/WEB-INF/views/layout/commonLib.jsp" %>
 <meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>

<style type="text/css">
	#search{
		display: inline-block; 
	}
	
	.menu{
		margin-bottom: 20px;
	}
	.listmenu, .excelmenu{
		display: inline-block; 
	}
	.excelmenu{
		float: left;
	}
	.listmenu{
		float: right;
		margin-right: 383px;
	}
	#habitRegistBtn, .updateBtn, .searchBtn{
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
	
	#habitRegistBtn:hover, .updateBtn:hover, .searchBtn:hover{
	    background-color: #000d22;
	    color: #fff;
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
	#sort{
		float:left;
		height: 25px;
	    border-radius: 5px;
	    border: 1px solid black;
	    margin-right: 3px;
	}
	#habitSt, .habitSt{
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
		
		$('.updateBtn').on('click',function(){
			habitGb = $(this).parent().find('.habitGb').val();
			$('#updateCheck').empty();
			if(habitGb ==''){
				var html = '<span style="color:red">**내용을 입력해주세요</span>';
				$('#updateCheck').append(html);
			}else{
				console.log("수정");
				$(this).parent().submit();
			}
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
	<h1>습관어 관리</h1>
		<div class="contentBox">
			<h3>습관어 등록</h3>
				<div class="registHabitGubun">
					<form id="habitRegistFrm" action="${cp }/habit/createProcess.do" method="post">
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
						<a id="habitRegistBtn">등록</a>
					</form>
					<div id="check">&nbsp;</div>
				</div>
		</div>
		<div class="contentBox">
			<h3>습관어 목록</h3>
				<form:form commandName="habitVO" id="listForm" name="listForm" method="post">
		
					<div class="menu">
					<div class="excelmenu">
						<a  class="excelBtn" href="${cp }/habit/list/excelDown.do">↓ excel다운로드</a> 
						<span class="excelBtn" id="massiveCreate">↑ 일괄등록</span>
						<!-- excel file 읽어오기 -->
					    <form hidden id="massiveForm" name="massiveForm" enctype="multipart/form-data" method="post" action="<c:url value="${cp }/sampQuest/massiveCreateProcess.do"/>" >
					        <input hidden type="file" name="excelFile" />
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
			                    <span class="btn btn-primary">
			        	        	<a class="searchBtn" href="javascript:searchList();">검색</a>
			        	        </span>
			                </ul>
						</div>
					</div>
					<br>	
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
									<a class="updateBtn" >수정</a>
									<div id="updateCheck" style="display: inline-block;">&nbsp;</div>
								</form>	
						</c:forEach>
					</div>
					<div id="paging">
						<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="linkPage" />
						<form:hidden path="pageIndex" />
					</div>
			</form:form>
		</div>
</body>
</html>