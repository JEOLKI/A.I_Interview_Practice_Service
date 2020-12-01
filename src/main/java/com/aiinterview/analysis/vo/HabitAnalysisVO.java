package com.aiinterview.analysis.vo;

public class HabitAnalysisVO {
	private String habitSq;		// 습관어 번호
	private String ansSq;			// 답변 번호
	private int habitCount;		// 습관어 사용 회수
	public String getHabitSq() {
		return habitSq;
	}
	public void setHabitSq(String habitSq) {
		this.habitSq = habitSq;
	}
	public String getAnsSq() {
		return ansSq;
	}
	public void setAnsSq(String ansSq) {
		this.ansSq = ansSq;
	}
	public int getHabitCount() {
		return habitCount;
	}
	public void setHabitCount(int habitCount) {
		this.habitCount = habitCount;
	}
	@Override
	public String toString() {
		return "HabitAnalysisVO [habitSq=" + habitSq + ", ansSq=" + ansSq + ", habitCount=" + habitCount + "]";
	}
	
	

}
