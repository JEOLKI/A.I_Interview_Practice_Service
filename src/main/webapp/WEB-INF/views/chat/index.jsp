<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<title>Web Socket Example</title>
<%@ include file="/WEB-INF/views/layout/commonLib.jsp" %>
<script type="text/javascript"
   src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.5/sockjs.min.js"></script>
</head>
<link href="https://cdnjs.cloudflare.com/ajax/libs/bulma/0.4.1/css/bulma.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>


<style>
.body{
}
.allUsersList{
  width: 300px;
  margin: 20px;
}
.allUsersList .card-header{
  background: #683db8;
  color: #FFF;
  padding: 10px;
}
.allUsersList .image img{
  border-radius: 16px;
}
.usersChatList{
  position: absolute;
  width: 250px;
  bottom: 0;
  margin-bottom: 0;
  right: 360px;
}
.show{
  display: block;
}
.thumb-user-list{
  display: none;
}
.thumb-user-list .image img{
  border-radius: 30px;
}
.usersChatList .card-header{
  background: #683db8;
  font-size: 13px;
}
.chatBox{
  position: absolute;
  width: 300px;
  font-size: 13px;
}
.chat-content{
  overflow: auto;
  height: 380px;
}
.chatBox .card{
  border-radius: 4px;
}
.chatBox .card-header{
  background: #683db8;
}
.header-title{
  height: 50px;
}
.card-header-title i{
  font-size: 10px;
  color: #32e4cd;
  margin-right: 6px;
}
.card-header .card-header-title{
  color: #FFF;
}
.chat-content small{
  margin: 0;
}
.chat-content p{
  background: #ecf1f8;
  padding: 10px;
  border-radius: 8px;
  margin-bottom: 0;
}
.my-content .media-content{
  width: 80%;
}
.my-content .message{
  float: right;
  background: #683db8;
  color: #FFF;
  text-align: right;
  padding: 10px;
  margin-bottom: 4px;
  font-size: 13px;
}
.my-content .chat-content small{
  float: right;
}
.my-content small{
  display: block;
  float: right;
  width: 100%;
  text-align: right;
}
.chat-textarea{
  font-size: 14px;
  padding: 8px;
  height: 40px;
  width: 100%;
  border: none;
  overflow: auto;
  outline: none;

  -webkit-box-shadow: none;
  -moz-box-shadow: none;
  box-shadow: none;
  resize: none;
}
.chat-message-group{
  
}
.chat-message-group .chat-thumb{
  float: left;
  width: 20%;
}
.chat-message-group .chat-messages{
  float: left;
  width: 80%;
  margin-bottom: 20px;
}
.chat-message-group .message{
  float: left;
  padding: 10px;
  background: #ecf1f8;
  font-size: 13px;
  border-radius: 5px;
  margin-bottom: 3px;
}
.chat-messages .from{
  float: left;
  display: block;
  width: 100%;
  text-align: left;
  font-size: 11px;
}
.chat-thumb img{
  border-radius: 40px;
}
.writer-user .chat-messages{
  float: right;
  width: 100%;
}
.writer-user .chat-messages .message{
  float: right;
  background: #683db8;
  color: #FFF;
}
.writer-user .chat-messages .from{
  float: left;
  display: block;
  width: 100%;
  text-align: right;
}
.chat-message-group .typing{
  float: left;
}
.chatBox .card-header-icon i{
  color: #FFF;
  font-size: 13px;
}
/* CSSS */
.outside-box{
  height: 100px;
  background: #F8C;
  width: 200px;
  margin: 20px;
  overflow: auto;
}
.outside-box .content-insider{
  height: 300px;
  background: #C9C;
}
/* CSS Spinner */
.spinner {
  margin: 0 30px;
  width: 70px;
  text-align: center;
}

.spinner > div {
  width: 4px;
  height: 4px;
  background-color: #888;

  border-radius: 100%;
  display: inline-block;
  -webkit-animation: sk-bouncedelay 1.4s infinite ease-in-out both;
  animation: sk-bouncedelay 1.4s infinite ease-in-out both;
}

.spinner .bounce1 {
  -webkit-animation-delay: -0.32s;
  animation-delay: -0.32s;
}

.spinner .bounce2 {
  -webkit-animation-delay: -0.16s;
  animation-delay: -0.16s;
}

@-webkit-keyframes sk-bouncedelay {
  0%, 80%, 100% { -webkit-transform: scale(0) }
  40% { -webkit-transform: scale(1.0) }
}

@keyframes sk-bouncedelay {
  0%, 80%, 100% { 
    -webkit-transform: scale(0);
    transform: scale(0);
  } 40% { 
    -webkit-transform: scale(1.0);
    transform: scale(1.0);
  }
}
/* EmojiBox */
.emojiBox{
  width: 150px;
  margin: 30px;
}
.emojiBox .box{
  height: 100px;
  padding: 4px;
}
/* */
.card-header-title img{
  border-radius: 40px;
}
body{
}
 
</style>

<body>
 

 
<div id="chatApp">
<div class="chatBox" id="chatBox">
  <div class="card">
 
 <header class="card-header header-title" @click="toggleChat()">
    <p class="card-header-title">
      <i class="fa fa-circle-o is-online"></i><img src="/member/profile.do?memId=TEST_ID2" style="width: 30px;">&nbsp;관리자와의 채팅
    </p>
    <a id="closeChat" class="card-header-icon">
      <span  class="icon">
        <i  class="fa fa-close"></i>
      </span>
    </a>
  </header>
 
 <div id="chatbox-area">
  <div class="card-content chat-content" id="chat-content">
  
    <div class="content" id="messageArea">
    
    
    <c:forEach items="${chatList }" var="chat" varStatus="status">
		
    	<c:choose>
			<c:when test="${chat.msgReceiver == S_MEMBER.memId }">
			
				<div class="chat-message-group">
					<div class="chat-thumb">
						<figure class="image is-32x32">
							<img src="/member/profile.do?memId=TEST_ID2">
						</figure>
					</div>
					<div class="chat-messages">
					
						<div class="message">${chat.msgContent }</div><div>&nbsp</div>${chat.msgDate }
						<div class="from">${chat.msgSender }&nbsp</div>
						
					</div>
				</div>

			</c:when>
    		<c:when test="${chat.msgReceiver != S_MEMBER.memId }">
				<div class="chat-message-group writer-user">
			        <div class="chat-messages">
			          <div class="message">${chat.msgContent }</div>
			          <div class="from">${chat.msgSender }&nbsp ${chat.msgDate}</div>
			        </div>
      			</div>
    		</c:when>
    		
    	</c:choose>
    
    </c:forEach>
    
    </div>
  </div>
  	<footer class="card-footer" id="chatBox-textbox">
    <div style="width: 63%">
      <textarea name="msgContent" id="textMessage" class="chat-textarea"  onkeydown="return enter()" placeholder="Digite aqui" v-on:focus="expandTextArea()" v-on:blur="dexpandTetArea()"></textarea>
    </div>
    <div class="has-text-centered" style="width: 37%">
      <a class="button is-white">
        <i class="fa fa-smile-o fa-5" aria-hidden="true"></i>
      </a>
    <a id="send" class="button is-white" onclick="sendMessage()">send</a></div>
	  </footer>
  </div>
  
</div>
</div>
<div class="emojiBox" style="display: none">
  <div class="box">
  
  </div>
</div>

</div>

<!-- 채팅 영역 -->
<!-- <form> -->
<!-- <!-- 텍스트 박스에 채팅의 내용을 작성한다. --> 
<!-- <input id="textMessage" type="text" onkeydown="return enter()"> -->
<!-- <!-- 서버로 메시지를 전송하는 버튼 -->
<!-- <input onclick="sendMessage()" value="Send" type="button"> -->
<!-- </form> -->
<!-- <br /> -->
<!-- 서버와 메시지를 주고 받는 콘솔 텍스트 영역 -->
<!-- <textarea id="messageTextArea" rows="10" cols="50" disabled="disabled"></textarea> -->
<!-- <div id="messageArea" ></div> -->

<script type="text/javascript">

var messageTextArea = document.getElementById("messageArea");
var webSocket =  new WebSocket("ws://localhost/broadsocket.do");
let message = document.getElementById("textMessage");
var arlamCheck = 'Y';
var d = new Date();
var minutes = ("00"+ d.getMinutes()).slice(-2)
var str = "";
var hours = d.getHours();


if (hours > 12){
	str = "오후"
	hours = hours - 12;
}else{
	str = "오전"
}
$(function(){
	var c = parent.document.querySelector("#chatting").style
	c.overflow= "hidden";
	
	$("#closeChat").on("click", function(){
		var a = parent.document.querySelector("#chatting").style;
		a.display = "none";
		$("#chatting").attr("style", "display:none");
		webSocket.close();
	})
	
	
$("#chat-content").scrollTop($("#chat-content")[0].scrollHeight); 	

// 서버의 broadsocket의 서블릿으로 웹 소켓을 한다.
// 콘솔 텍스트 영역
// 접속이 완료되면
webSocket.onopen = function(message) {
// 콘솔에 메시지를 남긴다.
};
// 접속이 끝기는 경우는 브라우저를 닫는 경우이기 떄문에 이 이벤트는 의미가 없음.
webSocket.onclose = function(message) { 
	
};
// 에러가 발생하면
webSocket.onerror = function(message) {
// 콘솔에 메시지를 남긴다.
// messageTextArea.value += "error...\n";
};
// 서버로부터 메시지가 도착하면 콘솔 화면에 메시지를 남긴다.
webSocket.onmessage = function(message) {
	
console.log(message)
console.log(message.data);
console.log("${S_MEMBER.memId}")

if(message.data=="bye"){
	$(".fa-circle").attr('class', 'fa fa-circle-o')
	arlamCheck = 'N';
	message.data = "";
// }else if(message.data=="${S_MEMBER.memId}"){
}else if(message.data=="AI_INTERVIEW_ADMIN_CHAT_ENTER"){
	$(".fa-circle-o").attr('class', 'fa fa-circle')
	message.data = "";
	arlamCheck = 'Y';
}
else{																																																																																	
	$("#messageArea").append("<div class='chat-message-group'><div class='chat-thumb'><figure class='image is-32x32'><img src='/member/profile.do?memId=TEST_ID2'></figure></div><div class='chat-messages'><div class='message'>"+message.data+"</div><div class='from'>"+str+" "+hours+":"+minutes+" </div></div>");
	$("#messageArea").append("</div>")

	$("#chat-content").scrollTop($("#chat-content")[0].scrollHeight);	
	
}
};


})
// 서버로 메시지를 발송하는 함수
// Send 버튼을 누르거나 텍스트 박스에서 엔터를 치면 실행
function sendMessage() {
	
sendProcess();

$("#messageArea").append("<div class='chat-message-group writer-user'><div class='chat-messages'><div class='message'>"+message.value+"</div><div class='from'>"+str+" "+hours+":"+minutes+" </div></div></div>");



// 소켓으로 보낸다.
webSocket.send(message.value);
// 텍스트 박스 추기화

message.value = "";

$('#chat-content').append("</div>");
$("#chat-content").scrollTop($("#chat-content")[0].scrollHeight);
}
// 텍스트 박스에서 엔터를 누르면
function enter() {
// keyCode 13은 엔터이다.
if(event.keyCode === 13) {
// 서버로 메시지 전송
sendMessage();
// form에 의해 자동 submit을 막는다.
return false;
}
return true;
}
function sendProcess(){
	var msg = $("#textMessage").val();
	console.log(msg)
	console.log(arlamCheck)
	$.ajax({
		url: "/chat/create.do",
		type: 'POST',
		dataType: 'json',
		data: { msgContent : msg, msgArlam : arlamCheck},
    	success : function(data){
    	}
	 });
}
</script>

</body>
</html>
















