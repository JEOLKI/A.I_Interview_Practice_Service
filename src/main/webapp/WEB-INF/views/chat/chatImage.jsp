<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/layout/commonLib.jsp"%>
<style>
 /* ::-webkit-scrollbar {
	width: 6px;
}
::-webkit-scrollbar-track {
	background-color: linear-gradient(103deg, rgb(79, 91, 255) 0%, rgb(79, 91, 255) 50%, rgb(108, 79, 255)) 100% center;
}
::-webkit-scrollbar-thumb {
	border-radius: 3px;
	background-color: black;
}
::-webkit-scrollbar-button {
	width: 0;
	height: 0;
}  */

#image {
	position: fixed;
	z-index: 30;
	bottom: 35px;
	left: 31px;
	width: 50px;
	cursor: pointer;
	 animation: fadein 0.5s; 
     -moz-animation: fadein 0.5s; 
     -webkit-animation: fadein 0.5s; 
     -o-animation: fadein 0.5s; 
}


#chatting {
	border: 0px;
	position: fixed;
	z-index: 30;
	bottom: 4%;
	left: 2%;
	height: 600px;
	border-radius: 20px;
	box-shadow: 12px 15px 20px rgba(46, 61, 73, 0.15); 
	overflow: hidden;
}

.iwEgly {
	display: inline-flex;
	-webkit-box-align: center;
	align-items: center;
	-webkit-box-pack: center;
	justify-content: center;
	color: rgb(255, 255, 255);
	background-color: rgb(249, 13, 60);
	border: 1px solid rgb(255, 74, 74);
	font-weight: bold;
	font-family: NotoSansKR, NotoSansJP, -apple-system, BlinkMacSystemFont,
		"Helvetica Neue", "맑은 고딕", "Yu Gothic", "Segoe UI", Roboto, system-ui,
		sans-serif;
	box-sizing: border-box;
	flex-wrap: nowrap !important;
	animation: 0.2s cubic-bezier(0.1, 0, 0.6, 1) 0.55s 1 normal backwards
		running fcEaNs !important;
	box-shadow: rgba(0, 0, 0, 0.4) 0px 1px 2px 0px !important;
	font-size: 14px !important;
	border-radius: 12px !important;
	visibility: visible !important;
}

.alarm {
	position: fixed;
	z-index: 1;
	color: white;
	bottom: 78px;
	left: 55px;
}

.nav-counter {
	bottom: 88px;
	left: 90px;
	position: fixed;
	z-index: 1;
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
	background: #dd202f;
	border-radius: 11px;
}

.chatbox-open {
	bottom: 90px;
	left: 90px;
	z-index: 10;
	position: fixed;
	min-width: 8px;
	width: 52px;
	height: 52px;
	line-height: 20px;
	margin-top: -11px;
	font-weight: normal;
	font-size: small;
	color: white;
	text-align: center;
	text-shadow: 0 1px rgba(0, 0, 0, 0.2);
	background: linear-gradient(103deg, rgb(79, 91, 255) 0%, rgb(79, 91, 255) 50%, rgb(108, 79, 255)) 100% center;
	border-radius: 50%;
	margin: 16px;
	box-shadow: -12px 15px 20px 0 rgba(46, 61, 73, 0.15);
}

@
keyframes fadein {from { opacity:0;
	
}

to {
	opacity: 1;
}

}
@
-moz-keyframes fadein {
	/* Firefox */ from { opacity:0;
	
}

to {
	opacity: 1;
}

}
@
-webkit-keyframes fadein {
	/* Safari and Chrome */ from { opacity:0;
	
}

to {
	opacity: 1;
}

}
@
-o-keyframes fadein {
	/* Opera */ from { opacity:0;
	
}

to {
	opacity: 1;
}
}
</style>



<script>
	webSocket = "";
	
	$(document).ready(function() {
		$("#image").fadeIn("slow");

		var a = alarmCount()
		$("#alarmCount").html(a)
		
		if(a==null ||a==0){
			$("#alarmCount").attr("style", "display:none");
		}
		
		if ("${S_MEMBER.memId}" == ""
				|| "${S_MEMBER.memId}" == null) {
			$("#image").attr("style", "display:none");
		} else if ('${S_MEMBER.memAuth}' == 'C') {
			$("#image").attr("style", "display:block");
			
			webSocket = new WebSocket(
					"ws://"+"${serverIp}"+"/admin.do");
			webSocket.onopen = function(message) {
			};
			webSocket.onclose = function(message) {
			};
			webSocket.onerror = function(message) {
			};
			// 서버로 부터 메시지가 오면
			webSocket.onmessage = function(message) {
				let node = JSON.parse(message.data);
				if (node.status === "message") {
					a++
					$("#alarmCount").html(a)
					$("#alarmCount").attr("style", "display:block");
				}
			}
		} else {
			$("#image").attr("style", "display:block");
			webSocket = new WebSocket(
					"ws://"+"${serverIp}"+"/broadalarm.do");
			webSocket.onopen = function(message) {
			};
			webSocket.onclose = function(message) {
			};
			webSocket.onerror = function(message) {
			};
			webSocket.onmessage = function(message) {
				if (message.data == "bye") {
				} else if (message.data == "AI_INTERVIEW_ADMIN_CHAT_ENTER") {
				} else {
					a++
					$("#alarmCount").html(a)
					$("#alarmCount").attr("style", "display:block");
				}
			}
		}

		$("#image").on("click",function() {
			var url = ""
			if ('${S_MEMBER.memAuth}' == 'C') {
				$("#image").attr("style", "display:none");
				webSocket.close();
				$("#alarmCount").attr("style", "display:none");
				$("#chatting").attr("style", "display:none");
				$("#chatting").attr("src",
						"/chat/room.do");
				$("#chatting").attr("style",
						"display:block");
				$("#chatting").attr("style",
						"width : 350px");
			} else if ("${S_MEMBER.memId}" == ""
					|| "${S_MEMBER.memId}" == null) {
				
			} else {
				$("#image").attr("style", "display:none");
				webSocket.close();
				$("#alarmCount").attr("style", "display:none");
				$("#chatting").attr("style", "display:none");
				$("#chatting").attr("src",
						"/chat/chat.do");
				$("#chatting").attr("style",
						"display:block");
				$("#chatting").attr("style",
						"width : 350px;");
				
			}
		})

	})

	function alarmCount() {
		var count;
		$.ajax({
			url : "/chat/alarmCount.do",
			type : 'GET',
			async : false,
			success : function(data) {
				count = data;
			}
		})
		return count;
	}
	
	function noRefresh()
	{
	    if (event.keyCode == 116) 
	    {
	    	webSocket.close();   	
	        event.keyCode = 2;
	    } 
	    else if(event.ctrlKey && (event.keyCode == 78 || event.keyCode == 82)) 
	    {
	    	webSocket.close();
	    }
	}
	document.onkeydown = noRefresh;
</script>

<button id="image" class="chatbox-open" >
    <i class="fa fa-comment fa-2x" aria-hidden="true"></i>
</button>
<span class="nav-counter" id="alarmCount" ></span>
	
<!-- <div class="alarm iwEgly">100</div> -->
	
<iframe id="chatting"  src = ""  style="display:none;"  >

</iframe>

