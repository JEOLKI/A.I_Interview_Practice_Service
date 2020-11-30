package com.aiinterview.interview.vo;

public class QuestionVO {
	private String questSq;			// 질문 번호
	private String questContent;	// 질문 내용
	private String interviewSq;		// 면접 번호
	private String sampQusetSq;		// 샘플 질문 번호
	public String getQuestSq() {
		return questSq;
	}
	public void setQuestSq(String questSq) {
		this.questSq = questSq;
	}
	public String getQuestContent() {
		return questContent;
	}
	public void setQuestContent(String questContent) {
		this.questContent = questContent;
	}
	public String getInterviewSq() {
		return interviewSq;
	}
	public void setInterviewSq(String interviewSq) {
		this.interviewSq = interviewSq;
	}
	public String getSampQusetSq() {
		return sampQusetSq;
	}
	public void setSampQusetSq(String sampQusetSq) {
		this.sampQusetSq = sampQusetSq;
	}
	@Override
	public String toString() {
		return "QuestionVO [questSq=" + questSq + ", questContent=" + questContent + ", interviewSq=" + interviewSq
				+ ", sampQusetSq=" + sampQusetSq + "]";
	}
	
	
}
