package com.aiinterview.interview.web;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.aiinterview.interview.service.KeywordService;

@RequestMapping("/keyword")
@Controller
public class KeywordController {

	@Resource(name="keywordService")
	private KeywordService keywordService;
}
