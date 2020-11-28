package com.aiinterview.member.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@RequestMapping("/member")
@Controller
public class MemberController {

	
	@RequestMapping(path = "/main", method = {RequestMethod.GET})
	public String mainView() {
		return "member/membermain";
	}
	
	@RequestMapping(path = "/interviewresult", method =  {RequestMethod.GET})
	public String interviewResultView() {
		return "member/interviewresult";
	}
	
	@RequestMapping(path = "/question", method = {RequestMethod.GET})
	public String questionView() {
		return "member/memberQuestion";
	}

	
	
}
