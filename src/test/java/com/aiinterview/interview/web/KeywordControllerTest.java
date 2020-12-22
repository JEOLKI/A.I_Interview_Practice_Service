package com.aiinterview.interview.web;

import static org.junit.Assert.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.view;

import java.io.InputStream;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.fileUpload;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.model;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.view;
import org.junit.Test;
import org.springframework.mock.web.MockMultipartFile;
import org.springframework.test.web.servlet.request.MockHttpServletRequestBuilder;

import com.aiinterview.WebTestConfig;

public class KeywordControllerTest  extends WebTestConfig {


	@Test
	public void createTest() throws Exception {
		mockMvc.perform(get("/keyword/create.do")
				.param("talentSq", "2")
				.param("keywordContent", "열정"))
		.andExpect(status().is(302))
		.andExpect(view().name("redirect:/talent/keywordManage.do?talentSq=2"));
	}

	@Test
	public void deleteTest() throws Exception {
		mockMvc.perform(post("/keyword/delete.do")
				.param("keywordSqs[0]", "1")
				.param("keywordContents[0]", "꾸준함")
				.param("deleteChecks[0]", "Y")
				.param("talentSqs[0]", "2")
				.param("talentSq","2"))
		.andExpect(status().is(302))
		.andExpect(view().name("redirect:/talent/keywordManage.do?talentSq=2"));
	}
	
	@Test
	public void excelDownTest() throws Exception {
		mockMvc.perform(get("/keyword/list/excelDown.do")
				.param("talentSq","2"))
		.andExpect(status().is(200))
		.andExpect(view().name("excelView"));
	}
	
	@Test
	public void createMassiveHabitTest() throws Exception {
		InputStream is  = getClass().getResourceAsStream("/file/habitTest.xlsx");
		MockMultipartFile file = new MockMultipartFile("excelFile", "habitTest.xlsx", "xlsx", is);
		
		mockMvc.perform(fileUpload("/keyword/massiveCreateProcess.do")
				.file(file)
				.param("talentSq","2"))
		.andExpect(status().is3xxRedirection())
		.andExpect(view().name("redirect:/talent/keywordManage.do?talentSq=2"));
	}
	

}
