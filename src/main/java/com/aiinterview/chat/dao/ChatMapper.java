package com.aiinterview.chat.dao;

import java.util.List;

import com.aiinterview.chat.vo.ChatVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("chatMapper")
public interface ChatMapper {

	/**
	 * 채팅을 할 때 목록을 불러오기 위한 메서드
	 * @param cv에 들어가는 1:1 채팅 두개
	 * @return
	 */
	List<ChatVO> List(ChatVO cv);
	
}
