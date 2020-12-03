package com.aiinterview.interview.dao;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertTrue;

import java.util.List;

import javax.annotation.Resource;

import org.junit.Test;

import com.aiinterview.ModelTestConfig;
import com.aiinterview.interview.vo.InterviewVO;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

public class InterviewMapperTest extends ModelTestConfig {

	@Resource(name="interviewMapper")
	private InterviewMapper interviewMapper;
	
	@Test
	public void retrieveListTest() throws Exception {
		
		/***Given***/
		
		/***When***/
		List<InterviewVO> interviewList = interviewMapper.retrieveList();
		
		/***Then***/
		assertEquals(4, interviewList.size());
		
	}
	
	@Test
	public void retrievePagingListCntTest() throws Exception {
		
		/***Given***/
		InterviewVO interviewVO = new InterviewVO();
		interviewVO.setMemId("TEST_ID");
		
		/***When***/
		int result = interviewMapper.retrievePagingListCnt(interviewVO);

		/***Then***/
		assertEquals(4, result);
		
	}
	
	@Test
	public void retrievePagingListTest() throws Exception {
		
		/***Given***/
		InterviewVO interviewVO = new InterviewVO();
		interviewVO.setMemId("TEST_ID");
		interviewVO.setPageUnit(10);
		interviewVO.setPageSize(10);
		
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(interviewVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(interviewVO.getPageUnit());
		paginationInfo.setPageSize(interviewVO.getPageSize());
		
		interviewVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		interviewVO.setLastIndex(paginationInfo.getLastRecordIndex());
		interviewVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		/***When***/
		List<InterviewVO> interviewList = interviewMapper.retrievePagingList(interviewVO);
		
		/***Then***/
		assertEquals(4, interviewList.size());
		
	}
	
	@Test
	public void retrieveTest() throws Exception {
		
		/***Given***/
		String interviewSq = "1";
		
		/***When***/
		InterviewVO interviewVO = interviewMapper.retrieve(interviewSq);
		
		/***Then***/
		assertEquals("1", interviewVO.getInterviewSq());
		
	}
	
	@Test
	public void createTest() throws Exception {
		
		/***Given***/
		InterviewVO interviewVO = new InterviewVO();
		interviewVO.setInterviewSq("1");
		interviewVO.setMemId("TEST_ID");
		
		/***When***/
		interviewMapper.create(interviewVO);
		
		/***Then***/
		assertTrue(interviewVO.getInterviewSq() != "0");
		
	}
	
	@Test
	public void updateTest() throws Exception {
		
		/***Given***/
		InterviewVO interviewVO = new InterviewVO();
		interviewVO.setInterviewSq("1");
		interviewVO.setInterviewNm("1차면접 준비");

		
		/***When***/
		int result = interviewMapper.update(interviewVO);
		
		/***Then***/
		assertEquals(1, result);
		
	}
	
	@Test
	public void deleteTest() throws Exception {
		
		/***Given***/
		String interviewSq = "1";
		
		/***When***/
		int result = interviewMapper.delete(interviewSq);
		
		/***Then***/
		assertEquals(1, result);
		
	}
	
}
