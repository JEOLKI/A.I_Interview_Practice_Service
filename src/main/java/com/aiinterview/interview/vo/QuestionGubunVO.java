package com.aiinterview.interview.vo;


public class QuestionGubunVO extends QuestionVO {
	private String questGbSq;			// 샘플질문 구분 번호
	private String questGbContent;		// 샘플질문 구분 내용 (직무)
	private String questGbSt;			// 샘플질문 구분 사용여부( Y:사용/N:미사용)
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
	public String getQuestGbSt() {
		return questGbSt;
	}
	public void setQuestGbSt(String questGbSt) {
		this.questGbSt = questGbSt;
	}
	@Override
	public String toString() {
		return "QuestionGubunVO [questGbSq=" + questGbSq + ", questGbContent=" + questGbContent + ", questGbSt="
				+ questGbSt + ", getSearchCondition()=" + getSearchCondition() + ", getSearchKeyword()="
				+ getSearchKeyword() + ", getSearchUseYn()=" + getSearchUseYn() + "]";
	}
	
	
	
	

}
