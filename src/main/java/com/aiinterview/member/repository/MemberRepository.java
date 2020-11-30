package com.aiinterview.member.repository;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.aiinterview.member.model.MemberVo;

@Repository("memberRepository")
public class MemberRepository implements MemberRepositoryI {

	@Resource(name = "sqlSessionTemplate")
	private SqlSessionTemplate sqlSession;

	@Override
	public MemberVo getMember(String memId) {
		return sqlSession.selectOne("member.getMember", memId);
	}

	@Override
	public MemberVo memberIdSearch(MemberVo memberVo) {
		return sqlSession.selectOne("member.memberIdSearch", memberVo);
	}

}
