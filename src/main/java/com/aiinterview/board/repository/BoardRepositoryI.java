package com.aiinterview.board.repository;

import java.util.List;

import com.aiinterview.board.model.AtchFileVo;
import com.aiinterview.board.model.BoardVo;
import com.aiinterview.board.model.ReplyVo;
import com.aiinterview.common.model.PageVo;

public interface BoardRepositoryI {

	List<BoardVo> getBoardList(int gubun_sq);

	List<BoardVo> getBoardPageList(PageVo pageVo);

	int getBoardTotalCnt(int gubun_sq);

	BoardVo getBoard(int board_sq);

	List<AtchFileVo> getAtchFileList(int board_sq);

	List<ReplyVo> getReplyList(int board_sq);

	int deleteBoard(int board_sq);

	int insertBoard(BoardVo boardVo);

	int insertAtchFile(AtchFileVo atchfileVo);

	int insertBoardChild(BoardVo boardVo);

	AtchFileVo getAtchFile(int atch_sq);

	int deleteAtchFile(int atch_sq);

	int updateBoard(BoardVo boardVo);
}
