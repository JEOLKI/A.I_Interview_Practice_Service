package com.aiinterview.board.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.aiinterview.board.dao.BoardGubunMapper;
import com.aiinterview.board.vo.BoardGubunVO;

@Service("boardGubunService")
public class BoardGubunService {
	
	@Resource(name = "boardGubunMapper")
	private BoardGubunMapper boardGubunMapper;
	
	public List<BoardGubunVO> retrieveList() throws Exception{
		return boardGubunMapper.retrieveList();
	}
	
	public int create(BoardGubunVO boardGubunVO) throws Exception{
		return boardGubunMapper.create(boardGubunVO);
	}
	
	public int update(BoardGubunVO boardGubunVO) throws Exception{
		return boardGubunMapper.update(boardGubunVO);
	}

}
