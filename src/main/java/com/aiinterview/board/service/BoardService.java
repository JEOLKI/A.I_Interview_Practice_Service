package com.aiinterview.board.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.aiinterview.board.dao.AttachmentMapper;
import com.aiinterview.board.dao.BoardMapper;
import com.aiinterview.board.dao.ReplyMapper;
import com.aiinterview.board.vo.AttachmentVO;
import com.aiinterview.board.vo.BoardGroupVO;
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
	
	public List<BoardVO> retrieveList(String BoardGbSq) throws Exception{
		return boardMapper.retrieveList(BoardGbSq);
	}

	public int retrievePagingListCnt(BoardVO boardVO) throws Exception {
		return boardMapper.retrievePagingListCnt(boardVO);
	}
	
	public BoardGroupVO retrieve(String boardSq) throws Exception{
		BoardGroupVO boardGroupVO = new BoardGroupVO();
		boardGroupVO.setBoardVO(boardMapper.retrieve(boardSq));
		boardGroupVO.setAttachmentList(attachmentMapper.retrieveList(boardSq));
		boardGroupVO.setReplyList(replyMapper.retrieveList(boardSq));
		
		return boardGroupVO;
	}
	
	public String create(BoardGroupVO boardGroupVO) throws Exception{
		
		BoardVO boardVO = boardGroupVO.getBoardVO();
		boardMapper.create(boardVO);
		
		String boardSq = boardVO.getBoardSq();
		List<AttachmentVO> attachmentList = boardGroupVO.getAttachmentList();
		
		if(attachmentList == null) return boardSq;
		
		for(AttachmentVO attachmentVO : attachmentList) {
			attachmentVO.setBoardSq(boardSq);
			attachmentMapper.create(attachmentVO);
		}
		
		return boardSq;
		
	}
	
	public String update(BoardGroupVO boardGroupVO) throws Exception{
		
		BoardVO boardVO = boardGroupVO.getBoardVO();
		
		int updateCnt = boardMapper.update(boardVO);
		
		List<String> deleteAtchSq = boardGroupVO.getDeleteAtchSqList();
		
		if(deleteAtchSq != null) {
			for(String atchSq : deleteAtchSq) {
				attachmentMapper.delete(atchSq);
			}
		}
		
		List<AttachmentVO> attachmentList = boardGroupVO.getAttachmentList();
		
		if(attachmentList != null) {
			for(AttachmentVO attachmentVO : attachmentList) {
				attachmentVO.setBoardSq(boardVO.getBoardSq());
				attachmentMapper.create(attachmentVO);
			}
		}
		
		return boardVO.getBoardSq();
	}
	
	public int delete(String boardSq) throws Exception{
		return boardMapper.delete(boardSq);
	}

	public List<BoardVO> retrieveAllList() throws Exception{
		return boardMapper.retrieveAllList();
	}

	

}
