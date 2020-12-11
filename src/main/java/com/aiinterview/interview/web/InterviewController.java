package com.aiinterview.interview.web;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.aiinterview.board.vo.BoardGubunVO;
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
	public String interviewSetting(@RequestParam(name="questionList") List<String> questionList,
								   @RequestParam(name="sampQuestSqList") List<String> sampQuestSqList, Model model) {
		model.addAttribute("questionList", questionList);
		model.addAttribute("sampQuestSqList", sampQuestSqList);

		return "interview/setting";
	}

	@RequestMapping(path = "/start.do", method = { RequestMethod.GET })
	public String interviewStart(@RequestParam("questionList") List<String> questionList,
								 @RequestParam("sampQuestSqList") List<String> sampQuestSqList,
								 String memId, Model model) {
		
		InterviewVO interviewVO = new InterviewVO(memId); // 인터뷰 객체 생성
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("interviewVO", interviewVO); // map 객체에 면접 객체 넣기
		
		List<QuestionVO> questionVOList = new ArrayList<>();
		
		for(int i=0 ; i < questionList.size(); i++) { // 임의 질문 사이즈만큼
			QuestionVO questionVO = new QuestionVO(questionList.get(i), sampQuestSqList.get(i));
			questionVOList.add(questionVO); // 최종 질문 목록에 추가
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
			logger.debug("questionGoList 내용 {} ", questionGoList.get(0).getQuestContent());
		} catch (Exception e) {
			e.printStackTrace();
		} 
		
		return "interview/start";
	}
	
	
	@RequestMapping(path="/update.do", method = { RequestMethod.POST })
	public String update(InterviewVO interviewVO,@RequestParam(required=false, defaultValue="") String pageNm, Model model) {
		
		try {
			int result = interviewService.update(interviewVO);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		if(pageNm.equals("resultPage")) {
			return "redirect:/analysis/question/retrievePagingList.do?interviewSq=" + interviewVO.getInterviewSq();
		}
		
		return "redirect:/analysis/interview/retrievePagingList.do";
	}
	

}
