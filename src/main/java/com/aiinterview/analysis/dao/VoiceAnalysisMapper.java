package com.aiinterview.analysis.dao;

import com.aiinterview.analysis.vo.VoiceAnalysisVO;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("voiceanalysisMapper")
public interface VoiceAnalysisMapper {

	public void create(VoiceAnalysisVO voiceAnalysisVO) throws Exception;
	
}
