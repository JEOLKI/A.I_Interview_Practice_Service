package com.aiinterview.interview.dao;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertTrue;

import java.util.List;

import javax.annotation.Resource;

import org.junit.Test;

import com.aiinterview.ModelTestConfig;
import com.aiinterview.interview.dao.QuestionMapper;
import com.aiinterview.interview.vo.QuestionVO;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;


public class QuestionMapperTest extends ModelTestConfig{

	@Resource(name="questionMapper")
	private QuestionMapper questionMapper;
	
	@Test
	public void retrieveListTest() throws Exception {
		
		/***Given***/
		String interviewSq = "1";
		
		/***When***/
		List<QuestionVO> questionList = questionMapper.retrieveList(interviewSq);

		/***Then***/
		assertEquals(2, questionList.size());
		
	}
	
	@Test
	public void retrievePagingListCntTest() throws Exception {
		
		/***Given***/
		QuestionVO questionVO = new QuestionVO();
		
		/***When***/
		int result = questionMapper.retrievePagingListCnt(questionVO);

		/***Then***/
		assertEquals(3, result);
		
	}
	
	@Test
	public void retrievePagingListTest() throws Exception {
		
		/***Given***/
		QuestionVO questionVO = new QuestionVO();
		questionVO.setPageUnit(10);
		questionVO.setPageSize(10);
		
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(questionVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(questionVO.getPageUnit());
		paginationInfo.setPageSize(questionVO.getPageSize());
		questionVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		questionVO.setLastIndex(paginationInfo.getLastRecordIndex());
		questionVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		/***When***/
		List<QuestionVO> questionList = questionMapper.retrievePagingList(questionVO);
		
		/***Then***/
		assertEquals(3, questionList.size());
		
	}
	
	@Test
	public void createTest() throws Exception {
		
		/***Given***/
		QuestionVO questionVO = new QuestionVO();
		questionVO.setQuestContent("TESTQUESTION");
		questionVO.setInterviewSq("1");
		questionVO.setSampQuestSq("1");
		
		/***When***/
		questionMapper.create(questionVO);
		
		/***Then***/
		assertTrue(Integer.parseInt(questionVO.getQuestSq()) > 0);
		
	}

}
