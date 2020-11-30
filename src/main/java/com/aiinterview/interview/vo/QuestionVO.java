package com.aiinterview.interview.vo;

public class QuestionVO {
	private int questSq;			// 질문 번호
	private String questContent;	// 질문 내용
	private int interviewSq;		// 면접 번호
	private int sampQusetSq;		// 샘플 질문 번호
	public int getQuestSq() {
		return questSq;
	}
	public void setQuestSq(int questSq) {
		this.questSq = questSq;
	}
	public String getQuestContent() {
		return questContent;
	}
	public void setQuestContent(String questContent) {
		this.questContent = questContent;
	}
	public int getInterviewSq() {
		return interviewSq;
	}
	public void setInterviewSq(int interviewSq) {
		this.interviewSq = interviewSq;
	}
	public int getSampQusetSq() {
		return sampQusetSq;
	}
	public void setSampQusetSq(int sampQusetSq) {
		this.sampQusetSq = sampQusetSq;
	}
	
	
}
