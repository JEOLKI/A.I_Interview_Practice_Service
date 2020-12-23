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

	@Test
	public void nGramTest() {
		/***Given***/
		ArrayList<String> list = new ArrayList<String>();
		ArrayList<String> result = new ArrayList<String>();
		String script = "여름이었다.";
		
		/***When***/
		for (int i = 0; i <= script.length() - 1; i++) {
			list.add(Character.toString(script.charAt(i)));
		}
		
		for (int i = 0; i < list.size() - 1; i++) {
			result.add(list.get(i) + list.get(i + 1));
		}

		/***Then***/
		assertEquals(5, result.size());
	}

	@Test
	public void resultNGramTest() {
		/***Given***/
		ArrayList<String> systemScriptList = new ArrayList<String>();
		systemScriptList.add("여름");
		systemScriptList.add("름이");
		systemScriptList.add("이었");
		systemScriptList.add("었다");
		systemScriptList.add("다.");
		
		ArrayList<String> memberScriptList = new ArrayList<String>();
		memberScriptList.add("여름");
		memberScriptList.add("름이");
		memberScriptList.add("이었");
		memberScriptList.add("었다");
		memberScriptList.add("다.");
		
		int count = 0;
		int size = systemScriptList.size();
		
		/***When***/
		for (int i = 0; i < systemScriptList.size(); i++) {
			for (int j = 0; j < memberScriptList.size(); j++) {
				if (systemScriptList.get(i).equals(memberScriptList.get(j))) {
					count += 1;
				}
			}
		}

		/***Then***/
		assertEquals(100, (int)((double)count/(double)size*100));
	}
}
