package com.aiinterview.interview.vo;

import com.aiinterview.base.vo.BaseVO;

public class SampleQuestionVO extends BaseVO{
	private String sampQuestSq;			// 샘플질문번호
	private String sampQuestContent;	// 샘플질문 내용
	private String sampQuestSt;			// 샘플질문 사용 여부
	private String questGbSq;				// 샘플질문 구문 번호 (직무)
	public String getSampQuestSq() {
		return sampQuestSq;
	}
	public void setSampQuestSq(String sampQuestSq) {
		this.sampQuestSq = sampQuestSq;
	}
	public String getSampQuestContent() {
		return sampQuestContent;
	}
	public void setSampQuestContent(String sampQuestContent) {
		this.sampQuestContent = sampQuestContent;
	}
	public String getSampQuestSt() {
		return sampQuestSt;
	}
	public void setSampQuestSt(String sampQuestSt) {
		this.sampQuestSt = sampQuestSt;
	}
	public String getQuestGbSq() {
		return questGbSq;
	}
	public void setQuestGbSq(String questGbSq) {
		this.questGbSq = questGbSq;
	}
	@Override
	public String toString() {
		return "SampleQuestionVO [sampQuestSq=" + sampQuestSq + ", sampQuestContent=" + sampQuestContent
				+ ", sampQuestSt=" + sampQuestSt + ", questGbSq=" + questGbSq + "]";
	}
	
	
}
