<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>

<head>
  <meta charset="utf-8">
  <title>Kakao Talk</title>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css" integrity="sha384-/Y6pD6FV/Vv2HJnA6t+vslU6fwYXjCFtcEpHbNJ0lyAFsXTsjBbfaDjzALeQsN6M" crossorigin="anonymous">

  <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
  <link rel="stylesheet" href="./css/style.css">
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
}

.left_icon {
  padding-right: 50px;
}

.right_icon_box {
  float: right;
  padding-right: 8px;
}

.right_icon {
  padding-left: 15px;
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
}

.chat__text {
  flex-grow: 2;
  margin-left: 20px;
}

.chat__username {
  font-weight: 600;
  display: block;
}

.chat__preview, .chat__date {
  color: rgba(0, 0, 0, 0.5);
}

.chat__date {
  font-size: 10px;
}

.number_of_people {
  font-size: 8px;
  color: rgb(125, 125, 125);
  border: 1px solid #d1d1d1;
  background-color: #e6e6e6;
}
</style>


<body>
  <header class="header">
    <div class="main_title">MyInterview</div>
    <div class="icon_box">
      <span class="left_icon_box">
      <span class="left_icon"><i class="material-icons">person</i></span>
      <span class="left_icon"><i class="material-icons">message</i></span>
      <span class="left_icon"><i class="material-icons">more</i></span>
      </span>

      <span class="right_icon_box">
      <span class="right_icon"><i class="material-icons">notifications</i></span>
      <span class="right_icon"><i class="material-icons">settings</i></span>
      </span>
    </div>
  </header>

  <section class="middle">
    <div class="input-group">
      <span class="input-group-addon" id="basic-addon1"><i class="material-icons">search</i></span>
      <input type="text" class="form-control" placeholder="채팅방 이름, 참여자 검색" aria-label="Username" aria-describedby="basic-addon1">
      <span class="input-group-addon"><i class="material-icons">list</i></span>
    </div>

	<c:forEach items="${listList }" var = "roomList">
		<c:forEach items="${roomList }" var ="room">
				<div class="chat_area">
					<div class="chat">
						<img src="/images/sally.png" alt=""
							class="chat__avatar">
						<div class="chat__text">
							<span class="chat__username">${room.memId }</span> <span
								class="chat__preview">${room.msgContent }</span>
						</div>
						<span class="chat__date">${room.msgDate }</span>
					</div>
				</div>
			</c:forEach>
	</c:forEach>

  </section>
</body>

</html>