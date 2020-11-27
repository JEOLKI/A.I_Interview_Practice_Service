package com.aiinterview.member.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.aiinterview.member.service.MemberServiceI;
import com.aiinterview.model.MemberVo;

@RequestMapping("/login")
@Controller
public class LoginController {
	
	@Resource(name = "memberService") 
	private MemberServiceI memberService;

	@RequestMapping(value = "/view", method = { RequestMethod.GET })
	public String view() {
		return "login/view";
	}

	@RequestMapping(value = "/process", method = { RequestMethod.GET, RequestMethod.POST })
	public String login(String userid, String pass, HttpSession session, Model model) {

		MemberVo memberVo = memberService.getMember(userid);

		if (memberVo == null || !memberVo.getPass().equals(pass)) {
			model.addAttribute("userid", userid);
			return "login/view";
		} else if (memberVo.getPass().equals(pass)) {
			session.setAttribute("S_MEMBER", memberVo);
			return "member/memberList";
		}
		return "login/view";
	}

	@RequestMapping(path = "/main")
	public String main() {
		return "member/memberList";
	}
	
	@RequestMapping(value = "/test", method = { RequestMethod.GET })
	public String mainTest() {
		System.out.println("테스트");
		return "main/main";
	}


}
