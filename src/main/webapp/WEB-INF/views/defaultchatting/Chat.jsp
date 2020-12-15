<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/WEB-INF/views/layout/commonLib.jsp" %>
<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.5/sockjs.min.js"></script>
	
<title>Insert title here</title>
<link rel="stylesheet" href="/css/Chatting.css">
</head>
<script>
$(document).ready(function() {
	chatAjax("${Receiver }");
	
});

function chatAjax(receiver){
	$.ajax({url : "/chat/chatListAjax.do",
		method : "post",
		data : { msgReceiver : receiver},
		dataType : "json",
		success : function(data){
			var html = "";
			console.log(data)
			for(var i = 0; i< data.chatList.length ; i++){
				var chat = data.chatList[i];                      
// 				html += ' <ul>                                              ';
				if("${S_MEMBER.memId }" == chat.msgSender){      
				html += ' 		<li><div  class="right">                                        ';
				html += ' 		<span>'+ chat.msgSender+''+ chat.msgDate+ '<br>       ';
				html += ' 		'+chat.msgContent+'</span>            ';
				html += ' 		</div></li>                        <br> <br><br>              ';
				}                                               
				else if("${S_MEMBER.memId }" == chat.msgReceiver){ 
				html += ' 		<li><div  class="left">                                        ';
				html += ' 		<span class="left">'+chat.msgSender+' 너<br>       ';
				html += ' 		'+chat.msgContent+'</span>            ';
				html += ' 		</div></li>                        <br> <br><br>              ';
				}                                          
// 				html += ' </ul>                                             ';
			}
			$("#Ulchatarea").html(html);
		
		}
	})
}


   

function create(receiver){
	$.ajax({url : "/chat/create.do",
		method : "post",
		data : { msgReceiver : receiver},
		dataType : "json",
		success : function(data){
			
			$("#chatarea").html(html);
		
		}
	})
}



</script>
<style>
	.left{
		float: left
	}
	.right{
		float: right
	}
	#chatarea{
		overflow:scroll;
		width:350px; 
		height:200px;

	}
</style>


<body>

<div id="one">
<input type="text" id="nickname" value="${S_MEMBER.memId }"  readonly="readonly" /> 
<input type="button" id="enter" value="채팅하기" />
</div>

<div id="two" style="display: none">

<input type="button" id="exit" value="나가기" /><br />

<div id="chatarea" class="" style="width:400px; height:600px; border:1px solid;">

<!-- 	<ul id = "Ulchatarea"> -->
	<ul>
		<li id = "Ulchatarea"></li>
		<li id="Ulchat" style="text-align: right;"></li>
	</ul>
</div>
		
<!-- 		<form action="/chat/create.do" method="POST">	 -->
		<input onkeyup="enterkey()" type="text" id="message" />
		<input type="submit" id="send" value="보내기" />
<!-- 		</form> -->
</div>
</body>






<script type="text/javascript">


one = document.getElementById("one");
two = document.getElementById("two");

document.getElementById("enter").addEventListener("click", function() {
//웹 소켓 연결해주는 함수 호출
connect();
});
document.getElementById("exit").addEventListener("click", function() {
//연결을 해제해주는 함수 호출
disconnect();
});
document.getElementById("send").addEventListener("click", function() {
//연결을 해제해주는 함수 호출
send();
});
var websocket;
//입장 버튼을 눌렀을 때 호출되는 함수

function connect(){
websocket = new SockJS("/chatting.do");
//웹 소켓에 이벤트가 발생했을 때 호출될 함수 등록
websocket.onopen = onOpen;
websocket.onmessage = onMessage;
websocket.onclose = onClose;

}

//보내기 버튼을 눌렀을 때 호출될 함수
function send(){
nickname = document.getElementById("nickname").value;
msg = document.getElementById("message").value;

websocket.send(nickname+"<br/>" +msg );
document.getElementById("message").value = "";
}

//웹 소켓에 연결되었을 때 호출될 함수
function onOpen(){
nickname = document.getElementById("nickname").value;
two = document.getElementById("two");
two.style.display='block';
websocket.send(nickname + "님 입장하셨습니다.");

enter = document.getElementById("enter");
enter.style.display='none';
}

//메시지가 출력될때 나오는 메시지
function onMessage(evt){
data= evt.data;
chatarea = document.getElementById("Ulchat");
chatarea.innerHTML = chatarea.innerHTML+"<br/>"  + data + "<br/>"
var chatarea = document.getElementById("chatarea"); 
chatarea.scrollTop = chatarea.scrollHeight;

// chatarea.append(data+ );
// chatarea.append()
// chatarea.append()
// $("#Ulchat").scrollTop($("#Ulchat")[0].scrollHeight);
// $('#msgArea').append("</div>");
// $("#msgArea").scrollTop($("#msgArea")[0].scrollHeight);
}

//퇴장 버튼을 눌렀을 때 호출되는 함수
function disconnect(){
msg = document.getElementById("nickname").value;
websocket.send(msg+"님이 퇴장하셨습니다");
websocket.close();
}


function onClose(){
}

function enterkey() {
    if (window.event.keyCode == 13) {
    	nickname = document.getElementById("nickname").value;
    	msg = document.getElementById("message").value;

    	websocket.send(nickname + ":"+ msg);
    	document.getElementById("message").value = "";
         
    }
}

</script>
</html>