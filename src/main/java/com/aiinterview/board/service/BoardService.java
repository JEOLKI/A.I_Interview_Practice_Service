package com.aiinterview.board.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.aiinterview.board.dao.BoardMapper;

@Transactional
@Service("boardService")
public class BoardService {

	@Resource(name = "boardMapper")
	private BoardMapper boardMapper;


}
