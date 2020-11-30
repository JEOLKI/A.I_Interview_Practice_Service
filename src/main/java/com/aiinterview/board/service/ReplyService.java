package com.aiinterview.board.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.aiinterview.board.dao.ReplyMapper;
import com.aiinterview.board.vo.ReplyVO;

@Service("replyService")
public class ReplyService {

	@Resource(name = "replyMapper")
	private ReplyMapper replyMapper;
	
}
