package com.aiinterview.analysis.web;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.aiinterview.analysis.vo.ImageAnalysisVO;

@RequestMapping("/test")
@Controller
public class Testcontroller {
	
	@RequestMapping("/view.do")
	public String dd() {
		return "interview/interviewMain";
	}
	
	@RequestMapping(path="/test.do", method = {RequestMethod.POST})
	public String dds(@ModelAttribute("face") List<ImageAnalysisVO> imageAnalysisVO) {
			
		
		return "interview/interviewMain";
	}
	
	
}
