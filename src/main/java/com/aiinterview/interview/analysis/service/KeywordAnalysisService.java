package com.aiinterview.interview.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.aiinterview.interview.dao.KeywordAnalysisMapper;


@Service("keywordAnalysisService")
public class KeywordAnalysisService {

	@Resource(name="keywordAnalysisMapper")
	private KeywordAnalysisMapper keywordAnalysisMapper;
}
