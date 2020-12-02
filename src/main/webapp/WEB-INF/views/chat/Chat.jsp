<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.5/sockjs.min.js"></script>
<title>Insert title here</title>
<link rel="stylesheet" href="/css/Chatting.css">
</head>
<style>
	.left{
		float: left
	}
	.right{
		float: right
	}

</style>
<script>
const Chat = (function(){
    const myName = "blue";
 
    // init 함수
    function init() {
        // enter 키 이벤트
        $(document).on('keydown', 'div.input-div textarea', function(e){
            if(e.keyCode == 13 && !e.shiftKey) {
                e.preventDefault();
                const message = $(this).val();
 
                // 메시지 전송
                sendMessage(message);
                // 입력창 clear
                clearTextarea();
            }
        });
    }
 
    // 메세지 태그 생성
    function createMessageTag(LR_className, senderName, message) {
        // 형식 가져오기
        let chatLi = $('div.chat.format ul li').clone();
 
        // 값 채우기
        chatLi.addClass(LR_className);
        chatLi.find('.sender span').text(senderName);
        chatLi.find('.message span').text(message);
 
        return chatLi;
    }
 
    // 메세지 태그 append
    function appendMessageTag(LR_className, senderName, message) {
        const chatLi = createMessageTag(LR_className, senderName, message);
 
        $('div.chat:not(.format) ul').append(chatLi);
 
        // 스크롤바 아래 고정
        $('div.chat').scrollTop($('div.chat').prop('scrollHeight'));
    }
 
    // 메세지 전송
    function sendMessage(message) {
        // 서버에 전송하는 코드로 후에 대체
        const data = {
            "senderName"    : "blue",
            "message"        : message
        };
 
        // 통신하는 기능이 없으므로 여기서 receive
        resive(data);
    }
 
    // 메세지 입력박스 내용 지우기
    function clearTextarea() {
        $('div.input-div textarea').val('');
    }
 
    // 메세지 수신
    function resive(data) {
        const LR = (data.senderName != myName)? "left" : "right";
        appendMessageTag("right", data.senderName, data.message);
    }
 
    return {
        'init': init
    };
})();
 
$(function(){
    Chat.init();
});

</script>






<body>


<div id="one">
<input type="text" id="nickname" value="${S_MEMBER.memId }"  readonly="readonly" /> 
<input type="button" id="enter" value="채팅하기" />
</div>

<div id="two" style="display: none">

<input type="button" id="exit" value="나가기" /><br />

<div id="chatarea" class="" style="width:400px; height:600px; border:1px solid;">
		<ul>
			
		
		
		<c:forEach items="${chatList }" var="chat">
				<c:choose>
					<c:when test="${S_MEMBER.memId == chat.msgSender }">
					<li>
					<div class="my_message right">
					  <div class="tooltip">
					<span>${ chat.msgSender}</span> 나<br>
					<span>${ chat.msgContent}</span>
						</div> 
					</div>
					</li>
					</c:when>
					<c:when test="${S_MEMBER.memId == chat.msgReceiver }">
					<li>
					<div class="you_message left">
					<div class="tooltip">
					<span>${ chat.msgSender}</span> 너<br>
					<span>${ chat.msgContent}</span>
					</div> 
					</div>
					</li>
					</c:when>
					<c:otherwise>안떠야해</c:otherwise>
				</c:choose>
			<br>
		</c:forEach>
		</ul>
	</div>
	
	
		
		<input type="text" id="message" />
		<input type="button" id="send" value="보내기" />

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
//퇴장 버튼을 눌렀을 때 호출되는 함수
function disconnect(){
msg = document.getElementById("nickname").value;
websocket.send(msg+"님이 퇴장하셨습니다");
websocket.close();
}

//보내기 버튼을 눌렀을 때 호출될 함수
function send(){
nickname = document.getElementById("nickname").value;
msg = document.getElementById("message").value;

websocket.send(nickname + ":"+ msg);
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
//웹 소켓에서 연결이 해제 되었을 때 호출될 함수

function onMessage(evt){
data= evt.data;
chatarea = document.getElementById("chatarea");
chatarea.innerHTML = data + "<br/>" + chatarea.innerHTML
}

function onClose(){
}
</script>
</html>