package com.aiinterview.interview.web;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.aiinterview.interview.service.QuestionGubunService;

@RequestMapping("/questionGubun")
@Controller
public class QuestionGubunController {

	@Resource(name="questionGubunService")
	private QuestionGubunService questionGubunService;
}
