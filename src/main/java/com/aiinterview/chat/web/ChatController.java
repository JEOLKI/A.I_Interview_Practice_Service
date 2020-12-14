package com.aiinterview.chat.web;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.aiinterview.chat.service.ChatService;
import com.aiinterview.chat.vo.ChatVO;
import com.aiinterview.member.vo.MemberVO;


@RequestMapping("/chat")
@Controller
public class ChatController {
	
	@Resource(name = "chatService")
	ChatService chatService;
	
	ChatVO cv = new ChatVO();
	@RequestMapping(path = "/chat.do", method = RequestMethod.GET)
	public String chatting(HttpSession session, Model model) {
		
		MemberVO mv = (MemberVO) session.getAttribute("S_MEMBER");
		String memId = mv.getMemId();
		
		String receiver = "TEST_ID2";
		
		//내가 보내는 사람이기 때문에 세션에서 가져온다.
		cv.setMsgSender(memId);
		cv.setMsgReceiver(receiver);
		
		List<ChatVO> chatList =  chatService.List(cv);
		
		model.addAttribute("chatList", chatList);
		model.addAttribute("Receiver", receiver);
		
		Admin.user(memId);
		BroadSocket.users(memId);
		return "chat/index";
	}
	
	@RequestMapping(path = "/admining.do", method = RequestMethod.GET)
	public String admin(HttpSession session, Model model) {
		
		
		
		
		return "chat/admin";
	}
	
	@RequestMapping(path = "/test.do", method = RequestMethod.GET)
	public String test() {
		return "chat/chatList";
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
	
	@RequestMapping(path = "/create.do", method = RequestMethod.POST)
	public void createProcess(Model model, ChatVO cv, HttpSession session) {
		chatService.create(cv);
	}
	
	
}
