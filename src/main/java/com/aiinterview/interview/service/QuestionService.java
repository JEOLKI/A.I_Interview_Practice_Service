package com.aiinterview.interview.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.aiinterview.interview.dao.QuestionMapper;

@Service("questionService")
public class QuestionService {
	@Resource(name="questionMapper")
	private QuestionMapper questionMapper;
}
