package com.aiinterview.analysis.dao;

import java.util.List;

import com.aiinterview.analysis.vo.RepetAnalysisVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("repetAnalysisMapper")
public interface RepetAnalysisMapper {
	
	public List<RepetAnalysisVO> retrieveList(String ansSq) throws Exception;
	
	public void create(RepetAnalysisVO repetAnalysisVO) throws Exception;

}
