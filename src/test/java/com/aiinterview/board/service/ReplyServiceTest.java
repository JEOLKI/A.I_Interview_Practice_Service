package com.aiinterview.board.service;

import static org.junit.Assert.assertEquals;

import java.util.List;

import javax.annotation.Resource;

import org.junit.Test;

import com.aiinterview.ModelTestConfig;
import com.aiinterview.board.vo.ReplyVO;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

public class ReplyServiceTest extends ModelTestConfig{

	@Resource(name="replyService")
	private ReplyService replyService;
	
	@Test
	public void retrieveListTest() throws Exception {
		
		/***Given***/
		String boardSq = "1";
		
		/***When***/
		List<ReplyVO> replyList = replyService.retrieveList(boardSq);

		/***Then***/
		assertEquals(1, replyList.size());
		
	}
	
	@Test
	public void retrievePagingListCntTest() throws Exception {
		
		/***Given***/
		ReplyVO replyVO = new ReplyVO();
		replyVO.setBoardSq("1");
		
		/***When***/
		int result = replyService.retrievePagingListCnt(replyVO);

		/***Then***/
		assertEquals(1, result);
		
	}
	
	@Test
	public void retrievePagingListTest() throws Exception {
		
		/***Given***/
		ReplyVO replyVO = new ReplyVO();
		replyVO.setBoardSq("1");
		
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(replyVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(replyVO.getPageUnit());
		paginationInfo.setPageSize(replyVO.getPageSize());
		replyVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		replyVO.setLastIndex(paginationInfo.getLastRecordIndex());
		replyVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		/***When***/
		List<ReplyVO> replyList = replyService.retrievePagingList(replyVO);
		
		/***Then***/
		assertEquals(1, replyList.size());
		
	}
	
	@Test
	public void retrieveTest() throws Exception {
		
		/***Given***/
		String replySq = "1";
		
		/***When***/
		ReplyVO replyVO = replyService.retrieve(replySq);
		
		/***Then***/
		assertEquals("1", replyVO.getReplySq());
		
	}
	
	@Test
	public void createTest() throws Exception {
		
		/***Given***/
		ReplyVO replyVO = new ReplyVO();
		replyVO.setBoardSq("1");
		replyVO.setReplyContent("TEST");;
		replyVO.setReplySt("Y");
		replyVO.setMemId("TEST_ID");
		
		String boardSq = "1";
		
		/***When***/
		replyService.create(replyVO);
		
		/***Then***/
		assertEquals(2, replyService.retrieveList(boardSq).size());
		
	}
	
	@Test
	public void updateTest() throws Exception {
		
		/***Given***/
		ReplyVO replyVO = new ReplyVO();
		replyVO.setReplySq("1");
		replyVO.setBoardSq("1");
		replyVO.setReplyContent("TEST");;
		replyVO.setReplySt("N");
		replyVO.setMemId("TEST_ID");
		
		/***When***/
		int result = replyService.update(replyVO);
		
		/***Then***/
		assertEquals(1, result);
		
	}
	
	@Test
	public void deleteTest() throws Exception {
		
		/***Given***/
		ReplyVO replyVO = new ReplyVO();
		replyVO.setReplySq("1");
		replyVO.setBoardSq("1");
		replyVO.setReplyContent("TEST");;
		replyVO.setReplySt("N");
		replyVO.setMemId("TEST_ID");
		
		/***When***/
		int result = replyService.delete(replyVO);
		
		/***Then***/
		assertEquals(1, result);
		
	}

}
