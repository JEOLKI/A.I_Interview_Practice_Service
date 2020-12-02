package com.aiinterview.member.web;


import java.io.File;
import java.io.IOException;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.aiinterview.member.service.MemberService;
import com.aiinterview.member.vo.MemberVO;

@RequestMapping("/member")
@Controller
public class MemberController {
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);

	@Resource(name = "memberService")
	private MemberService memberService;

	@RequestMapping(path = "/test.do", method = { RequestMethod.GET })
	public String testView() {
		logger.debug("MemberController.testView()진입");
		return "member/test";
	}

	@RequestMapping(path = "/retrieveid.do", method = { RequestMethod.GET })
	public String retrieveId(MemberVO memberVo, Model model) {
		MemberVO searchMemberVo = memberService.retrieveId(memberVo);
		model.addAttribute("searchMemberVo", searchMemberVo);
		return "main/idSearch";
	}

	@RequestMapping(path = "/retrievepw.do", method = { RequestMethod.GET })
	public String retrievePw(MemberVO memberVo, Model model) {
		MemberVO searchMemberVo = memberService.retrievePw(memberVo);
		model.addAttribute("searchMemberVo", searchMemberVo);
		return "main/pwSearch";
	}
	
	@RequestMapping(path = "/updatepw.do", method = { RequestMethod.GET })
	public String updatePw(MemberVO memberVo, Model model) {
		memberService.updatePw(memberVo);
		return "main/pwSearch";
	}
	
	@RequestMapping(path = "/idCheck.do", method = { RequestMethod.POST })
	public String idCheck(String memId, Model model) {
		MemberVO memberVo = memberService.retrieve(memId);
		model.addAttribute("memberVo",memberVo);
		
		return "main/check";
	}
	
	@RequestMapping(path = "/aliasCheck.do", method = { RequestMethod.POST })
	public String aliasCheck(String memAlias, Model model) {
		MemberVO memberVo = memberService.aliasCheck(memAlias);
		model.addAttribute("memberVo",memberVo);
		
		return "main/check";
	}
	
	@RequestMapping(path = "/create.do", method = { RequestMethod.POST })
	public String create(MemberVO memberVo, Model model,RedirectAttributes ra) {
		memberVo.setMemAuth("Y");
		memberVo.setMemSt("Y");
		System.out.println(memberVo);
		
		int insertCnt = memberService.create(memberVo);
		System.out.println(insertCnt);
		
		model.addAttribute("memberVo",memberVo);
		
		if(insertCnt == 1) {
			return "redirect:/login/main.do";
		}else {
			return "redirect:/login/join.do";
		}
	}
	
	@RequestMapping(path="/myprofileview.do", method= {RequestMethod.GET})
	public String myProfileView() {
		return "myProfile/myProfile";
	}
	
	@RequestMapping(path="/deleteview.do", method= {RequestMethod.GET})
	public String deleteView() {
		return "myProfile/myProfileDelete";
	}
	
	@RequestMapping(path="/deleteprocess.do", method= {RequestMethod.GET})
	public String deleteProcess(String memId, HttpSession session) {
		int deleteCnt = memberService.delete(memId);
		if(deleteCnt == 1) {
			session.removeAttribute("S_MEMBER");
			return "redirect:/login/main.do";
		}else {
			return "redirect:/member/myprofileview.do";
		}
	}
	
	@RequestMapping(path = "/profile.do", method = { RequestMethod.GET })
	public String profile(String memId,Model model) {
		MemberVO memberVo = memberService.retrieve(memId);
		model.addAttribute("memProfilePath", memberVo.getMemProfilePath());
		return "ProfileImgView";
	}
	
	@RequestMapping(path = "/updateview.do", method = { RequestMethod.GET })
	public String updateView(String memId,Model model) {
		return "myProfile/myProfileUpdate";
	}
	
	@RequestMapping(path = "/update.do", method = { RequestMethod.POST })
	public String update(MemberVO memberVo, Model model, HttpSession session,
			@RequestParam(name="profile",required = false) MultipartFile profile) {
		
		if(profile.getSize() > 0) {
			// 확장자 추출
			int index = profile.getOriginalFilename().lastIndexOf(".");
			String extension = profile.getOriginalFilename().substring(index + 1); 
			
			// 프로필파일 vo 등록
			memberVo.setMemProfileNm(profile.getOriginalFilename());
			String uploadFileName = UUID.randomUUID().toString() + "." + extension;
			memberVo.setMemProfilePath("d:\\final\\" +uploadFileName);
			
			// 파일 업로드
			File uploadFile = new File("d:\\final\\" + uploadFileName);
			try {
				profile.transferTo(uploadFile); // 업로드하는 메서드
			} catch (IllegalStateException | IOException e) {
				e.printStackTrace();
			}
			
			// 회원등록
			int updateCnt = memberService.update(memberVo);
			
			if(updateCnt == 1) {
				session.setAttribute("S_MEMBER", memberService.retrieve(memberVo.getMemId()));
				return "redirect:/member/myprofileview.do";
			}else {
				return "myProfile/myProfileUpdate";
			}
		}else {
			int updateCnt = memberService.update(memberVo);
			
			if(updateCnt == 1) {
				session.setAttribute("S_MEMBER", memberService.retrieve(memberVo.getMemId()));
				return "redirect:/member/myprofileview.do";
			}else {
				return "myProfile/myProfileUpdate";
			}
		}
		
	}

}