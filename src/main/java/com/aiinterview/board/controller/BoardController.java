package com.aiinterview.board.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;


@RequestMapping("/board")
@Controller
public class BoardController {

	@RequestMapping("/main")
	public String boardMain() {
		return "board/listBoard";
	}
	
}
