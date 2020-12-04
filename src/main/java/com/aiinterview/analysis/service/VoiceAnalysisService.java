package com.aiinterview.analysis.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.aiinterview.analysis.dao.VoiceAnalysisMapper;
import com.aiinterview.analysis.vo.VoiceAnalysisVO;

@Service("voiceAnalysisService")
public class VoiceAnalysisService {

	@Resource(name = "voiceAnalysisMapper")
	private VoiceAnalysisMapper voiceAnalysisMapper;

	public List<VoiceAnalysisVO> retrieveList(String ansSq) throws Exception{
		return voiceAnalysisMapper.retrieveList(ansSq);
	}
}
