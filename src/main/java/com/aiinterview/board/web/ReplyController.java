package com.aiinterview.board.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.aiinterview.board.service.ReplyService;
import com.aiinterview.board.vo.ReplyVO;

@RequestMapping("/reply")
@Controller
public class ReplyController {
	
	@Resource(name="replyService")
	private ReplyService replyService;
	
	@RequestMapping(path = "/create.do", method = { RequestMethod.GET })
	public String create(ReplyVO replyVO) {
		replyVO.setReplySt("Y");
		try {
			replyService.create(replyVO);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:/board/retrieve.do?boardSq=" + replyVO.getBoardSq();	
	}
	
	@RequestMapping(path = "/delete.do", method = {RequestMethod.GET})
	public String deleteProcess(ReplyVO replyVO, HttpServletRequest request) {
		
		replyVO.setReplyContent("삭제된 댓글");
		replyVO.setReplySt("N");
		
		try {
			int deleteCnt = replyService.update(replyVO);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:/board/retrieve.do?boardSq=" + replyVO.getBoardSq();	
	}
	
	@RequestMapping(path = "/update.do", method = { RequestMethod.GET })
	public String update(ReplyVO replyVO) {

		replyVO.setReplySt("Y");
		
		try {
			int updateCnt = replyService.update(replyVO);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:/board/retrieve.do?boardSq=" + replyVO.getBoardSq();	
	}

}
