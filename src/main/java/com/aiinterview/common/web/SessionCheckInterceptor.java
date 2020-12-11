package com.aiinterview.common.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.aiinterview.member.vo.MemberVO;


public class SessionCheckInterceptor extends HandlerInterceptorAdapter{
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {

		// 사용자가 정상적으로 접속 했는지 체크
		// SESSION에 S_MEMBER 속성이 존재해야함
		HttpSession session =  request.getSession();
		MemberVO memberVO = (MemberVO) session.getAttribute("S_MEMBER");
		
		// 로그인 페이지로 이동
		if(memberVO==null) {
			response.sendRedirect("/login/main.do");
			return false;
		}
		
		return true;
	}
	
}
