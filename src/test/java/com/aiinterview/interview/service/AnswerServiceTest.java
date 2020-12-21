package com.aiinterview.interview.service;

import static org.junit.Assert.assertEquals;

import java.util.List;

import javax.annotation.Resource;

import org.junit.Test;

import com.aiinterview.ModelTestConfig;
import com.aiinterview.interview.vo.AnswerVO;

public class AnswerServiceTest extends ModelTestConfig {

	@Resource(name="answerService")
	private AnswerService answerService;
	
	@Test
	public void retrieveTest() throws Exception {
		
		/***Given***/
		String questSq = "1";
		
		/***When***/
		AnswerVO answerVO = answerService.retrieve(questSq);
		
		/***Then***/
		assertEquals("1", answerVO.getInterviewSq());
		
	}
	
	@Test
	public void retrieveSpeedGrowth() throws Exception {
		
		/***Given***/
		
		/***When***/
		List<AnswerVO> answerList = answerService.retrieveSpeedGrowth("MEMBER1");
		
		/***Then***/
		assertEquals(5, answerList.size());
		
	}
	
	@Test
	public void createTest() throws Exception {
		
		/***Given***/
		
		/***When***/
		
		/***Then***/
		
	}
}
