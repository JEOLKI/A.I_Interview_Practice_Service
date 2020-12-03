package com.aiinterview.analysis.dao;

import com.aiinterview.analysis.vo.RepetAnalysisVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("repetanalysisMapper")
public interface RepetAnalysisMapper {
	
	public void create(RepetAnalysisVO repetAnalysisVO) throws Exception;

}
