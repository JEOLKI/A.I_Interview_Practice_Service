package com.aiinterview.board.repository;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;

import com.aiinterview.board.model.ReplyVo;

public class ReplyRepository implements ReplyRepositoryI {
	
	@Resource(name = "sqlSessionTemplate")
	private SqlSessionTemplate sqlSession;
	
	@Override
	public int insertReply(ReplyVo replyVo) {
		return sqlSession.insert("board.insertReply", replyVo);
	}

	@Override
	public int deleteReply(int reply_sq) {
		return sqlSession.insert("board.deleteReply", reply_sq);
	}
}
