package com.aiinterview.board.dao;

import static org.junit.Assert.assertEquals;


import java.util.List;

import javax.annotation.Resource;

import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.aiinterview.ModelTestConfig;
import com.aiinterview.board.vo.BoardGubunVO;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

public class BoardGubunMapperTest extends ModelTestConfig{
	
	private static final Logger logger = LoggerFactory.getLogger(BoardGubunMapperTest.class);
	
	@Resource(name="boardGubunMapper")
	private BoardGubunMapper boardGubunMapper;
	
	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	@Test
	public void retrieveListTest() throws Exception {
		
		/***Given***/
		
		/***When***/
		List<BoardGubunVO> boardGubunList = boardGubunMapper.retrieveList();

		/***Then***/
		assertEquals(4, boardGubunList.size());
		
	}
	
	@Test
	public void retrievePagingListCntTest() throws Exception {
		
		/***Given***/
		BoardGubunVO boardGubunVO = new BoardGubunVO();
		
		/***When***/
		int result = boardGubunMapper.retrievePagingListCnt(boardGubunVO);

		/***Then***/
		assertEquals(4, result);
		
	}
	
	
	@Test
	public void retrievePagingListTest() throws Exception {
		
		/***Given***/
		BoardGubunVO boardGubunVO = new BoardGubunVO();
		boardGubunVO.setPageUnit(propertiesService.getInt("pageUnit"));
		boardGubunVO.setPageSize(propertiesService.getInt("pageSize"));
		
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(boardGubunVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(boardGubunVO.getPageUnit());
		paginationInfo.setPageSize(boardGubunVO.getPageSize());

		boardGubunVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		boardGubunVO.setLastIndex(paginationInfo.getLastRecordIndex());
		boardGubunVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		/***When***/
		List<BoardGubunVO> boardGubunList = boardGubunMapper.retrievePagingList(boardGubunVO);
		
		/***Then***/
		assertEquals(4, boardGubunList.size());
		
	}
	
	@Test
	public void retrieveTest() throws Exception {
		
		/***Given***/
		String boardGbSq = "1";
		
		/***When***/
		BoardGubunVO boardGubunVO = boardGubunMapper.retrieve(boardGbSq);
		
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
		boardGubunMapper.create(boardGubunVO);
		
		/***Then***/
		assertEquals(5, boardGubunMapper.retrieveList().size());
		
	}
	
	@Test
	public void updateTest() throws Exception {
		
		/***Given***/
		BoardGubunVO boardGubunVO = new BoardGubunVO();
		boardGubunVO.setBoardGbSq("1");
		boardGubunVO.setBoardGbNm("UPDATETEST");
		boardGubunVO.setBoardGbSt("Y");
		
		/***When***/
		int result = boardGubunMapper.update(boardGubunVO);
		
		/***Then***/
		assertEquals(1, result);
		
	}
	
	@Test
	public void deleteTest() throws Exception {
		
		/***Given***/
		String boardGbSq = "2";
		
		/***When***/
		int result = boardGubunMapper.delete(boardGbSq);
		
		/***Then***/
		assertEquals(1, result);
		
	}
	
	@Test
	public void retrieveStatisticsTest() throws Exception {
		
		/***Given***/
		
		/***When***/
		List<BoardGubunVO> boardGubunList = boardGubunMapper.retrieveStatistics();
		
		/***Then***/
		assertEquals(4, boardGubunList.size());
		
	}
	
	

}
