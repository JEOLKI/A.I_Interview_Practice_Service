package com.aiinterview.script.dao;

import static org.junit.Assert.assertTrue;

import javax.annotation.Resource;

import org.junit.Test;

import com.aiinterview.ModelTestConfig;
import com.aiinterview.script.vo.ScriptTestVO;

public class ScriptTestMapperTest extends ModelTestConfig{
	@Resource(name="scriptTestMapper")
	private ScriptTestMapper scriptTestMapper;

	@Test
	public void createTest( ) throws Exception{
		/***Given***/
		ScriptTestVO scriptTestVO = new ScriptTestVO();
		scriptTestVO.setScriptContent("All I want for Christmas for you.");
		scriptTestVO.setScriptTestScore("86");
		scriptTestVO.setPerformScript("All I want for Christmas is you.");
		scriptTestVO.setScriptTestDate("2020/10/02");
		scriptTestVO.setMemId("oz");
		scriptTestVO.setScriptSq("6");
		
		/***When***/
		scriptTestMapper.create(scriptTestVO);
		
		/***Then***/
		assertTrue(scriptTestVO.getScriptTestSq() != "0");
	}
}
