package com.aiinterview.chat.dao;

import static org.junit.Assert.assertEquals;

import java.util.List;

import javax.annotation.Resource;

import org.antlr.grammar.v3.ANTLRParser.exceptionGroup_return;
import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.aiinterview.ModelTestConfig;
import com.aiinterview.chat.vo.ChatRoomVO;
import com.aiinterview.chat.vo.ChatVO;
import com.aiinterview.member.vo.MemberVO;

public class ChatMapperTest extends ModelTestConfig {

	private static final Logger logger = LoggerFactory.getLogger(ChatMapperTest.class);
	
	@Resource(name = "chatMapper")
	private ChatMapper chatMapper;
	
	
	@Test
	public void ListTest()throws Exception {
		/*** Given ***/
		ChatVO cv = new ChatVO();
		cv.setMsgReceiver("TEST_ID2");
		cv.setMsgSender("MEMBER1");

		/*** When ***/
		List<ChatVO> chatList =  chatMapper.List(cv);

		/*** Then ***/
		assertEquals(5, chatList.size());
	}
	
	@Test
	public void createTest()throws Exception{
		/*** Given ***/
		ChatVO cv = new ChatVO();
		cv.setMsgAlarm("N");
		cv.setMsgContent("테스트중입니다.");
		cv.setMsgReceiver("MEMBER1");
		cv.setMsgSender("TEST_ID2");
		
		/*** When ***/
		int result = chatMapper.create(cv);
		/*** Then ***/
		assertEquals(1, result);
	}

	@Test 
	public void roomListTest()throws Exception{
		/*** Given ***/
		
		/*** When ***/
		List<ChatRoomVO> chatList = chatMapper.roomList();
		
		/*** Then ***/
		assertEquals(2, chatList.size());
	}
	
	@Test
	public void alarmUpdate() {
		/*** Given ***/
		ChatVO cv = new ChatVO();
		cv.setMsgReceiver("TEST_ID2");
		cv.setMsgSender("MEMBER1");
		/*** When ***/
		int result = chatMapper.alarmUpdate(cv);
		/*** Then ***/
		assertEquals(1, result);
	}
	
	@Test
	public void alarmCount() {
		/*** Given ***/
		String memId = "TEST_ID2";
		/*** When ***/
		String result = chatMapper.alarmCount(memId);
		/*** Then ***/
		assertEquals("2", result);
	}
	
	@Test
	public void searchManager() {
		/*** Given ***/
		
		/*** When ***/
		MemberVO mv = chatMapper.searchManager();
		/*** Then ***/
		assertEquals("TEST_ID2", mv.getMemId());
	}
	
	
	
}
