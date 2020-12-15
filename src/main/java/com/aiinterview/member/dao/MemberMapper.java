package com.aiinterview.member.dao;

import java.util.List;

import com.aiinterview.member.vo.MemberVO;
import com.aiinterview.plan.vo.PlanUseVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("memberMapper")
public interface MemberMapper{

	/**
	 * 아이디에 해당하는 회원을 반환하는 메서드
	 * @param memId
	 * @return MemberVO
	 * @throws Exception 
	 */
	MemberVO retrieve(String memId) throws Exception;

	/**
	 * 회원 아이디를 찾는 메서드
	 * 
	 * @param memberVo
	 * @return MemberVO
	 */
	MemberVO retrieveId(MemberVO memberVo) throws Exception;
	/**
	 * 회원 비밀번호를 찾는 메서드
	 * 
	 * @param memberVo
	 * @return MemberVO
	 */
	MemberVO retrievePw(MemberVO memberVo) throws Exception;
	
	/**
	 * 회원 비밀번호를 변경하는 메서드
	 * 
	 * @param memberVo
	 * @return int
	 */
	
	int updatePw(MemberVO memberVo) throws Exception;
	
	/**
	 * 닉네임 중복을 체크하는 메서드
	 * 
	 * @param memberVo
	 * @return MemberVO
	 */
	List<MemberVO> aliasCheck(String memAlias) throws Exception;
	
	/**
	 * 회원 가입을하는 메서드
	 * 
	 * @param memberVo
	 * @return int
	 */
	int create(MemberVO memberVo) throws Exception;
	
	/**
	 * 회원 탈퇴하는 메서드
	 * 
	 * @param memId
	 * @return int
	 */
	int delete(String memId) throws Exception;
	
	/**
	 * 회원 정보 수정하는 메서드
	 * 
	 * @param memberVo
	 * @return int
	 */
	int update(MemberVO memberVo) throws Exception;
	
	/**
	 * 회원 페이징 리스트하는 메서드
	 * 
	 * @param planUseVO
	 * @return
	 */
	public List<MemberVO> retrievePagingList(MemberVO memberVO) throws Exception;
	
	
	/**
	 * 회원 페이징 리스트하기위한 카운트 메서드
	 * 
	 * @param memberVO
	 * @return
	 */
	public int retrievePagingListCnt(MemberVO memberVO) throws Exception;
	
	/**
	 * 회원 목록을 엑셀로 출력하기 위한 메서드
	 * 
	 * @return
	 */
	public List<MemberVO> manageMember() throws Exception;

}