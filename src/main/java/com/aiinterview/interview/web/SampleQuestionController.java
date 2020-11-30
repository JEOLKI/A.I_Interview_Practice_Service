package com.aiinterview.interview.web;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.aiinterview.interview.service.SampleQuestionService;

@RequestMapping("/sampleQuestion")
@Controller
public class SampleQuestionController {

	@Resource(name="sampleQuestionService")
	private SampleQuestionService sampleQuestionService;
}
