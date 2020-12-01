package com.aiinterview.analysis.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.aiinterview.analysis.dao.HabitAnalysisMapper;


@Service("habitAnalysisService")
public class HabitAnalysisService{

	@Resource(name="habitAnalysisMapper")
	private HabitAnalysisMapper habitAnalysisMapper;
}
