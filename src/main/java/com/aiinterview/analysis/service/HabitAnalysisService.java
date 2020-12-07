package com.aiinterview.analysis.service;

import java.util.List;
import java.util.Map;

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
	
	/**
	 * 면접 답변에 대한 습관어 분석 생성하는 메서드
	 * @param habitAnalysisVOList
	 */
	public void create(List<HabitAnalysisVO> habitAnalysisVOList)throws Exception{
		for(int i=0; i<habitAnalysisVOList.size(); i++) {
			habitAnalysisMapper.create(habitAnalysisVOList.get(i));
		}
	}
	
}
