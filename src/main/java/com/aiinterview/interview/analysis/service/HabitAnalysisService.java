package com.aiinterview.interview.analysis.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.aiinterview.interview.analysis.dao.HabitAnalysisMapper;


@Service("habitAnalysisService")
public class HabitAnalysisService{

	@Resource(name="habitAnalysisMapper")
	private HabitAnalysisMapper habitAnalysisMapper;
}
