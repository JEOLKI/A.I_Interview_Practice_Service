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

	@Override
	public MemberVO retrieve(String memId) {
		return memberMapper.retrieve(memId);
	}

	@Override
	public MemberVO retrieveId(MemberVO memberVo) {
		return memberMapper.retrieveId(memberVo);
	}

	@Override
	public MemberVO retrievePw(MemberVO memberVo) {
		return memberMapper.retrievePw(memberVo);
	}

	@Override
	public int updatePw(MemberVO memberVo) {
		return memberMapper.updatePw(memberVo);
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

	@Override
	public int update(MemberVO memberVo) {
		return memberMapper.update(memberVo);
	}

}
