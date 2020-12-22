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


public class SampleQuestionControllerTest extends WebTestConfig {


	@Test
	public void retrievePagingListTest() throws Exception {
		mockMvc.perform(get("/sampQuest/retrievePagingList.do"))
		.andExpect(status().is(200))
		.andExpect(view().name("manage/sampleQuestionManage"));
	}

	@Test
	public void createSampQuestProcessTest() throws Exception {
		mockMvc.perform(post("/sampQuest/createProcess.do")
				.param("sampQuestContent", "TEST")
				.param("sampQuestSt", "Y")
				.param("questGbSq", "1"))
		.andExpect(status().is(302))
		.andExpect(view().name("redirect:/sampQuest/retrievePagingList.do"));
	}
	
	@Test
	public void createMassiveSampQuestTest() throws Exception {
		InputStream is  = getClass().getResourceAsStream("/file/sampleQuestionTest.xlsx");
		MockMultipartFile file = new MockMultipartFile("excelFile", "sampleQuestionTest.xlsx", "xlsx", is);
		
		mockMvc.perform(fileUpload("/sampQuest/massiveCreateProcess.do")
				.file(file))
		.andExpect(status().is3xxRedirection())
		.andExpect(view().name("redirect:/sampQuest/retrievePagingList.do"));
	}
	
	@Test
	public void excelDownTest() throws Exception {
		mockMvc.perform(get("/sampQuest/list/excelDown.do"))
		.andExpect(status().is(200))
		.andExpect(view().name("excelView"));
	}

	@Test
	public void updateProcessTest() throws Exception {
		mockMvc.perform(post("/sampQuest/updateProcess.do")
				.param("sampQuestSqs[0]", "1")
				.param("sampQuestContents[0]", "TEST")
				.param("sampQuestSts[0]", "N"))
		.andExpect(status().is(302))
		.andExpect(view().name("redirect:/sampQuest/retrievePagingList.do"));
	}
	
	@Test
	public void retrieveRandomTest() throws Exception {
		mockMvc.perform(get("/sampQuest/retrieveRandom.do"))
		.andExpect(status().is(200))
		.andExpect(view().name("jsonView"));
	}
	
	@Test
	public void statisticsTest() throws Exception {
		mockMvc.perform(get("/sampQuest/statistics.do"))
		.andExpect(status().is(200))
		.andExpect(view().name("manage/questionStatistic"));
	}
	
	@Test
	public void retrieveQuestGbStatisticsListTest() throws Exception {
		mockMvc.perform(get("/sampQuest/retrieveQuestGbStatisticsList.do")
				.param("startDate", "2020-01-01")
				.param("endDate", "sysdate"))
		.andExpect(status().is(200))
		.andExpect(view().name("jsonView"));
	}
	
	@Test
	public void retrieveQuestGbAndSampStatisticsListTest() throws Exception {
		mockMvc.perform(get("/sampQuest/retrieveQuestGbAndSampStatisticsList.do")
				.param("startDate", "2020-01-01")
				.param("endDate", "sysdate"))
		.andExpect(status().is(200))
		.andExpect(view().name("jsonView"));
	}

}
