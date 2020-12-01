package com.aiinterview.interview.analysis.web;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.aiinterview.interview.analysis.service.KeywordAnalysisService;

@RequestMapping("/keywordAnalysis")
@Controller
public class KeywordAnalysisController {
	
	@Resource(name="keywordAnalysisService")
	private KeywordAnalysisService keywordAnalysisService;
	

}
