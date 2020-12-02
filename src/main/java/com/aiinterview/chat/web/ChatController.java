package com.aiinterview.chat.web;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.aiinterview.chat.service.ChatService;
import com.aiinterview.chat.vo.ChatVO;
import com.aiinterview.member.vo.MemberVO;
import com.aiinterview.member.web.LoginController;


@RequestMapping("/chat")
@Controller
public class ChatController {
	
	@Resource(name = "chatService")
	ChatService chatService;
	
	@RequestMapping(path = "/list.do", method = RequestMethod.GET)
	public String ListView(Model model, ChatVO cv, HttpSession session) {
		System.out.println("aaaa");
		MemberVO mv = (MemberVO) session.getAttribute("S_MEMBER");
		String memId = mv.getMemId();
		
		String receiver = "a002";
		
		//내가 보내는 사람이기 때문에 세션에서 가져온다.
		cv.setMsgSender(memId);
		cv.setMsgReceiver(receiver);
		
		List<ChatVO> chatList =  chatService.List(cv);
		
		for (int i = 0; i < chatList.size(); i++) {
			System.out.println(chatList.get(i));
		}
		
		model.addAttribute("chatList", chatList);
		return "chat/Chat";
	}
	
	
	
}
