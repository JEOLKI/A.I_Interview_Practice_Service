package com.aiinterview.interview.service;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertTrue;

import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.junit.Test;

import com.aiinterview.ModelTestConfig;
import com.aiinterview.interview.vo.InterviewVO;
import com.aiinterview.interview.vo.QuestionVO;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

public class InterviewServiceTest extends ModelTestConfig{
	
	@Resource(name="interviewService")
	private InterviewService interviewService;
	
	@Test
	public void retrieveListTest() throws Exception {
		
		/***Given***/
		
		/***When***/
		List<InterviewVO> interviewList = interviewService.retrieveList();
		
		/***Then***/
		assertEquals(5, interviewList.size());
		
	}
	
	@Test
	public void retrievePagingListCntTest() throws Exception {
		
		/***Given***/
		InterviewVO interviewVO = new InterviewVO();
		interviewVO.setMemId("MEMBER1");
		
		/***When***/
		int result = interviewService.retrievePagingListCnt(interviewVO);

		/***Then***/
		assertEquals(5, result);
		
	}
	
	@Test
	public void retrievePagingListTest() throws Exception {
		
		/***Given***/
		InterviewVO interviewVO = new InterviewVO();
		interviewVO.setMemId("MEMBER1");
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
		List<InterviewVO> interviewList = interviewService.retrievePagingList(interviewVO);
		
		/***Then***/
		assertEquals(5, interviewList.size());
		
	}
	
	@Test
	public void retrieveTest() throws Exception {
		
		/***Given***/
		String interviewSq = "1";
		
		/***When***/
		InterviewVO interviewVO = interviewService.retrieve(interviewSq);
		
		/***Then***/
		assertEquals("1", interviewVO.getInterviewSq());
		
	}
	
	@Test
	public void createTest() throws Exception {
		
		/***Given***/
		Map<String, Object> map = new HashMap<String, Object>();
		InterviewVO interviewVO = new InterviewVO();
		interviewVO.setMemId("MEMBER1");
		map.put("interviewVO", interviewVO); // map 객체에 면접 객체 넣기
		
		List<QuestionVO> questionVOList = new ArrayList<>();
		QuestionVO questionVO = new QuestionVO("테스트 질문", "0");
		questionVOList.add(questionVO); // 최종 질문 목록에 추가
		map.put("questionVOList", questionVOList);
		
		
		/***When***/
		String interviewSq = interviewService.create(map);
		
		/***Then***/
		assertTrue(interviewSq != null);
		
	}
	
	@Test
	public void updateTest() throws Exception {
		
		/***Given***/
		InterviewVO interviewVO = new InterviewVO();
		interviewVO.setInterviewSq("1");
		interviewVO.setInterviewNm("1차면접 준비");

		
		/***When***/
		int result = interviewService.update(interviewVO);
		
		/***Then***/
		assertEquals(1, result);
		
	}
	
	@Test
	public void deleteTest() throws Exception {
		
		/***Given***/
		String interviewSq = "1";
		
		/***When***/
		int result = interviewService.delete(interviewSq);
		
		/***Then***/
		assertEquals(1, result);
		
	}

}
