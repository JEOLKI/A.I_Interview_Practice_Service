package com.aiinterview.chat.web;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.model;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.view;

import org.junit.Test;
import org.springframework.mock.web.MockHttpSession;

import com.aiinterview.WebTestConfig;
import com.aiinterview.member.vo.MemberVO;

public class ChatControllerTest extends WebTestConfig{
	
	@Test
	public void roomTest() throws Exception {

		mockMvc.perform(get("/chat/room.do"))
		.andExpect(status().isOk())
		.andExpect(view().name("chat/chatRoom"));
	}
 
	@Test 
	public void alarmgCount( ) throws Exception{
		MemberVO mv = new MemberVO();
		mv.setMemId("MEMBER1");
		mv.setMemAuth("Y");
		
		mv.setMemId("TEST_ID2");
		mv.setMemSt("C");
		
		MockHttpSession session = new MockHttpSession();
		session.setAttribute("S_MEMBER", mv);
		
		mockMvc.perform(get("/chat/alarmCount.do").session(session))
		.andExpect(status().isOk())
		.andReturn();
	}
	
	@Test
	public void chatUser() throws Exception{
		MemberVO mv = new MemberVO();
		mv.setMemId("MEMBER1");
		mv.setMemAuth("Y");
		
		mv.setMemId("TEST_ID2");
		mv.setMemSt("C");
		
		MockHttpSession session = new MockHttpSession();
		session.setAttribute("S_MEMBER", mv);
		
		mockMvc.perform(get("/chat/chat.do")
				.session(session))
		.andExpect(status().isOk())
		.andExpect(model().attributeExists("chatList"))
		.andExpect(model().attributeExists("manager"))
		.andExpect(view().name("chat/chatmember"));
		
	}
	
	@Test
	public void adminTest() throws Exception{
		mockMvc.perform(get("/chat/admining.do")
				.param("memId", "MEMBER1"))
		.andExpect(status().isOk())
		.andExpect(view().name("chat/admin"));
	}
	
	@Test
	public void create() throws Exception{
		MemberVO mv = new MemberVO();
		mv.setMemId("MEMBER1");
		mv.setMemAuth("Y");
		
		mv.setMemId("TEST_ID2");
		mv.setMemSt("C");
		
		MockHttpSession session = new MockHttpSession();
		session.setAttribute("S_MEMBER", mv);
		
		mockMvc.perform(post("/chat/create.do").session(session))
		.andExpect(status().isOk());
	}
	
	@Test
	public void createAdmin() throws Exception{
		MemberVO mv = new MemberVO();
		mv.setMemAuth("Y");
		
		mv.setMemId("TEST_ID2");
		mv.setMemSt("C");
		
		MockHttpSession session = new MockHttpSession();
		session.setAttribute("S_MEMBER", mv);
		
		mockMvc.perform(post("/chat/createAdmin.do")
				.session(session)
				.param("msgReceiver", "MEMBER1"))
		.andExpect(status().isOk());
	}
	
	@Test
	public void managerId() throws Exception{
		mockMvc.perform(get("/chat/managerId.do"))
		.andExpect(status().isOk())
		.andReturn();
		
	}
	

	
}
