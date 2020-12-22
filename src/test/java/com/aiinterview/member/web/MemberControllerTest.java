package com.aiinterview.member.web;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.fileUpload;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.view;

import java.io.InputStream;

import org.junit.Test;
import org.springframework.mock.web.MockHttpSession;
import org.springframework.mock.web.MockMultipartFile;

import com.aiinterview.WebTestConfig;
import com.aiinterview.member.vo.MemberVO;

public class MemberControllerTest extends WebTestConfig {
	
	@Test
	public void retrieveIdTest() throws Exception {
		mockMvc.perform(get("/member/retrieveid.do"))
		.andExpect(status().is(200))
		.andExpect(view().name("jsonView"));
	}
	
	@Test
	public void retrievePwTest() throws Exception {
		mockMvc.perform(get("/member/retrievepw.do"))
		.andExpect(status().is(200))
		.andExpect(view().name("jsonView"));
	}
	
	@Test
	public void updatePwTest() throws Exception {
		mockMvc.perform(get("/member/updatepw.do")
				.param("memId", "TEST_ID")
				.param("memPw", "PW_TEST"))
		.andExpect(status().is(200))
		.andExpect(view().name("jsonView"));
	}
	
	@Test
	public void idCheckTest() throws Exception {
		mockMvc.perform(post("/member/idCheck.do")
				.param("memId", "TEST_ID"))
		.andExpect(status().is(200))
		.andExpect(view().name("jsonView"));
	}
	
	@Test
	public void aliasCheckTest() throws Exception {
		mockMvc.perform(post("/member/aliasCheck.do")
				.param("memAlias", "test"))
		.andExpect(status().is(200))
		.andExpect(view().name("jsonView"));
	}
	
	@Test
	public void createTest() throws Exception {
		mockMvc.perform(post("/member/create.do")
				.param("memId", "test")
				.param("memPw", "test")
				.param("memAlias", "test")
				.param("memNm", "test")
				.param("memTel", "010-0000-0000")
				.param("memAddr1", "addr1")
				.param("memAddr2", "addr2")
				.param("memZipcode", "12345")
				.param("memCareer", "신입")
				.param("memEduc", "기타")
				.param("memGender", "F")
				.param("memTargetCompany", "카카오")
				.param("memTargetJob", "개발")
				.param("searchJobDate", "2020년 하반기")
				.param("memMajor", "공학"))
		.andExpect(status().is(302))
		.andExpect(view().name("redirect:/login/main.do"));
	}
	
	@Test
	public void myProfileViewTest() throws Exception {
		mockMvc.perform(get("/member/myprofileview.do"))
		.andExpect(status().is(200))
		.andExpect(view().name("myProfile/myProfile"));
	}
	
	@Test
	public void myPlanAjaxTest() throws Exception {
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
	    
		mockMvc.perform(get("/member/myPlanAjax.do")
				.session(session))
		.andExpect(status().is(200))
		.andExpect(view().name("jsonView"));
	}
	
	@Test
	public void deleteViewTest() throws Exception {
		mockMvc.perform(get("/member/deleteview.do"))
		.andExpect(status().is(200))
		.andExpect(view().name("myProfile/myProfileDelete"));
	}
	
	@Test
	public void deleteProcessTest() throws Exception {
		mockMvc.perform(get("/member/deleteprocess.do")
				.param("memId", "TEST_ID"))
		.andExpect(status().is(302))
		.andExpect(view().name("redirect:/login/main.do"));
	}
	
	@Test
	public void profileTest() throws Exception {
		mockMvc.perform(get("/member/profile.do")
				.param("memId", "TEST_ID"))
		.andExpect(status().is(200))
		.andExpect(view().name("ProfileImgView"));
	}
	
	@Test
	public void updateViewTest() throws Exception {
		mockMvc.perform(get("/member/updateview.do"))
		.andExpect(status().is(200))
		.andExpect(view().name("myProfile/myProfileUpdate"));
	}
	
	@Test
	public void updateTest() throws Exception {
		InputStream is = getClass().getResourceAsStream("/file/brown.png");
		MockMultipartFile profile = new MockMultipartFile("profile", "brown.png", "png", is);
		
		mockMvc.perform(fileUpload("/member/update.do")
				.file(profile)
				.param("memId", "TEST_ID")
				.param("memPw", "TEST_PW")
				.param("memAlias", "TEST_ALIAS")
				.param("memNm", "TEST_NAME")
				.param("memTel", "010-0000-0000")
				.param("memAddr1", "addr1")
				.param("memAddr2", "addr2")
				.param("memZipcode", "12345")
				.param("memCareer", "신입")
				.param("memEduc", "기타")
				.param("memGender", "F")
				.param("memTargetCompany", "카카오")
				.param("memTargetJob", "개발")
				.param("searchJobDate", "2020년 하반기")
				.param("memMajor", "공학")
				)
		.andExpect(status().is(302))
		.andExpect(view().name("redirect:/member/myprofileview.do"));
	}

	@Test
	public void marketingAgreeTest() throws Exception {
		mockMvc.perform(get("/member/marketingAgree.do"))
		.andExpect(status().is(200))
		.andExpect(view().name("agreement/marketingAgree"));
	}
	
	@Test
	public void retrievePagingListTest() throws Exception {
		mockMvc.perform(get("/member/retrievePagingList.do"))
		.andExpect(status().is(200))
		.andExpect(view().name("manage/memberManage"));
	}
	
	@Test
	public void memberExcelDownTest() throws Exception {
		mockMvc.perform(get("/member/memberExcel.do"))
		.andExpect(status().is(200))
		.andExpect(view().name("excelView"));
	}
	
	@Test
	public void authorityManageTest() throws Exception {
		mockMvc.perform(get("/member/authorityManage.do"))
		.andExpect(status().is(200))
		.andExpect(view().name("manage/authorityManage"));
	}
	
	@Test
	public void authorityChangeTest() throws Exception {
		mockMvc.perform(get("/member/authorityChange.do")
				.param("memId", "TEST_ID")
				.param("memAuth", "C"))
		.andExpect(status().is(302))
		.andExpect(view().name("redirect:/member/authorityManage.do"));
	}
	
	@Test
	public void majorStatisticTest() throws Exception {
		mockMvc.perform(get("/member/majorStatistic.do")
				.param("memId", "TEST_ID")
				.param("memPw", "TEST_PW")
				.param("memAlias", "TEST_ALIAS")
				.param("memNm", "TEST_NAME")
				.param("memTel", "010-0000-0000")
				.param("memAddr1", "addr1")
				.param("memAddr2", "addr2")
				.param("memZipcode", "12345")
				.param("memCareer", "신입")
				.param("memEduc", "기타")
				.param("memGender", "F")
				.param("memTargetCompany", "카카오")
				.param("memTargetJob", "개발")
				.param("searchJobDate", "2020년 하반기")
				.param("memMajor", "공학"))
		.andExpect(status().is(200))
		.andExpect(view().name("jsonView"));
	}
	
	@Test
	public void educationStatisticTest() throws Exception {
		mockMvc.perform(get("/member/educationStatistic.do")
				.param("memId", "TEST_ID")
				.param("memPw", "TEST_PW")
				.param("memAlias", "TEST_ALIAS")
				.param("memNm", "TEST_NAME")
				.param("memTel", "010-0000-0000")
				.param("memAddr1", "addr1")
				.param("memAddr2", "addr2")
				.param("memZipcode", "12345")
				.param("memCareer", "신입")
				.param("memEduc", "기타")
				.param("memGender", "F")
				.param("memTargetCompany", "카카오")
				.param("memTargetJob", "개발")
				.param("searchJobDate", "2020년 하반기")
				.param("memMajor", "공학"))
		.andExpect(status().is(200))
		.andExpect(view().name("jsonView"));
	}
	
	@Test
	public void careerStatisticTest() throws Exception {
		mockMvc.perform(get("/member/careerStatistic.do")
				.param("memId", "TEST_ID")
				.param("memPw", "TEST_PW")
				.param("memAlias", "TEST_ALIAS")
				.param("memNm", "TEST_NAME")
				.param("memTel", "010-0000-0000")
				.param("memAddr1", "addr1")
				.param("memAddr2", "addr2")
				.param("memZipcode", "12345")
				.param("memCareer", "신입")
				.param("memEduc", "기타")
				.param("memGender", "F")
				.param("memTargetCompany", "카카오")
				.param("memTargetJob", "개발")
				.param("searchJobDate", "2020년 하반기")
				.param("memMajor", "공학"))
		.andExpect(status().is(200))
		.andExpect(view().name("jsonView"));
	}
	
	@Test
	public void genderStatisticTest() throws Exception {
		mockMvc.perform(get("/member/genderStatistic.do")
				.param("memId", "TEST_ID")
				.param("memPw", "TEST_PW")
				.param("memAlias", "TEST_ALIAS")
				.param("memNm", "TEST_NAME")
				.param("memTel", "010-0000-0000")
				.param("memAddr1", "addr1")
				.param("memAddr2", "addr2")
				.param("memZipcode", "12345")
				.param("memCareer", "신입")
				.param("memEduc", "기타")
				.param("memGender", "F")
				.param("memTargetCompany", "카카오")
				.param("memTargetJob", "개발")
				.param("searchJobDate", "2020년 하반기")
				.param("memMajor", "공학"))
		.andExpect(status().is(200))
		.andExpect(view().name("jsonView"));
	}
}
