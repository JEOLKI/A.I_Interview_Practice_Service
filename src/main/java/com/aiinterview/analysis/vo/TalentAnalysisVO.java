package com.aiinterview.analysis.vo;

import com.aiinterview.base.vo.BaseVO;

public class TalentAnalysisVO extends BaseVO{
	
	private String talentNm;
	private String keywordContent;
	private int keywordCount;
	public String getTalentNm() {
		return talentNm;
	}
	public void setTalentNm(String talentNm) {
		this.talentNm = talentNm;
	}
	public String getKeywordContent() {
		return keywordContent;
	}
	public void setKeywordContent(String keywordContent) {
		this.keywordContent = keywordContent;
	}
	public int getKeywordCount() {
		return keywordCount;
	}
	public void setKeywordCount(int keywordCount) {
		this.keywordCount = keywordCount;
	}
	
	

}
