package com.aiinterview.script.dao;

import static org.junit.Assert.assertEquals;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.aiinterview.ModelTestConfig;
import com.aiinterview.script.vo.ScriptGubunVO;
import com.aiinterview.script.vo.ScriptTestVO;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

public class ScriptGubunMapperTest extends ModelTestConfig{
	private static final Logger logger = LoggerFactory.getLogger(ScriptGubunMapperTest.class);

	@Resource(name="scriptGubunMapper")
	private ScriptGubunMapper scriptGubunMapper;
	
	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	@Test
	public void retrievePagingListTest( ) throws Exception{
		/***Given***/
		ScriptGubunVO scriptGbVO = new ScriptGubunVO();
		scriptGbVO.setPageUnit(propertiesService.getInt("pageUnit"));
		scriptGbVO.setPageSize(propertiesService.getInt("pageSize"));
		
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(scriptGbVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(scriptGbVO.getPageUnit());
		paginationInfo.setPageSize(scriptGbVO.getPageSize());

		scriptGbVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		scriptGbVO.setLastIndex(paginationInfo.getLastRecordIndex());
		scriptGbVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		/***When***/
		List<ScriptGubunVO> scriptGubunList = scriptGubunMapper.retrievePagingList(scriptGbVO);
		logger.debug("scriptGbList : {}", scriptGubunList);
		
		/***Then***/
		assertEquals(2, scriptGubunList.size());
	}

	@Test
	public void retrievePagingListCntTest( ) throws Exception{
		/***Given***/
		ScriptGubunVO scriptGbVO = new ScriptGubunVO();
		
		/***When***/
		int result = scriptGubunMapper.retrievePagingListCnt(scriptGbVO);
		
		/***Then***/
		assertEquals(2, result);
	}
	
	@Test
	public void createTest( ) throws Exception{
		/***Given***/
		ScriptGubunVO scriptGbVO = new ScriptGubunVO();
		scriptGbVO.setScriptGbContent("TEST ScriptGubun");
		scriptGbVO.setScriptGbSt("N");
		
		/***When***/
		scriptGubunMapper.create(scriptGbVO);

		/***Then***/
		assertEquals(3, scriptGubunMapper.retrieveList().size());
	}
	
	@Test
	public void retrieveListTest() throws Exception{
		/***Given***/
		
		/***When***/
		List<ScriptGubunVO> scriptGbList = scriptGubunMapper.retrieveList();

		/***Then***/
		assertEquals(2, scriptGbList.size());
	}
	
	@Test
	public void updateTest( ) throws Exception{
		/***Given***/
		ScriptGubunVO scriptGbVO = scriptGubunMapper.retrieve("2");
		scriptGbVO.setScriptGbSt("N");
		
		/***When***/
		int result = scriptGubunMapper.update(scriptGbVO);
		
		/***Then***/
		assertEquals(1, result);
	}
	
	@Test
	public void retrieveTest( ) throws Exception{
		/***Given***/
		String scriptGbSq = "1";
		
		/***When***/
		ScriptGubunVO scriptGbVO = scriptGubunMapper.retrieve(scriptGbSq);
		
		/***Then***/
		assertEquals("1", scriptGbVO.getScriptGbSq());
	}

	@Test
	public void retrieveScriptGubunSearchListTest( ) throws Exception{
		/***Given***/
		String keyword = "영";
		
		/***When***/
		List<ScriptGubunVO> searchList = scriptGubunMapper.retrieveScriptGubunSearchList(keyword);
		
		/***Then***/
		assertEquals(1, searchList.size());
	}

	@Test
	public void retrieveRankingListTest( ) throws Exception{
		/***Given***/
		Map<String, String> statisticMap = new HashMap<String, String>();
		statisticMap.put("startDate", "20201002");
		statisticMap.put("endDate", "20201231");
		statisticMap.put("scriptGbSq", "2");
		
		/***When***/
		List<ScriptTestVO> rankingList = scriptGubunMapper.retrieveRankingList(statisticMap);
		logger.debug("rankingList : {}", rankingList);
		
		/***Then***/
		assertEquals(2, rankingList.size());
	}

	@Test
	public void retrieveScoreListTest( ) throws Exception{
		/***Given***/
		String scriptGbSq = "2";
		
		/***When***/
		List<ScriptTestVO> scoreList = scriptGubunMapper.retrieveScoreList(scriptGbSq);

		/***Then***/
		assertEquals(3, scoreList.size());
	}
}
