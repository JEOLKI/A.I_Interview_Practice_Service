package com.aiinterview.interview.vo;

public class SampleQuestionVO {
	private int sampQuestSq;			// 샘플질문번호
	private String sampQuestContent;	// 샘플질문 내용
	private char sampQuestSt;			// 샘플질문 사용 여부
	private int questGbSq;				// 샘플질문 구문 번호 (직무)
	public int getSampQuestSq() {
		return sampQuestSq;
	}
	public void setSampQuestSq(int sampQuestSq) {
		this.sampQuestSq = sampQuestSq;
	}
	public String getSampQuestContent() {
		return sampQuestContent;
	}
	public void setSampQuestContent(String sampQuestContent) {
		this.sampQuestContent = sampQuestContent;
	}
	public char getSampQuestSt() {
		return sampQuestSt;
	}
	public void setSampQuestSt(char sampQuestSt) {
		this.sampQuestSt = sampQuestSt;
	}
	public int getQuestGbSq() {
		return questGbSq;
	}
	public void setQuestGbSq(int questGbSq) {
		this.questGbSq = questGbSq;
	}
	
	
}
