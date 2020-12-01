package com.aiinterview.board.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.aiinterview.board.dao.BoardMapper;
import com.aiinterview.board.vo.BoardVO;

@Transactional
@Service("boardService")
public class BoardService {

	@Resource(name = "boardMapper")
	private BoardMapper boardMapper;

	public List<BoardVO> retrievePagingList(BoardVO boardVO) throws Exception {
		return boardMapper.retrieveList(boardVO);
	}
	
	public List<BoardVO> retrieveList(BoardVO boardVO) throws Exception{
		return boardMapper.retrieveList(boardVO);
	}

	public int retrievePagingListCnt(BoardVO boardVO) throws Exception {
		return boardMapper.retrievePagingListCnt(boardVO);
	}
	
	public BoardVO retrieve(int boardSq) throws Exception{
		return boardMapper.retrieve(boardSq);
	}
	
	public String create(BoardVO boardVO) throws Exception{
		return boardMapper.create(boardVO);
	}
	
	public int update(BoardVO boardVO) throws Exception{
		return boardMapper.update(boardVO);
	}
	
	public int delete(int boardSq) throws Exception{
		return boardMapper.delete(boardSq);
	}

	

}
