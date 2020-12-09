package com.aiinterview.analysis.dao;

import java.util.List;

import com.aiinterview.analysis.vo.ImageAnalysisVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("imageAnalysisMapper")
public interface ImageAnalysisMapper {
	
	public List<ImageAnalysisVO> retrieveList(String ansSq) throws Exception;
	
	public void create(ImageAnalysisVO imageAnalysisVO) throws Exception;
	
	public ImageAnalysisVO retrieveAnalysis(String ansSq) throws Exception;
	
	
}
