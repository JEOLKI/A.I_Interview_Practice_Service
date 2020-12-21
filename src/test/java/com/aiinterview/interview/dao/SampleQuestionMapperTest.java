package com.aiinterview.interview.dao;

import static org.junit.Assert.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.junit.Test;

import com.aiinterview.ModelTestConfig;
import com.aiinterview.interview.vo.SampleQuestionVO;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

public class SampleQuestionMapperTest extends ModelTestConfig {
	
	@Resource(name="sampleQuestionMapper")
	private SampleQuestionMapper sampleQuestionMapper;

	@Test
	public void retrievePagingListTest() throws Exception{
		/***Given***/
		SampleQuestionVO sampleQuestionVO = new SampleQuestionVO();
		sampleQuestionVO.setPageUnit(3);
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(sampleQuestionVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(sampleQuestionVO.getPageUnit());
		paginationInfo.setPageSize(sampleQuestionVO.getPageSize());
		sampleQuestionVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		sampleQuestionVO.setLastIndex(paginationInfo.getLastRecordIndex());
		sampleQuestionVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		/***When***/
		List<SampleQuestionVO> sampQuestPagingList = sampleQuestionMapper.retrievePagingList(sampleQuestionVO);

		/***Then***/
		assertEquals(3, sampQuestPagingList.size());
	}
	
	@Test
	public void retrievePagingListCntTest() throws Exception{
		/***Given***/
		SampleQuestionVO sampleQuestionVO = new SampleQuestionVO();

		/***When***/
		int totCnt = sampleQuestionMapper.retrievePagingListCnt(sampleQuestionVO);

		/***Then***/
		assertEquals(33, totCnt);
	}
	
	@Test
	public void createTest() throws Exception{
		/***Given***/
		SampleQuestionVO sampleQuestionVO = new SampleQuestionVO();
		sampleQuestionVO.setSampQuestContent("test");
		sampleQuestionVO.setSampQuestSt("Y");
		sampleQuestionVO.setQuestGbSq("1");

		/***When***/
		sampleQuestionMapper.create(sampleQuestionVO);

		/***Then***/
		assertTrue(sampleQuestionVO.getSampQuestSq() !="0");
		
	}
	
	@Test
	public void retrieveListTest() throws Exception{
		/***Given***/

		/***When***/
		List<SampleQuestionVO> sampQuestList = sampleQuestionMapper.retrieveList();

		/***Then***/
		assertEquals(33, sampQuestList.size());
	}
	
	@Test
	public void updateTest() throws Exception{
		/***Given***/
		SampleQuestionVO sampleQuestionVO = new SampleQuestionVO();
		sampleQuestionVO.setSampQuestSq("1");
		sampleQuestionVO.setSampQuestContent("test");
		sampleQuestionVO.setSampQuestSt("Y");
		sampleQuestionVO.setQuestGbSq("1");

		/***When***/
		int updateCnt = sampleQuestionMapper.update(sampleQuestionVO);
				
		/***Then***/
		assertEquals(1, updateCnt);
		assertEquals("test", sampleQuestionVO.getSampQuestContent());
	}
	
	@Test
	public void retrieveTest() throws Exception{
		/***Given***/
		String searchKeyword = "회사";

		/***When***/
		List<SampleQuestionVO> searchList = sampleQuestionMapper.retrieve(searchKeyword);

		/***Then***/
		assertEquals(6, searchList.size());
		
	}
	
	
	@Test
	public void retrieveQuestGbUseCountTest() throws Exception{
		/***Given***/
		Map<String, String> statisticMap = new HashMap<>();
  		statisticMap.put("startDate", "2000-01-01");
		statisticMap.put("endDate", "sysdate");
		statisticMap.put("searchKeyword", "");
		statisticMap.put("searchCondition", "0");

		/***When***/
		List<SampleQuestionVO> resultList = sampleQuestionMapper.retrieveQuestGbUseCount(statisticMap);

		/***Then***/
		assertEquals(2, resultList.size());
	}
	
	@Test
	public void retrieveQuestGbAndSampUseCountTest() throws Exception{
		/***Given***/
		Map<String, String> statisticMap = new HashMap<>();
  		statisticMap.put("startDate", "2000-01-01");
		statisticMap.put("endDate", "sysdate");
		statisticMap.put("searchKeyword", "");
		statisticMap.put("searchCondition", "0");

		/***When***/
		List<SampleQuestionVO> resultList = sampleQuestionMapper.retrieveQuestGbAndSampUseCount(statisticMap);
		
		/***Then***/
		assertEquals(2, resultList.get(0).getUseCount());
	}
	

	@Test
	public void retrieveOneTest() throws Exception{
		/***Given***/
		String sampQuestSq = "1";

		/***When***/
		SampleQuestionVO sampleQuestionVO = sampleQuestionMapper.retrieveOne(sampQuestSq);

		/***Then***/
		assertEquals("우리 회사만의 강점이 무엇인가요?", sampleQuestionVO.getSampQuestContent());
	}
}
