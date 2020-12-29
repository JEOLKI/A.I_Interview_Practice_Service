package com.aiinterview.analysis.service;

import static org.junit.Assert.*;

import java.util.List;

import javax.annotation.Resource;

import org.junit.Test;

import com.aiinterview.ModelTestConfig;
import com.aiinterview.analysis.dao.ImageAnalysisMapper;
import com.aiinterview.analysis.vo.ImageAnalysisVO;

public class ImageAnalysisServiceTest extends ModelTestConfig{

	@Resource(name="imageAnalysisService")
	private ImageAnalysisService imageAnalysisService;
	
	@Test
	public void retrieveListTest() throws Exception {
		/***Given***/
		
		/***When***/
		List<ImageAnalysisVO> imageAnalysisList = imageAnalysisService.retrieveList("1");	
		
		/***Then***/
		assertEquals(2,imageAnalysisList.size());
		
	}

	@Test
	public void retrieveAnalysisTest() throws Exception {
		/***Given***/
		
		/***When***/
		ImageAnalysisVO imageAnalysiVO = imageAnalysisService.retrieveAnalysis("1");	
		
		/***Then***/
		assertEquals("0",imageAnalysiVO.getContempt());
		
	}
	
	@Test
	public void retrieveGrowthTest() throws Exception {
		/***Given***/
		
		/***When***/
		List<ImageAnalysisVO> imageAnalysiList = imageAnalysisService.retrieveGrowth("MEMBER1");	
		
		/***Then***/
		assertEquals(5,imageAnalysiList.size());
		
	}

}
