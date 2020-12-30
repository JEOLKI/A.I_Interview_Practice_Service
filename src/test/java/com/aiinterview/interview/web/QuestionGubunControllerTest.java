package com.aiinterview.interview.web;

import static org.junit.Assert.*;

import org.junit.Test;
import org.springframework.mock.web.MockMultipartFile;

import com.aiinterview.WebTestConfig;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.fileUpload;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.model;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.view;

import java.io.InputStream;


public class QuestionGubunControllerTest  extends WebTestConfig {

	@Test
	public void retrievePagingListTest() throws Exception{
		mockMvc.perform(get("/questGb/retrievePagingList.do"))
		.andExpect(status().is(200))
		.andExpect(view().name("manage/questionGubunManage"));
	}
	
	@Test
	public void createQuestGbProcessTest() throws Exception {
		mockMvc.perform(post("/questGb/createProcess.do")
				.param("questGbContent", "TEST")
				.param("questGbSt", "Y"))
		.andExpect(status().is(302))
		.andExpect(view().name("redirect:/questGb/retrievePagingList.do"));
	}

	@Test
	public void createMassiveQuestGbTest() throws Exception {
		InputStream is  = getClass().getResourceAsStream("/file/questionGubunTest.xlsx");
		MockMultipartFile file = new MockMultipartFile("excelFile", "questionGubunTest.xlsx", "xlsx", is);
		
		mockMvc.perform(fileUpload("/questGb/massiveCreateProcess.do")
				.file(file))
		.andExpect(status().is3xxRedirection())
		.andExpect(view().name("redirect:/questGb/retrievePagingList.do"));
	}
	
	@Test
	public void updateProcessTest() throws Exception {
		mockMvc.perform(post("/questGb/updateProcess.do")
				.param("questGbSqs[0]", "1")
				.param("questGbContents[0]", "TEST")
				.param("questGbSts[0]", "N"))
		.andExpect(status().is(302))
		.andExpect(view().name("redirect:/questGb/retrievePagingList.do"));
	}

	@Test
	public void excelDownTest() throws Exception {
		mockMvc.perform(get("/questGb/list/excelDown.do"))
		.andExpect(status().is(200))
		.andExpect(view().name("excelView"));
	}
	
}
