package com.aiinterview.board.service;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertTrue;

import java.util.List;

import javax.annotation.Resource;

import org.junit.Test;

import com.aiinterview.ModelTestConfig;
import com.aiinterview.board.vo.BoardGubunVO;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

public class BoardGubunServiceTest extends ModelTestConfig{

	@Resource(name="boardGubunService")
	private BoardGubunService boardGubunService;
	
	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	@Test
	public void retrieveListTest() throws Exception {
		
		/***Given***/
		
		/***When***/
		List<BoardGubunVO> boardGubunList = boardGubunService.retrieveList();

		/***Then***/
		assertEquals(4, boardGubunList.size());
		
	}
	
	@Test
	public void retrievePagingListCntTest() throws Exception {
		
		/***Given***/
		BoardGubunVO boardGubunVO = new BoardGubunVO();
		
		/***When***/
		int result = boardGubunService.retrievePagingListCnt(boardGubunVO);

		/***Then***/
		assertEquals(4, result);
		
	}
	
	
	@Test
	public void retrievePagingListTest() throws Exception {
		
		/***Given***/
		BoardGubunVO boardGubunVO = new BoardGubunVO();
		
		/** EgovPropertyService.sample */
		boardGubunVO.setPageUnit(propertiesService.getInt("pageUnit"));
		boardGubunVO.setPageSize(propertiesService.getInt("pageSize"));

		/** pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(boardGubunVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(boardGubunVO.getPageUnit());
		paginationInfo.setPageSize(boardGubunVO.getPageSize());

		boardGubunVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		boardGubunVO.setLastIndex(paginationInfo.getLastRecordIndex());
		boardGubunVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		
		/***When***/
		List<BoardGubunVO> boardGubunList = boardGubunService.retrievePagingList(boardGubunVO);
		
		/***Then***/
		assertEquals(4, boardGubunList.size());
		
	}
	
	@Test
	public void retrieveTest() throws Exception {
		
		/***Given***/
		String boardGbSq = "1";
		
		/***When***/
		BoardGubunVO boardGubunVO = boardGubunService.retrieve(boardGbSq);
		
		/***Then***/
		assertEquals("1", boardGubunVO.getBoardGbSq());
		
	}
	
	@Test
	public void createTest() throws Exception {
		
		/***Given***/
		BoardGubunVO boardGubunVO = new BoardGubunVO();
		boardGubunVO.setBoardGbNm("TEST");
		boardGubunVO.setBoardGbSt("Y");
		
		/***When***/
		String result = boardGubunService.create(boardGubunVO);
		
		/***Then***/
		assertTrue(Integer.parseInt(result) > 0);
		
	}
	
	@Test
	public void updateTest() throws Exception {
		
		/***Given***/
		BoardGubunVO boardGubunVO = new BoardGubunVO();
		boardGubunVO.setBoardGbSq("1");
		boardGubunVO.setBoardGbNm("UPDATETEST");
		boardGubunVO.setBoardGbSt("Y");
		
		/***When***/
		int result = boardGubunService.update(boardGubunVO);
		
		/***Then***/
		assertEquals(1, result);
		
	}
	
	@Test
	public void deleteTest() throws Exception {
		
		/***Given***/
		String boardGbSq = "2";
		
		/***When***/
		int result = boardGubunService.delete(boardGbSq);
		
		/***Then***/
		assertEquals(1, result);
		
	}
	
	@Test
	public void retrieveStatisticsTest() throws Exception {
		
		/***Given***/
		
		/***When***/
		List<BoardGubunVO> boardGubunList = boardGubunService.retrieveStatistics();
		
		/***Then***/
		assertEquals(4, boardGubunList.size());
		
	}

}
