package com.aiinterview.analysis.vo;

import com.aiinterview.interview.vo.TalentVO;

public class TalentAnalysisVO extends TalentVO{
	private int rn;	
	private String talentNm;
	private String percent;
	private int talentCount;
	public String getTalentNm() {
		return talentNm;
	}
	public void setTalentNm(String talentNm) {
		this.talentNm = talentNm;
	}
	public String getPercent() {
		return percent;
	}
	public void setPercent(String percent) {
		this.percent = percent;
	}
	public int getTalentCount() {
		return talentCount;
	}
	public void setTalentCount(int talentCount) {
		this.talentCount = talentCount;
	}
	public int getRn() {
		return rn;
	}
	public void setRn(int rn) {
		this.rn = rn;
	}
	
	

}
