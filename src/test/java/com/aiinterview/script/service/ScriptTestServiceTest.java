package com.aiinterview.script.service;

import static org.junit.Assert.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.junit.Test;

import com.aiinterview.ModelTestConfig;
import com.aiinterview.script.vo.ScriptTestVO;

public class ScriptTestServiceTest extends ModelTestConfig{
	@Resource(name="scriptTestService")
	private ScriptTestService scriptTestService;
	
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
		scriptTestService.create(scriptTestVO);
		
		/***Then***/
		assertTrue(scriptTestVO.getScriptTestSq() != "0");
	}
	
	@Test
	public void retrieveListTest( ) throws Exception{
		/***Given***/
		String memId = "MEMBER2";
		
		/***When***/
		List<ScriptTestVO> scriptTestList = scriptTestService.retrieveList(memId);
		
		/***Then***/
		assertEquals(4, scriptTestList.size());
	}
	
	@Test
	public void retrieveScoreTest( ) throws Exception{
		/***Given***/
		Map<String, String> testScoreMap = new HashMap<>();
		String first = "동해물과 백두산이 마르고 닳도록";
		testScoreMap.put("scriptContent", first);
		String second = "동해물과 백두산이 마르고 닳도록";
		testScoreMap.put("resultScript", second);
		
		/***When***/
		int score = scriptTestService.retrieveScore(testScoreMap);

		/***Then***/
		assertEquals(100, score);
	}
}
