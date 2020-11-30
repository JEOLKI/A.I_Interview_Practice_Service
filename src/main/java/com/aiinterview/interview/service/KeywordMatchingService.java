package com.aiinterview.interview.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.aiinterview.interview.dao.KeywordMatchingMapper;


@Service("keywordMatchingService")
public class KeywordMatchingService {
	
	@Resource(name="keywordMatchingMapper")
	private KeywordMatchingMapper keywordMatchingMapper;

}
