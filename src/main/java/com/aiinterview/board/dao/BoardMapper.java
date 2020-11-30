package com.aiinterview.board.dao;

import java.util.List;

import com.aiinterview.board.vo.AtchFileVo;
import com.aiinterview.board.vo.BoardVo;
import com.aiinterview.board.vo.ReplyVo;
import com.aiinterview.common.model.PageVo;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("boardMapper")
public interface BoardMapper {

	List<BoardVo> getBoardList(int gubun_sq) throws Exception;

	List<BoardVo> getBoardPageList(PageVo pageVo) throws Exception;

	int getBoardTotalCnt(int gubun_sq) throws Exception;

	BoardVo getBoard(int board_sq) throws Exception;

	List<AtchFileVo> getAtchFileList(int board_sq) throws Exception;

	List<ReplyVo> getReplyList(int board_sq) throws Exception;

	int deleteBoard(int board_sq) throws Exception;

	int insertBoard(BoardVo boardVo) throws Exception;

	int insertAtchFile(AtchFileVo atchfileVo) throws Exception;

	int insertBoardChild(BoardVo boardVo) throws Exception;

	AtchFileVo getAtchFile(int atch_sq) throws Exception;

	int deleteAtchFile(int atch_sq) throws Exception;

	int updateBoard(BoardVo boardVo) throws Exception;
}
