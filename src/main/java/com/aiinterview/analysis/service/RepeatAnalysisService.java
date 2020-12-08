package com.aiinterview.analysis.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.aiinterview.analysis.dao.RepeatAnalysisMapper;
import com.aiinterview.analysis.vo.RepeatAnalysisVO;

@Service("repeatAnalysisService")
public class RepeatAnalysisService {
	
	@Resource(name = "repeatAnalysisMapper")
	private RepeatAnalysisMapper repeatAnalysisMapper;

	public List<RepeatAnalysisVO> retrieveList(String ansSq) throws Exception{
		return repeatAnalysisMapper.retrieveList(ansSq);
	}

	public void create(List<RepeatAnalysisVO> repeatList) throws Exception {
		for(int i=0; i<repeatList.size(); i++) {
			repeatAnalysisMapper.create(repeatList.get(i));
		}
		
	}
}
