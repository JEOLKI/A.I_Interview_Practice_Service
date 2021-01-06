package com.aiinterview.script.web;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.view;

import org.junit.Test;

import com.aiinterview.WebTestConfig;

public class ScriptTestControllerTest extends WebTestConfig {
	
	@Test
	public void createTest() throws Exception{
			mockMvc.perform(post("/scriptTest/create.do")
					.param("resultScript",  "여름이었다.")
					.param("memId",  "MEMBER2")
					.param("scriptSq", "4"))
				.andExpect(status().is(302));
	}
	
	@Test
	public void testPopupTest() throws Exception{
			mockMvc.perform(get("/scriptTest/testPopup.do")
					.session(session))
				.andExpect(status().is(200))
				.andExpect(view().name("script/testPopup"));
	}
	
	@Test
	public void testStartTest() throws Exception{
		mockMvc.perform(post("/scriptTest/testStart.do")
				.param("scriptGbSq", "1")
				.session(session))
		.andExpect(status().is(200))
		.andExpect(view().name("script/testStart"));
	}
	
	@Test
	public void retrieveSelectListTest() throws Exception{
			mockMvc.perform(post("/scriptTest/retrieveScriptList.do")
					.param("scriptGbSq", "2")
					.session(session))
				.andExpect(status().is(200))
				.andExpect(view().name("jsonView"));
	}

	@Test
	public void retrieveScriptTestList() throws Exception {
			mockMvc.perform(get("/scriptTest/retrieveScriptTestList.do")
					.param("memId", "MEMBER2")
					.session(session))
				.andExpect(status().is(200))
				.andExpect(view().name("jsonView"));
	}

	@Test
	public void retrieveRankingListTest() throws Exception {
			mockMvc.perform(get("/scriptTest/retrieveRankingList.do")
					.param("startDate", "2020-10-02")
					.param("endDate", "sysdate")
					.param("scriptGbSq", "2")
					.session(session))
			.andExpect(status().is(200))
			.andExpect(view().name("jsonView"));
	}
	
	@Test
	public void retrieveScoreListTest() throws Exception {
			mockMvc.perform(get("/scriptTest/retrieveScoreList.do")
					.param("startDate", "2020-10-02")
					.param("endDate", "sysdate")
					.param("scriptGbSq", "2")
					.session(session))
			.andExpect(status().is(200))
			.andExpect(view().name("jsonView"));
	}
}
