<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<!--
This is a starter template page. Use this page to start your new project from
scratch. This page gets rid of all links and provides the needed markup only.
-->
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="x-ua-compatible" content="ie=edge">

<title>회원 리스트</title>


<%@ include file="/WEB-INF/views/layout/commonLib.jsp" %>

<script>

	// 해당 html이 로딩이 완료 되었을 때 실해오디는 이벤트 핸들러 함수
	$(document).ready(function() {

		memberList(1)

		// delegate 방식 : 이미 존재하는 태그(#memberList)에 이벤트를 거는것 
		$("#memberList").on("click", "tr", function() {
			//console.log("memberList tr click");

			// data-userid
			var userid = $(this).data("userid");
			console.log("userid : " + userid);

			document.location = "/member/member?userid=" + userid;

		});

		$('#regBtn').on('click', function(){
			document.location = "/member/regist";
		})

		$("#perPageNum").val("${param.pageSize == null ? '5' : param.pageSize}");
		$("#searchType").val("${param.searchType == null ? 'gubun' : param.searchType}");
		
		/* $("#perPageNum").on("change", function(){
			memberList(1)
		}); */

		$('#searchBtn').on('click', function(){

			if($("#searchType").val() == 'gubun' || $('#searchKeyWord').val() == ""){
				memberList(1);
			} else {
				searchList(1);
			}
		})
		
		
	});

	function memberList(p){
		$.ajax({url : "/member/list",
				data : {page : p, pageSize : $("#perPageNum").val()},
				method : "get",
				success : function(data){
					var i = 0;
					// memberList tbody 영역에 들어갈 html 문자열 생성
					var html = "";
					for(var i = 0; i < data.memberList.length ; i++){
						var member = data.memberList[i];
						html += "<tr data-userid='"+ member.userid +"'>";
						html += "	<td>"+ member.userid +"</td>";			
						html += "	<td>"+ member.usernm +"</td>";			
						html += "	<td>"+ member.alias +"</td>";			
						html += "	<td>"+ member.addr1 + member.addr2 +"</td>";			
						html += "	<td>"+ member.fmt_reg_dt +"</td>"; // value 객체에 설정
						html += "</tr>";
					}
					
					$("#memberList").html(html);

					//페이지 내비게이션 html 문자열 동적으로 생성하기
					var html = "";
					if(data.cpage == 1 ){
						html += '<li class="page-item active"><span class="page-link" href="#"><i class="fas fa-angle-double-left"></i></span></li>';
						html += '<li class="page-item active"><span class="page-link" href="#"><i class="fas fa-angle-left"></i></span></li>';
					} else {
						html += '<li class="page-item"><a class="page-link" href="javascript:memberList(1)"><i class="fas fa-angle-double-left"></i></a></li>';
						html += '<li class="page-item"><a class="page-link" href="javascript:memberList('+ (data.cpage-1) +')"><i class="fas fa-angle-left"></i></a></li>';
					}
					
					for(var i = 1 ; i <= data.pages ; i++){
						if(i == data.cpage){
							html += '<li class="page-item active"><span class="page-link">'+ i +'</span></li>';
						} else {
							html += '<li class="page-item"><a class="page-link" href="javascript:memberList('+i+');">'+ i +'</a></li>'; // <a href="javascript:memberListAjax(1);"/>
						}
					}

					if(data.cpage == data.pages ){
						html += '<li class="page-item active"><span class="page-link" href="#"><i class="fas fa-angle-right"></i></span></li>';
						html += '<li class="page-item active"><span class="page-link" href="#"><i class="fas fa-angle-double-right"></i></span></li>';
					} else {
						html += '<li class="page-item"><a class="page-link" href="javascript:memberList('+ (data.cpage+1) +')"><i class="fas fa-angle-right"></i></a></li>';
						html += '<li class="page-item"><a class="page-link" href="javascript:memberList('+ data.pages +')"><i class="fas fa-angle-double-right"></i></a></li>';
					}

					$("ul.pagination").html(html);
					
				}
		});
	}

	function searchList(p){
		$.ajax({
			url : '/member/search',
			data : { 
					searchType : $('#searchType').val(),
				 	searchKeyWord : $('#searchKeyWord').val(),
				 	page : p,
				 	pageSize : $("#perPageNum").val()
					},
			type : 'get',
			dataType : 'json',
			success : function(data) {
				
				var i = 0;
				// memberList tbody 영역에 들어갈 html 문자열 생성
				var html = "";
				for(var i = 0; i < data.memberList.length ; i++){
					var member = data.memberList[i];
					html += "<tr data-userid='"+ member.userid +"'>";
					html += "	<td>"+ member.userid +"</td>";			
					html += "	<td>"+ member.usernm +"</td>";			
					html += "	<td>"+ member.alias +"</td>";
					html += "	<td>"+ member.addr1 + member.addr2 +"</td>";			
					html += "	<td>"+ member.fmt_reg_dt +"</td>"; // value 객체에 설정
					html += "</tr>";
				}
				
				$("#memberList").html(html);

				//페이지 내비게이션 html 문자열 동적으로 생성하기
				var html = "";
				if(data.cpage == 1 ){
					html += '<li class="page-item active"><span class="page-link" href="#"><i class="fas fa-angle-double-left"></i></span></li>';
					html += '<li class="page-item active"><span class="page-link" href="#"><i class="fas fa-angle-left"></i></span></li>';
				} else {
					html += '<li class="page-item"><a class="page-link" href="javascript:searchList(1)"><i class="fas fa-angle-double-left"></i></a></li>';
					html += '<li class="page-item"><a class="page-link" href="javascript:searchList('+ (data.cpage-1) +')"><i class="fas fa-angle-left"></i></a></li>';
				}
				
				for(var i = 1 ; i <= data.pages ; i++){
					if(i == data.cpage){
						html += '<li class="page-item active"><span class="page-link">'+ i +'</span></li>';
					} else {
						html += '<li class="page-item"><a class="page-link" href="javascript:searchList('+i+');">'+ i +'</a></li>'; // <a href="javascript:memberListAjax(1);"/>
					}
				}

				if(data.cpage == data.pages ){
					html += '<li class="page-item active"><span class="page-link" href="#"><i class="fas fa-angle-right"></i></span></li>';
					html += '<li class="page-item active"><span class="page-link" href="#"><i class="fas fa-angle-double-right"></i></span></li>';
				} else {
					html += '<li class="page-item"><a class="page-link" href="javascript:searchList('+ (data.cpage+1) +')"><i class="fas fa-angle-right"></i></a></li>';
					html += '<li class="page-item"><a class="page-link" href="javascript:searchList('+ data.pages +')"><i class="fas fa-angle-double-right"></i></a></li>';
				}

				$("ul.pagination").html(html);
					
				
			}
		})


		
	}

</script>

</head>
<body class="hold-transition sidebar-mini">


</body>
</html>







