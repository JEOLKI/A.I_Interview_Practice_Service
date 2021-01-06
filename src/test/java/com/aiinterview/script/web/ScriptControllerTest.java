package com.aiinterview.script.web;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.fileUpload;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.view;

import java.io.InputStream;

import org.junit.Test;
import org.springframework.mock.web.MockMultipartFile;

import com.aiinterview.WebTestConfig;

public class ScriptControllerTest  extends WebTestConfig{

	@Test
	public void createProcessTest() throws Exception{
			mockMvc.perform(post("/script/createProcess.do")
					.param("scriptContent", "여름임.")
					.param("scriptSt",  "Y")
					.param("scriptGbSq", "1")
					.session(session))
				.andExpect(status().is(302))
				.andExpect(view().name("redirect:/scriptGubun/scriptManage.do?scriptGbSq=1"));
	}

	@Test
	public void createMassiveScriptTest() throws Exception{
		InputStream is  = getClass().getResourceAsStream("/file/scriptTest.xlsx");
		MockMultipartFile file =  new MockMultipartFile("excelFile", "scriptTest.xlsx", "xlsx", is);

		mockMvc.perform(fileUpload("/script/massiveCreateProcess.do")
					.file(file)
					.param("scriptGbSq", "1")
					.session(session))
			.andExpect(status().is3xxRedirection())
			.andExpect(view().name("redirect:/scriptGubun/scriptManage.do?scriptGbSq=1"));
	}
	
	@Test
	public void updateProcessTest() throws Exception{
			mockMvc.perform(get("/script/updateProcess.do")
					.param("scriptSqs[0]", "1")
					.param("scriptContents[0]", "Script Test")
					.param("pageScriptGbSq", "1")
					.session(session))
			.andExpect(status().is(302))
			.andExpect(view().name("redirect:/scriptGubun/scriptManage.do?scriptGbSq=1"));
	}
	
	@Test
	public void excelDownTest() throws Exception{
			mockMvc.perform(get("/script/list/excelDown.do")
					.param("scriptGbSq", "1")
					.session(session))
			.andExpect(status().is(200))
			.andExpect(view().name("excelView"));
	}
}
