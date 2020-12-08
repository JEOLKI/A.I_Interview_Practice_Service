package com.aiinterview.analysis.vo;

public class RepeatAnalysisVO {

	private String repeatAnalysisSq;		// 반복어 분석번호
	private String repeatCount;			// 반복어 횟수
	private String repeatContent;		// 반복어 내용
	private String ansSq;				// 답변 내용

	public String getRepeatAnalysisSq() {
		return repeatAnalysisSq;
	}

	public void setRepeatAnalysisSq(String repeatAnalysisSq) {
		this.repeatAnalysisSq = repeatAnalysisSq;
	}

	public String getRepeatCount() {
		return repeatCount;
	}

	public void setRepeatCount(String repeatCount) {
		this.repeatCount = repeatCount;
	}

	public String getRepeatContent() {
		return repeatContent;
	}

	public void setRepeatContent(String repeatContent) {
		this.repeatContent = repeatContent;
	}

	public String getAnsSq() {
		return ansSq;
	}

	public void setAnsSq(String ansSq) {
		this.ansSq = ansSq;
	}

}
