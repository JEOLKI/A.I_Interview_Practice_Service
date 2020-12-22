package com.aiinterview.board.web;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.fileUpload;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.model;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.view;

import java.io.InputStream;

import org.junit.Test;
import org.springframework.mock.web.MockMultipartFile;

import com.aiinterview.WebTestConfig;

public class BoardControllerTest extends WebTestConfig{

	@Test
	public void retrievePagingListTest() throws Exception {
		mockMvc.perform(get("/board/retrievePagingList.do")
						.param("boardGbSq", "1")
						.param("boardGbNm", "TEST"))
				.andExpect(status().isOk())
				.andExpect(view().name("board/boardList"));
	}
	
	@Test
	public void boardDetailTest() throws Exception {
		mockMvc.perform(get("/board/retrieve.do")
				.param("boardSq", "1"))
		.andExpect(status().isOk())
		.andExpect(model().attributeExists("boardVO"))
		.andExpect(model().attributeExists("attachmentList"))
		.andExpect(model().attributeExists("replyList"))
		.andExpect(view().name("board/boardDetail"));
	}
	
	@Test
	public void createGetTest() throws Exception {
		mockMvc.perform(get("/board/create.do")
				.param("boardGbSq", "1")
				.param("boardGbNm", "TEST"))
		.andExpect(status().isOk())
		.andExpect(model().attributeExists("parentSq"))
		.andExpect(model().attributeExists("groupNo"))
		.andExpect(model().attributeExists("boardGbSq"))
		.andExpect(model().attributeExists("boardGbNm"))
		.andExpect(view().name("board/boardCreate"));
	}
	
	@Test
	public void createPostTest() throws Exception {
		
		InputStream is = getClass().getResourceAsStream("/file/brown.png");
		MockMultipartFile file = new MockMultipartFile("file", "brown.png", "image/png", is);
		
		mockMvc.perform(fileUpload("/board/create.do")
						.file(file)
						.param("MemId", "TEST_ID")
						.param("boardGbSq", "TEST")
						.param("boardTitle", "TEST")
						.param("boardContent", "TEST")
						.param("catContent", "TEST"))
		.andExpect(status().is3xxRedirection());
	}
	
	@Test
	public void deleteTest() throws Exception {
		mockMvc.perform(get("/board/delete.do")
						.param("boardSq", "1")
						.param("boardGbSq", "1"))
				.andExpect(status().is3xxRedirection());
	}
	
	@Test
	public void updateViewTest() throws Exception {
		mockMvc.perform(get("/board/update.do")
				.param("boardSq", "1")
				.param("boardGbSq", "1"))
		.andExpect(model().attributeExists("boardVO"))
		.andExpect(model().attributeExists("attachmentList"))
		.andExpect(status().isOk())
		.andExpect(view().name("board/boardUpdate"));
	}
	
	@Test
	public void updateProcessTest() throws Exception {
		InputStream is = getClass().getResourceAsStream("/file/brown.png");
		MockMultipartFile file = new MockMultipartFile("file", "brown.png", "image/png", is);
		
		mockMvc.perform(fileUpload("/board/update.do")
						.file(file)
						.param("boardSq", "1")
						.param("MemId", "TEST_ID")
						.param("boardGbSq", "TEST")
						.param("boardTitle", "TEST")
						.param("boardContent", "TEST")
						.param("catContent", "TEST"))
		.andExpect(status().is3xxRedirection());
		
	}
	

}
