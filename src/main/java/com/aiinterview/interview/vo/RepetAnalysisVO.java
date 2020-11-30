package com.aiinterview.interview.vo;

public class RepetAnalysisVO {
	private String repetAnalysisSq;		// 반복어 분석 번호
	private String repetContent;		// 반복어 내용
	private int repetCount;				// 반복어 사용 회수
	private String ansSq;					// 답변 번호
	public String getRepetAnalysisSq() {
		return repetAnalysisSq;
	}
	public void setRepetAnalysisSq(String repetAnalysisSq) {
		this.repetAnalysisSq = repetAnalysisSq;
	}
	public String getRepetContent() {
		return repetContent;
	}
	public void setRepetContent(String repetContent) {
		this.repetContent = repetContent;
	}
	public int getRepetCount() {
		return repetCount;
	}
	public void setRepetCount(int repetCount) {
		this.repetCount = repetCount;
	}
	public String getAnsSq() {
		return ansSq;
	}
	public void setAnsSq(String ansSq) {
		this.ansSq = ansSq;
	}
	@Override
	public String toString() {
		return "RepetAnalysisVO [repetAnalysisSq=" + repetAnalysisSq + ", repetContent=" + repetContent
				+ ", repetCount=" + repetCount + ", ansSq=" + ansSq + "]";
	}
	
	

}
