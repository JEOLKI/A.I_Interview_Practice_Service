package com.aiinterview.member.web;


import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
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
import com.aiinterview.plan.service.PlanService;
import com.aiinterview.plan.vo.PlanUseVO;
import com.aiinterview.plan.vo.PlanVO;

@RequestMapping("/member")
@Controller
public class MemberController {
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);

	@Resource(name = "memberService")
	private MemberService memberService;
	
	@Resource(name = "planService")
	private PlanService planService;
	
	@RequestMapping(path = "/test.do", method = { RequestMethod.GET })
	public String testView() {
		logger.debug("MemberController.testView()진입");
		return "member/test";
	}

	@RequestMapping(path = "/retrieveid.do", method = { RequestMethod.GET })
	public String retrieveId(MemberVO memberVo, Model model){
		MemberVO searchMemberVo = null;
		try {
			searchMemberVo = memberService.retrieveId(memberVo);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		model.addAttribute("searchMemberVo", searchMemberVo);
		return "jsonView";
	}

	@RequestMapping(path = "/retrievepw.do", method = { RequestMethod.GET })
	public String retrievePw(MemberVO memberVo, Model model){
		MemberVO searchMemberVo = null;
		try {
			searchMemberVo = memberService.retrievePw(memberVo);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		model.addAttribute("searchMemberVo", searchMemberVo);
		return "jsonView";
	}
	
	@RequestMapping(path = "/updatepw.do", method = { RequestMethod.GET })
	public String updatePw(MemberVO memberVo, Model model){
		int updateCnt = 0;
		try {
			updateCnt = memberService.updatePw(memberVo);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		model.addAttribute("updateCnt", updateCnt);
		return "jsonView";
	}
	
	@RequestMapping(path = "/idCheck.do", method = { RequestMethod.POST })
	public String idCheck(String memId, Model model){
		MemberVO memberVo = null;
		try {
			memberVo = memberService.retrieve(memId);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		model.addAttribute("memberVo",memberVo);
		
		return "jsonView";
	}
	
	@RequestMapping(path = "/aliasCheck.do", method = { RequestMethod.POST })
	public String aliasCheck(String memAlias, Model model) {
		List<MemberVO>memberList =null;
		try {
			memberList = memberService.aliasCheck(memAlias);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		model.addAttribute("memberList",memberList);
		
		return "jsonView";
	}
	
	@RequestMapping(path = "/create.do", method = { RequestMethod.POST })
	public String create(MemberVO memberVo, Model model,RedirectAttributes ra){
		memberVo.setMemAuth("Y");
		memberVo.setMemSt("Y");
		System.out.println(memberVo);
		
		int insertCnt = 0;
		try {
			insertCnt = memberService.create(memberVo);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println(insertCnt);
		
		model.addAttribute("memberVo",memberVo);
		
		if(insertCnt == 1) {
			return "redirect:/login/main.do";
		}else {
			return "redirect:/login/join.do";
		}
	}
	
	@RequestMapping(path="/myprofileview.do", method= {RequestMethod.GET})
	public String myProfileView(HttpSession session, Model model) {
		 
		return "myProfile/myProfile";
	}
	
	
	@RequestMapping(path="/myPlanAjax.do", method= {RequestMethod.GET})
	public String myPlanAjax(HttpSession session, Model model) {
		MemberVO mv =  (MemberVO) session.getAttribute("S_MEMBER");
		String memId = mv.getMemId();
		PlanUseVO puv = new PlanUseVO();
		PlanVO pv = new PlanVO();
		puv.setMemId(memId);
		
		try {
			if (planService.planUseCount(puv) > 0) {
				PlanUseVO planUseCheck =  
						planService.planUseCheck(puv);
				
				pv.setPlanSq(planUseCheck.getPlanSq());
				PlanVO planUse = planService.planContent(pv);
				
				long calDate = planUseCheck.getEndDate().getTime() - planUseCheck.getStartDate().getTime();
				long calDateDays =calDate / (24*60*60*1000);
				planUseCheck.setTerm((int) (calDateDays = Math.abs(calDateDays))); 
				
				model.addAttribute("planUse", planUse);
				model.addAttribute("planUseCheck", planUseCheck);
				System.out.println(planUseCheck);
				System.out.println("오류 확인");
			}else {
				puv.setTerm(-1);
				
				System.out.println(puv);
				model.addAttribute("planUseCheck", puv);
				
			}
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "jsonView";
	}
	
	@RequestMapping(path="/deleteview.do", method= {RequestMethod.GET})
	public String deleteView() {
		return "myProfile/myProfileDelete";
	}
	
	@RequestMapping(path="/deleteprocess.do", method= {RequestMethod.GET})
	public String deleteProcess(String memId, HttpSession session){
		int deleteCnt = 0;
		try {
			deleteCnt = memberService.delete(memId);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		if(deleteCnt == 1) {
			session.removeAttribute("S_MEMBER");
			return "redirect:/login/main.do";
		}else {
			return "redirect:/member/myprofileview.do";
		}
	}
	
	@RequestMapping(path = "/profile.do", method = { RequestMethod.GET })
	public String profile(String memId,Model model){
		MemberVO memberVo = null;
		try {
			memberVo = memberService.retrieve(memId);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
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
			int updateCnt = 0;
			try {
				updateCnt = memberService.update(memberVo);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			if(updateCnt == 1) {
				try {
					session.setAttribute("S_MEMBER", memberService.retrieve(memberVo.getMemId()));
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				return "redirect:/member/myprofileview.do";
			}else {
				return "myProfile/myProfileUpdate";
			}
		}else {
			int updateCnt = 0;
			try {
				updateCnt = memberService.update(memberVo);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			if(updateCnt == 1) {
				try {
					session.setAttribute("S_MEMBER", memberService.retrieve(memberVo.getMemId()));
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				return "redirect:/member/myprofileview.do";
			}else {
				return "myProfile/myProfileUpdate";
			}
		}
		
	}
	
	@RequestMapping("/marketingAgree.do")
	public String marketingAgree() {
		return "agreement/marketingAgree";
	}

}