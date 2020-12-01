package com.aiinterview.analysis.web;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.aiinterview.analysis.service.HabitAnalysisService;

@RequestMapping("/habitanalysis")
@Controller
public class HabitAnalysisController {

	@Resource(name="habitAnalysisService")
	private HabitAnalysisService habitAnalysisService;
}
