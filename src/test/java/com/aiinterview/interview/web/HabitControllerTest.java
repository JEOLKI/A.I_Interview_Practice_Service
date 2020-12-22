package com.aiinterview.interview.web;

import static org.junit.Assert.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.view;

import java.io.InputStream;
import java.util.List;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.fileUpload;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.model;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.view;

import org.junit.Test;
import org.springframework.mock.web.MockMultipartFile;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.util.MultiValueMap;
import org.springframework.web.servlet.ModelAndView;

import com.aiinterview.WebTestConfig;

public class HabitControllerTest extends WebTestConfig{
	
	@Test
	public void retrievePagingListTest() throws Exception {
		mockMvc.perform(get("/habit/retrievePagingList.do"))
		.andExpect(status().is(200))
		.andExpect(view().name("manage/habitManage"));
	}
	
	@Test
	public void createProcessTest() throws Exception {
		mockMvc.perform(post("/habit/createProcess.do")
				.param("habitGb", "오")
				.param("habitSt", "Y"))
		.andExpect(status().is(302))
		.andExpect(view().name("redirect:/habit/retrievePagingList.do"));
	}

	@Test
	public void updateProcessTest() throws Exception {
		mockMvc.perform(post("/habit/createProcess.do")
				.param("habitSqs[0]", "1")
				.param("habitGbs[0]", "TEST")
				.param("habitSts[0]", "N"))
		.andExpect(status().is(302))
		.andExpect(view().name("redirect:/habit/retrievePagingList.do"));
	}
	
	@Test
	public void createMassiveHabitTest() throws Exception {
		InputStream is  = getClass().getResourceAsStream("/file/habitTest.xlsx");
		MockMultipartFile file = new MockMultipartFile("excelFile", "habitTest.xlsx", "xlsx", is);
		
		mockMvc.perform(fileUpload("/habit/massiveCreateProcess.do")
				.file(file))
		.andExpect(status().is3xxRedirection())
		.andExpect(view().name("redirect:/habit/retrievePagingList.do"));
	}
	
	@Test
	public void excelDownTest() throws Exception {
		mockMvc.perform(get("/habit/list/excelDown.do"))
		.andExpect(status().is(200))
		.andExpect(view().name("excelView"));
	}
	
	@Test
	public void statisticsTest() throws Exception {
		mockMvc.perform(get("/habit/statistics.do"))
		.andExpect(status().is(200))
		.andExpect(view().name("manage/habitStatistics"));
	}
	
	@Test
	public void retrieveHabitStatisticsListTest() throws Exception {
		mockMvc.perform(get("/habit/retrieveHabitStatisticsList.do")
				.param("startDate", "2020-01-01")
				.param("endDate", "sysdate"))
		.andExpect(status().is(200))
		.andExpect(view().name("jsonView"));
	}

}
