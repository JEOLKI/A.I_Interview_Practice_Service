	<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Web Socket Example</title>
<%@ include file="/WEB-INF/views/layout/commonLib.jsp" %>
<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.5/sockjs.min.js"></script>
<link href="https://cdnjs.cloudflare.com/ajax/libs/bulma/0.4.1/css/bulma.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	
	
<style>
/* 여러 채팅창 간의 간격과 배열 위치*/
.float-left{
float:left;
margin: 5px;
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
  bottom: 0;
  width: 300px;
  margin: 40px;
  margin-bottom: 0;
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

</style>
</head>
<body>
<!-- 유저가 접속할 때마다 이 템플릿으로 채팅창을 생성한다. -->
<!-- class="template" -->
<div id="chatApp"  style="display:none" class="template">

<div class="chatBox" id="chatBox">
  <div class="card">
 
 <header class="card-header header-title" @click="toggleChat()">
    <p class="card-header-title">
      <i class="fa fa-circle is-online"></i><img src="/images/sally.png" style="width: 30px;">&nbsp;관리자와의 채팅
    </p>
    <a class="card-header-icon">
      <span class="icon">
        <i class="fa fa-close"></i>
      </span>
    </a>
  </header>
 
 <div id="chatbox-area">
  <div class="card-content chat-content">
  
    <div class="content messageArea">
    
      <div class="chat-message-group">
        <div class="chat-thumb">
          <figure class="image is-32x32">
            <img src="https://k0.okccdn.com/php/load_okc_image.php/images/32x0/971x939/0/10846088441021659030.webp?v=2">
          </figure>
        </div>
        <div class="chat-messages">
          <div class="message">Olá meu nome é Camila</div>
          <div class="from">Hoje 04:55</div>
        </div>
      </div>
      
      <div class="chat-message-group writer-user">
        <div class="chat-messages">
          <div class="message">Olá meu nome é Marinho</div>
          <div class="from">Hoje 04:55</div>
        </div>
      </div>
      
      <div class="chat-message-group">
        <div class="chat-thumb">
          <figure class="image is-32x32">
            <img src="https://k0.okccdn.com/php/load_okc_image.php/images/32x0/971x939/0/10846088441021659030.webp?v=2">
          </figure>
        </div>
        <div class="chat-messages">
          <div class="message">Olá meu nome é Marinho</div>
          <div class="message">Caro marinho</div>
          <div class="from">Hoje 04:55</div>
        </div>
      </div>
      
    </div>
  </div>
  <footer class="card-footer" id="chatBox-textbox">
    <div style="width: 63%">
      <textarea id="textMessage" class="adminMsg chat-textarea"  onkeydown="if(event.keyCode === 13) return false;" placeholder="Digite aqui" v-on:focus="expandTextArea()" v-on:blur="dexpandTetArea()"></textarea>
    </div>
    <div class="has-text-centered" style="width: 37%">
      <a class="button is-white">
        <i class="fa fa-smile-o fa-5" aria-hidden="true"></i>
      </a>
    <a class="button is-white sendBtn">send</a></div>
  </footer>
  </div>
  
</div>
</div>
<div class="emojiBox" style="display: none">
  <div class="box">
  
  </div>
</div>

</div>











<!-- <div style="display:none"> -->
<!-- <form> -->
<!-- 메시지 텍스트 박스 -->
<!-- <input type="text" onkeydown="if(event.keyCode === 13) return false;"> -->
<!-- <!-- 전송 버튼 --> 
<!-- <input value="Send" type="button" class="sendBtn"> -->
<!-- </form> -->
<!-- <br /> -->
<!-- 서버와 메시지를 주고 받는 콘솔 텍스트 영역 --> 
<!-- <textarea rows="10" cols="50" class="console" disabled="disabled"></textarea> -->
<!-- </div> -->
<!-- 소스를 간단하게 하기 위하 Jquery를 사용했습니다. -->
<script type="text/javascript">
// 서버의 admin의 서블릿으로 웹 소켓을 한다.
$(function(){
	

var webSocket =  new WebSocket("ws://localhost/admin.do");
// let message = document.getElementById("textMessage");
// 운영자에서의 open, close, error는 의미가 없어서 형태만 선언
webSocket.onopen = function(message) { };
webSocket.onclose = function(message) { };
webSocket.onerror = function(message) { };
// 서버로 부터 메시지가 오면
webSocket.onmessage = function(message) {
// 메시지의 구조는 JSON 형태로 만들었다.
let node = JSON.parse(message.data);
// 메시지의 status는 유저의 접속 형태이다.
// visit은 유저가 접속했을 때 알리는 메시지다.
console.log("node"+node)
console.log("user : "+node.user)

if(node.status === "visit") {
console.log("node.status"+node.status)	
// 위 템플릿 div를 취득한다.
let form = $(".template").html();
// div를 감싸고 속성 data-key에 unique키를 넣는다.
form = $("<div class='float-left'></div>").attr("data-key",node.key).append(form);
console.log("form"+form)
// body에 추가한다.
$("body").append(form);
// message는 유저가 메시지를 보낼 때 알려주는 메시지이다.
} else if(node.status === "message") {
// key로 해당 div영역을 찾는다.
// 메시지 추가할려고 쓰는것임
let $div = $("[data-key='"+node.key+"']");
// console영역을 찾는다.
// .messageArea
// let log = $div.find(".console").val();
// 아래에 메시지를 추가한다.

$div.find(".messageArea").append("<div class='chat-message-group'><div class='chat-thumb'><figure class='image is-32x32'><img src='/images/sally.png'></figure></div><div class='chat-messages'><div class='message'>"+node.message+"</div><div class='from'>Hoje 04:55</div></div>");
$div.find(".chat-content").scrollTop($div.find(".chat-content")[0].scrollHeight); 

// bye는 유저가 접속을 끊었을 때 알려주는 메시지이다.
} else if(node.status === "bye") {
// 해당 키로 div를 찾아서 dom을 제거한다.
$("[data-key='"+node.key+"']").remove();
}
};
// 전송 버튼을 클릭하면 발생하는 이벤트
$(document).on("click", ".sendBtn", function(){
// div 태그를 찾는다.
let $div = $(this).closest(".float-left");
// 메시지 텍스트 박스를 찾아서 값을 취득한다.
let message = $div.find(".adminMsg").val();
console.log(message)
// 유저 key를 취득한다.
let key = $div.data("key");
// console영역을 찾는다.
// let log = $div.find(".console").val();


// 아래에 메시지를 추가한다.
$div.find(".messageArea").append("<div class='chat-message-group writer-user'><div class='chat-messages'><div class='message'>"+message+"</div><div class='from'>Hoje 04:55</div></div></div>");
$div.find(".chat-content").scrollTop($div.find(".chat-content")[0].scrollHeight);
// 텍스트 박스의 값을 초기화 한다.
$div.find(".adminMsg").val("");
// 웹소켓으로 메시지를 보낸다.
webSocket.send(key+"#####"+message);
});
// 텍스트 박스에서 엔터키를 누르면
$(document).on("keydown", ".adminMsg", function(){
// keyCode 13은 엔터이다.
if(event.keyCode === 13) {
// 버튼을 클릭하는 트리거를 발생한다.
$(this).closest(".float-left").find(".sendBtn").trigger("click");
// form에 의해 자동 submit을 막는다.
return false;
}
return true;
});
})
</script>
</body>
</html>
