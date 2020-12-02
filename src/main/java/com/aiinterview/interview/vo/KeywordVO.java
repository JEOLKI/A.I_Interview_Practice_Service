package com.aiinterview.interview.vo;

import com.aiinterview.base.vo.BaseVO;

public class KeywordVO extends BaseVO{
	
	private String keywordSq; 				// 키워드 번호
	private String keywordContent;		// 키워드 내용
	private char keywordSt;				// 키워드 사용 여부
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
	public char getKeywordSt() {
		return keywordSt;
	}
	public void setKeywordSt(char keywordSt) {
		this.keywordSt = keywordSt;
	}
	@Override
	public String toString() {
		return "KeywordVO [keywordSq=" + keywordSq + ", keywordContent=" + keywordContent + ", keywordSt=" + keywordSt
				+ "]";
	}
	
	

}
