package com.aiinterview.analysis.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.aiinterview.analysis.vo.ImageAnalysisVO;

@RequestMapping("/test")
@Controller
public class Testcontroller {
	
	private static final Logger logger = LoggerFactory.getLogger(Testcontroller.class);
	
	@RequestMapping("/view.do")
	public String dd() {
		return "interview/interviewMain";
	}	
	
	@RequestMapping(path="/test.do", method = {RequestMethod.POST})
	public String dds(ImageAnalysisVO imageAnalysisVO) {
		
		List<ImageAnalysisVO> imageAnalysisList = imageAnalysisVO.getImageAnalysisVOList();
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		return "interview/interviewMain";
	}
	
	
}
