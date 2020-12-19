package com.aiinterview.interview.vo;


public class HabitVO extends InterviewVO{
	
	private String habitSq;	// 습관어 번호
	private String habitGb;	// 습관어 내용
	private String habitSt; 	// 습관어 사용 여부
	
	
	private String[] habitSqs;	// 습관어 번호를 받을 배열
	private String[] habitGbs;	// 습관어 내용를 받을 배열
	private String[] habitSts; 	// 습관어 사용 여부를 받을 배열
	
	
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
	
	
	
	public String[] getHabitSqs() {
		return habitSqs;
	}
	public void setHabitSqs(String[] habitSqs) {
		this.habitSqs = habitSqs;
	}
	public String[] getHabitGbs() {
		return habitGbs;
	}
	public void setHabitGbs(String[] habitGbs) {
		this.habitGbs = habitGbs;
	}
	public String[] getHabitSts() {
		return habitSts;
	}
	public void setHabitSts(String[] habitSts) {
		this.habitSts = habitSts;
	}
	@Override
	public String toString() {
		return "HabitVO [habitSq=" + habitSq + ", habitGb=" + habitGb + ", habitSt=" + habitSt + "]";
	}
	
	

}
