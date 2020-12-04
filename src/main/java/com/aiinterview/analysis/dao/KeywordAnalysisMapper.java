package com.aiinterview.analysis.dao;

import java.util.List;

import com.aiinterview.analysis.vo.KeywordAnalysisVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("keywordAnalysisMapper")
public interface KeywordAnalysisMapper {
	
	public List<KeywordAnalysisVO> retrieveList(String ansSq) throws Exception;
	
	public void create(KeywordAnalysisVO keywordAnalysisVO) throws Exception;
	
}
