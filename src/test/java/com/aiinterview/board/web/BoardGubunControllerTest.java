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

public class BoardGubunControllerTest extends WebTestConfig{

	@Test
	public void retrieveListTest() throws Exception {
		mockMvc.perform(get("/boardGubun/retrieveList.do"))
				.andExpect(status().isOk())
				.andExpect(view().name("jsonView"));
	}
	
	@Test
	public void retrievePagingListTest() throws Exception {
		mockMvc.perform(get("/boardGubun/retrievePagingList.do"))
		.andExpect(status().isOk())
		.andExpect(view().name("manage/boardGbManage"));
	}
	
	@Test
	public void createTest() throws Exception {
		mockMvc.perform(get("/boardGubun/create.do")
				.param("boardGbNm", "TEST")
				.param("boardGbSt", "Y"))
		.andExpect(status().is3xxRedirection())
		.andExpect(view().name("redirect:/boardGubun/retrievePagingList.do"));
	}
	
	@Test
	public void updateTest() throws Exception {
		mockMvc.perform(get("/boardGubun/update.do")
				.param("boardGbSqArr[0]", "1")
				.param("boardGbNmArr[0]", "TEST")
				.param("boardGbStArr[0]", "Y"))
		.andExpect(status().is3xxRedirection())
		.andExpect(view().name("redirect:/boardGubun/retrievePagingList.do"));
	}

	@Test
	public void excelDownTest() throws Exception {
		mockMvc.perform(get("/boardGubun/list/excelDown.do"))
		.andExpect(status().isOk())
		.andExpect(view().name("excelView"));
	}
	
	@Test
	public void createMassiveHabitTest() throws Exception {
		
		InputStream is = getClass().getResourceAsStream("/file/boardGubunTest.xlsx");
		MockMultipartFile file = new MockMultipartFile("excelFile", "boardGubunTest.xlsx", "xlsx", is);
		
		mockMvc.perform(fileUpload("/boardGubun/massiveCreateProcess.do")
						.file(file))
				.andExpect(status().is3xxRedirection())
				.andExpect(view().name("redirect:/boardGubun/retrievePagingList.do"));
	}
	
	@Test
	public void statisticTest() throws Exception {
		mockMvc.perform(get("/boardGubun/statistic.do"))
		.andExpect(status().isOk())
		.andExpect(view().name("manage/boardGbStatistics"));
	}
	
	@Test
	public void retrieveStatisticsTest() throws Exception {
		mockMvc.perform(get("/boardGubun/retrieveStatistics.do"))
		.andExpect(status().isOk())
		.andExpect(model().attributeExists("boardGbList"))
		.andExpect(view().name("jsonView"));
	}
	
}
