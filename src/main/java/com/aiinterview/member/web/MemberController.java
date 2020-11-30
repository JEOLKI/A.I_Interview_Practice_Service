package com.aiinterview.member.web;


import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.aiinterview.member.service.MemberService;
import com.aiinterview.member.vo.MemberVO;

@RequestMapping("/member")
@Controller
public class MemberController {
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);

	@Resource(name = "memberService")
	private MemberService memberService;

	@RequestMapping(path = "/main", method = { RequestMethod.GET })
	public String mainView() {
		return "member/membermain";
	}

	@RequestMapping(path = "/interviewresult", method = { RequestMethod.GET })
	public String interviewResultView() {
		return "member/interviewresult";
	}

	@RequestMapping(path = "/question", method = { RequestMethod.GET })
	public String questionView() {
		return "member/memberQuestion";
	}

	@RequestMapping(path = "/test", method = { RequestMethod.GET })
	public String testView() {
		logger.debug("MemberController.testView()진입");
		return "member/test";
	}

	@RequestMapping(path = "/idSearch.do", method = { RequestMethod.GET })
	public String idSearch(MemberVO memberVo, Model model) {
		System.out.println("MemberController.idSearch()진입");

		MemberVO searchMemberVo = memberService.memberIdSearch(memberVo);

		model.addAttribute("searchMemberVo", searchMemberVo);
		return "main/idSearch";
	}

	@RequestMapping(path = "/pwSearch.do", method = { RequestMethod.GET })
	public String pwSearch(MemberVO memberVo, Model model) {
		System.out.println("MemberController.pwSearch()진입");

		MemberVO searchMemberVo = memberService.memberPwSearch(memberVo);
		System.out.println(searchMemberVo);
		
		model.addAttribute("searchMemberVo", searchMemberVo);
		return "main/pwSearch";
	}

}