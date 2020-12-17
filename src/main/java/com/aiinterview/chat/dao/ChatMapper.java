package com.aiinterview.chat.dao;

import java.util.List;

import com.aiinterview.chat.vo.ChatRoomVO;
import com.aiinterview.chat.vo.ChatVO;
import com.aiinterview.member.vo.MemberVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("chatMapper")
public interface ChatMapper {

	/**
	 * 채팅을 할 때 목록을 불러오기 위한 메서드
	 * @param cv에 들어가는 1:1 채팅 두개
	 * @return
	 */
	List<ChatVO> List(ChatVO cv);

	/**
	 * 채팅 로그를 db에 저장하기 위한 메서드
	 * @param cv의 vo내용
	 * @return
	 */
	int create(ChatVO cv);
	
	/**
	 * 채팅방 리스트를 불러오기 위한 메서드 
	 * @param mv 전체 회원의 이름
	 * @return 
	 */
	List<ChatRoomVO>roomList();
	
}
