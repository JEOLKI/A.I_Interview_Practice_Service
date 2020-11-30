package com.aiinterview.board.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.aiinterview.board.model.AtchFileVo;
import com.aiinterview.board.model.BoardVo;
import com.aiinterview.board.repository.BoardRepositoryI;
import com.aiinterview.common.model.PageVo;

@Transactional
@Service("boardService")
public class BoardService implements BoardServiceI {

	@Resource(name = "boardRepository")
	private BoardRepositoryI boardRepository;

	@Override
	public List<BoardVo> getBoardList(int gubun_sq) {
		return boardRepository.getBoardList(gubun_sq);
	}

	@Override
	public Map<String, Object> getBoardPageList(PageVo pageVo) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		List<BoardVo> boardList = boardRepository.getBoardPageList(pageVo);
		
		for(BoardVo board :boardList) {
			if(board.getBoard_title().contains(("→"))){
				board.setBoard_title(board.getBoard_title().replaceAll("1", "&nbsp;"));
			}
		}
		map.put("boardList", boardRepository.getBoardPageList(pageVo));
		
		// 15건, 페이지 사이즈를 7로 가정했을때 3개의 페이지가 나와야한다
		// 15/7 =2.14.. 올림을 하여 3개의 페이지가 필요
		int totalCnt = boardRepository.getBoardTotalCnt(pageVo.getGubun_sq());
		int pageSize = pageVo.getPageSize();
		int pages = (int) Math.ceil( (double)totalCnt/pageSize);
		map.put("pages", pages);
		
		return map;
		
	}

	@Override
	public Map<String, Object> getBoard(int board_sq) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("boardVo", boardRepository.getBoard(board_sq));
		map.put("atchFileList", boardRepository.getAtchFileList(board_sq));
		map.put("replyList", boardRepository.getReplyList(board_sq));
		return map;
	}

	@Override
	public int deleteBoard(int board_sq) {
		return boardRepository.deleteBoard(board_sq);
	}

	@Override
	public int insertBoard(Map<String, Object> map) {
		
		int boardCurSq = 0;
		BoardVo boardVo = (BoardVo) map.get("boardVo");
		if ( boardVo.getBoard_p_sq() == 0) {
			boardCurSq = boardRepository.insertBoard((BoardVo)map.get("boardVo"));
		} else {
			boardCurSq = boardRepository.insertBoardChild((BoardVo)map.get("boardVo"));
		}
		List<AtchFileVo> atchFileList = (List<AtchFileVo>) map.get("atchFileList");
		
		if(atchFileList == null) return boardCurSq;
		
		int insertCnt = 0;
		
		for(AtchFileVo atchfileVo : atchFileList) {
			atchfileVo.setBoard_sq(boardCurSq);
			insertCnt += boardRepository.insertAtchFile(atchfileVo);
		}
		
		return boardCurSq;
	}

	@Override
	public AtchFileVo getAtchFile(int atch_sq) {
		return boardRepository.getAtchFile(atch_sq);
	}

	@Override
	public int deleteAtchFile(int atch_sq) {
		return boardRepository.deleteAtchFile(atch_sq);
	}

	@Override
	public int updateBoard(Map<String, Object> map) {
		
		BoardVo boardVo = (BoardVo) map.get("boardVo");
		
		int updateCnt = boardRepository.updateBoard(boardVo);
		
		List<String> deleteAtchSq = (List<String>) map.get("deleteAtchSq");
		
		if(deleteAtchSq != null) {
			for(String atch_sq : deleteAtchSq) {
				boardRepository.deleteAtchFile(Integer.parseInt(atch_sq));
			}
		}
		
		List<AtchFileVo> atchFileList = (List<AtchFileVo>) map.get("atchFileList");
		
		int insertCnt = 0;
		for(AtchFileVo atchfileVo : atchFileList) {
			atchfileVo.setBoard_sq(boardVo.getBoard_sq());
			insertCnt += boardRepository.insertAtchFile(atchfileVo);
		}
		
		return boardVo.getBoard_sq();
	}

}
