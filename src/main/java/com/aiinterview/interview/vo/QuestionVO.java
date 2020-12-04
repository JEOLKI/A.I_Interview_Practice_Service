package com.aiinterview.interview.vo;

public class QuestionVO extends InterviewVO {

	private String questSq; // 질문 번호
	private String questContent; // 질문 내용
	private String interviewSq; // 면접 번호
	private String sampQuestSq; // 샘플 질문 번호

	public QuestionVO() {

	}
	
	public QuestionVO(String questContent, String sampQuestSq) {
		this.questContent = questContent;
		this.sampQuestSq = sampQuestSq;
	}

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

	public String getSampQuestSq() {
		return sampQuestSq;
	}

	public void setSampQuestSq(String sampQuestSq) {
		this.sampQuestSq = sampQuestSq;
	}

}
