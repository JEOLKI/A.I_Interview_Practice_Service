package com.aiinterview.interview.service;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.aiinterview.analysis.vo.HabitAnalysisVO;
import com.aiinterview.analysis.vo.ImageAnalysisVO;
import com.aiinterview.analysis.vo.KeywordAnalysisVO;
import com.aiinterview.analysis.vo.RepetAnalysisVO;
import com.aiinterview.analysis.vo.VoiceAnalysisVO;
import com.aiinterview.interview.dao.AnswerMapper;
import com.aiinterview.interview.vo.AnswerVO;


@Service("answerService")
public class AnswerService {
	
	@Resource(name="answerMapper")
	private AnswerMapper answerMapper;
	
	public AnswerVO retrieve(String questSq) throws Exception{
		return answerMapper.retrieve(questSq);
	}
	public void create(Map<String, Object> map) throws Exception{
		
		HabitAnalysisVO habitAnalysisVO = (HabitAnalysisVO) map.get("habitAnalysisVO");
		ImageAnalysisVO imageAnalysisVO = (ImageAnalysisVO) map.get("imageAnalysisVO");
		KeywordAnalysisVO keywordAnalysisVO = (KeywordAnalysisVO) map.get("keywordAnalysisVO");
		RepetAnalysisVO repetAnalysisVO = (RepetAnalysisVO) map.get("repetAnalysisVO");
		VoiceAnalysisVO voiceAnalysisVO = (VoiceAnalysisVO) map.get("voiceAnalysisVO");
		
	}

}
