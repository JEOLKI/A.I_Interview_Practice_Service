package com.aiinterview.interview.web;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.aiinterview.interview.service.KeywordMatchingService;

@RequestMapping("/keywordMatching")
@Controller
public class KeywordMatchingController {

	@Resource(name="keywordMatchingService")
	private KeywordMatchingService keywordMatchingService;
}
