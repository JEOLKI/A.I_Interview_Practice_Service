package com.aiinterview.script.service;

import static org.junit.Assert.assertEquals;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.junit.Test;

import com.aiinterview.ModelTestConfig;
import com.aiinterview.script.vo.ScriptGubunVO;
import com.aiinterview.script.vo.ScriptTestVO;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

public class ScriptGubunServiceTest extends ModelTestConfig{
	@Resource(name="scriptGubunService")
	private ScriptGubunService scriptGubunService;

	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	@Test
	public void retrievePagingListTest( ) throws Exception {
		/***Given***/
		ScriptGubunVO scriptGubunVO = new ScriptGubunVO();
		
		/** EgovPropertyService.sample */
		scriptGubunVO.setPageUnit(propertiesService.getInt("pageUnit"));
		scriptGubunVO.setPageSize(propertiesService.getInt("pageSize"));

		/** pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(scriptGubunVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(scriptGubunVO.getPageUnit());
		paginationInfo.setPageSize(scriptGubunVO.getPageSize());

		scriptGubunVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		scriptGubunVO.setLastIndex(paginationInfo.getLastRecordIndex());
		scriptGubunVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		/***When***/
		List<ScriptGubunVO> scriptGubunList = scriptGubunService.retrievePagingList(scriptGubunVO);
		
		/***Then***/
		assertEquals(2, scriptGubunList.size());
	}

	@Test
	public void retrievePagingListCntTest( ) throws Exception {
		/***Given***/
		ScriptGubunVO scriptGbVO = new ScriptGubunVO();
		
		/***When***/
		int result = scriptGubunService.retrievePagingListCnt(scriptGbVO);
		
		/***Then***/
		assertEquals(2, result);
	}

	@Test
	public void createTest() throws Exception{
		/***Given***/
		ScriptGubunVO scriptGbVO = new ScriptGubunVO();
		scriptGbVO.setScriptGbContent("TEST ScriptGubun");
		scriptGbVO.setScriptGbSt("N");
		
		/***When***/
		scriptGubunService.create(scriptGbVO);
		
		/***Then***/
		assertEquals(3, scriptGubunService.retrieveList().size());
	}

	@Test
	public void createMassiveScriptGubunTest() throws Exception {
		/***Given***/
		File destFile = new File("C:\\Users\\PC-15\\Desktop\\scriptGubun.xlsx");
		
		/***When***/
		scriptGubunService.createMassiveScriptGubun(destFile);
		List<ScriptGubunVO> scriptGbList = scriptGubunService.retrieveList();
		
		/***Then***/
		assertEquals(5, scriptGbList.size());
	}

	@Test
	public void retrieveListTest() throws Exception{
		/***Given***/
		
		/***When***/
		List<ScriptGubunVO> scriptGbList = scriptGubunService.retrieveList();

		/***Then***/
		assertEquals(2, scriptGbList.size());
	}

	@Test
	public void updateTest() throws Exception{
		/***Given***/
		ScriptGubunVO scriptGbVO = scriptGubunService.retrieve("1");
		scriptGbVO.setScriptGbSt("N");
		
		/***When***/
		int result = scriptGubunService.update(scriptGbVO);
		
		/***Then***/
		assertEquals(1, result);
	}

	@Test
	public void retrieveTest() throws Exception{
		/***Given***/
		String scriptGbSq = "1";
		
		/***When***/
		ScriptGubunVO scriptGbVO = scriptGubunService.retrieve(scriptGbSq);
		
		/***Then***/
		assertEquals("1", scriptGbVO.getScriptGbSq());
	}
	
	@Test
	public void retrieveScriptGubunSearchListTest() throws Exception{
		/***Given***/
		String keyword = "영";
		
		/***When***/
		List<ScriptGubunVO> searchList = scriptGubunService.retrieveScriptGubunSearchList(keyword);
		
		/***Then***/
		assertEquals(1, searchList.size());
	}

	@Test
	public void retrieveRankingListTest() throws Exception{
		/***Given***/
		Map<String,String> statisticMap = new HashMap<>();
		statisticMap.put("startDate", "20201002");
		statisticMap.put("endDate", "20201231");
		statisticMap.put("scriptGbSq", "2");
		
		/***When***/
		List<ScriptTestVO> rankingList = scriptGubunService.retrieveRankingList(statisticMap);

		/***Then***/
		assertEquals(2, rankingList.size());
	}

	@Test
	public void retrieveScoreList() throws Exception{
		/***Given***/
		String scriptGbSq = "2";
		
		/***When***/
		List<ScriptTestVO> scoreList = scriptGubunService.retrieveScoreList(scriptGbSq);
		
		/***Then***/
		assertEquals(3, scoreList.size());
	}
}
