package com.aiinterview.script.web;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.fileUpload;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.model;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.view;

import java.io.IOException;
import java.io.InputStream;

import org.junit.Test;
import org.springframework.mock.web.MockMultipartFile;

import com.aiinterview.WebTestConfig;

public class ScriptGubunControllerTest extends WebTestConfig{

	@Test
	public void retrievePagingListTest() throws Exception{
			mockMvc.perform(get("/scriptGubun/retrievePagingList.do"))
				.andExpect(status().is(200))
				.andExpect(view().name("manage/scriptGubunManage"));
	}

	@Test
	public void scriptManageTest() throws Exception{
			mockMvc.perform(get("/scriptGubun/scriptManage.do")
					.param("scriptGbSq", "2")
					.param("scriptGbList[0]",  "영어"))
				.andExpect(status().is(200))
				.andExpect(view().name("manage/scriptManage"));
	}
	
	@Test
	public void createProcessTest() throws Exception{
			mockMvc.perform(post("/scriptGubun/createProcess.do")
					.param("scriptGbContent", "금붕어")
					.param("scriptGbSt",  "Y"))
				.andExpect(status().is(302))
				.andExpect(view().name("redirect:/scriptGubun/retrievePagingList.do"));
	}
	
	@Test
	public void createMassiveScriptGbTest() throws Exception{
		InputStream is  = getClass().getResourceAsStream("/file/scriptGbTest.xlsx");
		MockMultipartFile file = new MockMultipartFile("excelFile", "scriptGbTest.xlsx", "xlsx", is);
		
			mockMvc.perform(fileUpload("/scriptGubun/massiveCreateProcess.do")
					.file(file))
			.andExpect(status().is3xxRedirection())
			.andExpect(view().name("redirect:/scriptGubun/retrievePagingList.do"));
	}
	
	@Test
	public void updateProcessTest() throws Exception{
			mockMvc.perform(post("/scriptGubun/updateProcess.do")
					.param("scriptGbSqs[0]", "1")
					.param("scriptGbContents[0]", "Script Gubun Test")
					.param("scriptGbSts[0]", "N"))
			.andExpect(status().is(302))
			.andExpect(view().name("redirect:/scriptGubun/retrievePagingList.do"));
	}
	
	@Test
	public void excelDownTest() throws Exception{
			mockMvc.perform(get("/scriptGubun/list/excelDown.do"))
			.andExpect(status().is(200))
			.andExpect(view().name("excelView"));
	}

	@Test
	public void statisticsViewTest() throws Exception {
		mockMvc.perform(get("/scriptGubun/statistics.do"))
			.andExpect(status().is(200))
			.andExpect(view().name("script/scriptGbStatistics"));
	}
}
