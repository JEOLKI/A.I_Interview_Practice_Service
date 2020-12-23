package com.aiinterview.plan.web;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.model;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.view;

import static org.junit.Assert.*;

import org.junit.Test;
import org.springframework.mock.web.MockHttpSession;

import com.aiinterview.WebTestConfig;
import com.aiinterview.member.vo.MemberVO;
import com.aiinterview.plan.vo.PlanVO;

public class planControllerTest extends WebTestConfig {

	@Test
	public void planListView() throws Exception {
		mockMvc.perform(get("/plan/planList.do"))
		.andExpect(status().isOk())
		.andExpect(view().name("plan/planList"));
	}

	@Test
	public void buypalnAjax() throws Exception{
		mockMvc.perform(get("/plan/planListAjax.do"))
		.andExpect(status().isOk())
		.andExpect(view().name("jsonView"));
	}
	
	@Test
	public void planContentView() throws Exception{
		MemberVO mv = new MemberVO();
		mv.setMemId("MEMBER1");
		mv.setMemAuth("Y");
		
		mv.setMemSt("C");
		MockHttpSession session = new MockHttpSession();
		session.setAttribute("S_MEMBER", mv);
		
		mockMvc.perform(get("/plan/planContent.do")
				.session(session)
				.param("planSq", "1"))
				.andExpect(status().isOk())
//				.andExpect(model().attributeExists("planUseCheck"))
				.andExpect(model().attributeExists("pvContent"))
				.andExpect(view().name("plan/planContent"));
	}
	@Test
	public void payPlanAjax() throws Exception{
		mockMvc.perform(get("/plan/payPlanAjax.do")
				.param("planSq", "1"))
				.andExpect(status().isOk())
				.andExpect(model().attributeExists("pvContent"))
				.andExpect(view().name("jsonView"));
	}
	@Test
	public void planUseCreateView() throws Exception{
		
		MemberVO mv = new MemberVO();
		mv.setMemId("MEMBER1");
		mv.setMemAuth("Y");
		
		mv.setMemSt("C");
		MockHttpSession session = new MockHttpSession();
		session.setAttribute("S_MEMBER", mv);
		
		mockMvc.perform(get("/plan/planUseCreate.do")
				.param("planSq", "1")
				.session(session))
				.andExpect(status().is3xxRedirection());
	}
	
	@Test
	public void createView() throws Exception{
		
		mockMvc.perform(get("/plan/manage.do"))
				.andExpect(view().name("manage/planManage"));
		
	}
	
	@Test
	public void createProcess() throws Exception{
		mockMvc.perform(post("/plan/create.do")
			 .param("PlanNm", "2일 이용권")
			 .param("PlanPrice", "3000")
			 .param("PlanPeriod", "2")
			 .param("PlanExplain", "특별 2일 이용권"))
			.andExpect(view().name("manage/planManage"));
	}
	
	@Test
	public void updateView() throws Exception{
		mockMvc.perform(get("/plan/update.do")
				.param("PlanSq", "2"))
		.andExpect(view().name("manage/planManage"));
	}
	
	@Test
	public void totalPayList() throws Exception{
		MemberVO mv = new MemberVO();
		mv.setMemId("MEMBER1");
		mv.setMemAuth("Y");
		
		mv.setMemSt("C");
		MockHttpSession session = new MockHttpSession();
		session.setAttribute("S_MEMBER", mv);
		
		mockMvc.perform(get("/plan/totalPayList.do")
				.session(session))
				.andExpect(view().name("plan/totalPayList"));
	}
	
	@Test
	public void planExcelDown() throws Exception{
		mockMvc.perform(get("/plan/planExcel.do"))
		.andExpect(view().name("excelView"));
	}
	
	@Test
	public void planUseExcel() throws Exception{
		mockMvc.perform(get("/plan/planUseExcel.do"))
		.andExpect(view().name("excelView"));
	}
	
	@Test
	public void cashListView() throws Exception{
		MemberVO mv = new MemberVO();
		mv.setMemId("MEMBER1");
		mv.setMemAuth("Y");
		
		mv.setMemSt("C");
		MockHttpSession session = new MockHttpSession();
		session.setAttribute("S_MEMBER", mv);
		
		mockMvc.perform(get("/plan/cashList.do")
				.session(session))
				.andExpect(model().attributeExists("startList"))
				.andExpect(model().attributeExists("endList"))
				.andExpect(model().attributeExists("cashList"))
				.andExpect(view().name("jsonView"));
	}
	
	@Test
	public void payComplete() throws Exception{
		
		mockMvc.perform(get("/plan/payComplete.do"))
					.andExpect(view().name("myProfile/myProfile"));
	}
	
	@Test
	public void retrievePagingList() throws Exception{
		
		mockMvc.perform(get("/plan/retrievePagingList.do"))
				.andExpect(model().attributeExists("resultList"))
				.andExpect(model().attributeExists("paginationInfo"))
				.andExpect(view().name("manage/planUseListManage"));
	}

	@Test
	public void statistics() throws Exception{
		
		mockMvc.perform(get("/plan/statistics.do"))
		.andExpect(view().name("manage/planStatistics"));
	}
	
	@Test
	public void totalStatistics() throws Exception{
		
		mockMvc.perform(get("/plan/totalUseStatistics.do")
				.param("startDate", "2020-11-27")
				.param("endDate", "2020-12-15")
				.param("searchKeyword", "일"))
				.andExpect(model().attributeExists("totalUseList"))
				.andExpect(view().name("jsonView"));
	}
	
	@Test
	public void totalSaleStatistics() throws Exception{
		
		mockMvc.perform(get("/plan/totalSaleStatistics.do")
				.param("startDate", "2020-11-27")
				.param("endDate", "2020-12-15")
				.param("searchKeyword", "일"))
				.andExpect(model().attributeExists("totalSaleList"))
				.andExpect(view().name("jsonView"));
	}
	
	
	
	
}

















