package com.aiinterview.interview.service;

import static org.junit.Assert.*;

import java.io.File;
import java.util.List;

import javax.annotation.Resource;

import org.junit.Test;

import com.aiinterview.ModelTestConfig;
import com.aiinterview.interview.vo.HabitVO;
import com.aiinterview.interview.vo.QuestionGubunVO;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

public class QuestionGubunServiceTest extends ModelTestConfig{
	
	@Resource(name="questionGubunService")
	private QuestionGubunService questionGubunService;

	@Test
	public void retrieveListTest() throws Exception{
		/***Given***/

		/***When***/
		List<QuestionGubunVO> questGbList = questionGubunService.retrieveList();

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
		questionGubunService.create(questionGubunVO);

		/***Then***/
		assertTrue(questionGubunVO.getQuestGbSq() != "0");
	}
	
	@Test
	public void createMassiveQuestGbTest() throws Exception{
		/***Given***/
		File destFile = new File("src/test/resources/file/guestionGubunTest.xlsx");

		/***When***/
		questionGubunService.createMassiveQuestGb(destFile);
		List<QuestionGubunVO> questGbList = questionGubunService.retrieveList();

		/***Then***/
		assertEquals(27, questGbList.size());
	}
	
	
	@Test
	public void updateTest() throws Exception{
		/***Given***/
		QuestionGubunVO questionGubunVO = new QuestionGubunVO();
		questionGubunVO.setQuestGbSq("1");
		questionGubunVO.setQuestGbContent("updateTest");
		questionGubunVO.setQuestGbSt("N");

		/***When***/
		int updateCnt = questionGubunService.update(questionGubunVO);

		/***Then***/
		assertEquals(1, updateCnt);
		assertEquals("N", questionGubunVO.getQuestGbSt());
		assertEquals("updateTest", questionGubunVO.getQuestGbContent());
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
		List<QuestionGubunVO> questGbList = questionGubunService.retrievePagingList(questionGubunVO);

		/***Then***/
		assertEquals(10, questGbList.size());
	}
	
	@Test
	public void retrievePagingListCntTest() throws Exception{
		/***Given***/
		QuestionGubunVO questionGubunVO = new QuestionGubunVO();

		/***When***/
		int totCnt = questionGubunService.retrievePagingListCnt(questionGubunVO);

		/***Then***/
		assertEquals(14, totCnt);
	}
	
	@Test
	public void retrieveUsingListTest() throws Exception{
		/***Given***/

		/***When***/
		List<QuestionGubunVO> usingList = questionGubunService.retrieveUsingList();
		
		/***Then***/
		assertEquals(14, usingList.size());
		
	}
	
	@Test
	public void retrieveTest() throws Exception{
		/***Given***/
		String questGbSq = "1";

		/***When***/
		QuestionGubunVO questionGubunVO = questionGubunService.retrieve(questGbSq);

		/***Then***/
		assertEquals("일반", questionGubunVO.getQuestGbContent());
	}
	
}
