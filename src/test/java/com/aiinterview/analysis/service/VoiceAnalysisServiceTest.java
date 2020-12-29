package com.aiinterview.analysis.service;

import static org.junit.Assert.*;

import java.util.List;

import javax.annotation.Resource;

import org.junit.Test;

import com.aiinterview.ModelTestConfig;
import com.aiinterview.analysis.service.VoiceAnalysisService;
import com.aiinterview.analysis.vo.VoiceAnalysisVO;

public class VoiceAnalysisServiceTest extends ModelTestConfig {

	@Resource(name="voiceAnalysisService")
	private VoiceAnalysisService voiceAnalysisService;
	
	@Test
	public void retrieveListTest() throws Exception {
		/***Given***/
		

		/***When***/
		List<VoiceAnalysisVO> voiceAnalysisList = voiceAnalysisService.retrieveList("1");

		/***Then***/
		assertEquals(50, voiceAnalysisList.size());
	}
	
	@Test
	public void retrieveGrowthTest() throws Exception {
		/***Given***/

		
		/***When***/
		List<VoiceAnalysisVO> voiceAnalysisList = voiceAnalysisService.retrieveGrowth("MEMBER1");
		
		/***Then***/
		assertEquals(5, voiceAnalysisList.size());
	}

}
