package com.aiinterview.board.service;

import java.util.List;
import java.util.Map;

import com.aiinterview.board.model.AtchFileVo;
import com.aiinterview.board.model.BoardVo;
import com.aiinterview.common.model.PageVo;

public interface BoardServiceI {
	
	List<BoardVo> getBoardList(int gubun_sq);

	Map<String, Object> getBoardPageList(PageVo pageVo);

	Map<String, Object> getBoard(int board_sq);

	int deleteBoard(int board_sq);

	int insertBoard(Map<String, Object> map);
	
	AtchFileVo getAtchFile(int atch_sq);

	int deleteAtchFile(int atch_sq);

	int updateBoard(Map<String, Object> map);
	
}
