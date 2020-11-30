package com.aiinterview.board.service;

import com.aiinterview.board.model.ReplyVo;

public interface ReplyServiceI {

	int insertReply(ReplyVo replyVo);

	int deleteReply(int reply_sq);

}
