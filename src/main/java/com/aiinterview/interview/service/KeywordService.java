package com.aiinterview.interview.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.aiinterview.interview.dao.KeywordMapper;

@Service("keywordService")
public class KeywordService {
	
	@Resource(name="keywordMapper")
	private KeywordMapper keywordMapper;

}
