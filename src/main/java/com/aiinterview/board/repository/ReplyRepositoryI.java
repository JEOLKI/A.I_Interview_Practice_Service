package com.aiinterview.board.repository;

import com.aiinterview.board.model.ReplyVo;

public interface ReplyRepositoryI {
	
	int insertReply(ReplyVo replyVo);

	int deleteReply(int reply_sq);
}
