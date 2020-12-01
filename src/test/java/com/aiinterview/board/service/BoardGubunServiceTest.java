package com.aiinterview.board.service;

import static org.junit.Assert.assertEquals;

import java.util.List;

import javax.annotation.Resource;

import org.junit.Test;

import com.aiinterview.ModelTestConfig;
import com.aiinterview.board.vo.BoardGubunVO;

public class BoardGubunServiceTest extends ModelTestConfig{

	@Resource(name="boardGubunService")
	private BoardGubunService boardGubunService;
	
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
		assertEquals(5, result);
		
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

}
