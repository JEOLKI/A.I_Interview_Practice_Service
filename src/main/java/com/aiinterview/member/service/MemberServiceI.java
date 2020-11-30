package com.aiinterview.member.service;

import com.aiinterview.member.model.MemberVo;

public interface MemberServiceI {

	MemberVo getMember(String userId);
	
	/**
	 * 회원 아이디를 찾는 메서드
	 * @param memberVo
	 * @return MemberVo
	 */
	MemberVo memberIdSearch(MemberVo memberVo);

	
}
