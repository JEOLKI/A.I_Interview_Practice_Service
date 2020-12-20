package com.aiinterview.interview.vo;

import com.aiinterview.base.vo.BaseVO;

public class KeywordMatchingVO extends BaseVO{
	private String talentSq; 	// 인재상 번호
	private String keywordSq; 	// 키워드 번호
	
	private String[] talentSqs; 	// 인재상 번호를 받을 배열
	private String[] keywordSqs; 	// 키워드 번호를 받을 배열
	
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
	
	
	public String[] getTalentSqs() {
		return talentSqs;
	}
	public void setTalentSqs(String[] talentSqs) {
		this.talentSqs = talentSqs;
	}
	public String[] getKeywordSqs() {
		return keywordSqs;
	}
	public void setKeywordSqs(String[] keywordSqs) {
		this.keywordSqs = keywordSqs;
	}
	@Override
	public String toString() {
		return "KeywordMatchingVO [talentSq=" + talentSq + ", keywordSq=" + keywordSq + "]";
	}
	

}
