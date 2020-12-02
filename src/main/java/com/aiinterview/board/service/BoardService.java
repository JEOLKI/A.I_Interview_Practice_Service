package com.aiinterview.board.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.aiinterview.board.dao.AttachmentMapper;
import com.aiinterview.board.dao.BoardMapper;
import com.aiinterview.board.dao.ReplyMapper;
import com.aiinterview.board.vo.AttachmentVO;
import com.aiinterview.board.vo.BoardVO;

@Transactional
@Service("boardService")
public class BoardService {

	@Resource(name = "boardMapper")
	private BoardMapper boardMapper;
	
	@Resource(name = "attachmentMapper")
	private AttachmentMapper attachmentMapper;

	@Resource(name = "replyMapper")
	private ReplyMapper replyMapper;
	
	public List<BoardVO> retrievePagingList(BoardVO boardVO) throws Exception {
		return boardMapper.retrievePagingList(boardVO);
	}
	
	public List<BoardVO> retrieveList() throws Exception{
		return boardMapper.retrieveList();
	}

	public int retrievePagingListCnt(BoardVO boardVO) throws Exception {
		return boardMapper.retrievePagingListCnt(boardVO);
	}
	
	public Map<String, Object> retrieve(String boardSq) throws Exception{
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("boardVO", boardMapper.retrieve(boardSq));
		map.put("attachmentList", attachmentMapper.retrieveList(boardSq));
		map.put("replyList", replyMapper.retrieveList(boardSq));
		return map;
	}
	
	public String create(Map<String, Object> map) throws Exception{
		
		BoardVO boardVO = (BoardVO) map.get("boardVO");
		boardMapper.create(boardVO);
		
		String boardSq = boardVO.getBoardSq();
		List<AttachmentVO> attachmentList = (List<AttachmentVO>) map.get("attachmentList");
		
		if(attachmentList == null) return boardSq;
		
		for(AttachmentVO attachmentVO : attachmentList) {
			attachmentVO.setBoardSq(boardSq);
			attachmentMapper.create(attachmentVO);
		}
		
		return boardSq;
		
	}
	
	public String update(Map<String, Object> map) throws Exception{
		
		BoardVO boardVO = (BoardVO) map.get("boardVO");
		
		int updateCnt = boardMapper.update(boardVO);
		
		List<String> deleteAtchSq = (List<String>) map.get("deleteAtchSq");
		
		if(deleteAtchSq != null) {
			for(String atchSq : deleteAtchSq) {
				attachmentMapper.delete(atchSq);
			}
		}
		List<AttachmentVO> attachmentList = (List<AttachmentVO>) map.get("attachmentList");
		
		int insertCnt = 0;
		for(AttachmentVO attachmentVO : attachmentList) {
			attachmentVO.setBoardSq(boardVO.getBoardSq());
			attachmentMapper.create(attachmentVO);
		}
		
		return boardVO.getBoardSq();
	}
	
	public int delete(String boardSq) throws Exception{
		return boardMapper.delete(boardSq);
	}

	

}
