package com.aiinterview.script.web;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.fileUpload;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.view;

import java.io.IOException;
import java.io.InputStream;

import org.junit.Test;
import org.springframework.mock.web.MockMultipartFile;

import com.aiinterview.WebTestConfig;

public class ScriptGubunControllerTest extends WebTestConfig{

	@Test
	public void retrievePagingListTest() {
		try {
			mockMvc.perform(get("/scriptGubun/retrievePagingList.do"))
				.andExpect(status().is(200))
				.andExpect(view().name("manage/scriptGubunManage"));
		} catch (Exception e) { }
	}

	@Test
	public void scriptManageTest() {
		try {
			mockMvc.perform(get("/scriptGubun/scriptManage.do")
					.param("scriptGbSq", "2")
					.param("scriptGbList[0]",  "영어"))
				.andExpect(status().is(200))
				.andExpect(view().name("manage/scriptManage"));
		} catch (Exception e) { }
	}
	
	@Test
	public void createProcessTest() {
		try {
			mockMvc.perform(post("/scriptGubun/createProcess.do")
					.param("scriptGbContent", "금붕어")
					.param("scriptGbSt",  "Y"))
				.andExpect(status().is(302))
				.andExpect(view().name("redirect:/scriptGubun/retrievePagingList.do"));
		} catch (Exception e) { }
	}
	
	/* 일괄 등록 */
	@Test
	public void createMassiveScriptGbTest() {
		InputStream is  = getClass().getResourceAsStream("/file/scriptGbTest.xlsx");
		MockMultipartFile file = null;
		try {
			file = new MockMultipartFile("excelFile", "scriptGbTest.xlsx", "xlsx", is);
		} catch (IOException ex) { }
		
		try {
			mockMvc.perform(fileUpload("/scriptGubun/massiveCreateProcess.do")
					.file(file))
			.andExpect(status().is3xxRedirection())
			.andExpect(view().name("redirect:/scriptGubun/retrievePagingList.do"));
		} catch (Exception e) { }
	}
	
	@Test
	public void updateProcessTest(){
		try {
			mockMvc.perform(post("/scriptGubun/updateProcess.do")
					.param("scriptGbSqs[0]", "1")
					.param("scriptGbContents[0]", "Script Gubun Test")
					.param("scriptGbSts[0]", "N"))
			.andExpect(status().is(302))
			.andExpect(view().name("redirect:/scriptGubun/retrievePagingList.do"));
		} catch (Exception e) { }
	}
	
	@Test
	public void excelDownTest() {
		try {
			mockMvc.perform(get("/scriptGubun/list/excelDown.do"))
			.andExpect(status().is(200))
			.andExpect(view().name("excelView"));
		} catch (Exception e) { }
	}

	@Test
	public void statisticsViewTest() throws Exception {
		mockMvc.perform(get("/scriptGubun/statistics.do"))
			.andExpect(status().is(200))
			.andExpect(view().name("script/scriptGbStatistics"));
	}

	@Test
	public void retrieveRankingListTest() {
		try {
			mockMvc.perform(get("/scriptGubun/retrieveRankingList.do")
					.param("startDate", "2020-10-02")
					.param("endDate", "sysdate")
					.param("scriptGbSq", "2"))
			.andExpect(status().is(200))
			.andExpect(view().name("jsonView"));
		} catch (Exception e) { }
	}
	
	@Test
	public void retrieveScoreListTest() {
		try {
			mockMvc.perform(get("/scriptGubun/retrieveScoreList.do")
					.param("startDate", "2020-10-02")
					.param("endDate", "sysdate")
					.param("scriptGbSq", "2"))
			.andExpect(status().is(200))
			.andExpect(view().name("jsonView"));
		} catch (Exception e) { }
	}
}
