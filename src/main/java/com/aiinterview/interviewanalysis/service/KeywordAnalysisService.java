package com.aiinterview.interviewanalysis.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.aiinterview.interviewanalysis.dao.KeywordAnalysisMapper;



@Service("keywordAnalysisService")
public class KeywordAnalysisService {

	@Resource(name="keywordAnalysisMapper")
	private KeywordAnalysisMapper keywordAnalysisMapper;
}
