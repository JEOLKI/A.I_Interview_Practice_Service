package com.aiinterview.member.dao;

import static org.junit.Assert.*;

import java.util.List;

import javax.annotation.Resource;

import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.aiinterview.ModelTestConfig;
import com.aiinterview.member.vo.MemberVO;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

public class MemberMapperTest extends ModelTestConfig{
	private static final Logger logger = LoggerFactory.getLogger(MemberMapperTest.class);
	
	@Resource(name="memberMapper")
	private MemberMapper memberMapper;
	
	@Test
	public void retrieveTest()throws Exception {
		/***Given***/
		

		/***When***/
		MemberVO memberVO = memberMapper.retrieve("TEST_ID");
		

		/***Then***/
		assertEquals("TEST_ID", memberVO.getMemId());
	}
	
	@Test
	public void retrieveIdTest() throws Exception{
		/***Given***/
		MemberVO memberVO = new MemberVO();
		memberVO.setMemNm("TEST_NAME");
		memberVO.setMemTel("010-1234-5678");

		/***When***/
		MemberVO findMemberVO = memberMapper.retrieveId(memberVO);

		/***Then***/
		assertEquals("TEST_ID", findMemberVO.getMemId());
	}
	
	@Test
	public void retirevePwTest() throws Exception {
		/***Given***/
		MemberVO memberVO = new MemberVO();
		memberVO.setMemId("TEST_ID");
		memberVO.setMemNm("TEST_NAME");
		memberVO.setMemTel("010-1234-5678");

		/***When***/
		MemberVO findMemberVO = memberMapper.retrievePw(memberVO);

		/***Then***/
		assertEquals("TEST_ID", findMemberVO.getMemId());
		
	}
	
	@Test
	public void retrieveUpdatePwTest() throws Exception {
		/***Given***/
		MemberVO memberVO = new MemberVO();
		memberVO.setMemId("TEST_ID");
		memberVO.setMemPw("NEW_PW");

		/***When***/
		int updateCount = memberMapper.updatePw(memberVO);

		/***Then***/
		assertEquals(1, updateCount);
	}
	
	@Test
	public void aliasCheckTest() throws Exception {
		/***Given***/
		

		/***When***/
		List<MemberVO> memberList = memberMapper.aliasCheck("TEST_ALIAS");
		
		/***Then***/
		assertEquals(1, memberList.size());
	}
	
	@Test
	public void createTest() throws Exception {
		/***Given***/
		MemberVO memberVO = new MemberVO();
		memberVO.setMemId("TEST2");
		memberVO.setMemPw("TEST2");
		memberVO.setMemAuth("Y");
		memberVO.setMemSt("Y");
		memberVO.setMemAlias("TEST2");
		memberVO.setMemNm("TEST2");
		memberVO.setMemTel("010-9765-4853");
		memberVO.setMemAddr1("대전광역시 중구");
		memberVO.setMemAddr2("대흥동 영민빌딩 4층");
		memberVO.setMemZipcode(12345);
		memberVO.setMemCareer("신입");
		memberVO.setMemEduc("대학교 졸업");
		memberVO.setMemGender("M");
		memberVO.setMemTargetCompany("정부기관");
		memberVO.setMemTargetJob("기획");
		memberVO.setSearchJobDate("2020년 상반기");
		memberVO.setMemMajor("인문");

		/***When***/
		int createCnt = memberMapper.create(memberVO);
		
		/***Then***/
		assertEquals(1, createCnt);
		
	}
	
	@Test
	public void deleteTest() throws Exception {
		/***Given***/
		

		/***When***/
		int deleteCnt = memberMapper.delete("MEMBER1");

		/***Then***/
		assertEquals(1, deleteCnt);
	}
	
	@Test
	public void updateTest() throws Exception{
		/***Given***/
		MemberVO memberVO = new MemberVO();
		memberVO.setMemId("MEMBER1");
		memberVO.setMemPw("UPDATE_PW");
		memberVO.setMemAlias("UPDATE_ALIAS");
		memberVO.setMemTel("010-1111-1111");
		memberVO.setMemAddr1("대전광역시 중구");
		memberVO.setMemAddr2("대흥동 영민빌딩 3층");
		memberVO.setMemZipcode(12345);
		memberVO.setMemCareer("경력");
		memberVO.setMemEduc("대학교 졸업");
		memberVO.setMemGender("M");
		memberVO.setMemTargetCompany("정부기관");
		memberVO.setMemTargetJob("기획");
		memberVO.setSearchJobDate("2020년 상반기");
		memberVO.setMemMajor("인문");
		memberVO.setMemProfileNm("");
		memberVO.setMemProfilePath("");

		/***When***/
		int updateCnt = memberMapper.update(memberVO);

		/***Then***/
		assertEquals(1, updateCnt);
	}
	
	@Test
	public void retrievePagingListCntTest() throws Exception {
		/***Given***/
		MemberVO memberVO = new MemberVO();

		/***When***/
		int result  = memberMapper.retrievePagingListCnt(memberVO);

		/***Then***/
		assertEquals(4, result);
	}
	
	@Test
	public void retirevePagingListTest() throws Exception {
		/***Given***/
		MemberVO memberVO = new MemberVO();
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(memberVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(memberVO.getPageUnit());
		paginationInfo.setPageSize(memberVO.getPageSize());
		memberVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		memberVO.setLastIndex(paginationInfo.getLastRecordIndex());
		memberVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		/***When***/
		List<MemberVO> memberList =  memberMapper.retrievePagingList(memberVO);

		/***Then***/
		assertEquals(4, memberList.size());
	}
	
	@Test
	public void manageMemberTest() throws Exception {
		/***Given***/
		

		/***When***/
		List<MemberVO> memberList = memberMapper.manageMember();
		
		/***Then***/
		assertEquals(4, memberList.size());
	}
	
	@Test
	public void retrieveMajorTest() throws Exception {
		/***Given***/
		MemberVO memberVO = new MemberVO();

		/***When***/
		List<MemberVO> memberList = memberMapper.retrieveMajor(memberVO);

		/***Then***/
		assertEquals(2, memberList.size());
	}
	
	@Test
	public void retrieveEducationTest() throws Exception {
		/***Given***/
		MemberVO memberVO = new MemberVO();
		
		/***When***/
		List<MemberVO> memberList = memberMapper.retrieveEducation(memberVO);
		
		/***Then***/
		assertEquals(4, memberList.size());
	}
	
	@Test
	public void retrieveSearchJobDateTest() throws Exception {
		/***Given***/
		MemberVO memberVO = new MemberVO();
		
		/***When***/
		List<MemberVO> memberList = memberMapper.retrieveSearchJobDate(memberVO);
		
		/***Then***/
		assertEquals(3, memberList.size());
	}
	
	@Test
	public void retrieveCareerTest() throws Exception {
		/***Given***/
		MemberVO memberVO = new MemberVO();
		
		/***When***/
		List<MemberVO> memberList = memberMapper.retrieveCareer(memberVO);
		
		/***Then***/
		assertEquals(2, memberList.size());
	}
	
	@Test
	public void retrieveGenderTest() throws Exception {
		/***Given***/
		MemberVO memberVO = new MemberVO();
		
		/***When***/
		List<MemberVO> memberList = memberMapper.retrieveGender(memberVO);
		
		/***Then***/
		assertEquals(1, memberList.size());
	}

}
