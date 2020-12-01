package com.aiinterview.interview.analysis.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.aiinterview.interview.analysis.dao.KeywordAnalysisMapper;


@Service("keywordAnalysisService")
public class KeywordAnalysisService {

	@Resource(name="keywordAnalysisMapper")
	private KeywordAnalysisMapper keywordAnalysisMapper;
}
