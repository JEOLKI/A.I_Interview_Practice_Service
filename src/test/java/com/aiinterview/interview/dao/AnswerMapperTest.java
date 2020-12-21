package com.aiinterview.interview.dao;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertTrue;

import javax.annotation.Resource;

import org.junit.Test;

import com.aiinterview.ModelTestConfig;
import com.aiinterview.interview.vo.AnswerVO;

public class AnswerMapperTest extends ModelTestConfig{

	@Resource(name="answerMapper")
	private AnswerMapper answerMapper;
	
	@Test
	public void retrieveTest() throws Exception {
		
		/***Given***/
		String questSq = "1";
		
		/***When***/
		AnswerVO answerVO = answerMapper.retrieve(questSq);
		/***Then***/
		assertEquals("1", answerVO.getAnsSq());
		
	}
	
	@Test
	public void createTest() throws Exception {
		
		/***Given***/
		AnswerVO answerVO = new AnswerVO();
		answerVO.setAnsContent("TEST");
		answerVO.setVideoPath("TEST");
		answerVO.setAnsTime("10");
		answerVO.setAnsSpeed("60");
		answerVO.setQuestSq("6");
		
		/***When***/
		answerMapper.create(answerVO);
		
		/***Then***/
		assertTrue( Integer.parseInt(answerVO.getAnsSq()) > 0);
		
	}
	
}
