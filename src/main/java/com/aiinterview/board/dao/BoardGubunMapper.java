package com.aiinterview.board.dao;

import java.util.List;

import com.aiinterview.board.vo.BoardGubunVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("boardGubunMapper")
public interface BoardGubunMapper {
	
	public List<BoardGubunVO> retrievePagingList(BoardGubunVO boardGubunVO) throws Exception;
	
	public int retrievePagingListCnt(BoardGubunVO boardGubunVO) throws Exception;
	
	public List<BoardGubunVO> retrieveList() throws Exception;
	
	public BoardGubunVO retrieve(String boardGbSq) throws Exception;
	
	public void create(BoardGubunVO boardGubunVO) throws Exception;
	
	public int update(BoardGubunVO boardGubunVO) throws Exception;
	
	public int delete(String boardGbSq) throws Exception;

	public List<BoardGubunVO> retrieveStatistics() throws Exception;

}
