package com.aiinterview.interview.vo;


public class KeywordVO extends KeywordMatchingVO{
	
	private String keywordSq; 			// 키워드 번호
	private String keywordContent;		// 키워드 내용
	
	private String[] keywordSqs; 		// 키워드 번호를 받을 배열
	private String[] keywordContents;	// 키워드 내용을 받을 배열
	private String[] deleteChecks;		// 삭제 여부를 받을 배열
	
	
	public String getKeywordSq() {
		return keywordSq;
	}
	public void setKeywordSq(String keywordSq) {
		this.keywordSq = keywordSq;
	}
	public String getKeywordContent() {
		return keywordContent;
	}
	public void setKeywordContent(String keywordContent) {
		this.keywordContent = keywordContent;
	}
	public String[] getKeywordSqs() {
		return keywordSqs;
	}
	public void setKeywordSqs(String[] keywordSqs) {
		this.keywordSqs = keywordSqs;
	}
	public String[] getKeywordContents() {
		return keywordContents;
	}
	public void setKeywordContents(String[] keywordContents) {
		this.keywordContents = keywordContents;
	}
	public String[] getDeleteChecks() {
		return deleteChecks;
	}
	public void setDeleteChecks(String[] deleteChecks) {
		this.deleteChecks = deleteChecks;
	}
	

}
