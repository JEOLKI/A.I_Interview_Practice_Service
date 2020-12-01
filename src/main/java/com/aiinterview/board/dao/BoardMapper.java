package com.aiinterview.board.dao;

import java.util.List;

import com.aiinterview.board.vo.BoardVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("boardMapper")
public interface BoardMapper {
	
	public List<BoardVO> retrieveList() throws Exception;
	
	public List<BoardVO> retrievePagingList(BoardVO boardVO) throws Exception;
	
	public int retrievePagingListCnt(BoardVO boardVO) throws Exception;
	
	public BoardVO retrieve(String boardSq) throws Exception;
	
	public String create(BoardVO boardVO) throws Exception;
	
	public int update(BoardVO boardVO) throws Exception;
	
	public int delete(String boardSq) throws Exception;
	
	
}
