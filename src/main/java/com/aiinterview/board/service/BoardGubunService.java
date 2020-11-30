package com.aiinterview.board.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.aiinterview.board.model.BoardGubunVo;
import com.aiinterview.board.repository.BoardGubunRepositoryI;

@Transactional
@Service("boardGubunService")
public class BoardGubunService implements BoardGubunServiceI{
	
	@Resource(name = "boardGubunRepository")
	private BoardGubunRepositoryI boardGubunRepository;
	
	@Override
	public List<BoardGubunVo> getBoardGubunList() {
		return boardGubunRepository.getBoardGubunList();
	}

	@Override
	public int insertBoardGubun(BoardGubunVo boardGubunVo) {
		return boardGubunRepository.insertBoardGubun(boardGubunVo);
	}

	@Override
	public int updateBoardGubun(BoardGubunVo boardGubunVo) {
		return boardGubunRepository.updateBoardGubun(boardGubunVo);
	}

	@Override
	public int deleteBoardGubun(String gubun_nm) {
		return boardGubunRepository.deleteBoardGubun(gubun_nm);
	}

}
