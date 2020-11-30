package com.aiinterview.interview.web;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.aiinterview.interview.service.QuestionService;

@RequestMapping("/question")
@Controller 
public class QuestionController {

	@Resource(name="questionService")
	private QuestionService questionService;
}
