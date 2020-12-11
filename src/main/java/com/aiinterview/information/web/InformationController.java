package com.aiinterview.information.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/info")
@Controller
public class InformationController {
	
	@RequestMapping("/serviceIntro.do")
	public String serviceIntroView() {
		return "information/serviceIntro";
	}
	
}