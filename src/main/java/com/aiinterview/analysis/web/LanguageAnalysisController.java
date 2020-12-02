package com.aiinterview.analysis.web;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/languageanalysis")
@Controller
public class LanguageAnalysisController {
	private static final Logger logger = LoggerFactory.getLogger(LanguageAnalysisController.class);
	
	@RequestMapping("/test.do")
	public String test() {
		logger.debug("test진입");
		return "analysis/languageAnalysis";
	}

}
