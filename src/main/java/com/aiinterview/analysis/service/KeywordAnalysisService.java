package com.aiinterview.analysis.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.aiinterview.analysis.dao.KeywordAnalysisMapper;
import com.aiinterview.analysis.vo.KeywordAnalysisVO;
import com.aiinterview.analysis.vo.TalentAnalysisVO;

@Service("keywordAnalysisService")
public class KeywordAnalysisService {
	
	@Resource(name = "keywordAnalysisMapper")
	private KeywordAnalysisMapper keywordAnalysisMapper;

	public List<KeywordAnalysisVO> retrieveList(String ansSq) throws Exception{
		return keywordAnalysisMapper.retrieveList(ansSq);
	}

	/**
	 * 답변에 대한 인재상 분석 생성을 위한 메서드
	 * @param keywordAnalysisList
	 * @throws Exception 
	 */
	public void create(List<KeywordAnalysisVO> keywordAnalysisList) throws Exception {
		for(int i=0; i<keywordAnalysisList.size(); i++) {
			keywordAnalysisMapper.create(keywordAnalysisList.get(i));
		}
	}
	

	public List<TalentAnalysisVO> talentAnalysisList(String talentSq) throws Exception{
		return keywordAnalysisMapper.talentAnalysisList(talentSq);
	}
}
