package com.aiinterview.board.dao;

import java.util.List;

import com.aiinterview.board.vo.BoardGubunVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("boardGubunMapper")
public interface BoardGubunMapper {
	
	public List<BoardGubunVO> retrieveList() throws Exception;
	
	public int create(BoardGubunVO boardGubunVO) throws Exception;
	
	public int update(BoardGubunVO boardGubunVO) throws Exception;
	
}
