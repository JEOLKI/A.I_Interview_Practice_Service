package com.aiinterview.analysis.dao;

import java.util.List;

import com.aiinterview.analysis.vo.RepeatAnalysisVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("repeatAnalysisMapper")
public interface RepeatAnalysisMapper {
	
	public List<RepeatAnalysisVO> retrieveList(String ansSq) throws Exception;
	
	public void create(RepeatAnalysisVO repeatAnalysisVO) throws Exception;

}
