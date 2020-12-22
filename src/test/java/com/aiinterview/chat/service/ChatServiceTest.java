package com.aiinterview.chat.service;

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

public class ChatServiceTest extends ModelTestConfig {

	private static final Logger logger = LoggerFactory.getLogger(ChatServiceTest.class);
	
	@Resource(name = "chatService")
	private ChatService chatService;
	
	
	@Test
	public void listTest() throws Exception { 
		
		/*** Given ***/
		ChatVO cv = new ChatVO();
		cv.setMsgReceiver("TEST_ID2");
		cv.setMsgSender("MEMBER1");

		/*** When ***/
		List<ChatVO> chatList =  chatService.retrieveList(cv);

		/*** Then ***/
		assertEquals(5, chatList.size());
	}
	
	@Test
	public void createTest() throws Exception{
		/*** Given ***/
		ChatVO cv = new ChatVO();
		cv.setMsgAlarm("N");
		cv.setMsgContent("테스트중입니다.");
		cv.setMsgReceiver("MEMBER1");
		cv.setMsgSender("TEST_ID2");
		
		/*** When ***/
		int result = chatService.create(cv);
		/*** Then ***/
		assertEquals(1, result);
	}

	@Test 
	public void roomListTest() throws Exception{
		/*** Given ***/
		
		/*** When ***/
		List<ChatRoomVO> chatList = chatService.retrieveRoomList();
		
		/*** Then ***/
		assertEquals(2, chatList.size());
	}
	
	@Test
	public void alarmUpdate() throws Exception {
		/*** Given ***/
		ChatVO cv = new ChatVO();
		cv.setMsgReceiver("TEST_ID2");
		cv.setMsgSender("MEMBER1");
		/*** When ***/
		int result = chatService.alarmUpdate(cv);
		/*** Then ***/
		assertEquals(1, result);
	}
	
	@Test
	public void alarmCount() throws Exception {
		/*** Given ***/
		String memId = "TEST_ID2";
		/*** When ***/
		String result = chatService.alarmCount(memId);
		/*** Then ***/
		assertEquals("2", result);
	}
	
	@Test
	public void searchManager() throws Exception {
		/*** Given ***/
		
		/*** When ***/
		MemberVO mv = chatService.searchManager();
		/*** Then ***/
		assertEquals("TEST_ID2", mv.getMemId());
	}
	
	
	
}
