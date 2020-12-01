package com.aiinterview.interviewanalysis.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.aiinterview.interviewanalysis.dao.HabitAnalysisMapper;



@Service("habitAnalysisService")
public class HabitAnalysisService{

	@Resource(name="habitAnalysisMapper")
	private HabitAnalysisMapper habitAnalysisMapper;
}
