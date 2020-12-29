package com.aiinterview.analysis.dao;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertTrue;

import java.util.List;

import javax.annotation.Resource;

import org.junit.Test;

import com.aiinterview.ModelTestConfig;
import com.aiinterview.analysis.vo.ImageAnalysisVO;

public class ImageAnalysisMapperTest extends ModelTestConfig{

	@Resource(name="imageAnalysisMapper")
	private ImageAnalysisMapper imageAnalysisMapper;
	
	@Test
	public void retrieveListTest() throws Exception {
		
		/***Given***/
		String ansSq = "1";
		
		/***When***/
		List<ImageAnalysisVO> imageAnalysisList = imageAnalysisMapper.retrieveList(ansSq);

		/***Then***/
		assertTrue(imageAnalysisList.size() > 0);
		
	}

	@Test
	public void createTest() throws Exception {
		
		/***Given***/
		ImageAnalysisVO imageAnalysisVO = new ImageAnalysisVO();
		imageAnalysisVO.setAnger("0.011");
		imageAnalysisVO.setContempt("0.001");
		imageAnalysisVO.setFear("0.004");
		imageAnalysisVO.setDisgust("0.005");
		imageAnalysisVO.setHappiness("0.004");
		imageAnalysisVO.setNeutral("0.631");
		imageAnalysisVO.setSadness("0.022");
		imageAnalysisVO.setSurprise("0.323");
		imageAnalysisVO.setFaceTop("52");
		imageAnalysisVO.setFaceLeft("124");
		imageAnalysisVO.setFaceWidth("104");
		imageAnalysisVO.setFaceHeight("104");
		imageAnalysisVO.setAnsSq("5");
		
		/***When***/
		imageAnalysisMapper.create(imageAnalysisVO);	
		
		/***Then***/
		assertTrue(imageAnalysisVO.getImageAnalysisSq() != "0");
		
	}
	
	@Test
	public void retrieveAnalysisTest() throws Exception {
		
		/***Given***/
		String ansSq = "1";
		
		/***When***/
		ImageAnalysisVO imageAnalysisVO = imageAnalysisMapper.retrieveAnalysis(ansSq);

		/***Then***/
		assertTrue(imageAnalysisVO != null);
		
	}
	
	@Test
	public void retrieveGrowthTest() throws Exception {
		
		/***Given***/
		String memId = "MEMBER1";
		
		/***When***/
		List<ImageAnalysisVO> imageAnalysisList = imageAnalysisMapper.retrieveGrowth(memId);

		/***Then***/
		assertEquals(5, imageAnalysisList.size());
		
	}

}
