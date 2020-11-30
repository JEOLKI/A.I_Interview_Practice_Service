package com.aiinterview.interview.vo;

public class AnswerVO {
	private String ansSq; 			// 답변 번호
	private String ansContent;	// 답변 내용
	private String videoPath;	// 영상 저장 경로
	private int ansTime;		// 답변 걸린 시간
	private int ansSpeed;		// 답변 속도 (00자/분)
	private String questSq;		// 질문 번호
	public String getAnsSq() {
		return ansSq;
	}
	public void setAnsSq(String ansSq) {
		this.ansSq = ansSq;
	}
	public String getAnsContent() {
		return ansContent;
	}
	public void setAnsContent(String ansContent) {
		this.ansContent = ansContent;
	}
	public String getVideoPath() {
		return videoPath;
	}
	public void setVideoPath(String videoPath) {
		this.videoPath = videoPath;
	}
	public int getAnsTime() {
		return ansTime;
	}
	public void setAnsTime(int ansTime) {
		this.ansTime = ansTime;
	}
	public int getAnsSpeed() {
		return ansSpeed;
	}
	public void setAnsSpeed(int ansSpeed) {
		this.ansSpeed = ansSpeed;
	}
	public String getQuestSq() {
		return questSq;
	}
	public void setQuestSq(String questSq) {
		this.questSq = questSq;
	}
	
	
}
