package com.aiinterview.interview.dao;

import static org.junit.Assert.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.junit.Test;

import com.aiinterview.ModelTestConfig;
import com.aiinterview.interview.vo.KeywordVO;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

public class KeywordMapperTest extends ModelTestConfig {
	
	@Resource(name="keywordMapper")
	private KeywordMapper keywordMapper;
	
	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	

	@Test
	public void retrieveTalentKeywordPagingTest() throws Exception{
		/***Given***/
		KeywordVO keywordVO = new KeywordVO();
		keywordVO.setTalentSq("2");
		keywordVO.setPageUnit(propertiesService.getInt("pageUnit"));
		keywordVO.setPageSize(propertiesService.getInt("pageSize"));

		keywordVO.setPageUnit(10);
		
		/** pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(keywordVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(keywordVO.getPageUnit());
		paginationInfo.setPageSize(keywordVO.getPageSize());
		
		keywordVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		keywordVO.setLastIndex(paginationInfo.getLastRecordIndex());
		keywordVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		Map<String, Object> retrieveMap = new HashMap<>();
		retrieveMap.put("firstIndex", keywordVO.getFirstIndex());
		retrieveMap.put("lastIndex", keywordVO.getLastIndex());
		retrieveMap.put("talentSq", keywordVO.getTalentSq());

		/***When***/
		List<KeywordVO> talentKeywordList = keywordMapper.retrieveTalentKeywordPagingList(retrieveMap);

		/***Then***/
		assertEquals(2, talentKeywordList.size());
	}
	

	@Test
	public void retrieveTalentKeywordPagingListCntTest() throws Exception{
		/***Given***/
		KeywordVO keywordVO = new KeywordVO();
		keywordVO.setTalentSq("2");
		Map<String, Object> retrieveMap = new HashMap<>();
		retrieveMap.put("firstIndex", keywordVO.getFirstIndex());
		retrieveMap.put("lastIndex", keywordVO.getLastIndex());
		retrieveMap.put("talentSq", keywordVO.getTalentSq());

		/***When***/
		int totCnt = keywordMapper.retrieveTalentKeywordPagingListCnt(retrieveMap);

		/***Then***/
		assertEquals(2, totCnt);
	}
	
	@Test
	public void retrieveTest() throws Exception{
		/***Given***/
		String keywordContent = "추진력";

		/***When***/
		int count = keywordMapper.retrieve(keywordContent);
		
		/***Then***/
		assertEquals(1, count);
		
	}
	
	@Test
	public void createTest() throws Exception{
		/***Given***/
		String keywordContent = "노력";

		/***When***/
		keywordMapper.create(keywordContent);
		int count = keywordMapper.retrieve(keywordContent);

		/***Then***/
		assertTrue(count != 0);
	}
	
	@Test
	public void retrieveKeywordSqTest() throws Exception{
		/***Given***/
		String keywordContent = "추진력";

		/***When***/
		int keywordSq = keywordMapper.retrieveKeywordSq(keywordContent);

		/***Then***/
		assertEquals(3, keywordSq);
	}
	
	@Test
	public void retrieveTalentKeywordAllListTest() throws Exception{
		/***Given***/
		String talentSq = "2";

		/***When***/
		List<KeywordVO> talentKeywordAllList = keywordMapper.retrieveTalentKeywordAllList(talentSq);
		
		/***Then***/
		assertEquals(2, talentKeywordAllList.size());
	}
	
	@Test
	public void retrieveKeywordContentTest() throws Exception{
		/***Given***/
		String keywordSq = "3";

		/***When***/
		String keywordContent = keywordMapper.retrieveKeywordContent(keywordSq);

		/***Then***/
		assertEquals("추진력", keywordContent);
		
	}
}
