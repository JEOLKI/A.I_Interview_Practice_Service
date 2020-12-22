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

public class TalentControllerTest extends WebTestConfig {

	@Test
	public void retrievePagingListTest() throws Exception {
		mockMvc.perform(get("/talent/retrievePagingList.do"))
		.andExpect(status().is(200))
		.andExpect(view().name("manage/talentManage"));
	}
	
	@Test
	public void createProcessTest() throws Exception {
		mockMvc.perform(post("/talent/createProcess.do")
				.param("talentNm", "도전")
				.param("talentSt", "Y"))
		.andExpect(status().is(302))
		.andExpect(view().name("redirect:/talent/retrievePagingList.do"));
	}
	
	@Test
	public void createMassiveTalentTest() throws Exception {
		InputStream is  = getClass().getResourceAsStream("/file/talentTest.xlsx");
		MockMultipartFile file = new MockMultipartFile("excelFile", "talentTest.xlsx", "xlsx", is);
		
		mockMvc.perform(fileUpload("/talent/massiveCreateProcess.do")
				.file(file))
		.andExpect(status().is3xxRedirection())
		.andExpect(view().name("redirect:/talent/retrievePagingList.do"));
	}
	
	@Test
	public void updateProcessTest() throws Exception {
		mockMvc.perform(post("/talent/updateProcess.do")
				.param("talentSqs[0]", "1")
				.param("talentNms[0]", "TEST")
				.param("talentSts[0]", "N"))
		.andExpect(status().is(302))
		.andExpect(view().name("redirect:/talent/retrievePagingList.do"));
	}
	
	@Test
	public void talentKeywordUpdateTest() throws Exception {
		mockMvc.perform(post("/talent/update.do")
				.param("talentSq", "1")
				.param("talentNm", "TEST")
				.param("talentSt", "N"))
		.andExpect(status().is(302))
		.andExpect(view().name("redirect:/talent/keywordManage.do?talentSq=1"));
	}
	
	@Test
	public void excelDownTest() throws Exception {
		mockMvc.perform(get("/talent/list/excelDown.do"))
		.andExpect(status().is(200))
		.andExpect(view().name("excelView"));
	}
	
	@Test
	public void keywordManageTest() throws Exception {
		mockMvc.perform(get("/talent/keywordManage.do")
				.param("talentSq", "2"))
		.andExpect(status().is(200))
		.andExpect(view().name("manage/talentKeywordManage"));
	}
	
	@Test
	public void statisticsTest() throws Exception {
		mockMvc.perform(get("/talent/statistics.do"))
		.andExpect(status().is(200))
		.andExpect(view().name("manage/talentStatistic"));
	}
	
	@Test
	public void talentStatisticsTest() throws Exception {
		mockMvc.perform(get("/talent/retrieveStatisticsList.do")
				.param("startDate", "2020-01-01")
				.param("endDate", "sysdate"))
		.andExpect(status().is(200))
		.andExpect(view().name("jsonView"));
	}
	

}
