package com.aiinterview.interview.vo;

public class TalentVO {

	private String talentSq; 		// 인재상 번호
	private String talentNm; 	// 인재상 이름
	private String talentSt;		// 인재상 사용 여부 
	public String getTalentSq() {
		return talentSq;
	}
	public void setTalentSq(String talentSq) {
		this.talentSq = talentSq;
	}
	public String getTalentNm() {
		return talentNm;
	}
	public void setTalentNm(String talentNm) {
		this.talentNm = talentNm;
	}
	public String getTalentSt() {
		return talentSt;
	}
	public void setTalentSt(String talentSt) {
		this.talentSt = talentSt;
	}
	@Override
	public String toString() {
		return "TalentVO [talentSq=" + talentSq + ", talentNm=" + talentNm + ", talentSt=" + talentSt + "]";
	}
	
	
}
