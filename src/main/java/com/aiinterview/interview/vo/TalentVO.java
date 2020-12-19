package com.aiinterview.interview.vo;

import com.aiinterview.base.vo.BaseVO;

public class TalentVO extends BaseVO{

	private String talentSq; 		// 인재상 번호
	private String talentNm; 	// 인재상 이름
	private String talentSt;		// 인재상 사용 여부 
	
	private String[] talentSqs; 		// 인재상 번호를 받을 배열
	private String[] talentNms; 	// 인재상 이름을 받을 배열
	private String[] talentSts;		// 인재상 사용 여부를 받을 배열 
	
	
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
	
	
	
	
	public String[] getTalentSqs() {
		return talentSqs;
	}
	public void setTalentSqs(String[] talentSqs) {
		this.talentSqs = talentSqs;
	}
	public String[] getTalentNms() {
		return talentNms;
	}
	public void setTalentNms(String[] talentNms) {
		this.talentNms = talentNms;
	}
	public String[] getTalentSts() {
		return talentSts;
	}
	public void setTalentSts(String[] talentSts) {
		this.talentSts = talentSts;
	}
	@Override
	public String toString() {
		return "TalentVO [talentSq=" + talentSq + ", talentNm=" + talentNm + ", talentSt=" + talentSt + "]";
	}
	
	
}
