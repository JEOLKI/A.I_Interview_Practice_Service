package com.aiinterview.interview.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.aiinterview.analysis.service.HabitAnalysisService;
import com.aiinterview.analysis.vo.HabitAnalysisVO;
import com.aiinterview.interview.service.HabitService;
import com.aiinterview.interview.vo.HabitVO;

@RequestMapping("/answertest")
@Controller
public class AnswerTestController {
	
	@Resource(name="habitService")
	private HabitService habitService;
	
	@Resource(name="habitAnalysisService")
	private HabitAnalysisService habitAnalysisService;
	
	@RequestMapping("/test.do")
	public String answerTest() {
		return "answerTest/answerTest";
	}
	
	@RequestMapping("/regist.do")
	public String regist(String script, String ansSq) {
		
		System.out.println("스크립트 : "+script);
		
		
		/* 습관어 분석 */
		List<HabitVO> habitList = habitService.retrieveList();
		
		HabitAnalysisVO habitAnalysisVO = null;
		
		List<HabitAnalysisVO> habitAnalysisVOList = new ArrayList<>();
		
		for(int i=0; i<habitList.size(); i++) {
			habitAnalysisVO = new HabitAnalysisVO(ansSq);
			String[] habitArr = script.split(habitList.get(i).getHabitGb());
			habitAnalysisVO.setHabitSq(habitList.get(i).getHabitSq());
			habitAnalysisVO.setHabitCount(habitArr.length-1+"");
			habitAnalysisVOList.add(habitAnalysisVO);
		}
		
		try {
			habitAnalysisService.create(habitAnalysisVOList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		/* 반복어 분석 */
		
		
		return "";
	}
}
