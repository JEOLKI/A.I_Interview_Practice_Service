package com.aiinterview.board.dao;

import static org.junit.Assert.*;

import java.util.List;

import javax.annotation.Resource;

import org.junit.Test;

import com.aiinterview.ModelTestConfig;
import com.aiinterview.board.dao.ReplyMapper;
import com.aiinterview.board.vo.ReplyVO;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

public class ReplyMapperTest extends ModelTestConfig{

	@Resource(name="replyMapper")
	private ReplyMapper replyMapper;
	
	@Test
	public void retrieveListTest() throws Exception {
		
		/***Given***/
		String boardSq = "1";
		
		/***When***/
		List<ReplyVO> categoryList = replyMapper.retrieveList(boardSq);

		/***Then***/
		assertEquals(3, categoryList.size());
		
	}
	
	@Test
	public void retrievePagingListCntTest() throws Exception {
		
		/***Given***/
		ReplyVO replyVO = new ReplyVO();
		replyVO.setBoardSq("1");
		
		/***When***/
		int result = replyMapper.retrievePagingListCnt(replyVO);

		/***Then***/
		assertEquals(3, result);
		
	}
	
	@Test
	public void retrievePagingListTest() throws Exception {
		
		/***Given***/
		ReplyVO replyVO = new ReplyVO();
		replyVO.setPageUnit(10);
		replyVO.setPageSize(10);
		replyVO.setBoardSq("1");
		
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(replyVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(replyVO.getPageUnit());
		paginationInfo.setPageSize(replyVO.getPageSize());
		replyVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		replyVO.setLastIndex(paginationInfo.getLastRecordIndex());
		replyVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		/***When***/
		List<ReplyVO> categoryList = replyMapper.retrievePagingList(replyVO);
		
		/***Then***/
		assertEquals(3, categoryList.size());
		
	}
	
	@Test
	public void retrieveTest() throws Exception {
		
		/***Given***/
		String replySq = "1";
		
		/***When***/
		ReplyVO replyVO = replyMapper.retrieve(replySq);
		
		/***Then***/
		assertEquals("1", replyVO.getReplySq());
		
	}
	
	@Test
	public void createTest() throws Exception {
		
		/***Given***/
		ReplyVO replyVO = new ReplyVO();
		replyVO.setBoardSq("1");
		replyVO.setReplyContent("TESTCONTENT");
		replyVO.setReplySt("Y");
		replyVO.setMemId("TEST_ID");
		
		/***When***/
		replyMapper.create(replyVO);
		
		/***Then***/
		assertEquals(4, replyMapper.retrieveList("1").size());
		
	}
	
	@Test
	public void updateTest() throws Exception {
		
		/***Given***/
		ReplyVO replyVO = new ReplyVO();
		replyVO.setReplySq("1");
		replyVO.setReplyContent("UPDATETEST");
		replyVO.setReplySt("N");
		
		/***When***/
		int result = replyMapper.update(replyVO);
		
		/***Then***/
		assertEquals(1, result);
		
	}
	
	@Test
	public void deleteTest() throws Exception {
		
		/***Given***/
		ReplyVO replyVO = new ReplyVO();
		replyVO.setReplySq("1");
		
		/***When***/
		int result = replyMapper.delete(replyVO);
		
		/***Then***/
		assertEquals(1, result);
		
	}

}
