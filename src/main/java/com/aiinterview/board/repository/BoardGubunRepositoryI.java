package com.aiinterview.board.repository;

import java.util.List;

import com.aiinterview.board.model.BoardGubunVo;

public interface BoardGubunRepositoryI {
	
	List<BoardGubunVo> getBoardGubunList();
	
	int insertBoardGubun(BoardGubunVo boardGubunVo);
	
	int updateBoardGubun(BoardGubunVo boardGubunVo);
	
	int deleteBoardGubun(String gubun_nm);
}
