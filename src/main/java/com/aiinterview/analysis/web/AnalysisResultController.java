package com.aiinterview.analysis.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@RequestMapping("/analysisresult")
@Controller
public class AnalysisResultController {
	
	@RequestMapping(path = "/main.do", method = { RequestMethod.GET })// 내 면접 클릭 했을 시
	public String analysisMain() {
		return "analysis/main";
	}
	
	@RequestMapping(path = "/interviewresult.do", method = { RequestMethod.GET })// 내 면접 클릭 했을 시
	public String interviewResultView() {
		return "analysis/interviewresult";
	}

	@RequestMapping(path = "/question.do", method = { RequestMethod.GET })// 내 면접 클릭 했을 시
	public String questionView() {
		return "analysis/memberQuestion";
	}
	
	@RequestMapping(path = "/interviewlist.do", method = { RequestMethod.GET })// 내 면접 클릭 했을 시
	public String interviewListView() {
		return "analysis/interviewList";
	}
	
}
