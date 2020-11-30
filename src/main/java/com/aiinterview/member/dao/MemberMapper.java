package com.aiinterview.member.dao;

import com.aiinterview.member.vo.MemberVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("memberMapper")
public interface MemberMapper{

	/**
	 * 아이디에 해당하는 회원을 반환하는 메서드
	 * @param memId
	 * @return MemberVO
	 */
	MemberVO getMember(String memId);

	/**
	 * 회원 아이디를 찾는 메서드
	 * 
	 * @param memberVo
	 * @return MemberVO
	 */
	MemberVO memberIdSearch(MemberVO memberVo);

	/**
	 * 회원 비밀번호를 찾는 메서드
	 * 
	 * @param memberVo
	 * @return
	 */
	MemberVO memberPwSearch(MemberVO memberVo);
	
	/**
	 * 회원 비밀번호를 변경하는 메서드
	 * 
	 * @param memberVo
	 * @return
	 */
	int memberPwChange(MemberVO memberVo);

}