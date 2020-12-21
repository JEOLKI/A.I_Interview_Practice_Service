package com.aiinterview.interview.service;

import static org.junit.Assert.*;

import java.util.List;

import javax.annotation.Resource;

import org.junit.Test;

import com.aiinterview.ModelTestConfig;
import com.aiinterview.interview.vo.QuestionVO;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

public class QuestionServiceTest extends ModelTestConfig {

	@Resource(name="questionService")
	private QuestionService questionService;
	
	@Test
	public void retrieveListTest() throws Exception {
		
		/***Given***/
		String interviewSq = "1";
		
		/***When***/
		List<QuestionVO> questionList = questionService.retrieveList(interviewSq);

		/***Then***/
		assertEquals(1, questionList.size());
		
	}
	
	@Test
	public void retrievePagingListCntTest() throws Exception {
		
		/***Given***/
		QuestionVO questionVO = new QuestionVO();
		questionVO.setInterviewSq("1");
		
		/***When***/
		int result = questionService.retrievePagingListCnt(questionVO);

		/***Then***/
		assertEquals(1, result);
		
	}
	
	@Test
	public void retrievePagingListTest() throws Exception {
		
		/***Given***/
		QuestionVO questionVO = new QuestionVO();
		questionVO.setInterviewSq("1");
		
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
		List<QuestionVO> questionList = questionService.retrievePagingList(questionVO);
		
		/***Then***/
		assertEquals(1, questionList.size());
		
	}

}
