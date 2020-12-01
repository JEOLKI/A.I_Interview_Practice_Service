package com.aiinterview.member.web;


import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
	
	@RequestMapping(path = "/pwChange.do", method = { RequestMethod.GET })
	public String pwChange(MemberVO memberVo, Model model) {
		System.out.println("MemberController.pwChange()진입");
		
		System.out.println(memberVo);
		
		int updateCnt = memberService.memberPwChange(memberVo);
		
		return "main/pwSearch";
	}
	
	@RequestMapping(path = "/idCheck.do", method = { RequestMethod.POST })
	public String idCheck(String memId, Model model) {
		System.out.println("MemberController.idCheck()진입");
		
		MemberVO memberVo = memberService.getMember(memId);
		model.addAttribute("memberVo",memberVo);
		
		return "main/check";
	}
	
	@RequestMapping(path = "/aliasCheck.do", method = { RequestMethod.POST })
	public String aliasCheck(String memAlias, Model model) {
		System.out.println("MemberController.aliasCheck()진입");
		
		MemberVO memberVo = memberService.aliasCheck(memAlias);
		model.addAttribute("memberVo",memberVo);
		
		return "main/check";
	}
	
	@RequestMapping(path = "/create.do", method = { RequestMethod.POST })
	public String create(MemberVO memberVo, Model model,RedirectAttributes ra) {
		System.out.println("MemberController.create()진입");
		
		memberVo.setMemAuth("Y");
		memberVo.setMemSt("Y");
		System.out.println(memberVo);
		
		int insertCnt = memberService.create(memberVo);
		System.out.println(insertCnt);
		
		model.addAttribute("memberVo",memberVo);
		
		if(insertCnt == 1) {
			return "redirect:/login/main.do";
		}else {
			ra.addAttribute("msg","가입에 실패했습니다.");
			return "redirect:/login/join.do";
		}
	}
	
	@RequestMapping(path="/myprofileview.do", method= {RequestMethod.GET})
	public String myProfileView() {
		System.out.println("MemberController.myProfileView()진입");
		
		return "myProfile/myProfile";
	}
	
	@RequestMapping(path="/deleteview.do", method= {RequestMethod.GET})
	public String deleteView() {
		System.out.println("MemberController.deleteView()진입");
		
		return "myProfile/myProfileDelete";
	}
	
	@RequestMapping(path="/deleteprocess.do", method= {RequestMethod.GET})
	public String deleteProcess(String memId, HttpSession session) {
		System.out.println("MemberController.deleteProcess()진입");
		System.out.println(memId);
		
		int deleteCnt = memberService.delete(memId);
		if(deleteCnt == 1) {
			session.removeAttribute("S_MEMBER");
			return "redirect:/login/main.do";
		}else {
			return "redirect:/member/myprofileview.do";
		}
	}

}