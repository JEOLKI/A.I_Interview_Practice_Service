package com.aiinterview.board.dao;

import com.aiinterview.board.vo.ReplyVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("replyMapper")
public interface ReplyMapper {
	
	int insertReply(ReplyVO replyVo) throws Exception;

	int deleteReply(int reply_sq)  throws Exception;
}
