package com.aiinterview.analysis.dao;

import com.aiinterview.analysis.vo.ImageAnalysisVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("imageanalysisMapper")
public interface ImageAnalysisMapper {
	
	public void create(ImageAnalysisVO imageAnalysisVO) throws Exception;
	
}
