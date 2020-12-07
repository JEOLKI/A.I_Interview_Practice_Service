package com.aiinterview.interview.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.aiinterview.analysis.vo.ImageAnalysisVO;
import com.aiinterview.interview.service.AnswerService;
import com.aiinterview.interview.vo.AnswerVO;

@RequestMapping("/answer")
@Controller
public class AnswerController {
	
	@Resource(name="answerService")
	private AnswerService answerseivce;
	
	@RequestMapping(path="/create.do", method= {RequestMethod.POST})
	public String create(AnswerVO answerVO, ImageAnalysisVO imageAnalysisVO){
		
		List<ImageAnalysisVO> imageAnalysisList = imageAnalysisVO.getImageAnalysisVOList();
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("imageAnalysisList", imageAnalysisList);
		
		try {
			answerseivce.create(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "";
	}
	
}
