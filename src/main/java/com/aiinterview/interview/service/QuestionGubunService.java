package com.aiinterview.interview.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.aiinterview.interview.dao.QuestionGubunMapper;


@Service("questionGubunService")
public class QuestionGubunService {
	
	
	@Resource(name="questionGubunMapper")
	private QuestionGubunMapper questionGubunMapper;

}
