package com.aiinterview.board.dao;

import java.util.List;

import com.aiinterview.board.vo.ReplyVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("replyMapper")
public interface ReplyMapper {
	
	public List<ReplyVO> retrieveList(String boardSq) throws Exception;
	
	public List<ReplyVO> retrievePagingList(ReplyVO replyVO) throws Exception;
	
	public int retrievePagingListCnt(ReplyVO replyVO) throws Exception;
	
	public ReplyVO retrieve(String replySq) throws Exception;
	
	public void create(ReplyVO replyVO) throws Exception;
	
	public int update(ReplyVO replyVO) throws Exception;
	
	public int delete(ReplyVO replyVO) throws Exception;
	
}
