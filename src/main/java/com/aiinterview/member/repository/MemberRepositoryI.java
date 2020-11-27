package com.aiinterview.member.repository;

import com.aiinterview.model.MemberVo;

public interface MemberRepositoryI {
	
	MemberVo getMember(String userId);
	
}
