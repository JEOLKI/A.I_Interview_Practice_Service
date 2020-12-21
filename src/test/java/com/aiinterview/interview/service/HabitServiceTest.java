package com.aiinterview.interview.service;

import static org.junit.Assert.*;

import java.util.List;

import javax.annotation.Resource;

import org.junit.Test;

import com.aiinterview.ModelTestConfig;
import com.aiinterview.interview.vo.HabitVO;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

public class HabitServiceTest extends ModelTestConfig {
	
	@Resource(name="habitService")
	private HabitService habitService;

	@Test
	public void createTest() throws Exception{
		/***Given***/
		HabitVO habitVO = new HabitVO();
		habitVO.setHabitGb("serviceTest");
		habitVO.setHabitSt("Y");

		/***When***/
		habitService.create(habitVO);

		/***Then***/
		assertTrue(habitVO.getHabitSq() != "0");
	}
	
	@Test
	public void retrieveListTest() throws Exception{
		/***Given***/

		/***When***/
		 List<HabitVO> retrieveList = habitService.retrieveList();

		/***Then***/
		assertEquals(5, retrieveList.size());
	}
	
	@Test
	public void retrieve() throws Exception{
		/***Given***/
		String habitSq = "1";

		/***When***/
		String habitGb = habitService.retrieve(habitSq);
		
		/***Then***/
		assertEquals("음", habitGb);
	
	}
	
	
	@Test
	public void update() throws Exception{
		/***Given***/
		HabitVO habitVO = new HabitVO();
		habitVO.setHabitSq("1");
		habitVO.setHabitGb("음");
		habitVO.setHabitSt("Y");

		/***When***/
		int updateCnt = habitService.update(habitVO);

		/***Then***/
		assertEquals(1, updateCnt);
		assertEquals("Y", habitVO.getHabitSt());
	}
	
	@Test
	public void retrieveUsingList() throws Exception{
		/***Given***/

		/***When***/
		List<HabitVO> habitUsingList = habitService.retrieveUsingList();
		
		/***Then***/
		assertEquals(5, habitUsingList.size());
		
	}
	
	@Test
	public void retrievePagingList() throws Exception{
		/***Given***/
		HabitVO habitVO = new HabitVO();
		habitVO.setPageUnit(3);
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(habitVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(habitVO.getPageUnit());
		paginationInfo.setPageSize(habitVO.getPageSize());
		habitVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		habitVO.setLastIndex(paginationInfo.getLastRecordIndex());
		habitVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		/***When***/
		List<HabitVO> habitPagingList = habitService.retrievePagingList(habitVO);

		/***Then***/
		assertEquals(3, habitPagingList.size());
	}
	
	@Test
	public void retrieveOne() throws Exception{
		/***Given***/
		String habitSq = "1";

		/***When***/
		HabitVO habitVO = habitService.retrieveOne(habitSq);

		/***Then***/
		assertEquals("음", habitVO.getHabitGb());
	}

}
