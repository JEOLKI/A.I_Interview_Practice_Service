package com.aiinterview.board.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.aiinterview.board.model.ReplyVo;
import com.aiinterview.board.repository.ReplyRepositoryI;

@Transactional
@Service("replyService")
public class ReplyService implements ReplyServiceI{

	@Resource(name = "replyRepository")
	private ReplyRepositoryI replyRepository;
	
	@Override
	public int insertReply(ReplyVo replyVo) {
		return replyRepository.insertReply(replyVo);
	}

	@Override
	public int deleteReply(int reply_sq) {
		return replyRepository.deleteReply(reply_sq);
	}

}
