package com.aiinterview.interview.web;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@RequestMapping("/interview")
@Controller
public class InterviewController {
	private static final Logger logger = LoggerFactory.getLogger(InterviewController.class);
	
	@RequestMapping(path="/start.do",method = { RequestMethod.GET })
	public String interview() {
		logger.debug("InterviewController.interview()진입");
//		return "interview/interviewMain";
		return "member/memberQuestion";
	}
}
