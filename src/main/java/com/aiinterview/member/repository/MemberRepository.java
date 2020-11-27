package com.aiinterview.member.repository;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.aiinterview.model.MemberVo;

@Repository("memberRepository")
public class MemberRepository implements MemberRepositoryI {

	@Resource(name = "sqlSessionTemplate")
	private SqlSessionTemplate sqlSession;

	@Override
	public MemberVo getMember(String userId) {
		return sqlSession.selectOne("member.getMember", userId);
	}

}
