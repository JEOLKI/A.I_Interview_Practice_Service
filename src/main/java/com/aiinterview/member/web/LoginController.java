package com.aiinterview.member.web;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.aiinterview.board.service.BoardService;
import com.aiinterview.board.vo.BoardVO;
import com.aiinterview.interview.service.InterviewService;
import com.aiinterview.interview.vo.InterviewVO;
import com.aiinterview.member.service.MemberService;
import com.aiinterview.member.vo.MemberVO;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@RequestMapping("/login")
@Controller
public class LoginController {
	private static final Logger logger = LoggerFactory.getLogger(LoginController.class);
	
	@Resource(name = "memberService") 
	private MemberService memberService;
	
	@Resource(name = "interviewService")
	private InterviewService interviewService;
	
	@Resource(name = "boardService")
	private BoardService boardService;
	
	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	@RequestMapping(value = "/main.do", method = { RequestMethod.GET })
	public String view(Model model) {
		
		try {
			List<InterviewVO> interviewList = interviewService.retrieveStatistics();
			
			int interviewCount = 0;
			for (InterviewVO interviewVO : interviewList) {
				interviewCount += Integer.parseInt(interviewVO.getCount());
			}
			
			model.addAttribute("interviewCount", interviewCount);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "login/main";
	}
	
	@RequestMapping(value = "/home.do", method = { RequestMethod.GET })
	public String home() {
		return "login/home";
	}
	
	@RequestMapping(value = "/logout.do", method = { RequestMethod.GET })
	public String logout(HttpSession session) {
		session.removeAttribute("S_MEMBER");
		return "login/main";
	}

	@RequestMapping(value = "/process.do", method = { RequestMethod.POST })
	public String login(String memId, String memPw, HttpSession session, Model model) throws Exception {
		MemberVO memberVo = memberService.retrieve(memId);
		
		InterviewVO interviewVO = new InterviewVO();
		/** EgovPropertyService.sample */
		interviewVO.setPageUnit(propertiesService.getInt("pageUnit"));
		interviewVO.setPageSize(propertiesService.getInt("pageSize"));
		interviewVO.setMemId(memId);
		
		/** pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(interviewVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(interviewVO.getPageUnit());
		paginationInfo.setPageSize(interviewVO.getPageSize());

		interviewVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		interviewVO.setLastIndex(paginationInfo.getLastRecordIndex());
		interviewVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		if (memberVo == null || !memberVo.getMemPw().equals(memPw)) {
			model.addAttribute("memId", memId);
			return "redirect:/login/main.do";
		} else if (memberVo.getMemPw().equals(memPw)&&"Y".equals(memberVo.getMemSt())) {
			session.setAttribute("S_MEMBER", memberVo);
			if(interviewService.retrievePagingList(interviewVO).size()==0){
				// 면접 결과가 없을 경우
				logger.debug("면접결과 없을경우 {}",interviewService.retrievePagingList(interviewVO).size());
				return "redirect:/login/home.do";
			}else {
				// 면접 결과가 있을 경우
				logger.debug("면접결과 있을경우 {}",interviewService.retrievePagingList(interviewVO).size());
				return "redirect:/analysis/interview/retrievePagingList.do";
			}
		}
		return "redirect:/login/main.do";
	}

	@RequestMapping(value = "/manage.do", method = { RequestMethod.GET })
	public String managerView() {
		return "manage/main";
	}
	
	@RequestMapping(value = "/manageStatistic.do", method = { RequestMethod.GET })
	public String manageStatistic(Model model) {
		
		List<BoardVO> boardList;
		try {
			boardList = boardService.retrieveAllList();
			model.addAttribute("boardList", boardList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		List<MemberVO>memberList = null;
		try {
			memberList = memberService.manageMember();
		} catch (Exception e) {
			e.printStackTrace();
		}
		model.addAttribute("memberListSize",memberList.size());
		
		return "manage/manageStatistic";
	}
	
	
	@RequestMapping(path = "/join.do", method = { RequestMethod.GET })
	public String main(MemberVO memberVo, Model model) {
		return "login/join";
	}
	
	@RequestMapping(path = "/help.do", method = { RequestMethod.GET })
	public String help() {
		return "login/help";
	}
	
	@RequestMapping("/serviceIntro.do")
	public String serviceIntro() {
		return "login/serviceIntro";
	}
	
	@RequestMapping("/userAgree.do")
	public String userAgree() {
		return "agreement/userAgree";
	}
	@RequestMapping("/personalAgree.do")
	public String personalAgree() {
		return "agreement/personalAgree";
	}
	

}
