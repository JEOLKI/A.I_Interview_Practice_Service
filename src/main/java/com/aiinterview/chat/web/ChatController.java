package com.aiinterview.chat.web;

import java.util.ArrayList;
import java.util.HashSet;
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
	public static HttpSession usersSession;
	public static  List<String> IdList = new ArrayList<>();
	
	@RequestMapping(path = "/chat.do", method = RequestMethod.GET)
	public String chatting(HttpSession session, Model model) {
		
		usersSession =session;
		
		MemberVO mv = (MemberVO) session.getAttribute("S_MEMBER");
		System.out.println("mv.getId="+mv.getMemId());
		String memId = mv.getMemId();
		
		IdList.add(memId);
//		for(String data : IdList){
//		    if(!IdList.contains(data))
//		}
		String receiver = "TEST_ID2";
		
		//내가 보내는 사람이기 때문에 세션에서 가져온다.
		cv.setMsgSender(memId);
		cv.setMsgReceiver(receiver);
		
		List<ChatVO> chatList =  chatService.List(cv);
		
		model.addAttribute("chatList", chatList);
		model.addAttribute("Receiver", receiver);
		
		return "chat/index";
	}
	
	@RequestMapping(path = "/admining.do", method = RequestMethod.GET)
	public String admin(HttpSession session, Model model) {
		ChatVO cv = new ChatVO();
		List<String> arrayList = new ArrayList<>();
		
		List<List<ChatVO>> Listlist = new ArrayList<>();
		String Sender = "TEST_ID2";
		
		for(String data : IdList){
		    if(!arrayList.contains(data))
		        arrayList.add(data);
		}
		
	
		
		for (int i = 0; i < arrayList.size(); i++) {
			cv.setMsgSender(Sender);
			cv.setMsgReceiver(arrayList.get(i));
			List<ChatVO> chatList =  chatService.List(cv);
			Listlist.add(chatList);
			
			model.addAttribute("Receiver", arrayList.get(i));
		}
			model.addAttribute("Listlist", Listlist);
		
	
		model.addAttribute("arrayList", arrayList);
		
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
