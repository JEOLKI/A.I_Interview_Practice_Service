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
	
	@RequestMapping(path="/ready.do",method = { RequestMethod.GET })
	public String interviewReady() {
		logger.debug("InterviewController.interviewReady()진입");
		return "interview/ready";
	}
	
	@RequestMapping(path="/start.do",method = { RequestMethod.GET })
	public String interviewStart() {
		logger.debug("InterviewController.interviewStart()진입");
		return "interview/interview";
	}
	
	@RequestMapping(path="/test.do",method = { RequestMethod.GET })
	public String interviewTest() {
		logger.debug("InterviewController.interviewTest()진입");
		return "interview/interviewMain";
	}
	
}
