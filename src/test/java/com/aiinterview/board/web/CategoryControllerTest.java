package com.aiinterview.board.web;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.fileUpload;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.view;

import java.io.InputStream;

import org.junit.Test;
import org.springframework.mock.web.MockMultipartFile;

import com.aiinterview.WebTestConfig;

public class CategoryControllerTest extends WebTestConfig{
	
	@Test
	public void retrievePagingListTest() throws Exception {
		mockMvc.perform(get("/category/retrievePagingList.do")
				.param("boardGbSq", "1"))
		.andExpect(status().isOk())
		.andExpect(view().name("manage/categoryManage"));
	}
	
	@Test
	public void createTest() throws Exception {
		mockMvc.perform(get("/category/create.do")
				.param("boardGbSq", "1")
				.param("catContent", "TEST")
				.param("catSt", "Y"))
		.andExpect(status().is3xxRedirection())
		.andExpect(view().name("redirect:/category/retrievePagingList.do?boardGbSq=1"));
	}
	
	@Test
	public void updateTest() throws Exception {
		mockMvc.perform(get("/category/update.do")
				.param("catSqArr[0]", "1")
				.param("catContentArr[0]", "TEST")
				.param("boardGbSq", "1")
				.param("catStArr[0]", "Y"))
		.andExpect(status().is3xxRedirection())
		.andExpect(view().name("redirect:/category/retrievePagingList.do?boardGbSq=1"));
	}

	@Test
	public void excelDownTest() throws Exception {
		mockMvc.perform(get("/category/list/excelDown.do")
						.param("boardGbSq", "1"))
		.andExpect(status().isOk())
		.andExpect(view().name("excelView"));
	}
	
	@Test
	public void createMassiveTest() throws Exception {
		
		InputStream is = getClass().getResourceAsStream("/file/categoryTest.xlsx");
		MockMultipartFile file = new MockMultipartFile("excelFile", "categoryTest.xlsx", "xlsx", is);
		
		mockMvc.perform(fileUpload("/category/massiveCreateProcess.do")
						.file(file)
						.param("boardGbSq", "1"))
				.andExpect(status().is3xxRedirection())
				.andExpect(view().name("redirect:/category/retrievePagingList.do"));
		
	}
	
}
