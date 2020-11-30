package com.aiinterview.interview.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.aiinterview.interview.dao.SampleQuestionMapper;

@Service("sampleQuestionService")
public class SampleQuestionService {

	@Resource(name="sampleQuestionMapper")
	private SampleQuestionMapper sampleQuestionMapper;
	
}
