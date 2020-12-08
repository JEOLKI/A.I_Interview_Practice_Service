package com.aiinterview.interview.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.aiinterview.analysis.dao.ImageAnalysisMapper;
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
	
	public AnswerVO retrieve(String questSq) throws Exception{
		return answerMapper.retrieve(questSq);
	}
	public void create(Map<String, Object> map) throws Exception{
		
		AnswerVO answerVO = (AnswerVO) map.get("answerVO");
		
		answerMapper.create(answerVO);
		String ansSq = answerVO.getAnsSq();
		
		List<ImageAnalysisVO> imageAnalysisList = (List<ImageAnalysisVO>) map.get("imageAnalysisList");
		for (ImageAnalysisVO imageAnalysisVO : imageAnalysisList) {
			imageAnalysisVO.setAnsSq(ansSq);
			imageAnalysisMapper.create(imageAnalysisVO);
		}
		
		
//		HabitAnalysisVO habitAnalysisVO = (HabitAnalysisVO) map.get("habitAnalysisVO");
//		KeywordAnalysisVO keywordAnalysisVO = (KeywordAnalysisVO) map.get("keywordAnalysisVO");
//		repeatAnalysisVO repeatAnalysisVO = (repeatAnalysisVO) map.get("repeatAnalysisVO");
//		VoiceAnalysisVO voiceAnalysisVO = (VoiceAnalysisVO) map.get("voiceAnalysisVO");
		
	}

}
