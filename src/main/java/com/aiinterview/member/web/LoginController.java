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

	@RequestMapping(value = "/process.do", method = { RequestMethod.POST })
	public String login(String memId, String memPw, HttpSession session, Model model) {
		MemberVO memberVo = memberService.retrieve(memId);
		
		if (memberVo == null || !memberVo.getMemPw().equals(memPw)) {
			model.addAttribute("memId", memId);
			return "login/main";
		} else if (memberVo.getMemPw().equals(memPw)) {
			session.setAttribute("S_MEMBER", memberVo);
			return "redirect:/login/main.do";
		}
		return "redirect:/login/main.do";
	}

	@RequestMapping(value = "/manage.do", method = { RequestMethod.GET })
	public String managerView() {
		return "manage/main";
	}
	
	@RequestMapping(path = "/view.do")
	public String login() {
		return "main/main";
	}
	
	@RequestMapping(path = "/join.do", method = { RequestMethod.GET })
	public String main(MemberVO memberVo, Model model) {
		return "main/join";
	}
	
	@RequestMapping(path = "/experience.do", method = { RequestMethod.GET })
	public String experience() {
		return "main/experience";
	}


}
