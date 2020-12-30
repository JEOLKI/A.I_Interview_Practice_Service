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
	
	public List<ChatVO> retrieveList(ChatVO cv) throws Exception{
		return chatMapper.retrieveList(cv);
	}
	
	public int create(ChatVO cv) throws Exception{
		return chatMapper.create(cv) ;
	}
	
	public List<ChatRoomVO> retrieveRoomList() throws Exception{
		return chatMapper.retrieveRoomList();
	}
	
	public int alarmUpdate(ChatVO cv) throws Exception {
		return chatMapper.alarmUpdate(cv);
	}
	
	public String alarmCount(String memId) throws Exception{
		return chatMapper.alarmCount(memId);
	}
	
	public MemberVO searchManager() throws Exception {
		return chatMapper.searchManager();
	}
}
