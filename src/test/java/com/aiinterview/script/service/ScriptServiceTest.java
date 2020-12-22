package com.aiinterview.script.service;

import static org.junit.Assert.assertEquals;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.junit.Test;

import com.aiinterview.ModelTestConfig;
import com.aiinterview.script.vo.ScriptVO;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

public class ScriptServiceTest extends ModelTestConfig{
	@Resource(name="scriptService")
	private ScriptService scriptService;

	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	@Test
	public void retrievePagingListTest() throws Exception{
		/***Given***/
		ScriptVO scriptVO = new ScriptVO();
		scriptVO.setPageUnit(propertiesService.getInt("pageUnit"));
		scriptVO.setPageSize(propertiesService.getInt("pageSize"));
		
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(scriptVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(scriptVO.getPageUnit());
		paginationInfo.setPageSize(scriptVO.getPageSize());

		scriptVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		scriptVO.setLastIndex(paginationInfo.getLastRecordIndex());
		scriptVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		/***When***/
		List<ScriptVO> scriptList = scriptService.retrievePagingList(scriptVO);
		
		/***Then***/
		assertEquals(6, scriptList.size());
	}

	@Test
	public void retrievePagingListCntTest() throws Exception{
		/***Given***/
		ScriptVO scriptVO = new ScriptVO();
		
		/***When***/
		int totCnt = scriptService.retrievePagingListCnt(scriptVO);
		
		/***Then***/
		assertEquals(6, totCnt);
	}
	
	@Test
	public void createTest() throws Exception{
		/***Given***/
		ScriptVO scriptVO = new ScriptVO();
		scriptVO.setScriptContent("TEST Script");
		scriptVO.setScriptSt("N");
		scriptVO.setScriptGbSq("2");
		
		/***When***/
		scriptService.create(scriptVO);

		/***Then***/
		assertEquals(7, scriptService.retrieveList().size());
	}

	@Test
	public void createMassiveScriptTest() throws Exception{
		/***Given***/
		File destFile = new File("C:\\Users\\PC-15\\Desktop\\script.xlsx");
		String scriptGbSq = "1";
		
		/***When***/
		scriptService.createMassiveScript(destFile, scriptGbSq);
		List<ScriptVO> scriptGbList = scriptService.retrieveSelectList(scriptGbSq);
		
		/***Then***/
		assertEquals(4, scriptGbList.size());
	}

	@Test
	public void retrieveListTest() throws Exception{
		/***Given***/
		
		/***When***/
		List<ScriptVO> scriptGbList = scriptService.retrieveList();

		/***Then***/
		assertEquals(6, scriptGbList.size());
	}
	
	@Test
	public void updateTest( ) throws Exception{
		/***Given***/
		ScriptVO scriptVO = scriptService.retrieve("1");
		scriptVO.setScriptSt("N");
		
		/***When***/
		int result = scriptService.update(scriptVO);
		
		/***Then***/
		assertEquals(1, result);
	}

	@Test
	public void retrieveTest() throws Exception{
		/***Given***/
		String scriptSq = "1";
		
		/***When***/
		ScriptVO scriptVO = scriptService.retrieve(scriptSq);
		
		/***Then***/
		assertEquals("1", scriptVO.getScriptSq());
	}

	@Test
	public void retrieveScriptSearchListTest()  throws Exception{
		/***Given***/
		String keyword = "christmas";
		
		/***When***/
		List<ScriptVO> searchList = scriptService.retrieveScriptSearchList(keyword);
		
		/***Then***/
		assertEquals(1, searchList.size());
	}

	@Test
	public void retrieveSelectListTest() throws Exception{
		/***Given***/
		String scriptGbSq = "1";
		
		/***When***/
		List<ScriptVO> scriptList = scriptService.retrieveSelectList(scriptGbSq);
		
		/***Then***/
		assertEquals(2, scriptList.size());
	}

	@Test
	public void retrieveScriptGbScriptPagingListTest()  throws Exception{
		/***Given***/
		ScriptVO scriptVO = new ScriptVO();
		scriptVO.setScriptGbSq("1");
		scriptVO.setPageUnit(propertiesService.getInt("pageUnit"));
		scriptVO.setPageSize(propertiesService.getInt("pageSize"));
		
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(scriptVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(scriptVO.getPageUnit());
		paginationInfo.setPageSize(scriptVO.getPageSize());

		scriptVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		scriptVO.setLastIndex(paginationInfo.getLastRecordIndex());
		scriptVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		Map<String, Object> retrieveMap = new HashMap<>();
		String scriptGbSq = scriptVO.getScriptGbSq();
		String searchKeyword = "christmas";
		retrieveMap.put("firstIndex", scriptVO.getFirstIndex());
		retrieveMap.put("lastIndex", scriptVO.getLastIndex());
		retrieveMap.put("scriptGbSq", scriptGbSq);
		retrieveMap.put("searchKeyword", searchKeyword);

		/***When***/
		List<ScriptVO> scriptList = scriptService.retrieveScriptGbScriptPagingList(retrieveMap);
		
		/***Then***/
		assertEquals(1, scriptList.size());
	}

	@Test
	public void retrieveScriptGbScriptPagingListCntTest() throws Exception{
		/***Given***/
		ScriptVO scriptVO = new ScriptVO();
		scriptVO.setScriptGbSq("1");
		Map<String, Object> retrieveMap = new HashMap<>();
		retrieveMap.put("firstIndex", scriptVO.getFirstIndex());
		retrieveMap.put("lastIndex", scriptVO.getLastIndex());
		retrieveMap.put("scriptGbSq", scriptVO.getScriptGbSq());

		/***When***/
		int totCnt = scriptService.retrieveScriptGbScriptPagingListCnt(scriptVO);

		/***Then***/
		assertEquals(2, totCnt);
	}
}
