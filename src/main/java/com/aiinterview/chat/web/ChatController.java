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
	public static  HttpSession usersSession;
	public static  List<String> IdList = new ArrayList<>();
	
	@RequestMapping(path = "/test.do", method = RequestMethod.GET)
	public String test() {
		
		return "chat/test";
	}
	
	@ResponseBody
	@RequestMapping(path = "/session.do", method = RequestMethod.GET)
	public void session(HttpSession session) {
		usersSession =session;
	}
	
	@RequestMapping(path = "/room.do", method = RequestMethod.GET)
	public String room(Model model, HttpSession session) {
		
		List<ChatRoomVO> roomList;
		try {
			roomList = chatService.retrieveRoomList();
			model.addAttribute("roomList", roomList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "chat/chatRoom";
	}
	
	@ResponseBody
	@RequestMapping(path = "alarmCount.do", method = RequestMethod.GET)
	public String alarmCount(Model model, HttpSession session) {
		usersSession =session;
		
		MemberVO mv = (MemberVO) session.getAttribute("S_MEMBER");
		System.out.println("alarmCount의 mv 값: "+  mv);
		String alarmCount = "0";
		if(mv!=null) {
			try {
				alarmCount = chatService.alarmCount(mv.getMemId());
				model.addAttribute("alarmCount", alarmCount);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return alarmCount;
	}
	
	@RequestMapping(path = "/chat.do", method = RequestMethod.GET)
	public String chatting(HttpSession session, Model model) {
	
		usersSession =session;
		
		ChatVO cv = new ChatVO();
		
		MemberVO mv = (MemberVO) session.getAttribute("S_MEMBER");
		String memId = mv.getMemId();
		
		MemberVO manager;
		try {
			manager = chatService.searchManager();
			String sender = manager.getMemId();
			Admin.chatEnter(memId);
			
			cv.setMsgSender(sender);
			cv.setMsgReceiver(memId);
			chatService.alarmUpdate(cv);
			model.addAttribute("manager", sender);
			List<ChatVO> chatList =  chatService.retrieveList(cv);
			model.addAttribute("chatList", chatList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "chat/chatmember";
	}
	
	@RequestMapping(path = "/admining.do", method = RequestMethod.GET)
	public String admin(HttpSession session, Model model,String memId) {
		
		ChatVO cv = new ChatVO();
		
		MemberVO manager;
		try {
			manager = chatService.searchManager();
			String sender = manager.getMemId();
			cv.setMsgSender(memId);
			cv.setMsgReceiver(sender);
			chatService.alarmUpdate(cv);
			List<ChatVO> chatList =  chatService.retrieveList(cv);
			model.addAttribute("chatList", chatList);
			model.addAttribute("manager", sender);
		} catch (Exception e1) {
			e1.printStackTrace();
		}
		try {
			MemberVO mv = memberService.retrieve(memId);
			model.addAttribute("mv", mv);
			model.addAttribute("memId", memId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "chat/admin";
	}
	
	@ResponseBody
	@RequestMapping(path = "/create.do", method = RequestMethod.POST)
	public void createProcess(Model model, ChatVO cv, HttpSession session) {
		
		MemberVO mv = (MemberVO) session.getAttribute("S_MEMBER");
		String memId = mv.getMemId();
		
		MemberVO manager;
		try {
			manager = chatService.searchManager();
			String receiver = manager.getMemId();
			cv.setMsgSender(memId);
			cv.setMsgReceiver(receiver);
			chatService.create(cv);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	@ResponseBody
	@RequestMapping(path = "/createAdmin.do", method = RequestMethod.POST)
	public void createAdmin(ChatVO cv) {
		MemberVO manager;
		try {
			manager = chatService.searchManager();
			String sender = manager.getMemId();
			cv.setMsgSender(sender);
			chatService.create(cv);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@ResponseBody
	@RequestMapping(path = "/managerId.do", method = RequestMethod.GET)
	public String managerId() {
		String sender = null;
		MemberVO manager;
		try {
			manager = chatService.searchManager();
			sender = manager.getMemId();
		}catch (Exception e) {
			e.printStackTrace();
		}
		return sender;
	}
	public static void sendAdminKey (String key, String message) {
		BroadSocket.sendMessage(key, message);
	}
	
}
