package com.aiinterview.common.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.aiinterview.interview.service.InterviewService;
import com.aiinterview.interview.vo.InterviewVO;
import com.aiinterview.member.vo.MemberVO;
import com.aiinterview.plan.service.PlanService;


public class InterviewCheckInterceptor extends HandlerInterceptorAdapter{
	
	@Resource(name = "interviewService")
	private InterviewService interviewService;
	
	@Resource(name = "planService")
	private PlanService planService;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {

		HttpSession session =  request.getSession();
		MemberVO memberVO = (MemberVO) session.getAttribute("S_MEMBER");
		
		InterviewVO interviewVO = new InterviewVO();
		interviewVO.setMemId(memberVO.getMemId());
		
		int count = interviewService.retrievePagingListCnt(interviewVO);
		
		int remainCount = planService.retrieveEndDate(memberVO.getMemId());
		
		if(count >= 1) {
			
			if(remainCount == 0) {
				
				response.sendRedirect("/plan/planList.do");
				return false;
				
			}else {	
				
				return true;
			
			}
			
		}
		
		return true;
	}
	
}
