package com.aiinterview.interview.vo;

public class QuestionGubunVO {
	private String questGbSq;			// 샘플질문 구분 번호
	private String questGbContent;	// 샘플질문 구분 내용 (직무)
	public String getQuestGbSq() {		
		return questGbSq;
	}
	public void setQuestGbSq(String questGbSq) {
		this.questGbSq = questGbSq;
	}
	public String getQuestGbContent() {
		return questGbContent;
	}
	public void setQuestGbContent(String questGbContent) {
		this.questGbContent = questGbContent;
	}
	@Override
	public String toString() {
		return "QuestionGubunVO [questGbSq=" + questGbSq + ", questGbContent=" + questGbContent + "]";
	}
	
	

}
