package com.aiinterview.member.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/member")
@Controller
public class MemberController {

	
	@RequestMapping(path = "/main")
	public String main() {
		return "member/membermain";
	}
	
	@RequestMapping(path = "/interviewresult")
	public String interviewresult() {
		return "member/interviewresult";
	}
	
	@RequestMapping(path = "/question")
	public String Question() {
		return "member/memberQuestion";
	}

	
	
}
