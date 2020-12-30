package com.aiinterview.interview.dao;

import static org.junit.Assert.*;

import java.util.List;

import javax.annotation.Resource;

import org.junit.Test;

import com.aiinterview.ModelTestConfig;
import com.aiinterview.interview.vo.HabitVO;
import com.aiinterview.interview.vo.QuestionGubunVO;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

public class QuestionGubunMapperTest extends ModelTestConfig{
	
	@Resource(name="questionGubunMapper")
	private QuestionGubunMapper questionGubunMapper;

	@Test
	public void retrieveListTest() throws Exception{
		/***Given***/

		/***When***/
		List<QuestionGubunVO> questGbList = questionGubunMapper.retrieveList();

		/***Then***/
		assertEquals(14, questGbList.size());
	}

	
	@Test
	public void createTest() throws Exception{
		/***Given***/
		QuestionGubunVO questionGubunVO = new QuestionGubunVO();
		questionGubunVO.setQuestGbContent("test");
		questionGubunVO.setQuestGbSt("Y");

		/***When***/
		questionGubunMapper.create(questionGubunVO);

		/***Then***/
		assertTrue(questionGubunVO.getQuestGbSq() != "0");
	}
	
	@Test
	public void updateTest() throws Exception{
		/***Given***/
		QuestionGubunVO questionGubunVO = new QuestionGubunVO();
		questionGubunVO.setQuestGbSq("1");
		questionGubunVO.setQuestGbContent("updateTest");
		questionGubunVO.setQuestGbSt("N");

		/***When***/
		int updateCnt = questionGubunMapper.update(questionGubunVO);

		/***Then***/
		assertEquals(1, updateCnt);
		assertEquals("N", questionGubunVO.getQuestGbSt());
		assertEquals("updateTest", questionGubunVO.getQuestGbContent());
	}
	
	@Test
	public void createUpdateTest() throws Exception{
		/***Given***/
		QuestionGubunVO questionGubunVO = new QuestionGubunVO();
		questionGubunVO.setQuestGbContent("일반");
		questionGubunVO.setQuestGbSt("N");

		/***When***/
		int updateCnt = questionGubunMapper.createUpdate(questionGubunVO);

		/***Then***/
		assertEquals(1, updateCnt);
		assertEquals("N", questionGubunVO.getQuestGbSt());
		assertEquals("일반", questionGubunVO.getQuestGbContent());
	}
	
	@Test
	public void retrievePagingListTest() throws Exception{
		/***Given***/
		QuestionGubunVO questionGubunVO = new QuestionGubunVO();
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(questionGubunVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(questionGubunVO.getPageUnit());
		paginationInfo.setPageSize(questionGubunVO.getPageSize());
		questionGubunVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		questionGubunVO.setLastIndex(paginationInfo.getLastRecordIndex());
		questionGubunVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		/***When***/
		List<QuestionGubunVO> questGbList = questionGubunMapper.retrievePagingList(questionGubunVO);

		/***Then***/
		assertEquals(10, questGbList.size());
	}
	
	@Test
	public void retrievePagingListCntTest() throws Exception{
		/***Given***/
		QuestionGubunVO questionGubunVO = new QuestionGubunVO();

		/***When***/
		int totCnt = questionGubunMapper.retrievePagingListCnt(questionGubunVO);

		/***Then***/
		assertEquals(14, totCnt);
	}
	
	@Test
	public void retrieveUsingListTest() throws Exception{
		/***Given***/

		/***When***/
		List<QuestionGubunVO> usingList = questionGubunMapper.retrieveUsingList();
		
		/***Then***/
		assertEquals(14, usingList.size());
		
	}
	
	@Test
	public void retrieveTest() throws Exception{
		/***Given***/
		String questGbSq = "1";

		/***When***/
		QuestionGubunVO questionGubunVO = questionGubunMapper.retrieve(questGbSq);

		/***Then***/
		assertEquals("일반", questionGubunVO.getQuestGbContent());
	}
	
}
