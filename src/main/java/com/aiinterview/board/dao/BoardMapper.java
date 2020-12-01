package com.aiinterview.board.dao;

import java.util.List;

import com.aiinterview.board.vo.BoardVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("boardMapper")
public interface BoardMapper {
	
	public List<BoardVO> retrieveList(BoardVO boardVO) throws Exception;
	
	public List<BoardVO> retrievePageList(BoardVO boardVO) throws Exception;
	
	public int retrievePagingListCnt(BoardVO boardVO) throws Exception;
	
	public BoardVO retrieve(int boardSq) throws Exception;
	
	public String create(BoardVO boardVO) throws Exception;
	
	public int update(BoardVO boardVO) throws Exception;
	
	public int delete(int boardSq) throws Exception;
	
}
