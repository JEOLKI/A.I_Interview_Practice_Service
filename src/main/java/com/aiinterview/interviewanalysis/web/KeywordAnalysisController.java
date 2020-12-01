package com.aiinterview.interviewanalysis.web;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.aiinterview.interviewanalysis.service.KeywordAnalysisService;


@RequestMapping("/keywordAnalysis")
@Controller
public class KeywordAnalysisController {
	
	@Resource(name="keywordAnalysisService")
	private KeywordAnalysisService keywordAnalysisService;
	

}
