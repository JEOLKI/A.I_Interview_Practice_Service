package com.aiinterview.analysis.dao;

import java.util.List;

import com.aiinterview.analysis.vo.HabitAnalysisVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("habitAnalysisMapper")
public interface HabitAnalysisMapper {
	
	public List<HabitAnalysisVO> retrieveList(String ansSq) throws Exception;
	
	public void create(HabitAnalysisVO habitanalysisVO) throws Exception;
	
}
