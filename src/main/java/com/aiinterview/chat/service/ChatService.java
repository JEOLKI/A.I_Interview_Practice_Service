package com.aiinterview.chat.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.w3c.dom.ls.LSInput;

import com.aiinterview.chat.dao.ChatMapper;
import com.aiinterview.chat.vo.ChatRoomVO;
import com.aiinterview.chat.vo.ChatVO;
import com.aiinterview.member.vo.MemberVO;

@Service("chatService")
public class ChatService {

	@Resource(name = "chatMapper")
	private ChatMapper chatMapper;
	
	public List<ChatVO> List(ChatVO cv){
		return chatMapper.List(cv);
	}
	
	public int create(ChatVO cv) {
		return chatMapper.create(cv);
	}
	
	public List<ChatRoomVO> roomList(){
		return chatMapper.roomList();
	}
	
	public int arlamUpdate(String memId) {
		return chatMapper.arlamUpdate(memId);
	}
	
}
