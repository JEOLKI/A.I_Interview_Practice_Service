package com.aiinterview.member.repository;

import com.aiinterview.member.model.MemberVo;

public interface MemberRepositoryI {
	
	MemberVo getMember(String memId);
	
	/**
	 * 회원 아이디를 찾는 메서드
	 * @param memberVo
	 * @return MemberVo
	 */
	MemberVo memberIdSearch(MemberVo memberVo);
	
	
}
