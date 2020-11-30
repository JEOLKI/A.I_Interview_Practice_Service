package com.aiinterview.board.dao;

import com.aiinterview.board.vo.ReplyVo;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("replyMapper")
public interface ReplyMapper {
	
	int insertReply(ReplyVo replyVo) throws Exception;

	int deleteReply(int reply_sq)  throws Exception;
}
