package com.aiinterview.interview.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.aiinterview.analysis.dao.HabitAnalysisMapper;
import com.aiinterview.analysis.dao.ImageAnalysisMapper;
import com.aiinterview.analysis.dao.KeywordAnalysisMapper;
import com.aiinterview.analysis.dao.RepeatAnalysisMapper;
import com.aiinterview.analysis.dao.VoiceAnalysisMapper;
import com.aiinterview.analysis.vo.AnalysisVO;
import com.aiinterview.analysis.vo.HabitAnalysisVO;
import com.aiinterview.analysis.vo.ImageAnalysisVO;
import com.aiinterview.analysis.vo.KeywordAnalysisVO;
import com.aiinterview.analysis.vo.RepeatAnalysisVO;
import com.aiinterview.analysis.vo.VoiceAnalysisVO;
import com.aiinterview.interview.dao.AnswerMapper;
import com.aiinterview.interview.vo.AnswerVO;


@Service("answerService")
public class AnswerService {
	
	@Resource(name="answerMapper")
	private AnswerMapper answerMapper;
	
	@Resource(name="imageAnalysisMapper")
	private ImageAnalysisMapper imageAnalysisMapper;
	
	@Resource(name="habitAnalysisMapper")
	private HabitAnalysisMapper habitAnalysisMapper;
	
	@Resource(name="repeatAnalysisMapper")
	private RepeatAnalysisMapper repeatAnalysisMapper;
	
	@Resource(name="keywordAnalysisMapper")
	private KeywordAnalysisMapper keywordAnalysisMapper;
	
	@Resource(name="voiceAnalysisMapper")
	private VoiceAnalysisMapper voiceAnalysisMapper;
	
	public AnswerVO retrieve(String questSq) throws Exception{
		return answerMapper.retrieve(questSq);
	}
	
	public String create(AnalysisVO analysisVO) throws Exception{
		
		AnswerVO answerVO = analysisVO.getAnswerVO();
		
		answerMapper.create(answerVO);
		String ansSq = answerVO.getAnsSq();
		
		/* 이미지 */
		List<ImageAnalysisVO> imageAnalysisList = analysisVO.getImageAnalysisList();
		if(imageAnalysisList != null) {
			for (ImageAnalysisVO imageAnalysisVO : imageAnalysisList) {
				if(imageAnalysisVO.getAnger()!=null) {
					imageAnalysisVO.setAnsSq(ansSq);
					imageAnalysisMapper.create(imageAnalysisVO);
				}
			}
		}
		
		
		/* 습관어 insert */
		List<HabitAnalysisVO> habitAnalysisVOList = analysisVO.getHabitAnalysisList();
		for (HabitAnalysisVO habitAnalysisVO : habitAnalysisVOList) {
			habitAnalysisVO.setAnsSq(ansSq);
			habitAnalysisMapper.create(habitAnalysisVO);
		}
		
		/* 반복어 insert */
		List<RepeatAnalysisVO> repeatAnalysisList = analysisVO.getRepeatAnalysisList();
		if(repeatAnalysisList!=null) {
			for (RepeatAnalysisVO repeatAnalysisVO : repeatAnalysisList) {
				repeatAnalysisVO.setAnsSq(ansSq);
				repeatAnalysisMapper.create(repeatAnalysisVO);
			}
		}
		
		/* 키워드 분석 (인재상 ) insert */
		List<KeywordAnalysisVO> keywordAnalysisList = analysisVO.getKeywordAnalysisList();
		for (KeywordAnalysisVO keywordAnalysisVO : keywordAnalysisList) {
			keywordAnalysisVO.setAnsSq(ansSq);
			keywordAnalysisMapper.create(keywordAnalysisVO);
		}
		
		/* 음성 분석 (데시벨, 헤르츠 ) insert */
		List<VoiceAnalysisVO> voiceAnalysisList = analysisVO.getVoiceAnalysisList();
		for (VoiceAnalysisVO voiceAnalysisVO : voiceAnalysisList) {
			voiceAnalysisVO.setAnsSq(ansSq);
			voiceAnalysisMapper.create(voiceAnalysisVO);
		}
		return ansSq;
	}
	
	/**
	 * 최근 5회의 답변 속도 평균 리스트를 조회하는 메서드
	 * 성장 그래프용
	 * @param memId
	 * @return
	 */
	public List<AnswerVO> retrieveSpeedGrowth(String memId) {
		return answerMapper.retrieveSpeedGrowth(memId);
	}

}
