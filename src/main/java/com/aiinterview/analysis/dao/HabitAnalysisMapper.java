package com.aiinterview.analysis.dao;

import com.aiinterview.analysis.vo.HabitAnalysisVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("habitanalysisMapper")
public interface HabitAnalysisMapper {
	
	public void create(HabitAnalysisVO habitanalysisVO) throws Exception;
	
}
