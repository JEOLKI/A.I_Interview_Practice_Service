package com.aiinterview.common.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.aiinterview.member.vo.MemberVO;


public class ManageCheckInterceptor extends HandlerInterceptorAdapter{
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {

		// SESSION에 S_MEMBER 속성속에 관리자 권한이 있는지 check 해야한다.
		HttpSession session =  request.getSession();
		MemberVO memberVO = (MemberVO) session.getAttribute("S_MEMBER");
		
		// 로그인 페이지로 이동
		if(memberVO.getMemAuth().equals("N")) {
			response.sendRedirect("/login/main.do");
			return false;
		}
		
		return true;
	}
	
}
