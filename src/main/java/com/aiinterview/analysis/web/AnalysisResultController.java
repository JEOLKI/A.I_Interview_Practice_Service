package com.aiinterview.analysis.web;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.aiinterview.script.service.ScriptGubunService;
import com.aiinterview.script.service.ScriptService;
import com.aiinterview.script.vo.ScriptGubunVO;
import com.aiinterview.script.vo.ScriptVO;

@RequestMapping("/analysisresult")
@Controller
public class AnalysisResultController {
	private static final Logger logger = LoggerFactory.getLogger(AnalysisResultController.class);
	
	@RequestMapping(path = "/main.do", method = { RequestMethod.GET })// 내 면접 클릭 했을 시
	public String analysisMain(Model model) {
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
