package com.aiinterview.board.dao;

import java.util.List;

import com.aiinterview.board.vo.BoardGubunVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("boardGubunMapper")
public interface BoardGubunMapper {
	
	List<BoardGubunVO> retrieveList() throws Exception;
	
}
