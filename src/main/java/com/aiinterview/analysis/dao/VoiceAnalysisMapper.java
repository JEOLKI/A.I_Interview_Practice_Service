package com.aiinterview.analysis.dao;

import java.util.List;

import com.aiinterview.analysis.vo.VoiceAnalysisVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("voiceAnalysisMapper")
public interface VoiceAnalysisMapper {

	public List<VoiceAnalysisVO> retrieveList(String ansSq) throws Exception;
	
	public void create(VoiceAnalysisVO voiceAnalysisVO) throws Exception;
	
}
