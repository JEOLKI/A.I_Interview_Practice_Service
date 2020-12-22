package com.aiinterview.member.web;

import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.MediaType;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.fileUpload;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.model;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.view;

import com.aiinterview.WebTestConfig;

public class LoginControllerTest extends WebTestConfig {
	private static final Logger logger = LoggerFactory.getLogger(LoginControllerTest.class);

	@Test
	public void loginTest() throws Exception {
		mockMvc.perform(post("/login/process.do")
				.param("memId", "TEST_ID")
				.param("memPw","TEST_PW"))
		.andExpect(status().is(302))
		.andExpect(view().name("redirect:/login/home.do"));
	}
	
	@Test
	public void viewTest() throws Exception {
		mockMvc.perform(get("/login/main.do"))
		.andExpect(status().is(200))
		.andExpect(view().name("login/main"));
	}
	
	@Test
	public void homeTest() throws Exception {
		mockMvc.perform(get("/login/home.do"))
		.andExpect(status().is(200))
		.andExpect(view().name("login/home"));
	}
	
	@Test
	public void logoutTest() throws Exception {
		mockMvc.perform(get("/login/logout.do"))
		.andExpect(status().is(200))
		.andExpect(view().name("login/main"));
	}
	
	@Test
	public void managerViewTest() throws Exception{
		mockMvc.perform(get("/login/manage.do"))
		.andExpect(status().is(200))
		.andExpect(view().name("manage/main"));
	}
	
	@Test
	public void manageStatisticTest() throws Exception{
		mockMvc.perform(get("/login/manageStatistic.do"))
		.andExpect(status().is(200))
		.andExpect(view().name("manage/manageStatistic"));
	}
	
	@Test
	public void joinTest() throws Exception{
		mockMvc.perform(get("/login/join.do"))
		.andExpect(status().is(200))
		.andExpect(view().name("login/join"));
	}
	
	@Test
	public void helpTest() throws Exception{
		mockMvc.perform(get("/login/help.do"))
		.andExpect(status().is(200))
		.andExpect(view().name("login/help"));
	}
	
	@Test
	public void serviceIntroTest() throws Exception{
		mockMvc.perform(get("/login/serviceIntro.do"))
		.andExpect(status().is(200))
		.andExpect(view().name("login/serviceIntro"));
	}
	
	@Test
	public void userAgreeTest() throws Exception{
		mockMvc.perform(get("/login/userAgree.do"))
		.andExpect(status().is(200))
		.andExpect(view().name("agreement/userAgree"));
	}
	
	@Test
	public void personalAgreeTest() throws Exception{
		mockMvc.perform(get("/login/personalAgree.do"))
		.andExpect(status().is(200))
		.andExpect(view().name("agreement/personalAgree"));
	}
}
