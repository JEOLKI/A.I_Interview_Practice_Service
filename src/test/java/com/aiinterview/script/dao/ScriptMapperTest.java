package com.aiinterview.script.dao;

import static org.junit.Assert.assertEquals;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.junit.Test;

import com.aiinterview.ModelTestConfig;
import com.aiinterview.script.vo.ScriptVO;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

public class ScriptMapperTest extends ModelTestConfig{
	@Resource(name="scriptMapper")
	private ScriptMapper scriptMapper;

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
		List<ScriptVO> scriptGubunList = scriptMapper.retrievePagingList(scriptVO);
		
		/***Then***/
		assertEquals(6, scriptGubunList.size());
	}

	@Test
	public void retrievePagingListCntTest( ) throws Exception{
		/***Given***/
		ScriptVO scriptVO = new ScriptVO();
		
		/***When***/
		int result = scriptMapper.retrievePagingListCnt(scriptVO);
		
		/***Then***/
		assertEquals(6, result);
	}

	@Test
	public void createTest() throws Exception{
		/***Given***/
		ScriptVO scriptVO = new ScriptVO();
		scriptVO.setScriptContent("TEST Script");
		scriptVO.setScriptSt("N");
		scriptVO.setScriptGbSq("2");
		
		/***When***/
		scriptMapper.create(scriptVO);

		/***Then***/
		assertEquals(7, scriptMapper.retrieveList().size());
	}

	@Test
	public void retrieveListTest() throws Exception{
		/***Given***/
		
		/***When***/
		List<ScriptVO> scriptList = scriptMapper.retrieveList();

		/***Then***/
		assertEquals(6, scriptList.size());
	}

	@Test
	public void updateTest( ) throws Exception{
		/***Given***/
		ScriptVO ScriptVO = scriptMapper.retrieve("3");
		ScriptVO.setScriptSt("N");
		
		/***When***/
		int result = scriptMapper.update(ScriptVO);
		
		/***Then***/
		assertEquals(1, result);
	}
	
	@Test
	public void retrieveTest() throws Exception{
		/***Given***/
		String scriptSq = "1";
		
		/***When***/
		ScriptVO scriptVO = scriptMapper.retrieve(scriptSq);
		
		/***Then***/
		assertEquals("1", scriptVO.getScriptSq());
	}

	@Test
	public void retrieveScriptSearchListTest() throws Exception{
		/***Given***/
		String keyword = "여름이었다.";
		
		/***When***/
		List<ScriptVO> searchList = scriptMapper.retrieveScriptSearchList(keyword);
		
		/***Then***/
		assertEquals(1, searchList.size());
	}

	@Test
	public void retrieveSelectListTest( ) throws Exception{
		/***Given***/
		String scriptGbSq = "2";
		
		/***When***/
		List<ScriptVO> scriptList = scriptMapper.retrieveSelectList(scriptGbSq);
		
		/***Then***/
		assertEquals(4, scriptList.size());
	}

	@Test
	public void retrieveScriptGbScriptPagingListTest() throws Exception{
		/***Given***/
		ScriptVO scriptVO = new ScriptVO();
		scriptVO.setScriptGbSq("2");
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
		String searchKeyword = "여름이었다.";
		retrieveMap.put("firstIndex", scriptVO.getFirstIndex());
		retrieveMap.put("lastIndex", scriptVO.getLastIndex());
		retrieveMap.put("scriptGbSq", scriptGbSq);
		retrieveMap.put("searchKeyword", searchKeyword);

		/***When***/
		List<ScriptVO> scriptList = scriptMapper.retrieveScriptGbScriptPagingList(retrieveMap);
		
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
		int totCnt = scriptMapper.retrieveScriptGbScriptPagingListCnt(scriptVO);

		/***Then***/
		assertEquals(2, totCnt);
	}
}
