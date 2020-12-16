package com.aiinterview.analysis.vo;

import com.aiinterview.interview.vo.HabitVO;

public class HabitAnalysisVO extends HabitVO{

	private String habitSq; // 습관어 번호
	private String ansSq; // 답변 번호
	private String habitCount; // 습관어

	public HabitAnalysisVO() {
	}
	
	public HabitAnalysisVO(String ansSq2) {
		this.ansSq = ansSq;
	}

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

	public String getHabitCount() {
		return habitCount;
	}

	public void setHabitCount(String habitCount) {
		this.habitCount = habitCount;
	}

}
