<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>

<head>
  <meta charset="utf-8">
  <title>terview Talk</title>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css" integrity="sha384-/Y6pD6FV/Vv2HJnA6t+vslU6fwYXjCFtcEpHbNJ0lyAFsXTsjBbfaDjzALeQsN6M" crossorigin="anonymous">
  <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/bulma/0.4.1/css/bulma.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>

<style>
html, body {
  margin: 0;
  font-family: 'Open Sans';
  font-weight: 400;
  font-size: 14px;
}

.header {
    background: #683db8;
    padding: 12px 0px 40px 0px;
    color: white;
    width: 100%;
    font-weight: 300;
    height: 65px;
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
  color: rgba(0, 0, 0, 0.5);
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

</style>

<script>
	var webSocket =  new WebSocket("ws://localhost/admin.do");
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
				if(node.key!='TEST_ID2'){
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
	
	
</script>

<body>
  <header class="header">
    <div class="main_title">MyInterview&nbsp &nbsp<a id="closeChat"  style="margin-left: 55.5%">X</a>
    </div>
    <div class="icon_box">
    
    
    
    
<!--       <span class="left_icon_box"> -->
<!--       <span class="left_icon"><i class="material-icons">person</i></span> -->
<!--       <span class="left_icon"><i class="material-icons">message</i></span> -->
<!--       <span class="left_icon"><i class="material-icons">more</i></span> -->
<!--       </span> -->

<!--       <span class="right_icon_box"> -->
<!--       <span class="right_icon"><i class="material-icons">notifications</i></span> -->
<!--       <span class="right_icon"><i class="material-icons">settings</i></span> -->
<!--       </span> -->
    </div>
  </header>

  <section class="middle">
<!--     <div class="input-group"> -->
<!--       <span class="input-group-addon" id="basic-addon1"><i class="material-icons">search</i></span> -->
<!--       <input type="text" class="form-control" placeholder="채팅방 이름, 참여자 검색" aria-label="Username" aria-describedby="basic-addon1"> -->
<!--       <span class="input-group-addo	n"><i class="material-icons">list</i></span> -->
<!--     </div> -->
		
		<c:forEach items="${roomList }" var ="room">
			<div class="chat_area" data-id="${room.memId }" >
				<div class="chat">
				<img src="/member/profile.do?memId=${room.memId }" class="chat__avatar">
					<div class="chat__text">
						<span class="chat__username">${room.memId }</span>&nbsp<i class="fa fa-circle-o is-online"></i><span class="chat__date">${room.msgDate }</span><br>
						<span class="chat__preview">${room.msgContent }</span>
						<c:choose>
							<c:when test="${room.msgArlam !=0 }">
								<span class="alarm">${room.msgArlam }</span>
							</c:when>
							<c:otherwise><span class="alarm" style="display: none;">${room.msgArlam }</span></c:otherwise>
						</c:choose> 
					</div>
				</div>
			</div>
		</c:forEach>

  </section>
  
</body>

</html>