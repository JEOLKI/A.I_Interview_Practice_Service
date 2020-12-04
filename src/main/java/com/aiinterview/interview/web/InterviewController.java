package com.aiinterview.interview.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.aiinterview.interview.service.InterviewService;
import com.aiinterview.interview.service.QuestionService;
import com.aiinterview.interview.vo.InterviewVO;
import com.aiinterview.interview.vo.QuestionVO;

@RequestMapping("/interview")
@Controller
public class InterviewController {

	@Resource(name = "interviewService")
	private InterviewService interviewService;
	
	@Resource(name = "questionService")
	private QuestionService questionService;

	private static final Logger logger = LoggerFactory.getLogger(InterviewController.class);

	@RequestMapping(path = "/ready.do", method = { RequestMethod.GET })
	public String interviewReady() {
		logger.debug("InterviewController.interviewReady()진입");
		return "interview/ready";
	}

	@RequestMapping(path = "/setting.do", method = { RequestMethod.GET })
	public String interviewSetting(@RequestParam("questionList") List<String> questionList,
								   @RequestParam("sampQuestSqList") List<String> sampQuestSqList, Model model) {
		model.addAttribute("questionList", questionList);
		model.addAttribute("sampQuestSqList", sampQuestSqList);

		return "interview/setting";
	}

	@RequestMapping(path = "/start.do", method = { RequestMethod.GET })
	public String interviewStart(@RequestParam("questionList") List<String> questionList,
								 @RequestParam("sampQuestSqList") List<String> sampQuestSqList,
								 String memId, Model model) {
		
		InterviewVO interviewVO = new InterviewVO(memId);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("interviewVO", interviewVO);
		
		List<QuestionVO> questionVOList = new ArrayList<>();
		
		for(int i=0 ; i < questionList.size(); i++) {
			QuestionVO questionVO = new QuestionVO(questionList.get(i), sampQuestSqList.get(i));
			questionVOList.add(questionVO);
		}
		
		map.put("questionVOList", questionVOList);
		
		String interviewSq = "";
		try {
			interviewSq = interviewService.create(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		try {
			List<QuestionVO> questionGoList = questionService.retrieveList(interviewSq);
			model.addAttribute("questionGoList", questionGoList);
		} catch (Exception e) {
			e.printStackTrace();
		} 
		
		return "interview/start";
	}

}
