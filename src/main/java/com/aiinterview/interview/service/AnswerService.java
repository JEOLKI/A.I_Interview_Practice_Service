package com.aiinterview.interview.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.aiinterview.interview.dao.AnswerMapper;


@Service("answerService")
public class AnswerService {
	
	@Resource(name="answerMapper")
	private AnswerMapper answerMapper;

}
