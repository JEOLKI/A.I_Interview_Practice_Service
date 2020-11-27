package com.aiinterview.member.service;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.aiinterview.member.repository.MemberRepositoryI;
import com.aiinterview.model.MemberVo;

@Transactional
@Service("memberService")
public class MemberService implements MemberServiceI {

	private static final Logger logger = LoggerFactory.getLogger(MemberService.class);
	
	@Resource(name = "memberRepository")
	private MemberRepositoryI memberRepository;
	
	public MemberService() {
		// new 연산자가 아닌 빈을 주입하는 형태로 사용하기 위해서 지운다
		// new MemberRepository();
	}

	@Override
	public MemberVo getMember(String userId) {
		return memberRepository.getMember(userId);
	}



}
