package com.aiinterview.board.dao;

import static org.junit.Assert.assertEquals;

import java.util.List;

import javax.annotation.Resource;

import org.junit.Test;

import com.aiinterview.ModelTestConfig;
import com.aiinterview.board.vo.BoardVO;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

public class BoardMapperTest extends ModelTestConfig{
	
	@Resource(name="boardMapper")
	private BoardMapper boardMapper;
	
	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	@Test
	public void retrieveListTest() throws Exception {
		
		/***Given***/
		String BoardGbSq = "1";
		
		/***When***/
		List<BoardVO> boardList = boardMapper.retrieveList(BoardGbSq);

		/***Then***/
		assertEquals(2, boardList.size());
		
	}
	
	@Test
	public void retrievePagingListTest() throws Exception {
		
		/***Given***/
		BoardVO boardVO = new BoardVO();
		boardVO.setBoardGbSq("1");
		boardVO.setPageUnit(propertiesService.getInt("pageUnit"));
		boardVO.setPageSize(propertiesService.getInt("pageSize"));
		
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(boardVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(boardVO.getPageUnit());
		paginationInfo.setPageSize(boardVO.getPageSize());

		boardVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		boardVO.setLastIndex(paginationInfo.getLastRecordIndex());
		boardVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		/***When***/
		List<BoardVO> boardList = boardMapper.retrievePagingList(boardVO);
		
		/***Then***/
		assertEquals(2, boardList.size());
		
	}
	
	@Test
	public void retrievePagingListCntTest() throws Exception {
		
		/***Given***/
		BoardVO boardVO = new BoardVO();
		boardVO.setBoardGbSq("1");
		
		/***When***/
		int result = boardMapper.retrievePagingListCnt(boardVO);

		/***Then***/
		assertEquals(2, result);
		
	}
	
	@Test
	public void retrieveTest() throws Exception {
		
		/***Given***/
		String boardSq = "1";
		
		/***When***/
		BoardVO boardVO = boardMapper.retrieve(boardSq);
		
		/***Then***/
		assertEquals("1", boardVO.getBoardSq());
		
	}
	
	@Test
	public void createTest() throws Exception {
		
		/***Given***/
		BoardVO boardVO = new BoardVO();
		boardVO.setBoardGbSq("1");
		boardVO.setBoardTitle("TEST");
		boardVO.setBoardContent("TEST");
		boardVO.setBoardSt("Y");
		boardVO.setParentSq("0");
		boardVO.setGroupNo("0");
		boardVO.setMemId("TEST_ID");
		boardVO.setCatContent("TEST");
		
		String boardGbSq = "1";
		
		/***When***/
		boardMapper.create(boardVO);
		
		/***Then***/
		assertEquals(3, boardMapper.retrieveList(boardGbSq).size());
		
	}
	
	@Test
	public void updateTest() throws Exception {
		
		/***Given***/
		BoardVO boardVO = new BoardVO();
		boardVO.setBoardSq("1");
		boardVO.setBoardGbSq("1");
		boardVO.setBoardTitle("TEST");
		boardVO.setBoardContent("TEST");
		boardVO.setBoardSt("Y");
		boardVO.setParentSq("0");
		boardVO.setGroupNo("0");
		boardVO.setMemId("TEST_ID");
		boardVO.setCatContent("TEST");
		
		/***When***/
		int result = boardMapper.update(boardVO);
		
		/***Then***/
		assertEquals(1, result);
		
	}
	
	@Test
	public void deleteTest() throws Exception {
		
		/***Given***/
		String boardSq = "1";
		
		/***When***/
		int result = boardMapper.delete(boardSq);
		
		/***Then***/
		assertEquals(1, result);
		
	}
	
	@Test
	public void retrieveAllListTest() throws Exception {
		
		/***Given***/
		
		/***When***/
		List<BoardVO> boardList = boardMapper.retrieveAllList();
		
		/***Then***/
		assertEquals(6, boardList.size());
		
	}
	
	
	

}
