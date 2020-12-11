package com.aiinterview.interview.vo;

import com.aiinterview.analysis.vo.HabitAnalysisVO;

public class HabitVO extends HabitAnalysisVO{
	
	private String habitSq;	// 습관어 번호
	private String habitGb;	// 습관어 내용
	private String habitSt; 	// 습관어 사용 여부
	public String getHabitSq() {
		return habitSq;
	}
	public void setHabitSq(String habitSq) {
		this.habitSq = habitSq;
	}
	public String getHabitGb() {
		return habitGb;
	}
	public void setHabitGb(String habitGb) {
		this.habitGb = habitGb;
	}
	public String getHabitSt() {
		return habitSt;
	}
	public void setHabitSt(String habitSt) {
		this.habitSt = habitSt;
	}
	@Override
	public String toString() {
		return "HabitVO [habitSq=" + habitSq + ", habitGb=" + habitGb + ", habitSt=" + habitSt + "]";
	}
	
	

}
