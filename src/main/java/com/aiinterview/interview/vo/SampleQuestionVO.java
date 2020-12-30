package com.aiinterview.interview.vo;


/**
 * @author PC-13
 *
 */
public class SampleQuestionVO extends QuestionGubunVO{
	private int rn;						// 통계용 출력번호
	private int useCount;				// 통계용 사용 횟수
	private String sampQuestSq;			// 샘플질문번호
	private String sampQuestContent;	// 샘플질문 내용
	private String sampQuestSt;			// 샘플질문 사용 여부
//	private String questGbSq;			// 샘플질문 구문 번호 (직무)
	
	private String[] sampQuestSqs;			// 샘플질문번호를 받을 배열
	private String[] sampQuestContents;	// 샘플질문 내용를 받을 배열
	private String[] sampQuestSts;			// 샘플질문 사용 여부를 받을 배열
//	private String[] questGbSqs;			// 샘플질문 구문 번호 (직무)를 받을 배열
	
	public int getRn() {
		return rn;
	}
	public void setRn(int rn) {
		this.rn = rn;
	}
	public int getUseCount() {
		return useCount;
	}
	public void setUseCount(int useCount) {
		this.useCount = useCount;
	}
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
//	public String getQuestGbSq() {
//		return questGbSq;
//	}
//	public void setQuestGbSq(String questGbSq) {
//		this.questGbSq = questGbSq;
//	}
//	
	
	
	public String[] getSampQuestSqs() {
		return sampQuestSqs;
	}
	public void setSampQuestSqs(String[] sampQuestSqs) {
		this.sampQuestSqs = sampQuestSqs;
	}
	public String[] getSampQuestContents() {
		return sampQuestContents;
	}
	public void setSampQuestContents(String[] sampQuestContents) {
		this.sampQuestContents = sampQuestContents;
	}
	public String[] getSampQuestSts() {
		return sampQuestSts;
	}
	public void setSampQuestSts(String[] sampQuestSts) {
		this.sampQuestSts = sampQuestSts;
	}
//	public String[] getQuestGbSqs() {
//		return questGbSqs;
//	}
//	public void setQuestGbSqs(String[] questGbSqs) {
//		this.questGbSqs = questGbSqs;
//	}
	
	
}
