package com.aiinterview.board.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.aiinterview.board.model.ReplyVo;
import com.aiinterview.board.service.ReplyServiceI;

@RequestMapping("/reply")
@Controller
public class ReplyController {

	@Resource(name = "replyService")
	private ReplyServiceI replyService;
	
	@RequestMapping(path = "/delete", method = {RequestMethod.GET})
	public String deleteProcess(int reply_sq, int board_sq, HttpServletRequest request) {
		int deleteCnt = replyService.deleteReply(reply_sq);
		if ( deleteCnt == 1 ) {
			return "redirect:/board/detail?board_sq=" + board_sq;
		} else {
			return "main";
		}
	}
	
	@RequestMapping(path = "/regist", method = {RequestMethod.GET})
	public String registProcess(ReplyVo replyVo) {
		int insertCnt = replyService.insertReply(replyVo);
		
		if ( insertCnt == 1 ) {
			return "redirect:/board/detail?board_sq=" + replyVo.getBoard_sq();
		} else {
			return "main";
		}
	}
	
	
}
