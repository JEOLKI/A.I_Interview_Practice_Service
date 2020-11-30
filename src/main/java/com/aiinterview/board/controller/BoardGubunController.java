package com.aiinterview.board.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.aiinterview.board.model.BoardGubunVo;
import com.aiinterview.board.service.BoardGubunServiceI;

@RequestMapping("/boardGu")
@Controller
public class BoardGubunController {
	
	@Resource(name = "boardGubunService")
	private BoardGubunServiceI boardGubunService;
	
	@RequestMapping(path = "/list", method = {RequestMethod.GET})
	public String list(Model model) {
		model.addAttribute("boardGubunList",boardGubunService.getBoardGubunList());
		return "jsonView";
	}
	
	@RequestMapping(path = "/regist", method = {RequestMethod.GET})
	public String registView() {
		return "tiles/board/boardGubunRegister";
	}
	
	@RequestMapping(path = "/regist", method = {RequestMethod.POST})
	public String registProcess(BoardGubunVo boardGubunVo, HttpServletRequest request) {
		
		boardGubunVo.setGubun_yn(boardGubunVo.getGubun_yn().equals("사용")? "y" : "n" );
		
		int insertCnt = boardGubunService.insertBoardGubun(boardGubunVo);
		
		if ( insertCnt == 1 ) {
			return "redirect:"+request.getContextPath()+"/boardGu/regist";
		} else {
			return "redirect:main";
		}
	}
	
	@RequestMapping(path = "/update", method = {RequestMethod.POST})
	public String updateProcess(BoardGubunVo boardGubunVo, HttpServletRequest request) {
		
		boardGubunVo.setGubun_yn(boardGubunVo.getGubun_yn().equals("사용")? "y" : "n" );
		
		int updateCnt = boardGubunService.updateBoardGubun(boardGubunVo);
		
		if ( updateCnt == 1 ) {
			return "redirect:"+request.getContextPath()+"/boardGu/regist";
		} else {
			return "redirect:main";
		}
	}
	
}
