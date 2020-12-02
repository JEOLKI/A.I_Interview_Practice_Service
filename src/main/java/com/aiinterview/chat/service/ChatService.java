package com.aiinterview.chat.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.aiinterview.chat.dao.ChatMapper;
import com.aiinterview.chat.vo.ChatVO;

@Service("chatService")
public class ChatService {

	@Resource(name = "chatMapper")
	private ChatMapper chatMapper;
	
	public List<ChatVO> List(ChatVO cv){
		return chatMapper.List(cv);
	}
	
	
	
	
	
}
