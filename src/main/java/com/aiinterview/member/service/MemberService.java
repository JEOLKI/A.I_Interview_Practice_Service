package com.aiinterview.member.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.aiinterview.member.dao.MemberMapper;
import com.aiinterview.member.vo.MemberVO;

@Transactional
@Service("memberService")
public class MemberService implements MemberMapper {

	@Resource(name = "memberMapper")
	private MemberMapper memberMapper;

	public MemberService() {
		// new 연산자가 아닌 빈을 주입하는 형태로 사용하기 위해서 지운다
		// new MemberRepository();
	}

	public MemberVO getMember(String memId) {
		return memberMapper.getMember(memId);
	}

	public MemberVO memberIdSearch(MemberVO memberVo) {
		return memberMapper.memberIdSearch(memberVo);
	}

	public MemberVO memberPwSearch(MemberVO memberVo) {
		return memberMapper.memberPwSearch(memberVo);
	}

	@Override
	public int memberPwChange(MemberVO memberVo) {
		return memberMapper.memberPwChange(memberVo);
	}

	@Override
	public MemberVO aliasCheck(String memAlias) {
		return memberMapper.aliasCheck(memAlias);
	}

	@Override
	public int create(MemberVO memberVo) {
		return memberMapper.create(memberVo);
	}

	@Override
	public int delete(String memId) {
		return memberMapper.delete(memId);
	}

}
