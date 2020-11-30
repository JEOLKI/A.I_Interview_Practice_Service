package com.aiinterview.member.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.aiinterview.member.service.MemberService;
import com.aiinterview.member.vo.MemberVO;

@RequestMapping("/login")
@Controller
public class LoginController {
	private static final Logger logger = LoggerFactory.getLogger(LoginController.class);
	
	@Resource(name = "memberService") 
	private MemberService memberService;

	@RequestMapping(value = "/main.do", method = { RequestMethod.GET })
	public String view() {
		return "login/main";
	}
	

	@RequestMapping(value = "/process.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String login(String memId, String memPw, HttpSession session, Model model) {
		MemberVO memberVo = memberService.getMember(memId);
		
		if (memberVo == null || !memberVo.getMemPw().equals(memPw)) {
			model.addAttribute("memId", memId);
			return "login/view";
		} else if (memberVo.getMemPw().equals(memPw)) {
			session.setAttribute("S_MEMBER", memberVo);
			return "main/main";
		}
		return "login/main";
	}

	@RequestMapping(path = "/view.do")
	public String login() {
		return "main/main";
	}
	
	@RequestMapping(value = "/join.do", method = { RequestMethod.GET })
	public String main(MemberVO memberVo, Model model) {
		return "main/join";
	}
	
	@RequestMapping(value = "/experience.do", method = { RequestMethod.GET })
	public String experience() {
		return "main/experience";
	}


}
