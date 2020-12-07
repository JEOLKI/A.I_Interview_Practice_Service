package com.aiinterview.analysis.vo;

public class KeywordAnalysisVO {

	private String ansSq; // 답변 번호
	private String talentSq; // 인재상 번호
	private String keywordSq; // 키워드 번호
	private String keywordCount; // 키워드 횟수

	public KeywordAnalysisVO() {
	}
	public KeywordAnalysisVO(String ansSq) {
		this.ansSq = ansSq;
	}

	public String getAnsSq() {
		return ansSq;
	}

	public void setAnsSq(String ansSq) {
		this.ansSq = ansSq;
	}

	public String getTalentSq() {
		return talentSq;
	}

	public void setTalentSq(String talentSq) {
		this.talentSq = talentSq;
	}

	public String getKeywordSq() {
		return keywordSq;
	}

	public void setKeywordSq(String keywordSq) {
		this.keywordSq = keywordSq;
	}

	public String getKeywordCount() {
		return keywordCount;
	}

	public void setKeywordCount(String keywordCount) {
		this.keywordCount = keywordCount;
	}

}
