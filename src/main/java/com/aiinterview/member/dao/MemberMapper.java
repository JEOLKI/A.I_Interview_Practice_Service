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
	MemberVO retrieve(String memId);

	/**
	 * 회원 아이디를 찾는 메서드
	 * 
	 * @param memberVo
	 * @return MemberVO
	 */
	MemberVO retrieveId(MemberVO memberVo);

	/**
	 * 회원 비밀번호를 찾는 메서드
	 * 
	 * @param memberVo
	 * @return MemberVO
	 */
	MemberVO retrievePw(MemberVO memberVo);
	
	/**
	 * 회원 비밀번호를 변경하는 메서드
	 * 
	 * @param memberVo
	 * @return int
	 */
	
	int updatePw(MemberVO memberVo);
	
	/**
	 * 닉네임 중복을 체크하는 메서드
	 * 
	 * @param memberVo
	 * @return MemberVO
	 */
	MemberVO aliasCheck(String memAlias);
	
	/**
	 * 회원 가입을하는 메서드
	 * 
	 * @param memberVo
	 * @return int
	 */
	int create(MemberVO memberVo);
	
	/**
	 * 회원 탈퇴하는 메서드
	 * 
	 * @param memId
	 * @return int
	 */
	int delete(String memId);

}