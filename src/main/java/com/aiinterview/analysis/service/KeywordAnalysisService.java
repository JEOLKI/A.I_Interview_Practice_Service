package com.aiinterview.analysis.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.aiinterview.analysis.dao.KeywordAnalysisMapper;


@Service("keywordAnalysisService")
public class KeywordAnalysisService {

	@Resource(name="keywordAnalysisMapper")
	private KeywordAnalysisMapper keywordAnalysisMapper;
}
