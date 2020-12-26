package com.aiinterview.script.web;

import static org.junit.Assert.assertEquals;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.view;

import java.util.ArrayList;

import org.junit.Test;

import com.aiinterview.WebTestConfig;

public class ScriptTestControllerTest extends WebTestConfig{
	
	@Test
	public void createTest() {
		try {
			mockMvc.perform(post("/scriptTest/create.do")
					.param("performScript",  "여름이었다.")
					.param("memId",  "oz_official")
					.param("scriptSq",  "4"))
				.andExpect(status().is(200));
		} catch (Exception e) { }
	}
	
	@Test
	public void testPopupTest() {
		try {
			mockMvc.perform(get("/scriptTest/testPopup.do"))
				.andExpect(status().is(200))
				.andExpect(view().name("script/testPopup"));
		} catch (Exception e) { }
	}
	
	@Test
	public void retrieveSelectListTest() {
		try {
			mockMvc.perform(post("/scriptTest/retrieveScriptList.do")
					.param("scriptGbSq", "2"))
				.andExpect(status().is(200))
				.andExpect(view().name("jsonView"));
		} catch (Exception e) { }
	}

	@Test
	public void retrieveScriptTestList() {
		try {
			mockMvc.perform(get("/scriptTest/retrieveScriptTestList.do")
					.param("memId", "oz"))
				.andExpect(status().is(200))
				.andExpect(view().name("jsonView"));
		} catch (Exception e) { }
	}

}
