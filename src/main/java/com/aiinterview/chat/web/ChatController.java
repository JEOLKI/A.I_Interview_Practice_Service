package com.aiinterview.chat.web;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aiinterview.chat.service.ChatService;
import com.aiinterview.chat.vo.ChatRoomVO;
import com.aiinterview.chat.vo.ChatVO;
import com.aiinterview.member.service.MemberService;
import com.aiinterview.member.vo.MemberVO;


@RequestMapping("/chat")
@Controller
public class ChatController {
	
	@Resource(name = "chatService")
	ChatService chatService;
	
	@Resource(name = "memberService")
	private MemberService memberService;
	
	ChatVO cv = new ChatVO();
	public static HttpSession usersSession;
	public static  List<String> IdList = new ArrayList<>();
	
	@RequestMapping(path = "/room.do", method = RequestMethod.GET)
	public String test(Model model) {
		List<ChatRoomVO> roomList = chatService.roomList();
		model.addAttribute("roomList", roomList);
		return "chat/chatRoom";
	}
	
	
	
	@RequestMapping(path = "/chat.do", method = RequestMethod.GET)
	public String chatting(HttpSession session, Model model) {
		
		
		usersSession =session;
		
		MemberVO mv = (MemberVO) session.getAttribute("S_MEMBER");
		String memId = mv.getMemId();
		
		String receiver = "TEST_ID2";
		
		//내가 보내는 사람이기 때문에 세션에서 가져온다.
		cv.setMsgSender(memId);
		cv.setMsgReceiver(receiver);
		
		List<ChatVO> chatList =  chatService.List(cv);
		
		System.out.println("chatList확인 : "+chatList);
		
		model.addAttribute("chatList", chatList);
		model.addAttribute("Receiver", receiver);
		
		return "chat/index";
		
	}
	
	@RequestMapping(path = "/admining.do", method = RequestMethod.GET)
	public String admin(HttpSession session, Model model,String memId) {
		
		BroadSocket.sessionId(memId);
		
		chatService.arlamUpdate(memId);
		ChatVO cv = new ChatVO();
		List<String> arrayList = new ArrayList<>();
		
		String Sender = "TEST_ID2";
		
		for(String data : IdList){
		    if(!arrayList.contains(data))
		        arrayList.add(data);
		}
		
		cv.setMsgSender(Sender);
		cv.setMsgReceiver(memId);
		List<ChatVO> chatList =  chatService.List(cv);
		
		model.addAttribute("chatList", chatList);
		model.addAttribute("memId", memId);
		
		return "chat/admin";
	}
	
	@RequestMapping(path = "/adminAjax.do", method = RequestMethod.GET)
	public String adminAjax(HttpSession session, Model model, ChatVO cv) {
		
//		MemberVO mv = (MemberVO) session.getAttribute("S_MEMBER");
//		String memId = mv.getMemId();
		
		String Sender = "TEST_ID2";
//		cv.setMsgSender(memId);
		
		//내가 보내는 사람이기 때문에 세션에서 가져온다.
		cv.setMsgSender(Sender);//관리자 아이디
		List<ChatVO> chatList =  chatService.List(cv);
		System.out.println("cv 결과값 : "+cv);
		model.addAttribute("chatList", chatList);
		model.addAttribute("Receiver", cv.getMsgReceiver());
		
		return "chat/adminChatList";
	}

	
	@RequestMapping(path = "/list.do", method = RequestMethod.GET)
	public String ListView(Model model, ChatVO cv, HttpSession session) {
		System.out.println("aaaa");
		MemberVO mv = (MemberVO) session.getAttribute("S_MEMBER");
		String memId = mv.getMemId();
		
		String receiver = "TEST_ID2";
		
		//내가 보내는 사람이기 때문에 세션에서 가져온다.
		cv.setMsgSender(memId);
		cv.setMsgReceiver(receiver);
		
		List<ChatVO> chatList =  chatService.List(cv);
		
		for (int i = 0; i < chatList.size(); i++) {
			System.out.println(chatList.get(i));
		}
		
		model.addAttribute("chatList", chatList);
		model.addAttribute("Receiver", receiver);
		return "chat/Chat";
	}
	
	@RequestMapping(path = "/chatListAjax.do", method = RequestMethod.POST)
	public String chatListAjax(Model model, ChatVO cv, HttpSession session) {
		
		
		MemberVO mv = (MemberVO) session.getAttribute("S_MEMBER");
		String memId = mv.getMemId();
		
		//내가 보내는 사람이기 때문에 세션에서 가져온다.
		cv.setMsgSender(memId);
		List<ChatVO> chatList =  chatService.List(cv);
		
		for (int i = 0; i < chatList.size(); i++) {
			System.out.println(chatList.get(i));
		}
		
		model.addAttribute("chatList", chatList);
		
		return "jsonView";
		
	}
	
	@ResponseBody
	@RequestMapping(path = "/create.do", method = RequestMethod.POST)
	public void createProcess(Model model, ChatVO cv, HttpSession session) {
		
		System.out.println(cv);
		MemberVO mv = (MemberVO) session.getAttribute("S_MEMBER");
		String memId = mv.getMemId();
		cv.setMsgSender(memId);
		cv.setMsgReceiver("TEST_ID2");
		chatService.create(cv);
	}
	
	
	@ResponseBody
	@RequestMapping(path = "/createAdmin.do", method = RequestMethod.POST)
	public void createAdmin(Model model, ChatVO cv, HttpSession session) {
		System.out.println("값 잘들어왔는지 확인 :" +cv);
		cv.setMsgSender("TEST_ID2");
		chatService.create(cv);
	}

	
}
