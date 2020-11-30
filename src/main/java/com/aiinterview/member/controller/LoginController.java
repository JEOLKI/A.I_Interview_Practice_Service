package com.aiinterview.member.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.aiinterview.member.model.MemberVo;
import com.aiinterview.member.service.MemberServiceI;

@RequestMapping("/login")
@Controller
public class LoginController {
	
	@Resource(name = "memberService") 
	private MemberServiceI memberService;

	@RequestMapping(value = "/main", method = { RequestMethod.GET })
	public String view() {
		return "login/main";
	}
	

	@RequestMapping(value = "/process", method = { RequestMethod.GET, RequestMethod.POST })
	public String login(String memId, String memPw, HttpSession session, Model model) {

		MemberVo memberVo = memberService.getMember(memId);

		if (memberVo == null || !memberVo.getMemPw().equals(memPw)) {
			model.addAttribute("userid", memId);
			return "login/view";
		} else if (memberVo.getMemPw().equals(memPw)) {
			session.setAttribute("S_MEMBER", memberVo);
			return "member/memberList";
		}
		return "login/view";
	}

	@RequestMapping(path = "/view")
	public String login() {
		return "main/main";
	}
	
	@RequestMapping(value = "/join", method = { RequestMethod.GET })
	public String main() {
		return "main/join";
	}
	
	@RequestMapping(value = "/experience", method = { RequestMethod.GET })
	public String experience() {
		return "main/experience";
	}


}
