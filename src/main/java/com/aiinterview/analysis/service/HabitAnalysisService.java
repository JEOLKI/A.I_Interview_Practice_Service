package com.aiinterview.analysis.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.aiinterview.analysis.dao.HabitAnalysisMapper;
import com.aiinterview.analysis.vo.HabitAnalysisVO;

@Service("habitAnalysisService")
public class HabitAnalysisService {
	
	@Resource(name = "habitAnalysisMapper")
	private HabitAnalysisMapper habitAnalysisMapper;

	public List<HabitAnalysisVO> retrieveList(String ansSq) throws Exception{
		return habitAnalysisMapper.retrieveList(ansSq);
	}
	
}
