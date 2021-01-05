package com.aiinterview.member.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.aiinterview.member.dao.MemberMapper;
import com.aiinterview.member.vo.MemberVO;
import com.aiinterview.plan.vo.PlanUseVO;

@Service("memberService")
public class MemberService implements MemberMapper {

	@Resource(name = "memberMapper")
	private MemberMapper memberMapper;

	public MemberService() {
		// new 연산자가 아닌 빈을 주입하는 형태로 사용하기 위해서 지운다
		// new MemberRepository();
	}

	@Override
	public MemberVO retrieve(String memId) throws Exception {
		return memberMapper.retrieve(memId);
	}

	@Override
	public MemberVO retrieveId(MemberVO memberVo) throws Exception {
		return memberMapper.retrieveId(memberVo);
	}

	@Override
	public MemberVO retrievePw(MemberVO memberVo) throws Exception {
		return memberMapper.retrievePw(memberVo);
	}

	@Override
	public int updatePw(MemberVO memberVo) throws Exception {
		return memberMapper.updatePw(memberVo);
	}

	@Override
	public List<MemberVO> aliasCheck(String memAlias) throws Exception {
		return memberMapper.aliasCheck(memAlias);
	}

	@Override
	public int create(MemberVO memberVo) throws Exception {
		return memberMapper.create(memberVo);
	}

	@Override
	public int delete(String memId)  throws Exception{
		return memberMapper.delete(memId);
	}

	@Override
	public int update(MemberVO memberVo) throws Exception {
		return memberMapper.update(memberVo);
	}
	
	@Override
	public List<MemberVO> retrievePagingList(MemberVO memberVO) throws Exception {
		return memberMapper.retrievePagingList(memberVO);
	}
	
	@Override
	public int retrievePagingListCnt(MemberVO memberVO) throws Exception {
		return memberMapper.retrievePagingListCnt(memberVO);
	}

	@Override
	public List<MemberVO> manageMember() throws Exception {
		return memberMapper.manageMember();
	}

	@Override
	public List<MemberVO> retrieveMajor(MemberVO memberVO) throws Exception {
		return memberMapper.retrieveMajor(memberVO);
	}

	@Override
	public List<MemberVO> retrieveEducation(MemberVO memberVO) throws Exception {
		return memberMapper.retrieveEducation(memberVO);
	}

	@Override
	public List<MemberVO> retrieveSearchJobDate(MemberVO memberVO) throws Exception {
		return memberMapper.retrieveSearchJobDate(memberVO);
	}

	@Override
	public List<MemberVO> retrieveCareer(MemberVO memberVO) throws Exception {
		return memberMapper.retrieveCareer(memberVO);
	}

	@Override
	public List<MemberVO> retrieveGender(MemberVO memberVO) throws Exception {
		return memberMapper.retrieveGender(memberVO);
	}

}
