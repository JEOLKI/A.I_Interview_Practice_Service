<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt"%>

<body>    

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
  <div class="card-content chat-content" id="chat-content">
  
    <div class="content" id="messageArea">
    
    <c:forEach items="${chatList }" var="chat">
    	
    	<c:choose>
			<c:when test="${chat.msgReceiver == S_MEMBER.memId }">
			
				<div class="chat-message-group">
					<div class="chat-thumb">
						<figure class="image is-32x32">
							<img src="/images/sally.png">
						</figure>
					</div>
					<div class="chat-messages">
					
						<div class="message">${chat.msgContent }</div><div>&nbsp</div><a>${chat.msgDate }</a>
						<div class="from">${chat.msgSender }&nbsp</div>
						
<%-- 						<fmt:parseDate value="${chatList}" var="parseDateValue" pattern="yyyy.MM.dd HH:ss"/> --%>
<%-- 						<fmt:formatDate value="${parseDateValue}" pattern="yyyy-MM-dd HH:ss"/>  --%>
			
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
      <textarea id="textMessage" class="chat-textarea"  onkeydown="return enter()" placeholder="Digite aqui" v-on:focus="expandTextArea()" v-on:blur="dexpandTetArea()"></textarea>
    </div>
    <div class="has-text-centered" style="width: 37%">
      <a class="button is-white">
        <i class="fa fa-smile-o fa-5" aria-hidden="true"></i>
      </a>
    <a class="button is-white" onclick="sendMessage()">send</a></div>
  </footer>
  </div>
  
</div>
</div>
<div class="emojiBox" style="display: none">
  <div class="box">
  
  </div>
</div>

</div>
</body>