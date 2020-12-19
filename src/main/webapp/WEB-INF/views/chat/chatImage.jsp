<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/layout/commonLib.jsp"%>
<style>
#image {
	position: fixed;
	z-index: 30;
/* 	bottom: 40px; */
/* 	left: 20px; */
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
	height : 475px;
}
.iwEgly{
	display: inline-flex;
    -webkit-box-align: center;
    align-items: center;
    -webkit-box-pack: center;
    justify-content: center;
    color: rgb(255, 255, 255);
    background-color: rgb(249, 13, 60);
    border: 1px solid rgb(255, 74, 74);
    font-weight: bold;
    font-family: NotoSansKR, NotoSansJP, -apple-system, BlinkMacSystemFont, "Helvetica Neue", "맑은 고딕", "Yu Gothic", "Segoe UI", Roboto, system-ui, sans-serif;
    box-sizing: border-box;
    flex-wrap: nowrap !important;
    animation: 0.2s cubic-bezier(0.1, 0, 0.6, 1) 0.55s 1 normal backwards running fcEaNs !important;
    box-shadow: rgba(0, 0, 0, 0.4) 0px 1px 2px 0px !important;
    font-size: 14px !important;
    border-radius: 12px !important;
    visibility: visible !important;
}

.alarm{
	position: fixed;
	z-index: 1;
	color : white;
	bottom: 78px;
	left: 55px;
}


.nav-counter {
 bottom: 8%;
 left: 5.5%;
 z-index: 10;
 position: fixed;
 min-width: 8px;
 height: 20px;
 line-height: 20px;
 margin-top: -11px;
 padding: 0 6px;
 font-weight: normal;
 font-size: small;
 color: white;
 text-align: center;
 text-shadow: 0 1px rgba(0, 0, 0, 0.2);
 background: #683db8;
 border: 1px solid #911f28;
 border-radius: 11px;
 background-image: -webkit-linear-gradient(top, #e8616c, #dd202f);
 background-image: -moz-linear-gradient(top, #e8616c, #dd202f);
 background-image: -o-linear-gradient(top, #e8616c, #dd202f);
 background-image: linear-gradient(to bottom, #e8616c, #dd202f);
 -webkit-box-shadow: inset 0 0 1px 1px rgba(255, 255, 255, 0.1), 0 1px rgba(0, 0, 0, 0.12);
 box-shadow: inset 0 0 1px 1px rgba(255, 255, 255, 0.1), 0 1px rgba(0, 0, 0, 0.12);
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
					$("#chatting").attr("style", "width : 350px");
				}
				else if("${S_MEMBER.memId}" == "" || "${S_MEMBER.memId}" == null){
					alert("로그인 후에 이용해주세요")
				}
				else{
					$("#chatting").attr("src", "/chat/chat.do");
					$("#chatting").attr("style", "display:block");
					$("#chatting").attr("style", "width : 300px;");
				}
		})
		var a = arlamCount()
		console.log(a)
		$("#arlamCount").val(a)
	
	})
function arlamCount(){
	var count;
	$.ajax({
		url : "/chat/arlamCount.do",
		type : 'GET',
		async : false,
		success : function(data){
			count = data;
		}
	})
	return count;
}
</script>


<img id="image" class=""
	src="/images/ch-new-symbol-powered.png" alt="버그"><span class="nav-counter" id="arlamCount">30</span> 
	
<!-- <div class="alarm iwEgly">100</div> -->
	
<iframe id="chatting"  src = ""  style="display:none; overflow: hidden"  >

</iframe>



