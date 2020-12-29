package com.aiinterview.analysis.dao;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertTrue;

import java.util.List;

import javax.annotation.Resource;

import org.junit.Test;

import com.aiinterview.ModelTestConfig;
import com.aiinterview.analysis.dao.VoiceAnalysisMapper;
import com.aiinterview.analysis.vo.VoiceAnalysisVO;

public class VoiceAnalysisMapperTest extends ModelTestConfig{
	
	@Resource(name="voiceAnalysisMapper")
	private VoiceAnalysisMapper voiceAnalysisMapper;

	@Test
	public void retrieveListTest() throws Exception {
		/***Given***/
		

		/***When***/
		List<VoiceAnalysisVO> voiceAnalysisList = voiceAnalysisMapper.retrieveList("1");

		/***Then***/
		assertEquals(50, voiceAnalysisList.size());
	}
	
	@Test // voiceAnalysisSq가 위배된다 추후  디비 교체하면 문제없음
	public void createTest() throws Exception {
		/***Given***/
		VoiceAnalysisVO voiceAnalysisVO = new VoiceAnalysisVO();
		voiceAnalysisVO.setAnsSq("5");
		voiceAnalysisVO.setVoiceDecibel("80");
		voiceAnalysisVO.setVoiceRange("60");
		
		/***When***/
		voiceAnalysisMapper.create(voiceAnalysisVO);
		
		/***Then***/
		assertTrue(voiceAnalysisVO.getVoiceAnalysisSq() !="0");
	}
	
	@Test
	public void retrieveGrowthTest() throws Exception {
		/***Given***/

		
		/***When***/
		List<VoiceAnalysisVO> voiceAnalysisList = voiceAnalysisMapper.retrieveGrowth("MEMBER1");
		
		/***Then***/
		assertEquals(5, voiceAnalysisList.size());
	}

}
