package com.aiinterview.analysis.web;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.view;

import org.junit.Test;
import org.springframework.mock.web.MockHttpSession;

import com.aiinterview.WebTestConfig;
import com.aiinterview.member.vo.MemberVO;

public class AnalysisControllerTest extends WebTestConfig{

	@Test
	public void retrievePagingListTest() throws Exception {
		MemberVO memberVO = new MemberVO();
	    memberVO.setMemId("TEST_ID");
	    memberVO.setMemPw("TEST_PW");
	    memberVO.setMemNm("TEST_NAME");
	    memberVO.setMemAuth( "Y" );
	    memberVO.setMemSt( "Y" );
	    memberVO.setMemAlias( "TEST_ALIAS" );
	    memberVO.setMemTel("010-1234-5678");
	    memberVO.setMemAddr1("대전 중구 계룡로955번길 6");
	    memberVO.setMemAddr2("2층");
	    memberVO.setMemZipcode(34953);
	    memberVO.setMemCareer("경력");
	    memberVO.setMemEduc("대학교 졸업");
	    memberVO.setMemGender("F");
	    memberVO.setMemTargetCompany("카카오");
	    memberVO.setMemTargetJob("개발");
	    memberVO.setSearchJobDate("2020년 상반기");
	    memberVO.setMemMajor("공학");
	    
	    MockHttpSession session = new MockHttpSession();
	    session.setAttribute("S_MEMBER", memberVO);
		mockMvc.perform(post("/analysis/interview/retrievePagingList.do")
				.session(session))
		.andExpect(status().is(200))
		.andExpect(view().name("login/home"));
	}
	
	@Test
	public void retrievePagingListTwoTest() throws Exception {
		mockMvc.perform(post("/analysis/question/retrievePagingList.do"))
		.andExpect(status().is(200))
		.andExpect(view().name("analysis/myInterviewResult"));
	}
	
	@Test
	public void retrieveViewTest() throws Exception {
		mockMvc.perform(post("/analysis/answer/retrieve.do")
				.param("shareMemId", "MEMBER1")
				.param("quesetSq", "1"))
		.andExpect(status().is(200))
		.andExpect(view().name("analysis/analysisResult"));
	}
	
	@Test
	public void retrieveAnalysisTest() throws Exception {
		MemberVO memberVO = new MemberVO();
	    memberVO.setMemId("MEMBER1");
	    memberVO.setMemPw("TEST_PW");
	    memberVO.setMemNm("TEST_NAME");
	    memberVO.setMemAuth( "Y" );
	    memberVO.setMemSt( "Y" );
	    memberVO.setMemAlias( "TEST_ALIAS" );
	    memberVO.setMemTel("010-1234-5678");
	    memberVO.setMemAddr1("대전 중구 계룡로955번길 6");
	    memberVO.setMemAddr2("2층");
	    memberVO.setMemZipcode(34953);
	    memberVO.setMemCareer("경력");
	    memberVO.setMemEduc("대학교 졸업");
	    memberVO.setMemGender("F");
	    memberVO.setMemTargetCompany("카카오");
	    memberVO.setMemTargetJob("개발");
	    memberVO.setSearchJobDate("2020년 상반기");
	    memberVO.setMemMajor("공학");
	    
	    MockHttpSession session = new MockHttpSession();
	    session.setAttribute("S_MEMBER", memberVO);
		
		mockMvc.perform(post("/analysis/answer/retrieveAnalysis.do")
				.param("shareMemId", "MEMBER1")
				.param("profilePath", "/file/brown.png"))
		.andExpect(status().is(200))
		.andExpect(view().name("jsonView"));
	}

	@Test
	public void imageRetrieveGrowthTest() throws Exception {
		MemberVO memberVO = new MemberVO();
	    memberVO.setMemId("MEMBER1");
	    memberVO.setMemPw("TEST_PW");
	    memberVO.setMemNm("TEST_NAME");
	    memberVO.setMemAuth( "Y" );
	    memberVO.setMemSt( "Y" );
	    memberVO.setMemAlias( "TEST_ALIAS" );
	    memberVO.setMemTel("010-1234-5678");
	    memberVO.setMemAddr1("대전 중구 계룡로955번길 6");
	    memberVO.setMemAddr2("2층");
	    memberVO.setMemZipcode(34953);
	    memberVO.setMemCareer("경력");
	    memberVO.setMemEduc("대학교 졸업");
	    memberVO.setMemGender("F");
	    memberVO.setMemTargetCompany("카카오");
	    memberVO.setMemTargetJob("개발");
	    memberVO.setSearchJobDate("2020년 상반기");
	    memberVO.setMemMajor("공학");
	    
	    MockHttpSession session = new MockHttpSession();
	    session.setAttribute("S_MEMBER", memberVO);
		
		mockMvc.perform(post("/analysis/image/retrieveGrowth.do")
				.session(session))
		.andExpect(status().is(200))
		.andExpect(view().name("jsonView"));
	}
	
	@Test	
	public void speedRetrieveGrowthTest() throws Exception {
		MemberVO memberVO = new MemberVO();
		memberVO.setMemId("MEMBER1");
		memberVO.setMemPw("TEST_PW");
		memberVO.setMemNm("TEST_NAME");
		memberVO.setMemAuth( "Y" );
		memberVO.setMemSt( "Y" );
		memberVO.setMemAlias( "TEST_ALIAS" );
		memberVO.setMemTel("010-1234-5678");
		memberVO.setMemAddr1("대전 중구 계룡로955번길 6");
		memberVO.setMemAddr2("2층");
		memberVO.setMemZipcode(34953);
		memberVO.setMemCareer("경력");
		memberVO.setMemEduc("대학교 졸업");
		memberVO.setMemGender("F");
		memberVO.setMemTargetCompany("카카오");
		memberVO.setMemTargetJob("개발");
		memberVO.setSearchJobDate("2020년 상반기");
		memberVO.setMemMajor("공학");
		
		MockHttpSession session = new MockHttpSession();
		session.setAttribute("S_MEMBER", memberVO);
		
		mockMvc.perform(post("/analysis/speed/retrieveGrowth.do")
				.session(session))
		.andExpect(status().is(200))
		.andExpect(view().name("jsonView"));
	}
	
	@Test	
	public void habitRetrieveGrowthTest() throws Exception {
		MemberVO memberVO = new MemberVO();
		memberVO.setMemId("MEMBER1");
		memberVO.setMemPw("TEST_PW");
		memberVO.setMemNm("TEST_NAME");
		memberVO.setMemAuth( "Y" );
		memberVO.setMemSt( "Y" );
		memberVO.setMemAlias( "TEST_ALIAS" );
		memberVO.setMemTel("010-1234-5678");
		memberVO.setMemAddr1("대전 중구 계룡로955번길 6");
		memberVO.setMemAddr2("2층");
		memberVO.setMemZipcode(34953);
		memberVO.setMemCareer("경력");
		memberVO.setMemEduc("대학교 졸업");
		memberVO.setMemGender("F");
		memberVO.setMemTargetCompany("카카오");
		memberVO.setMemTargetJob("개발");
		memberVO.setSearchJobDate("2020년 상반기");
		memberVO.setMemMajor("공학");
		
		MockHttpSession session = new MockHttpSession();
		session.setAttribute("S_MEMBER", memberVO);
		
		mockMvc.perform(post("/analysis/habit/retrieveGrowth.do")
				.session(session))
		.andExpect(status().is(200))
		.andExpect(view().name("jsonView"));
	}
	
	@Test	
	public void voiceRetrieveGrowthTest() throws Exception {
		MemberVO memberVO = new MemberVO();
		memberVO.setMemId("MEMBER1");
		memberVO.setMemPw("TEST_PW");
		memberVO.setMemNm("TEST_NAME");
		memberVO.setMemAuth( "Y" );
		memberVO.setMemSt( "Y" );
		memberVO.setMemAlias( "TEST_ALIAS" );
		memberVO.setMemTel("010-1234-5678");
		memberVO.setMemAddr1("대전 중구 계룡로955번길 6");
		memberVO.setMemAddr2("2층");
		memberVO.setMemZipcode(34953);
		memberVO.setMemCareer("경력");
		memberVO.setMemEduc("대학교 졸업");
		memberVO.setMemGender("F");
		memberVO.setMemTargetCompany("카카오");
		memberVO.setMemTargetJob("개발");
		memberVO.setSearchJobDate("2020년 상반기");
		memberVO.setMemMajor("공학");
		
		MockHttpSession session = new MockHttpSession();
		session.setAttribute("S_MEMBER", memberVO);
		
		mockMvc.perform(post("/analysis/voice/retrieveGrowth.do")
				.session(session))
		.andExpect(status().is(200))
		.andExpect(view().name("jsonView"));
	}
	
	@Test	
	public void shareTest() throws Exception {
		mockMvc.perform(post("/analysis/share.do")
				.param("sharePw","1234")
				.param("shareMemId","MEMBER1")
				.param("profilePath","/file/borwn.png")
				.param("interviewSq","1")
				)
		.andExpect(status().is(200))
		.andExpect(view().name("analysis/analysisShare"));
	}
	
	@Test	
	public void resultShareTest() throws Exception {
		mockMvc.perform(post("/analysis/resultShare.do")
				.param("shareMemId","MEMBER1")
				.param("profilePath","/file/borwn.png")
				.param("questionSq","1")
				.param("questionContent","내용")
				.param("interviewSq","1")
				.param("sampQuestSq","1")
				)
		.andExpect(status().is(200))
		.andExpect(view().name("analysis/shareInterviewResult"));
	}
	
	@Test	
	public void manageStatisticTest() throws Exception {
		mockMvc.perform(post("/analysis/manageStatistic.do")
				)
		.andExpect(status().is(200))
		.andExpect(view().name("jsonView"));
	}

}
