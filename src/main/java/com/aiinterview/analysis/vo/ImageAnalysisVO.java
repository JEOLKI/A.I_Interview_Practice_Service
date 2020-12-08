package com.aiinterview.analysis.vo;

import java.util.List;

public class ImageAnalysisVO {

	private String imageAnalysisSq;	// 이미지 분석 번호
	private String anger;			// 분노
	private String contempt;		// 경멸
	private String fear;			// 두려움
	private String disgust;			// 역겨움
	private String happiness;		// 행복
	private String neutral;			// 무표정
	private String sadness;			// 슬픔
	private String surprise;		// 놀람
	private String faceTop;			// 얼굴 프레임 상단 왼쪽을 기준으로한 y좌표  
	private String faceLeft;		// 얼굴 프레임 상단 왼쪽을 기준으로한 x좌표
	private String faceWidth;		// 얼굴 프레임의 가로길이
	private String faceHeight;		// 얼굴 프레임의 세로길
	private String ansSq;			// 답변의 번호
	private List<ImageAnalysisVO> imageAnalysisVOList;
	
	
	
	
	
	public List<ImageAnalysisVO> getImageAnalysisVOList() {
		return imageAnalysisVOList;
	}
	public void setImageAnalysisVOList(List<ImageAnalysisVO> imageAnalysisVOList) {
		this.imageAnalysisVOList = imageAnalysisVOList;
	}
	public String getImageAnalysisSq() {
		return imageAnalysisSq;
	}
	public void setImageAnalysisSq(String imageAnalysisSq) {
		this.imageAnalysisSq = imageAnalysisSq;
	}
	public String getAnger() {
		return anger;
	}
	public void setAnger(String anger) {
		this.anger = anger;
	}
	public String getContempt() {
		return contempt;
	}
	public void setContempt(String contempt) {
		this.contempt = contempt;
	}
	public String getFear() {
		return fear;
	}
	public void setFear(String fear) {
		this.fear = fear;
	}
	public String getDisgust() {
		return disgust;
	}
	public void setDisgust(String disgust) {
		this.disgust = disgust;
	}
	public String getHappiness() {
		return happiness;
	}
	public void setHappiness(String happiness) {
		this.happiness = happiness;
	}
	public String getNeutral() {
		return neutral;
	}
	public void setNeutral(String neutral) {
		this.neutral = neutral;
	}
	public String getSadness() {
		return sadness;
	}
	public void setSadness(String sadness) {
		this.sadness = sadness;
	}
	public String getSurprise() {
		return surprise;
	}
	public void setSurprise(String surprise) {
		this.surprise = surprise;
	}
	public String getFaceTop() {
		return faceTop;
	}
	public void setFaceTop(String faceTop) {
		this.faceTop = faceTop;
	}
	public String getFaceLeft() {
		return faceLeft;
	}
	public void setFaceLeft(String faceLeft) {
		this.faceLeft = faceLeft;
	}
	public String getFaceWidth() {
		return faceWidth;
	}
	public void setFaceWidth(String faceWidth) {
		this.faceWidth = faceWidth;
	}
	public String getFaceHeight() {
		return faceHeight;
	}
	public void setFaceHeight(String faceHeight) {
		this.faceHeight = faceHeight;
	}
	public String getAnsSq() {
		return ansSq;
	}
	public void setAnsSq(String ansSq) {
		this.ansSq = ansSq;
	}
	@Override
	public String toString() {
		return "ImageAnalysisVO [imageAnalysisSq=" + imageAnalysisSq + ", anger=" + anger + ", contempt=" + contempt
				+ ", fear=" + fear + ", disgust=" + disgust + ", happiness=" + happiness
				+ ", neutral=" + neutral + ", sadness=" + sadness + ", surprise=" + surprise + ", faceTop=" + faceTop
				+ ", faceLeft=" + faceLeft + ", faceWidth=" + faceWidth + ", faceHeight=" + faceHeight + ", ansSq="
				+ ansSq + ", imageAnalysisVOList=" + imageAnalysisVOList + "]";
	}
	
	

	

}
