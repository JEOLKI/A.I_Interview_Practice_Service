<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html><head>
  <meta charset="utf-8">
  <title>terview Talk</title>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/bulma/0.4.1/css/bulma.css" rel="stylesheet">
  <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
   <link rel="stylesheet" href="./css/style.css">
<style>
*{
box-sizing: content-box;
}
html, body {
  margin: 0;
  font-family: 'Open Sans';
  font-weight: 400;
  font-size: 14px;
  width : 290px;
}

.header {
    background: #0360a5;
    padding: 12px 0px 40px 0px;
    color: white;
    width: 100%;
    font-weight: 300;
    height: auto;
}


.main_title {
  margin: 0;
  font-size: 18px;
  padding: 0px 15px 15px 10px;
  font-weight: 600;
}

.icon_box {
  width: 100%;
}

.left_icon_box {
  float: left;
  padding-left: 8px;
  cursor: pointer;
}

.left_icon {
  padding-right: 50px;
  cursor: pointer;
}

.right_icon_box {
  float: right;
  padding-right: 8px;
  cursor: pointer;
}

.right_icon {
  padding-left: 15px;
  cursor: pointer;
}

.chat {
  border-bottom: 1px solid rgba(0, 0, 0, 0.1);
  padding: 10px;
  box-sizing: border-box;
  display: flex;
  justify-content: space-between;
}

.chats {
    padding-top: 40px;
    padding-bottom: 50px;
}


.chat__avatar {
  width: 50px;
  height: 50px;
  border-radius: 50%;
  cursor: pointer;
}

.chat__text {
  flex-grow: 2;
  margin-left: 20px;
}

.chat__username {
  font-weight: 600;
  cursor: pointer;
}
.chat__preview{
	diplay : block;
	cursor: pointer;
}

.chat__preview, .chat__date {
}

.chat__date {
  font-size: 10px;
  float: right;
}

.number_of_people {
  font-size: 8px;
  color: rgb(125, 125, 125);
  border: 1px solid #d1d1d1;
  background-color: #e6e6e6;
}
.chat_area, .material-icons{
	
}
.fa, .fa-circle{
color: #32e4cd;
}
.alarm{
 min-width: 8px;
 padding: 0 6px;
 font-weight: normal;
 font-size: small;
 color: white;
 text-align: center;
 text-shadow: 0 1px rgba(0, 0, 0, 0.2);
 background: #683db8;
 border-radius: 11px;
 -webkit-box-shadow: inset 0 0 1px 1px rgba(255, 255, 255, 0.1), 0 1px rgba(0, 0, 0, 0.12);
 box-shadow: inset 0 0 1px 1px rgba(255, 255, 255, 0.1), 0 1px rgba(0, 0, 0, 0.12);
    float: right;
}
.chat_area:hover{
	 background-color: #F6F6F6;
}
.input-group {
    position: relative;
    display: -ms-flexbox;
    display: flex;
    width: 100%;
}
.input-group-addon {
    padding: .5rem .75rem;
    margin-bottom: 0;
    font-size: 1rem;
    font-weight: 400;
    line-height: 1.25;
    color: #495057;
    text-align: center;
    background-color: #e9ecef;
    border: 1px solid rgba(0,0,0,.15);
    border-radius: .25rem;
}
.input-group .form-control {
    position: relative;
    z-index: 2;
    -ms-flex: 1 1 auto;
    flex: 1 1 auto;
    width: 1%;
    margin-bottom: 0;
}
.form-control {
    display: block;
    width: 100%;
    padding: .5rem .75rem;
    font-size: 1rem;
    line-height: 1.25;
    color: #495057;
    background-color: #fff;
    background-image: none;
    background-clip: padding-box;
    border: 1px solid rgba(0,0,0,.15);
    border-radius: .25rem;
    transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
}
.input-group-addon { 
    padding: .5rem .75rem;
    margin-bottom: 0;
    font-size: 1rem;
    font-weight: 400;
    line-height: 1.25;
    color: #495057;
    text-align: center;
    background-color: #e9ecef;
    border: 1px solid rgba(0,0,0,.15);
    border-radius: .25rem;
}
</style>
<script>
	var webSocket =  new WebSocket("ws://localhost/admin.do");
	
	var managerId = getManager()
	$(function(){
		
		webSocket.onopen = function(message) { };
		webSocket.onclose = function(message) { };
		webSocket.onerror = function(message) { };
		webSocket.onmessage = function(message) {
		let node = JSON.parse(message.data);
		let $div = $("[data-id='"+node.key+"']");
			if(node.status === "visit") {
				$div.find(".fa-circle-o").attr('class', 'fa fa-circle')
			}
			
			else if(node.status === "message") {
				if(node.key!=managerId){
					$div.find(".alarm").attr('style', 'display:block')
					a = $div.find(".alarm").text();
					a++
					$div.find(".alarm").text(a);
					$div.find(".chat__preview").text(node.message)	
				}
			}
			else if(node.status === "bye") {
				console.log("사용자 종료")
				$div.find(".fa-circle").attr('class', 'fa fa-circle-o')	
				
				// 해당 키로 div를 찾아서 dom을 제거한다.
				$("[data-key='"+node.key+"']").remove();
				
			}
		}
		
		$("#closeChat").on("click", function(){
			var a = parent.document.querySelector("#chatting").style
			a.display = "none"
			webSocket.close()	
			parent.document.location.reload()
		})
		
		$('.chat_area').on('click', function(){
			webSocket.close();
			var a = parent.document.querySelector("#chatting").style
			a.width = "300px";
			memid = $(this).data("id")
			console.log(memid)
			console.log("정신나갈거같아.")
			location.href="/chat/admining.do?memId="+memid;
		})
		
	})
function getManager(){
	$.ajax({
		url: "/chat/managerId.do",
		type: 'GET',
		dataType: 'json',
    	success : function(data){
			console.log(data)
    	}
	})	
}
function filter(){

       var value, name, item, i;

       value = document.getElementById("value").value.toUpperCase();
       item = document.getElementsByClassName("chat_area");

       for(i=0;i<item.length;i++){
         name = item[i].getElementsByClassName("chat__username");
         if(name[0].innerHTML.toUpperCase().indexOf(value) > -1){
           item[i].style.display = "flex";
         }else{
           item[i].style.display = "none";
         }
       }
     }
</script></head>





<body>
  <header class="header">
    <div class="main_title">MyInterview&nbsp; &nbsp;<a id="closeChat" style="padding-left: 48%; color:white;">X</a>
    </div>
    <div class="icon_box">
    
      <span class="left_icon_box">
      <span class="left_icon"><i class="material-icons">person</i></span>
      <span class="left_icon"><i class="material-icons">message</i></span>
<!--       <span class="left_icon"><i class="material-icons">more</i></span> -->
      </span>

      <span class="right_icon_box">
<!--       <span class="right_icon"><i class="material-icons">notifications</i></span> -->
      <span class="right_icon"><i class="material-icons">settings</i></span>
      </span>
    </div>
  </header>

  <section class="middle">
	<div class="input-group">
      <span class="input-group-addon" id="basic-addon1"><i class="material-icons">search</i></span>
      <input type="text" onkeyup="filter()" id = "value" class="form-control" placeholder="채팅방 이름, 참여자 검색" aria-label="Username" aria-describedby="basic-addon1">
      <span class="input-group-addon"><i class="material-icons">list</i></span>
    </div>
		
		
			<div class="chat_area" data-id="TEST_ID">
				<div class="chat">
						<img src="/member/profile.do?memId=TEST_ID" alt="error" class="chat__avatar">
					<div class="chat__text">
						<span class="chat__username">TEST_ID</span>&nbsp;<i class="fa fa-circle-o is-online"></i><span class="chat__date">2020-12-23
	오후 04:55</span><br>
						<span class="chat__preview">GDDD</span>
							<span class="alarm" style="display: none;">0</span>
					</div>
				</div>
			</div>
			
			<div class="chat_area" data-id="MEMBER1">
				<div class="chat">
						<img src="/member/profile.do?memId=MEMBER1" alt="error" class="chat__avatar">
					<div class="chat__text">
						<span class="chat__username">MEMBER1</span>&nbsp;<i class="fa fa-circle-o is-online"></i><span class="chat__date">2020-12-23
	오후 04:55</span><br>
						<span class="chat__preview">ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ</span>
							<span class="alarm" style="display: none;">0</span>
					</div>
				</div>
			</div>
		
			<div class="chat_area" data-id="MEMBER3">
				<div class="chat">
						<img alt="error" src="/images/defaultImage.jpg" class="chat__avatar">
					<div class="chat__text">
						<span class="chat__username">MEMBER3</span>&nbsp;<i class="fa fa-circle-o is-online"></i><span class="chat__date">2020-12-23
	오전 11:49</span><br>
						<span class="chat__preview">안녕하세요</span>
							<span class="alarm" style="display: none;">0</span>
					</div>
				</div>
			</div>
		
			<div class="chat_area" data-id="MEMBER2">
				<div class="chat">
						<img src="/member/profile.do?memId=MEMBER2" alt="error" class="chat__avatar">
					<div class="chat__text">
						<span class="chat__username">MEMBER2</span>&nbsp;<i class="fa fa-circle-o is-online"></i><span class="chat__date">2020-12-22
	오전 12:00</span><br>
						<span class="chat__preview">안녕하세요</span>
							<span class="alarm" style="display: none;">0</span>
					</div>
				</div>
			</div>
  </section>
  


</body></html>