package com.aiinterview.analysis.vo;

import java.util.List;

import com.aiinterview.interview.vo.AnswerVO;

public class AnalysisVO {
	
	private AnswerVO answerVO;
	
	private HabitAnalysisVO habitAnalysisVO;
	private ImageAnalysisVO imageAnalysisVO;
	private KeywordAnalysisVO keywordAnalysisVO;
	private RepeatAnalysisVO repeatAnalysisVO;
	private TalentAnalysisVO talentAnalysisVO;
	private VoiceAnalysisVO voiceAnalysisVO;
	
	private List<ImageAnalysisVO> imageAnalysisList;
	private List<HabitAnalysisVO> habitAnalysisList;
	private List<RepeatAnalysisVO> repeatAnalysisList;
	private List<KeywordAnalysisVO> keywordAnalysisList;
	private List<VoiceAnalysisVO> voiceAnalysisList;
	
	public List<VoiceAnalysisVO> getVoiceAnalysisList() {
		return voiceAnalysisList;
	}

	public void setVoiceAnalysisList(List<VoiceAnalysisVO> voiceAnalysisList) {
		this.voiceAnalysisList = voiceAnalysisList;
	}

	public List<KeywordAnalysisVO> getKeywordAnalysisList() {
		return keywordAnalysisList;
	}

	public void setKeywordAnalysisList(List<KeywordAnalysisVO> keywordAnalysisList) {
		this.keywordAnalysisList = keywordAnalysisList;
	}

	public List<RepeatAnalysisVO> getRepeatAnalysisList() {
		return repeatAnalysisList;
	}

	public void setRepeatAnalysisList(List<RepeatAnalysisVO> repeatAnalysisList) {
		this.repeatAnalysisList = repeatAnalysisList;
	}

	public AnswerVO getAnswerVO() {
		return answerVO;
	}

	public void setAnswerVO(AnswerVO answerVO) {
		this.answerVO = answerVO;
	}

	public List<HabitAnalysisVO> getHabitAnalysisList() {
		return habitAnalysisList;
	}

	public void setHabitAnalysisList(List<HabitAnalysisVO> habitAnalysisList) {
		this.habitAnalysisList = habitAnalysisList;
	}

	public List<ImageAnalysisVO> getImageAnalysisList() {
		return imageAnalysisList;
	}

	public void setImageAnalysisList(List<ImageAnalysisVO> imageAnalysisList) {
		this.imageAnalysisList = imageAnalysisList;
	}

	public HabitAnalysisVO getHabitAnalysisVO() {
		return habitAnalysisVO;
	}

	public void setHabitAnalysisVO(HabitAnalysisVO habitAnalysisVO) {
		this.habitAnalysisVO = habitAnalysisVO;
	}

	public ImageAnalysisVO getImageAnalysisVO() {
		return imageAnalysisVO;
	}

	public void setImageAnalysisVO(ImageAnalysisVO imageAnalysisVO) {
		this.imageAnalysisVO = imageAnalysisVO;
	}

	public KeywordAnalysisVO getKeywordAnalysisVO() {
		return keywordAnalysisVO;
	}

	public void setKeywordAnalysisVO(KeywordAnalysisVO keywordAnalysisVO) {
		this.keywordAnalysisVO = keywordAnalysisVO;
	}

	public RepeatAnalysisVO getRepeatAnalysisVO() {
		return repeatAnalysisVO;
	}

	public void setRepeatAnalysisVO(RepeatAnalysisVO repeatAnalysisVO) {
		this.repeatAnalysisVO = repeatAnalysisVO;
	}

	public TalentAnalysisVO getTalentAnalysisVO() {
		return talentAnalysisVO;
	}

	public void setTalentAnalysisVO(TalentAnalysisVO talentAnalysisVO) {
		this.talentAnalysisVO = talentAnalysisVO;
	}

	public VoiceAnalysisVO getVoiceAnalysisVO() {
		return voiceAnalysisVO;
	}

	public void setVoiceAnalysisVO(VoiceAnalysisVO voiceAnalysisVO) {
		this.voiceAnalysisVO = voiceAnalysisVO;
	}

}
