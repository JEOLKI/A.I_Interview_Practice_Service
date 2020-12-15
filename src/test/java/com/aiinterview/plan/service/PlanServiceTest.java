package com.aiinterview.plan.service;

import static org.junit.Assert.assertEquals;

import javax.annotation.Resource;

import org.junit.Test;

import com.aiinterview.ModelTestConfig;

public class PlanServiceTest extends ModelTestConfig{
	
	@Resource(name = "planService")
	private PlanService planService;
	
	@Test
	public void retrieveEndDatTtest() throws Exception {
		
		/***Given***/
		String memId= "TEST_ID";
		
		/***When***/
		int count = planService.retrieveEndDate(memId);

		/***Then***/
		assertEquals(1, count);
		
	}
}
