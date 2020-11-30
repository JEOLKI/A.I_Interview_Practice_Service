<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<%@ include file="/WEB-INF/views/layout/commonLib.jsp" %>

</head>

<script type="text/javascript">

	$(function(){
		$.ajax({url : "/list.do",
			method : "get",
			dataType : "json",
			success : function(data){
				var html = "";
				for(var i = 0; i< data.boardGubunList.length ; i++){
					var gubun = data.boardGubunList[i];
					if(gubun.gubunYn == "y"){
						
					html += '<li class="active"><a >'+gubun.gubunNm+'</a></li>';

					}
				};
				$('#boardGuList').append(html);
			}
		});	
	});
	
</script>



<body>

   <%@ include file="/WEB-INF/views/layout/header.jsp" %>

	<ul class="nav nav-sidebar" id="boardGuList">
		<li class="active"><a href="${cp }/boardGu/regist">게시판생성</a></li><br>
	</ul>

</body>
</html>