package com.aiinterview.board.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.aiinterview.board.dao.BoardGubunMapper;
import com.aiinterview.board.vo.BoardGubunVO;

@Service("boardGubunService")
public class BoardGubunService {
	
	@Resource(name = "boardGubunMapper")
	private BoardGubunMapper boardGubunMapper;
	
	public List<BoardGubunVO> retrievePagingList(BoardGubunVO boardGubunVO) throws Exception {
		return boardGubunMapper.retrievePagingList(boardGubunVO);
	}
	
	public List<BoardGubunVO> retrieveList() throws Exception{
		return boardGubunMapper.retrieveList();
	}

	public int retrievePagingListCnt(BoardGubunVO boardGubunVO) throws Exception {
		return boardGubunMapper.retrievePagingListCnt(boardGubunVO);
	}
	
	public BoardGubunVO retrieve(String boardGbSq) throws Exception{
		return boardGubunMapper.retrieve(boardGbSq);
	}
	
	public String create(BoardGubunVO boardGubunVO) throws Exception{
		boardGubunMapper.create(boardGubunVO);
		return boardGubunVO.getBoardGbSq();
	}
	
	public int update(BoardGubunVO boardGubunVO) throws Exception{
		return boardGubunMapper.update(boardGubunVO);
	}
	
	public int delete(String boardGbSq) throws Exception{
		return boardGubunMapper.delete(boardGbSq);
	}

	public List<BoardGubunVO> retrieveStatistics() throws Exception{
		return boardGubunMapper.retrieveStatistics();
	}
	
	
}
