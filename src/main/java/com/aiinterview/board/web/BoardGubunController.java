package com.aiinterview.board.web;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.aiinterview.board.service.BoardGubunService;

@RequestMapping("/boardGubun")
@Controller
public class BoardGubunController {
	
	@Resource(name="boardGubunService")
	private BoardGubunService boardGubunService;
	
	@RequestMapping("/board.do")
	public String view() {
		return "board/boardList";
	}
	
	@RequestMapping(path ="/list.do")
	public String retrieveList(Model model) throws Exception {
		model.addAttribute("boardGubunList", boardGubunService.retrieveList());
		System.out.println("ss");
		return "jsonView";
	}
	
}
