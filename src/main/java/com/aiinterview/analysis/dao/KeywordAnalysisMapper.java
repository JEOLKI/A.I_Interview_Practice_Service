package com.aiinterview.analysis.dao;

import com.aiinterview.analysis.vo.KeywordAnalysisVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("keywordanalysisMapper")
public interface KeywordAnalysisMapper {
	
	public void create(KeywordAnalysisVO keywordAnalysisVO) throws Exception;
	
}
