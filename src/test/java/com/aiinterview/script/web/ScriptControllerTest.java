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

public class ScriptControllerTest  extends WebTestConfig{

	@Test
	public void createProcessTest(){
		try {
			mockMvc.perform(post("/script/createProcess.do")
					.param("scriptContent", "여름임.")
					.param("scriptSt",  "Y")
					.param("scriptGbSq", "1"))
				.andExpect(status().is(302))
				.andExpect(view().name("redirect:/scriptGubun/scriptManage.do?scriptGbSq=1"));
		} catch (Exception e) { }
	}

	@Test
	public void createMassiveScriptTest() {
		InputStream is  = getClass().getResourceAsStream("/file/scriptTest.xlsx");
		MockMultipartFile file = null;
		try {
			file = new MockMultipartFile("excelFile", "scriptTest.xlsx", "xlsx", is);
		} catch (IOException ex) { }
		
		try {
			mockMvc.perform(fileUpload("/script/massiveCreateProcess.do")
					.file(file)
					.param("scriptGbSq", "1"))
			.andExpect(status().is3xxRedirection())
			.andExpect(view().name("redirect:/scriptGubun/scriptManage.do?scriptGbSq=1"));
		} catch (Exception e) { }
	}
	
	@Test
	public void updateProcessTest(){
		try {
			mockMvc.perform(get("/script/updateProcess.do")
					.param("scriptSqs[0]", "1")
					.param("scriptContents[0]", "Script Test")
					.param("pageScriptGbSq", "1"))
			.andExpect(status().is(302))
			.andExpect(view().name("redirect:/scriptGubun/scriptManage.do?scriptGbSq=1"));
		} catch (Exception e) { }
	}
	
	@Test
	public void excelDownTest() {
		try {
			mockMvc.perform(get("/script/list/excelDown.do")
					.param("scriptGbSq", "1"))
			.andExpect(status().is(200))
			.andExpect(view().name("excelView"));
		} catch (Exception e) { }
	}
	

//	/* 페이징 처리 한 조회 */
//	@Test
//	public void retrievePagingListTest() throws Exception{
//		try {
//			mockMvc.perform(get("/script/retrievePagingList.do"))
//				.andExpect(status().is(200))
//				.andExpect(view().name("manage/scriptManage"));
//		} catch (Exception e) { }
//	}

}
