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
}
