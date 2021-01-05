package com.aiinterview.board.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.aiinterview.board.dao.ReplyMapper;
import com.aiinterview.board.vo.ReplyVO;

@Service("replyService")
public class ReplyService {

	@Resource(name = "replyMapper")
	private ReplyMapper replyMapper;
	
	public List<ReplyVO> retrievePagingList(ReplyVO replyVO) throws Exception {
		return replyMapper.retrievePagingList(replyVO);
	}
	
	public List<ReplyVO> retrieveList(String boardSq) throws Exception{
		return replyMapper.retrieveList(boardSq);
	}

	public int retrievePagingListCnt(ReplyVO replyVO) throws Exception {
		return replyMapper.retrievePagingListCnt(replyVO);
	}
	
	public ReplyVO retrieve(String replySq) throws Exception{
		return replyMapper.retrieve(replySq);
	}
	
	public void create(ReplyVO replyVO) throws Exception{
		replyMapper.create(replyVO);
	}
	
	public int update(ReplyVO replyVO) throws Exception{
		return replyMapper.update(replyVO);
	}
	
	public int delete(ReplyVO replyVO) throws Exception{
		return replyMapper.delete(replyVO);
	}
	
}
