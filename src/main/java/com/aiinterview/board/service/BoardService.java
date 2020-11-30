package com.aiinterview.board.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.aiinterview.board.dao.BoardMapper;
import com.aiinterview.board.vo.AtchFileVo;
import com.aiinterview.board.vo.BoardVo;
import com.aiinterview.common.model.PageVo;

@Transactional
@Service("boardService")
public class BoardService {

	@Resource(name = "boardMapper")
	private BoardMapper boardMapper;


}
