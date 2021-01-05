package com.aiinterview.member.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.aiinterview.member.dao.MemberMapper;
import com.aiinterview.member.vo.MemberVO;
import com.aiinterview.plan.vo.PlanUseVO;

@Service("memberService")
public class MemberService {

	@Resource(name = "memberMapper")
	private MemberMapper memberMapper;

	public MemberVO retrieve(String memId) throws Exception {
		return memberMapper.retrieve(memId);
	}

	public MemberVO retrieveId(MemberVO memberVo) throws Exception {
		return memberMapper.retrieveId(memberVo);
	}

	public MemberVO retrievePw(MemberVO memberVo) throws Exception {
		return memberMapper.retrievePw(memberVo);
	}

	public int updatePw(MemberVO memberVo) throws Exception {
		return memberMapper.updatePw(memberVo);
	}

	public List<MemberVO> aliasCheck(String memAlias) throws Exception {
		return memberMapper.aliasCheck(memAlias);
	}

	public int create(MemberVO memberVo) throws Exception {
		return memberMapper.create(memberVo);
	}

	public int delete(String memId)  throws Exception{
		return memberMapper.delete(memId);
	}

	public int update(MemberVO memberVo) throws Exception {
		return memberMapper.update(memberVo);
	}
	
	public List<MemberVO> retrievePagingList(MemberVO memberVO) throws Exception {
		return memberMapper.retrievePagingList(memberVO);
	}
	
	public int retrievePagingListCnt(MemberVO memberVO) throws Exception {
		return memberMapper.retrievePagingListCnt(memberVO);
	}

	public List<MemberVO> manageMember() throws Exception {
		return memberMapper.manageMember();
	}

	public List<MemberVO> retrieveMajor(MemberVO memberVO) throws Exception {
		return memberMapper.retrieveMajor(memberVO);
	}

	public List<MemberVO> retrieveEducation(MemberVO memberVO) throws Exception {
		return memberMapper.retrieveEducation(memberVO);
	}

	public List<MemberVO> retrieveSearchJobDate(MemberVO memberVO) throws Exception {
		return memberMapper.retrieveSearchJobDate(memberVO);
	}

	public List<MemberVO> retrieveCareer(MemberVO memberVO) throws Exception {
		return memberMapper.retrieveCareer(memberVO);
	}

	public List<MemberVO> retrieveGender(MemberVO memberVO) throws Exception {
		return memberMapper.retrieveGender(memberVO);
	}

}
