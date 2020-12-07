package com.aiinterview.analysis.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.aiinterview.analysis.dao.RepetAnalysisMapper;
import com.aiinterview.analysis.vo.RepetAnalysisVO;

@Service("repetAnalysisService")
public class RepetAnalysisService {
	
	@Resource(name = "repetAnalysisMapper")
	private RepetAnalysisMapper repetAnalysisMapper;

	public List<RepetAnalysisVO> retrieveList(String ansSq) throws Exception{
		return repetAnalysisMapper.retrieveList(ansSq);
	}

	public void create(List<RepetAnalysisVO> repetList) throws Exception {
		for(int i=0; i<repetList.size(); i++) {
			repetAnalysisMapper.create(repetList.get(i));
		}
		
	}
}
