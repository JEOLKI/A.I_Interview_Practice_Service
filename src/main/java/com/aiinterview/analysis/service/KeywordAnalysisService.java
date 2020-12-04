package com.aiinterview.analysis.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.aiinterview.analysis.dao.KeywordAnalysisMapper;
import com.aiinterview.analysis.vo.KeywordAnalysisVO;

@Service("keywordAnalysisService")
public class KeywordAnalysisService {
	
	@Resource(name = "keywordAnalysisMapper")
	private KeywordAnalysisMapper keywordAnalysisMapper;

	public List<KeywordAnalysisVO> retrieveList(String ansSq) throws Exception{
		return keywordAnalysisMapper.retrieveList(ansSq);
	}

}
