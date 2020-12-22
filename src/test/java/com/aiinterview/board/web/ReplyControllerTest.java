package com.aiinterview.board.web;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.view;

import org.junit.Test;

import com.aiinterview.WebTestConfig;

public class ReplyControllerTest extends WebTestConfig{

	@Test
	public void createTest() throws Exception {
		mockMvc.perform(get("/reply/create.do")
				.param("replyContent", "TEST")
				.param("boardSq", "1")
				.param("memId", "TEST_ID"))
		.andExpect(status().is3xxRedirection())
		.andExpect(view().name("redirect:/board/retrieve.do?boardSq=1"));
	}

	
	@Test
	public void deleteProcessTest() throws Exception {
		mockMvc.perform(get("/reply/delete.do")
				.param("replySq", "1")
				.param("replyContent", "TEST")
				.param("boardSq", "1")
				.param("memId", "TEST_ID"))
		.andExpect(status().is3xxRedirection())
		.andExpect(view().name("redirect:/board/retrieve.do?boardSq=1"));
	}
	
	@Test
	public void updateTest() throws Exception {
		mockMvc.perform(get("/reply/update.do")
				.param("replySq", "1")
				.param("replyContent", "TEST")
				.param("boardSq", "1")
				.param("memId", "TEST_ID"))
		.andExpect(status().is3xxRedirection())
		.andExpect(view().name("redirect:/board/retrieve.do?boardSq=1"));
	}
}
