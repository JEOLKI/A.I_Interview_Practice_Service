<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/layout/commonLib.jsp"%>
<style>
#image {
	position: fixed;
	z-index: 30;
	bottom: 4%;
	left: 2%;
	width: 50px;
	cursor: pointer;
	overflow: hidden;
}
#chatting{
	border: 0px;
	position: fixed;
	z-index: 30;
	bottom: 4%;
	left: 2%;
	overflow: hidden;
}

</style>



<script>
	$(document).ready(function() {
		$("#image").on("click", function() {
				var url = ""
				var option = "width = 350, height = 500, top = 350, left = 150, location = no, toolbar=no, menubar=no, scrollbars=no, tatus=no "
				if('${S_MEMBER.memId}' == 'TEST_ID2'){
					$("#chatting").attr("src", "/chat/room.do");
					$("#chatting").attr("style", "display:block");
				}
				else if("${S_MEMBER.memId}" == "" || "${S_MEMBER.memId}" == null){
					alert("로그인 후에 이용해주세요")
				}
				else{
					$("#chatting").attr("src", "/chat/chat.do");
					$("#chatting").attr("style", "display:block");
				}
				
		})
		
		
	})
</script>

<img id="image" class="lfSkuP"
	src="/images/ch-new-symbol-powered.png" alt="버그">
	
<iframe id="chatting"  src = ""  style="display:none; overflow: hidden"  > 

</iframe>



