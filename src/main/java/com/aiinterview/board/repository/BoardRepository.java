package com.aiinterview.board.repository;

import java.util.List;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.aiinterview.board.model.AtchFileVo;
import com.aiinterview.board.model.BoardVo;
import com.aiinterview.board.model.ReplyVo;
import com.aiinterview.common.model.PageVo;

@Repository("boardRepository")
public class BoardRepository implements BoardRepositoryI{
	@Resource(name = "sqlSessionTemplate")
	private SqlSessionTemplate sqlSession;

	@Override
	public List<BoardVo> getBoardList(int gubun_sq) {
		return sqlSession.selectList("board.getBoardList", gubun_sq);
	}

	@Override
	public List<BoardVo> getBoardPageList(PageVo pageVo) {
		return sqlSession.selectList("board.getBoardPageList", pageVo);
	}

	@Override
	public int getBoardTotalCnt(int gubun_sq) {
		return sqlSession.selectOne("board.getBoardTotalCnt", gubun_sq);
	}

	@Override
	public BoardVo getBoard(int board_sq) {
		return sqlSession.selectOne("board.getBoard", board_sq);
	}

	@Override
	public List<AtchFileVo> getAtchFileList(int board_sq) {
		return sqlSession.selectList("board.getAtchFileList", board_sq);
	}

	@Override
	public List<ReplyVo> getReplyList(int board_sq) {
		return sqlSession.selectList("board.getReplyList", board_sq);
	}

	@Override
	public int deleteBoard(int board_sq) {
		return sqlSession.update("board.deleteBoard", board_sq);
	}

	@Override
	public int insertBoard(BoardVo boardVo) {
		sqlSession.insert("board.insertBoard", boardVo);
		return boardVo.getBoard_sq();
	}

	@Override
	public int insertAtchFile(AtchFileVo atchfileVo) {
		return sqlSession.insert("board.insertAtchFile", atchfileVo);
	}

	@Override
	public int insertBoardChild(BoardVo boardVo) {
		sqlSession.insert("board.insertBoardChild", boardVo);
		return boardVo.getBoard_sq();
	}

	@Override
	public AtchFileVo getAtchFile(int atch_sq) {
		return sqlSession.selectOne("board.getAtchFile", atch_sq);
	}

	@Override
	public int deleteAtchFile(int atch_sq) {
		return sqlSession.delete("board.deleteAtchFile", atch_sq);
	}

	@Override
	public int updateBoard(BoardVo boardVo) {
		return sqlSession.update("board.updateBoard", boardVo);
	}

}
