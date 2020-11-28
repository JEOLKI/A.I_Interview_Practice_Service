package com.aiinterview.interview.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/interview")
@Controller
public class InterviewController {

	@RequestMapping("/main")
	public String interviewMain() {
		return "interview/interviewMain";
	}
	
}
