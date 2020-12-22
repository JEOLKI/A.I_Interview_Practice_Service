package com.aiinterview.chat.web;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.eclipse.jdt.internal.compiler.ast.ModuleDeclaration;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
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
	
	@RequestMapping(path = "/room.do", method = RequestMethod.GET)
	public String room(Model model, HttpSession session) {
		List<ChatRoomVO> roomList = chatService.retrieveRoomList();
		model.addAttribute("roomList", roomList);
		return "chat/chatRoom";
	}
	
	@ResponseBody
	@RequestMapping(path = "alarmCount.do", method = RequestMethod.GET)
	public String alarmgCount(Model model, HttpSession session) {
		
		MemberVO mv = (MemberVO) session.getAttribute("S_MEMBER");
		String alarmCount = chatService.alarmCount(mv.getMemId());
		model.addAttribute("alarmCount", alarmCount);
		
		return alarmCount;
	}
	
	@RequestMapping(path = "/chat.do", method = RequestMethod.GET)
	public String chatting(HttpSession session, Model model) {
		usersSession =session;
		ChatVO cv = new ChatVO();
		
		MemberVO mv = (MemberVO) session.getAttribute("S_MEMBER");
		String memId = mv.getMemId();
		
		MemberVO manager = chatService.searchManager();
		String sender = manager.getMemId();
		
		Admin.chatEnter(memId);
		
		cv.setMsgSender(sender);
		cv.setMsgReceiver(memId);
		chatService.alarmUpdate(cv);
		
		//내가 보내는 사람이기 때문에 세션에서 가져온다.
		
		List<ChatVO> chatList =  chatService.retrieveList(cv);
		
		System.out.println("chatList확인 : "+chatList);
		
		model.addAttribute("chatList", chatList);
		model.addAttribute("manager", sender);
		
		
		return "chat/index";
		
	}
	
	
	@RequestMapping(path = "/admining.do", method = RequestMethod.GET)
	public String admin(HttpSession session, Model model,String memId) {
		
//		BroadSocket.sessionId(memId);
		
		sendAdminKey(memId, "AI_INTERVIEW_ADMIN_CHAT_ENTER");
		
		ChatVO cv = new ChatVO();
		
		MemberVO manager = chatService.searchManager();
		String sender = manager.getMemId();
		
		cv.setMsgSender(memId);
		cv.setMsgReceiver(sender);
		System.out.println("업데이트 확인 : "+  cv);
		chatService.alarmUpdate(cv);
		
		List<ChatVO> chatList =  chatService.retrieveList(cv);
		
		model.addAttribute("chatList", chatList);
		model.addAttribute("memId", memId);
		model.addAttribute("manager", sender);
		
		return "chat/admin";
	}
	
	@ResponseBody
	@RequestMapping(path = "/create.do", method = RequestMethod.POST)
	public void createProcess(Model model, ChatVO cv, HttpSession session) {
		
		MemberVO mv = (MemberVO) session.getAttribute("S_MEMBER");
		String memId = mv.getMemId();
		
		MemberVO manager = chatService.searchManager();
		String receiver = manager.getMemId();
		
		cv.setMsgSender(memId);
		cv.setMsgReceiver(receiver);
		chatService.create(cv);
	}
	
	
	@ResponseBody
	@RequestMapping(path = "/createAdmin.do", method = RequestMethod.POST)
	public void createAdmin(ChatVO cv) {
		MemberVO manager = chatService.searchManager();
		String sender = manager.getMemId();
		cv.setMsgSender(sender);
		chatService.create(cv);
	}
	
	@ResponseBody
	@RequestMapping(path = "/managerId.do", method = RequestMethod.GET)
	public String managerId() {
		MemberVO manager = chatService.searchManager();
		String sender = manager.getMemId();
		return sender;
	}
	
	public static void sendAdminKey (String key, String message) {
		BroadSocket.sendMessage(key, message);
	}
	
	
}
