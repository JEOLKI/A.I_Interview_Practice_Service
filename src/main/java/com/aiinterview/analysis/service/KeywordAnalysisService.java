package com.aiinterview.analysis.service;

import java.util.List;
import java.util.Map;

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
	
	/**
	 * 답변에 대한 인재상, 퍼센트를 조회하는 메서드
	 * @param talentSq
	 * @return
	 * @throws Exception
	 */
	public List<TalentAnalysisVO> retrieveTalentPercentList(String ansSq) throws Exception{
		return keywordAnalysisMapper.retrieveTalentPercentList(ansSq);
	}
	
	/**
	 * 답변에 대한 인재상을 도출한 키워드 리스트
	 * @param talentSq
	 * @return
	 * @throws Exception
	 */
	public List<String> retrieveKeywordList(Map<String, String> selectMap) throws Exception{
		return keywordAnalysisMapper.retrieveKeywordList(selectMap);
	}
}